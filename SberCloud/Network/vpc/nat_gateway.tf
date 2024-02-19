resource "sbercloud_nat_gateway" "nat" {
  for_each = var.nat_gateway

  name                  = try(each.value.name, each.key)
  vpc_id                = try(each.value.vpc_id, sbercloud_vpc.vpc[each.value.vpc_name].id)
  spec                  = each.value.spec
  subnet_id             = try(each.value.subnet_id, sbercloud_vpc_subnet.subnet[each.value.subnet_name].id)
  region                = try(each.value.region, "ru-moscow-1")
  enterprise_project_id = try(each.value.project_id, var.general_project_id)
  description           = try(each.value.description, "Created by Terraform")
  tags                  = try(each.value.tags, { created_by = "Terraform" })
}