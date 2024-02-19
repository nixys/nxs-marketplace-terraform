provider "sbercloud" {
  auth_url = "https://iam.ru-moscow-1.hc.sbercloud.ru/v3"
  region   = "ru-moscow-1"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_rds.tfstate"
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

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    endpoint = "https://obs.ru-moscow-1.hc.sbercloud.ru"
    bucket   = "name-your-bucket"
    region   = "ru-moscow-1"
    key      = "name_your_tfstate_for_vpc.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

module "rds" {
  source = "github.com/nixys/nxs-marketplace-terraform/SberCloud/Database/rds"
  
  general_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"] # Default project
  general_region     = "ru-moscow-1"                                                                   # Default region

  instance = {
    name-your-instance-1 = {
      enterprise_project_id     = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]  # Changing this creates a new database.
      region                    = "ru-moscow-1"                                                                    # Changing this creates a new database.
      vpc_id                    = data.terraform_remote_state.vpc.outputs.vpc_ids["name_your_vpc_1"]               # Changing this creates a new database.
      subnet_id                 = data.terraform_remote_state.vpc.outputs.subnet_ids["name_your_subnet_1"]         # Changing this creates a new database.
      security_group_id         = data.terraform_remote_state.vpc.outputs.security_group_ids["name_your_security_group_1"]     # Changing this creates a new database.
      availability_zone         = ["ru-moscow-1a","ru-moscow-1c"]                                                  # Changing this creates a new database.
      database_type             = "postgresql"                                                                     # Changing this creates a new database.
      database_version          = "15"                                                                             # Changing this creates a new database.
      cpu                       = 2                                                                                # Changing this creates a new database.
      memory                    = 8                                                                                # Changing this creates a new database.
      group_type                = "normal2"                                                                        # Changing this creates a new database.
      database_password         = "wdWt0MeKH4g08tJMrLksJpgUKCBv!12"                                                # Changing this creates a new database.
      database_template         = "name-your-postgres-template-1"                                                  # Changing this creates a new database.
      port                      = 5432                                                                             # Changing this creates a new database.
      ha_replication_mode       = "async"                                                                          # Changing this creates a new database.
      time_zone                 = "UTC+03:00"                                                                      # Changing this creates a new database.
      fixed_ip                  = "10.0.0.11"                                                                      # Changing this creates a new database.
      volume_type               = "ULTRAHIGH"                                                                      # Changing this creates a new database.
      volume_size               = 40
      volume_disk_encryption_id = ""
      backup_start_time         = "08:00-09:00"
      backup_keep_days          = 1

      parameters                = [{
          name  = "cursor_tuple_fraction"                                                                                           
          value = "0.2"                                                                                           
        },
        {
          name  = "autovacuum_analyze_threshold"                                                                                           
          value = "50"                       
        },
      ]

      tags = {
        created_by = "terraform"
      }
    }
  }

  custom_database_template = {
    name-your-postgres-template-1 = {
      region                 = "ru-moscow-1"                                                                 # Changing this creates a new custom_database_template.    
      description            = "Created by Terraform"
      database_type          = "PostgreSQL"
      database_version       = "15"
      values                 = {                                                                             # Changing this creates a new custom_database_template.
        array_nulls = "off",
        authentication_timeout = "600",
        bgwriter_flush_after = "256"
      }
    }
  }

  custom_database_backup = {
    name-your-custom-database-backup-1 = {
      region                 = "ru-moscow-1"                                                                 # Changing this creates a new custom-backup.    
      description            = "Created by Terraform"                                                        # Changing this creates a new custom-backup.
      instance_rds_name      = "name-your-instance-1"                                                        # Changing this creates a new custom-backup. 
      database_name          = [{                                                                            # Changing this creates a new custom-backup. 
          name  = "postgres"
        }
      ]
    }
  }

  custom_replicas = {
    name-your-custom-replica-1 = {
      enterprise_project_id     = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]  # Changing this creates a database's replica.
      region                    = "ru-moscow-1"                                                                    # Changing this creates a database's replica.
      database_type             = "postgresql"                                                                     # Changing this creates a database's replica.
      database_version          = "15"                                                                             # Changing this creates a database's replica.
      cpu                       = 2                                                                                # Changing this creates a database's replica.
      memory                    = 8                                                                                # Changing this creates a database's replica.
      group_type                = "normal2"                                                                        # Changing this creates a database's replica.
      primary_instance_name     = "name-your-instance-1"                                                           # Changing this creates a database's replica.
      availability_zone         = "ru-moscow-1a"                                                                   # Changing this creates a database's replica.
      volume_type               = "ULTRAHIGH"                                                                      # Changing this creates a database's replica.
      volume_disk_encryption_id = ""                                                                               # Changing this creates a database's replica.

      tags = {
        created_by = "terraform"
      }
    }
  }

}
