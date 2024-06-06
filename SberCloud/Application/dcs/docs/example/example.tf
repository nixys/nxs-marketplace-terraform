provider "sbercloud" {
  auth_url = "https://iam.ru-moscow-1.hc.sbercloud.ru/v3"
  region   = "ru-moscow-1"
}
terraform {
  backend "s3" {
    bucket   = "name-your-bucket"
    key      = "name_your_tfstate_for_dcs.tfstate"
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

module "dcs" {
  source = "github.com/nixys/nxs-marketplace-terraform/SberCloud/Application/dcs"

  general_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"] # Default project
  general_region     = "ru-moscow-1"                                                                   # Default region

  instances = {
    name-your-instance-1 = {
      enterprise_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
      description           = "Created by Terraform"
      engine                = "Redis"
      engine_version        = "6.0"
      capacity              = 8
      cache_mode            = "cluster"
      cpu_architecture      = "x86_64"
      availability_zones    = ["ru-moscow-1d"]
      vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_ids["name_your_vpc_1"]            # Changing this creates a new cluster.
      subnet_id             = data.terraform_remote_state.vpc.outputs.subnet_ids["name_your_subnet_1"]     # Changing this creates a new cluster.
      period_unit           = "month"
      security_group_ids    = ["${data.terraform_remote_state.vpc.outputs.security_group_ids["name_your_security_group_1"]}"]
      auto_renew            = "true"
      period                = "1"
      backup_policy = [{
        backup_type = "auto"
        save_days   = 3
        backup_at   = [1, 3, 5, 7]
        begin_at    = "02:00-04:00"
      }]

      whitelists = [{
        group_name = "test-group1"
        ip_address = ["192.168.10.100", "192.168.0.0/24"]
      },
      {
        group_name = "test-group2"
        ip_address = ["172.16.10.100", "172.16.0.0/24"]
      }
      ]

      parameters_timeout                = "1000"
      parameters_maxclients             = "2100"
      parameters_appendfsync            = "no"
      parameters_maxmemory-policy       = "allkeys-random"
      parameters_zset-max-ziplist-value = "128"
      parameters_repl-timeout           = "120"
    }
    name-your-instance-2 = {
      enterprise_project_id = data.terraform_remote_state.projects.outputs.project_ids["name_your_project_1"]
      description           = "Created by Terraform"
      engine                = "Redis"
      engine_version        = "6.0"
      capacity              = 8
      cache_mode            = "cluster"
      cpu_architecture      = "x86_64"
      availability_zones    = ["ru-moscow-1d"]
      vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_ids["name_your_vpc_1"]            # Changing this creates a new cluster.
      subnet_id             = data.terraform_remote_state.vpc.outputs.subnet_ids["name_your_subnet_1"]     # Changing this creates a new cluster.
      period_unit           = "month"
      security_group_ids    = ["${data.terraform_remote_state.vpc.outputs.security_group_ids["name_your_security_group_1"]}"]
      auto_renew            = "true"
      period                = "1"
      backup_policy = [{
        backup_type = "auto"
        save_days   = 3
        backup_at   = [1, 3, 5, 7]
        begin_at    = "02:00-04:00"
      }]

      whitelists = [{
        group_name = "test-group1"
        ip_address = ["192.168.10.100", "192.168.0.0/24"]
      },
      {
        group_name = "test-group2"
        ip_address = ["172.16.10.100", "172.16.0.0/24"]
      }
      ]

      parameters_timeout                = "1000"
      parameters_maxclients             = "2100"
      parameters_appendfsync            = "no"
      parameters_maxmemory-policy       = "allkeys-random"
      parameters_zset-max-ziplist-value = "128"
      parameters_repl-timeout           = "120"
    }
  }

  restores = {
    name-your-restores-1 = {
      description           = "Created by Terraform"
      backup_name           = "name-your-backups-1"
      instance_name         = ""
      instance_name         = "name-your-instance-2"
    }   
  }

  backups = {
    name-your-backups-1 = {
      description           = "Created by Terraform"
      backup_fromat         = "rdb"
      instance_name         = "name-your-instance-1"
    }
  }
}
