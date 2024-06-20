provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = YOUR_CLOUD_ID
  folder_id                = YOUR_FOLDER_ID
  zone                     = "ru-central1-a"
}

terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "managed-clickhouse.tfstate"
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
    key      = "vpc.tfstate"
    region   = "ru-central1"
    endpoint = "https://storage.yandexcloud.net"
    shared_credentials_file = "storage-cred"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

module "managed-clickhouse" {
  source = "github.com/nixys/nxs-marketplace-terraform/YandexCloud/Managed-clickhouse/managed-clickhouse"

  clusters = {
    name-your-clickhouse-cluster-1 = {
      network_id                                      = data.terraform_remote_state.vpc.outputs.network_ids["name-your-network-1"]
      description                                     = "Created by Terraform"
      deletion_protection                             = false
      maintenance_window_type                         = "WEEKLY"
      maintenance_window_day                          = "MON"
      maintenance_window_hour                         = 21
      environment                                     = "PRODUCTION"
      clickhouse_version                              = 23.8
      resource_preset_id                              = "m2.micro"
      disk_type_id                                    = "network-ssd"
      disk_size                                       = "100"
      admin_password                                  = ""
      service_account_id                              = "aje2dldasdasа5ubdd0k42"
      acess_data_lens                                 = true
      cloud_storage_enable                            = true

#########
### config
#########
      config_background_pool_size                            = 0
      config_background_schedule_pool_size                   = 0
      config_keep_alive_timeout                              = 3
      config_log_level                                       = "INFORMATION"
      config_mark_cache_size                                 = 4294967296
      config_max_concurrent_queries                          = 500
      config_max_connections                                 = 4096
      config_metric_log_retention_time                       = 2592000000
      config_part_log_retention_time                         = 2592000000
      config_query_log_retention_time                        = 2592000000
      config_query_thread_log_retention_time                 = 2592000000
      config_text_log_enabled                                = false
      config_text_log_retention_time                         = 2592000000
      config_timezone                                        = "Europe/Moscow"
      config_trace_log_retention_time                        = 2592000000
      config_uncompressed_cache_size                         = 0
#########
### End Config
#########

      compression = [
        {
          level               = 0
          method              = "LZ4"
          min_part_size       = 1024
          min_part_size_ratio = 0.5
        }
      ]

      shard = [
        {
          name   = "shard1"
          weight = 100
          resources = [{
            resource_preset_id = "m2.micro"
            disk_type_id       = "network-ssd"
            disk_size          = "100"
          }]
        },
        {
          name   = "shard3"
          weight = 100
          resources = [{
            resource_preset_id = "m3-c2-m16"
            disk_type_id       = "network-ssd"
            disk_size          = "100"
          }]
        }
      ]

      shard_group = [
        {
          name        = "shardGroup1"
          description = "Created by Terraform"
          shard_names = ["shard3", ]
        }
      ]

      clickhouse_hosts = [
        {
          type              = "CLICKHOUSE"
          subnet_id         = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-1"]
          zone              = "ru-central1-a"
          shard_name        = "shard1"
        },
        {
          type              = "CLICKHOUSE"
          subnet_id         = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-2"]
          zone              = "ru-central1-b"
          shard_name        = "shard3"
        }
      ]

      database = [
        {
          name = "name-your-database-1"
        }
      ]

      user = [
        {
          name       = "name-your-user-1"
          permission = [{
            database_name = "name-your-database-1"
          }]
        }
      ]

      labels = {
        cluster = "name-your-clickhouse-cluster-1"
      }
    }
  }

}
