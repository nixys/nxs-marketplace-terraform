provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = YOUR_CLOUD_ID
  folder_id                = YOUR_FOLDER_ID
  zone                     = "ru-central1-a"
  shared_credentials_file  = "storage-cred-yandex"
}

terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_bucket.tfstate"
    region   = "ru-central1"
    endpoint = "storage.yandexcloud.net"
    shared_credentials_file = "storage-cred-s3"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

module "bucket" {
  source = "github.com/nixys/nxs-marketplace-terraform/YandexCloud/Storage/buckets"

  buckets = {
    name-your-bucket-1 = {
      max_size                        = 1048576
      versioning_enabled              = true
      enable_logging                  = true
      default_storage_class           = "COLD"
      object_lock_enabled             = "Enabled"
      object_lock_configuration_mode  = "GOVERNANCE"
      object_lock_configuration_years = 1
      kms_master_key_id               = ""
      sse_algorithm                   = "aws:kms"
      website                         = [{
          index_document            = "index.html"
          error_document            = "error.html"
          routing_rules             = <<EOF
          [{
              "Condition": {
                  "KeyPrefixEquals": "docs/"
              },
              "Redirect": {
                  "ReplaceKeyPrefixWith": "documents/"
              }
          }]
          EOF
        },
      ]

      grant         = [
#        {
#        grant_name  = "myuser"
#        type        = "CanonicalUser"
#        permissions = ["FULL_CONTROL"]
#        },
      ]

      cors_rule           = [{
          allowed_origins = ["https://obs-website-test.hashicorp.com"]
          allowed_methods = ["PUT", "POST"]
          allowed_headers = ["*"]
          expose_headers  = ["ETag"]
          max_age_seconds = 3000
        },
      ]

      lifecycle_rule        = [{
          name              = "log"
          prefix            = "log/"
          enabled           = true

          expiration = [{
              days          = 365                                                                           # Changing this creates a new bucket.
            }
          ]

          transition = [{
              days          = 60                                                                            # Changing this creates a new bucket.
              storage_class = "STANDARD_IA"                                                                        # Changing this creates a new bucket.
            },
            {
              days          = 180                                                                           # Changing this creates a new bucket.
              storage_class = "COLD"                                                                        # Changing this creates a new bucket.
            }
          ]
        },
        {
          name              = "tmp"
          prefix            = "tmp/"
          enabled           = true

          noncurrent_version_expiration = [{
              days                      = 180                                                                           # Changing this creates a new bucket.
            }
          ]

          noncurrent_version_transition = [{
              days                      = 30                                                                            # Changing this creates a new bucket.
              storage_class             = "STANDARD_IA"                                                                        # Changing this creates a new bucket.
            },
            {
              days                      = 60                                                                            # Changing this creates a new bucket.
              storage_class             = "COLD"                                                                        # Changing this creates a new bucket.
            }
          ]
        },
      ]

      policy        = <<POLICY
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
              "arn:aws:s3:::name-your-bucket-1/*",
              "arn:aws:s3:::name-your-bucket-1"
            ]
          },
          {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": [
              "arn:aws:s3:::name-your-bucket-1/*",
              "arn:aws:s3:::name-your-bucket-1"
            ]
          }
        ]
      }
      POLICY

      anonymous_access_flags_read        = true
      anonymous_access_flags_list        = false
      anonymous_access_flags_config_read = true

      tags = {
        "created_by" = "Terraform"
      }
    }
  }
}