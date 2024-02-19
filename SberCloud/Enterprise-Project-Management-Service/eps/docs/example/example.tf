provider "sbercloud" {
  auth_url = "https://iam.ru-moscow-1.hc.sbercloud.ru/v3"
  region   = "ru-moscow-1"
}
terraform {
  backend "s3" {
    endpoint = "https://obs.ru-moscow-1.hc.sbercloud.ru"
    bucket   = "name-your-bucket"
    region   = "ru-moscow-1"
    key      = "name_your_tfstate_for_projects.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

module "eps" {
  source = "github.com/nixys/nxs-marketplace-terraform/SberCloud/Enterprise-Project-Management-Service/eps"

  enterprise_projects = {
    name_your_project_1 = {
      name        = "name_your_project_1"
      description = "Created by Terraform"
      enable      = "true"
    }
  }
}

### ========= OUTPUTS ========== ###

output "project_ids" {
  value = module.eps.project_ids
}
