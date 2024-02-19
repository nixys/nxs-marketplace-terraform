### Create SNAT rule
resource "sbercloud_nat_snat_rule" "snat" {
  for_each = var.snat

  nat_gateway_id = try(each.value.nat_gateway_id, sbercloud_nat_gateway.nat[each.value.nat_gateway_name].id)
  floating_ip_id = try(each.value.floating_ip_id, sbercloud_vpc_eip.eip[each.value.floating_ip_name].id)
  subnet_id      = try(each.value.network_id, try(sbercloud_vpc_subnet.subnet[each.value.subnet_name].id, null))
  cidr           = try(each.value.cidr, null)
  source_type    = try(each.value.cidr, "0")
  region         = try(each.value.region, "ru-moscow-1")
  description    = try(each.value.description, "Created by Terraform")
}