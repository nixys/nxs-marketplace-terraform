# Create security groups
resource "sbercloud_network_acl" "nacl" {
  for_each    = var.network_acl
  name        = try(each.value.name, each.key)
  region      = try(each.value.region, "ru-moscow-1")
  description = try(each.value.description, "Created by Terraform")
  subnets     = try(each.value.subnets, [ for k in each.value.subnet_names : sbercloud_vpc_subnet.subnet[k].id ]) 

  inbound_rules = can(each.value.inbound_rules) ? [
    for k, v in each.value.inbound_rules :
    sbercloud_network_acl_rule.inbound_rules[format("%s_%s", each.key, k)].id
  ] : []

  outbound_rules = can(each.value.outbound_rules) ? [
    for k, v in each.value.outbound_rules :
    sbercloud_network_acl_rule.outbound_rules[format("%s_%s", each.key, k)].id
    if each.value.outbound_rules != null
  ] : []
}

