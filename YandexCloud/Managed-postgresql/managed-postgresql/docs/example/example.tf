provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = YOUR_CLOUD_ID
  folder_id                = YOUR_FOLDER_ID
  zone                     = "ru-central1-a"
}

terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_managed-postgresql.tfstate"
    region   = "ru-central1"
    endpoint = "storage.yandexcloud.net"
    shared_credentials_file = "storage-cred"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_vpc.tfstate"
    region   = "ru-central1"
    endpoint = "storage.yandexcloud.net"
    shared_credentials_file = "storage-cred"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

module "managed-postgresql" {
  source = "github.com/nixys/nxs-marketplace-terraform/YandexCloud/Managed-postgresql/managed-postgresql"

  clusters = {
    name-your-postgresql-1 = {
      network_id                                      = data.terraform_remote_state.vpc.outputs.network_ids["name-your-network-1"]
      description                                     = "Created by Terraform"
      host_master_name                                = "master"
      security_group_ids                              = [data.terraform_remote_state.vpc.outputs.sg_ids["name-your-security-groups-1"]]
      deletion_protection                             = false
      maintenance_window_type                         = "WEEKLY"
      maintenance_window_day                          = "SUN"
      maintenance_window_hour                         = 16
      environment                                     = "PRODUCTION"
      disk_size                                       = 10
      disk_type                                       = "network-hdd"
      instance_type                                   = "s2.small"
      postgresql_version                              = 14
      access_data_lens                                = false
      access_web_sql                                  = true
      access_serverless                               = false
      access_data_transfer                            = false
      perfomance_diagnostics_enabled                  = true
      sessions_sampling_interval                      = 300
      statements_sampling_interval                    = 300
      disk_size_autoscaling_limit                     = 20
      disk_size_autoscaling_emergency_usage_threshold = 90
      autofailover                                    = true
      backup_retain_period_days                       = 14
      backup_window_start_hours                       = 1
      backup_window_start_minutes                     = 15
      pooler_config_pool_discard                      = false
      pooler_config_pooling_mode                      = "TRANSACTION"

      postgresql_config = {
        password_encryption               = 0
        max_connections                   = 395
        enable_parallel_hash              = true
        default_transaction_isolation     = "TRANSACTION_ISOLATION_READ_COMMITTED"
        shared_preload_libraries          = "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN,SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN"
      }

      postgresql_hosts = [
        {
          zone                    = "ru-central1-a"
          assign_public_ip        = false
          subnet_id               = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-1"]
          name                    = "name-your-postgresql-host-1"
        }
      ]

      labels = {
        created_by = "terraform"
      }
    }
  }

  databases = {
    name-your-database-1 = {
      cluster_name        = "name-your-postgresql-1"
      owner_user          = "name-your-user-1"
      lc_collate          = ""
      lc_type             = ""
      template_db         = ""
      deletion_protection = false
    },
    name-your-database-2 = {
      cluster_name        = "name-your-postgresql-1"
      owner_user          = "name-your-user-1"
      lc_collate          = ""
      lc_type             = ""
      template_db         = ""

      extension = [
        {
          extension_name                = "uuid-ossp"
          version                       = ""
          deletion_protection           = false
        },
        {
          extension_name                = "pg_stat_statements"
          version                       = ""
          deletion_protection           = false
        },
      ]
    }
  }

  users = {
    name-your-user-1 = {
      cluster_name        = "name-your-postgresql-1"
      conn_limit          = "10"
      login               = true
      deletion_protection = false
      grants              = ["mdb_admin",]

      settings = {
        default_transaction_isolation = "read committed"
        log_min_duration_statement    = 5000
      }
    }
  }
}