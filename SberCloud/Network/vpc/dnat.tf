### Create DNAT rule
resource "sbercloud_nat_dnat_rule" "dnat" {
  for_each = var.dnat

  nat_gateway_id              = try(each.value.nat_gateway_id, sbercloud_nat_gateway.nat[each.value.nat_gateway_name].id)
  floating_ip_id              = try(each.value.floating_ip_id, sbercloud_vpc_eip.eip[each.value.floating_ip_name].id)
  internal_service_port       = each.value.internal_service_port
  external_service_port       = each.value.external_service_port
  protocol                    = try(each.value.protocol, "ANY")
  private_ip                  = try(each.value.private_ip, null)
  port_id                     = try(each.value.port_id, null)
  internal_service_port_range = try(each.value.internal_service_port_range, null)
  external_service_port_range = try(each.value.external_service_port_range, null)
  region                      = try(each.value.region, "ru-moscow-1")
  description                 = try(each.value.description, "Created by Terraform")

}