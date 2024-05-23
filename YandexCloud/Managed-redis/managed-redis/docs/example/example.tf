provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = YOUR_CLOUD_ID
  folder_id                = YOUR_FOLDER_ID
  zone                     = "ru-central1-a"
}

terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_managed-redis.tfstate"
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

module "managed-redis" {
  source = "github.com/nixys/nxs-marketplace-terraform/YandexCloud/Managed-redis/managed-redis"

  clusters = {
    name-your-redis-1 = {
      network_id                                      = data.terraform_remote_state.vpc.outputs.network_ids["name-your-network-1"]
      environment                                     = "PRODUCTION"
      description                                     = "Created by Terraform"
      version                                         = "7.2"
      databases                                       = "12"
      security_group_ids                              = [data.terraform_remote_state.vpc.outputs.sg_ids["name-your-security-groups-1"]]
      deletion_protection                             = false
      maintenance_window_type                         = "WEEKLY"
      maintenance_window_day                          = "SUN"
      maintenance_window_hour                         = 16
      disk_size                                       = 16
      disk_type                                       = "network-ssd"
      instance_type                                   = "hm3-c2-m8"
      sharded                                         = false

      redis_hosts = [
        {
          zone                    = "ru-central1-a"
          assign_public_ip        = false
          subnet_id               = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-1"]
        },
        {
          zone                    = "ru-central1-b"
          assign_public_ip        = false
          subnet_id               = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-2"]
        },
        {
          zone                    = "ru-central1-d"
          assign_public_ip        = false
          subnet_id               = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-3"]
        }
      ]

      labels = {
        created_by = "terraform"
      }
    }
  }
}
