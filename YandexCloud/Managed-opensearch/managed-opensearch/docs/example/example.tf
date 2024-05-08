provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = YOUR_CLOUD_ID
  folder_id                = YOUR_FOLDER_ID
  zone                     = "ru-central1-a"
}

terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_managed-opensearch.tfstate"
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

module "managed-opensearch" {
  source = "github.com/nixys/nxs-marketplace-terraform/YandexCloud/Managed-opensearch/managed-opensearch"
  clusters = {
    name-your-opensearch-1 = {
      environment             = "PRODUCTION"
      network_id              = data.terraform_remote_state.vpc.outputs.network_ids["name-your-network-1"]
      version                 = "2.8"
      maintenance_window_type = "WEEKLY"
      maintenance_window_day  = "SAT"
      maintenance_window_hour = 12
      security_group_id       = [data.terraform_remote_state.vpc.outputs.sg_ids["name-your-security-groups-1"]]
      deletion_protection     = false

      opensearch_node_groups = [{
        assign_public_ip    = "false"
        zone_ids            = ["ru-central1-a", "ru-central1-b", "ru-central1-d",]
        hosts_count         = 3
        name                = "name-your-opensearch-hostname-1"
        disk_type_id        = "network-ssd"
        disk_size           = 1073741824
        resources_preset_id = "s2.micro"
        },
      ]
      dashboards_node_groups = [{
        assign_public_ip    = "false"
        zone_ids            = ["ru-central1-a", ]
        hosts_count         = 1
        name                = "name-your-opensearch-dashboard-hostname-1"
        disk_type_id        = "network-ssd"
        disk_size           = 10737418240
        resources_preset_id = "s2.micro"
        },
      ]

      labels = {
        opensearch = "name-your-opensearch-1"
      }
    }
  }
}
