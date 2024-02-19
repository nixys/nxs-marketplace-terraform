provider "sbercloud" {
  auth_url = "https://iam.ru-moscow-1.hc.sbercloud.ru/v3"
  region   = "ru-moscow-1"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_route.tfstate"
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

module "routes" {
  source = "github.com/nixys/nxs-marketplace-terraform/SberCloud/Network/routes"

  route_tables = {
    name_your_route_tables_1 = {
      vpc_id = data.terraform_remote_state.vpc.outputs.vpc_ids["name_your_vpc_1"]
      subnets = [
        data.terraform_remote_state.vpc.outputs.subnet_ids["name_your_subnet_1"],
        data.terraform_remote_state.vpc.outputs.subnet_ids["name_your_subnet_2"],
      ]
      static_route = [
        {
          destination = data.terraform_remote_state.vpc.outputs.vpc_cidrs["name_your_vpc_2"]
          nexthop     = data.terraform_remote_state.vpc.outputs.peering_ids["name_your_peering_1"]
          type        = "peering"
        },
      ]
    },
    name_your_route_tables_2 = {
      vpc_id = data.terraform_remote_state.vpc.outputs.vpc_ids["name_your_vpc_2"]
      static_route = [
        {
          destination = data.terraform_remote_state.vpc.outputs.vpc_cidrs["name_your_vpc_1"]
          nexthop     = data.terraform_remote_state.vpc.outputs.peering_ids["name_your_peering_1"]
          type        = "peering"
        },
      ]
    },
  }
}

### ========= OUTPUTS ========== ###

output "route_table_names" {
  value = module.routes.route_table_names
}

output "route_table_ids" {
  value = module.routes.route_table_ids
}
