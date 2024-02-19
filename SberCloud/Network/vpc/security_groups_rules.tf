resource "sbercloud_networking_secgroup_rule" "ingress_rules" {
  for_each = local.ingress_rules_to_security_group_map

  direction               = "ingress"
  ethertype               = each.value.ethertype
  protocol                = each.value.protocol
  port_range_min          = each.value.port_range_min
  port_range_max          = each.value.port_range_max
  ports                   = each.value.ports
  remote_address_group_id = each.value.remote_address_group_id
  action                  = each.value.action
  priority                = each.value.priority
  remote_ip_prefix        = each.value.remote_ip_prefix
  remote_group_id         = each.value.remote_group_id
  security_group_id       = each.value.security_group_id
  region                  = each.value.region
  description             = each.value.description
}
resource "sbercloud_networking_secgroup_rule" "egress_rules" {
  for_each = local.egress_rules_to_security_group_map

  direction               = "egress"
  ethertype               = each.value.ethertype
  protocol                = each.value.protocol
  port_range_min          = each.value.port_range_min
  port_range_max          = each.value.port_range_max
  ports                   = each.value.ports
  remote_address_group_id = each.value.remote_address_group_id
  action                  = each.value.action
  priority                = each.value.priority
  remote_ip_prefix        = each.value.remote_ip_prefix
  remote_group_id         = each.value.remote_group_id
  security_group_id       = each.value.security_group_id
  region                  = each.value.region
  description             = each.value.description
}

