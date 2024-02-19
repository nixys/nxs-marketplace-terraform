provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = YOUR_CLOUD_ID
  folder_id                = YOUR_FOLDER_ID
  zone                     = "ru-central1-a"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_lb.tfstate"
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

module "lb" {
  source = "github.com/nixys/nxs-marketplace-terraform/YandexCloud/Network-load-balancer/network-load-balancer"
  
  target_groups = {
    name-your-target-group-1 = {
      description = "Created by Terraform"
      target = [{
        subnet_id = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-1"]
        address   = "10.2.2.10"
      }]
      labels = {
        target-group = "name-your-target-group-1"
      }
    }
  }

  load_balancers = {
    name-your-load-balancer-1 = {
      description         = "Created by Terraform"
      type                = "external"
      deletion_protection = false
      listener = [{
        name                  = "name-your-listener-1"
        port                  = 8080
        external_address_spec = [{
          ip_version = "ipv4"
          address    = data.terraform_remote_state.vpc.outputs.external_ips_names["name-your-static-ip-1"]
        }]
        internal_address_spec = [{
          ip_version = "ipv4"
          address    = "10.2.2.10"
          subnet_id  = data.terraform_remote_state.vpc.outputs.subnet_ids["name-your-subnet-1"]
        }]
      }]
      attached_target_group = [{
        target_name = "name-your-target-group-1"
        healthcheck = [{
          name                = "https"
          interval            = 2
          timeout             = 1
          unhealthy_threshold = 2
          healthy_threshold   = 3
          http_options        = [{
            port = 8080
            path = "/ping"
          }]
#          tcp_options        = [{
#            port = 8080
#          }]
        }]
      }]
      labels = {
        load-balancer = "name-your-load-balancer-1"
      }
    }
  }

}
