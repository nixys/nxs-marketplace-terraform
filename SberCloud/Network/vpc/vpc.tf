resource "sbercloud_vpc" "vpc" {
  for_each              = var.vpc
  name                  = try(each.value.name, each.key)
  cidr                  = each.value.cidr
  region                = try(each.value.region, "ru-moscow-1")
  description           = try(each.value.description, "Created by Terraform")
  enterprise_project_id = try(each.value.project_id, var.general_project_id)
  tags                  = try(each.value.tags, { created_by = "Terraform" })
}
