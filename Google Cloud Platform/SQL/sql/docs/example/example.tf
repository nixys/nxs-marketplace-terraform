provider "google" {
  credentials   = file("project-credentials.json")
  project       = YOUR_PROJECT_ID
  region        = YOUR_REGION
}
terraform {
  backend "gcs" {
    bucket      = "name-your-bucket-1"
    prefix      = "terraform/sql/sql/state"
    credentials = "project-credentials.json"
  }
}

module "sql" {
  source = "github.com/nixys/nxs-marketplace-terraform/Google Cloud Platform/SQL/sql"

  database_instances = {
    name-your-database-instance-1 = {
      database_version = "POSTGRES_14"
      deletion_protection  = false

      settings = [{
        tier      = "db-f1-micro"
        disk_size = 10
        disk_type = "PD_SSD"
        ip_configuration = [{
          psc_config = [{
            psc_enabled = true
          }]
          ipv4_enabled                                  = false
          enable_private_path_for_google_cloud_services = true
        }]
      }]
    }
  }
  
  databases = {
    name-your-database-1 = {
      instance        = "name-your-database-instance-1"
      deletion_policy = "DELETE"
    }
  }

  source_representation_instances = {
    name-your-source-representation-instances-1 = {
      database_version   = "POSTGRES_14"
      region             = "us-west1"
      host               = "10.20.30.40"
      port               = 5432
      username           = "some-user"
      password           = "password-for-the-user"
    }
  }

  ssl_certs = {
    name-ssl-cert-1 = {
      instance = "name-your-database-instance-1"
    }
  }

  users = {
    name-your-user-1 = {
      instance        = "name-your-database-instance-1"
      password        = "your-password-1"

#      password_policy = [{
#        allowed_failed_attempts      = 10
#        password_expiration_duration = 16
#        enable_failed_attempts_check = true
#        enable_password_verification = true
#      }]
    }
  }

}