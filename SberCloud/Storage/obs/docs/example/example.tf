provider "sbercloud" {
  auth_url = "https://iam.ru-moscow-1.hc.sbercloud.ru/v3"
  region   = "ru-moscow-1"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_obs.tfstate"
    region   = "ru-moscow-1"
    endpoint = "https://obs.ru-moscow-1.hc.sbercloud.ru"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

data "terraform_remote_state" "projects" {
  backend = "s3"
  config = {
    endpoint = "https://obs.ru-moscow-1.hc.sbercloud.ru"
    bucket   = "name-your-bucket"
    region   = "ru-moscow-1"
    key      = "name_your_tfstate_for_projects.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

module "obs" {
  source = "github.com/nixys/nxs-marketplace-terraform/SberCloud/Storage/obs"
  
  general_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"] # Default project
  general_region     = "ru-moscow-1"                                                                   # Default region

  buckets = {
    name-your-bucket-1 = {
      enterprise_project_id  = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]                              # Changing this creates a new bucket.
      acl                    = "private"
      versioning             = true
      storage_class          = "STANDARD"
      quota                  = 20
      force_destroy          = false
      region                 = "ru-moscow-1"                                                                                                # Changing this creates a new bucket.
      kms_key_id             = ""
      kms_key_project_id     = ""
      enable_logging         = true
      multi_az               = true                                                                                                         # Changing this creates a new bucket.
      policy_format          = "obs"                                                                                                        # Example: "s3", "obs".

      website                = [{
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

      cors_rule             = [{
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
              days                         = 365                                                                           # Changing this creates a new bucket.
            }
          ]

          transition = [{
              days                         = 60                                                                            # Changing this creates a new bucket.
              storage_class                = "WARM"                                                                        # Changing this creates a new bucket.
            },
            {
              days                         = 180                                                                           # Changing this creates a new bucket.
              storage_class                = "COLD"                                                                        # Changing this creates a new bucket.
            }
          ]
        },
        {
          name              = "tmp"
          prefix            = "tmp/"
          enabled           = true
          
          noncurrent_version_expiration = [{
              days                         = 180                                                                           # Changing this creates a new bucket.
            }
          ]

          noncurrent_version_transition = [{
              days                         = 30                                                                            # Changing this creates a new bucket.
              storage_class                = "WARM"                                                                        # Changing this creates a new bucket.
            },
            {
              days                         = 60                                                                            # Changing this creates a new bucket.
              storage_class                = "COLD"                                                                        # Changing this creates a new bucket.
            }
          ]
        },
      ]

      tags = {
        "created_by" = "Terraform"
      }
    }
  }

  bucket_acls = {
    name-your-bucket-acl-1 = {
      bucket_name                                   = "name-your-bucket-1"                                         # Changing this creates a new bucket acl.
      region                                        = "ru-moscow-1"                                                # Changing this creates a new bucket acl.
      owner_permission_access_to_bucket             = ["READ", "WRITE"]
      owner_permission_access_to_acl                = ["READ_ACP", "WRITE_ACP"]
      public_permission_access_to_bucket            = ["READ", "WRITE"]
      log_delivery_user_permission_access_to_bucket = ["READ", "WRITE"]
      log_delivery_user_permission_access_to_acl    = ["READ_ACP", "WRITE_ACP"]

      account_permission = [
        {
          access_to_bucket = ["READ", "WRITE"]
          access_to_acl    = ["READ_ACP", "WRITE_ACP"]
          account_id       = "rqwerqwerwer"
        },
      ]
    }
  }

  bucket_policys = {
    name-your-bucket-policy-1 = {
      bucket_name   = "name-your-bucket-1"                                                # Changing this creates a new policy.
      policy_format = "s3"                                                                # Example: "s3", "obs".
      region        = "ru-moscow-1"                                                       # Changing this creates a new policy.
      policy        = <<POLICY
      {
        "Version": "2008-10-17",
        "Id": "MYBUCKETPOLICY",
        "Statement": [
          {
            "Sid": "IPAllow",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::name-your-bucket-1/*",
            "Condition": {
              "IpAddress": {"aws:SourceIp": "8.8.8.8/32"}
            }
          }
        ]
      }
      POLICY
    }
  }

}

