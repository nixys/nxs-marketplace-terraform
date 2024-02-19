# Create security groups
resource "sbercloud_networking_secgroup" "security_groups" {
  for_each = var.security_groups

  name                  = try(each.value.name, each.key)
  delete_default_rules  = try(each.value.delete_default_rules, "true")
  enterprise_project_id = try(each.value.project_id, var.general_project_id)
  region                = try(each.value.region, "ru-moscow-1")
  description           = try(each.value.description, "Created by Terraform")
}
