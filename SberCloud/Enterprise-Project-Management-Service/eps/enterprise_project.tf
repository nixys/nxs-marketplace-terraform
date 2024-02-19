resource "sbercloud_enterprise_project" "projects" {
  for_each = var.enterprise_projects

  name        = try(each.value.name, each.key)
  description = try(each.value.description, "Created by Terraform")
  enable      = try(each.value.enable, true)
}