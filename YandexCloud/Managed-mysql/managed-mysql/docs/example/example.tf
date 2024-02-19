provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = YOUR_CLOUD_ID
  folder_id                = YOUR_FOLDER_ID
  zone                     = "ru-central1-a"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_managed-mysql.tfstate"
    region   = "ru-central1"
    endpoint = "https://storage.yandexcloud.net"
    shared_credentials_file = "storage-cred"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_vpc.tfstate"
    region   = "ru-central1"
    endpoint = "https://storage.yandexcloud.net"
    shared_credentials_file = "storage-cred"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

module "managed-mysql" {
  source = "github.com/nixys/nxs-marketplace-terraform/YandexCloud/Managed-mysql/managed-mysql"
  
  clusters = {
    name-your-mysql-1 = {
      environment                     = "PRODUCTION"
      network_id                      = data.terraform_remote_state.vpc.outputs.network_ids["name-your-network-1"]
      version                         = "8.0"
      maintenance_window_type         = "WEEKLY"
      maintenance_window_day          = "SAT"
      maintenance_window_hour         = 12
      resource_preset_id              = "s2.micro"
      disk_type                       = "network-hdd"
      disk_size                       = 10
      backup_window_start_hours       = "00"
      backup_window_start_minutes     = "00"
      backup_retain_period_days       = 7
      security_group_id               = [data.terraform_remote_state.vpc.outputs.sg_ids["name-your-security-groups-1"]]
      deletion_protection             = false
     
      mysql_config = {
        sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
        max_connections               = 100
        default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
        innodb_print_all_deadlocks    = true
      }
      
      mysql_hosts = [{
        subnet_id = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-1"]
        zone      = "ru-central1-a"
        name      = "name-your-mysql-hostname-1"
      },
      ]

      performance_diagnostics_enabled = false
      labels = {
        mysql = "name-your-mysql-1"
      }
    }
  }
  databases = {
    name-your-database-1 = {
      mysql_cluster_name = "name-your-mysql-1"
    }
  }
  users = {
    name-your-user-1 = {
      mysql_cluster_name       = "name-your-mysql-1"
      max_questions_per_hour   = 10
      max_updates_per_hour     = 20
      max_connections_per_hour = 30
      max_user_connections     = 40
      global_permissions       = ["PROCESS"]
      authentication_plugin    = "SHA256_PASSWORD"
  
      permission = [{
        database_name = "name-your-database-1"
        roles         = ["ALL"]
        },
      ]
    }
  }
}
