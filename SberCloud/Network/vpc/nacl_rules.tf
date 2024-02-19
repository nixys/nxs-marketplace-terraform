### Inbound rules for security group
resource "sbercloud_network_acl_rule" "inbound_rules" {
  for_each = merge([
    for k, v in var.network_acl : can(v.inbound_rules) ? {
      for key, value in v.inbound_rules : format("%s_%s", k, key) => value
    } : {}
  ]...)

  name                   = try(each.value.name, each.key)
  protocol               = try(each.value.protocol, "tcp")
  action                 = try(each.value.action, "allow")
  ip_version             = try(each.value.ip_version, "4")
  source_ip_address      = try(each.value.source_ip_address, null)
  source_port            = try(each.value.source_port, null)
  destination_ip_address = try(each.value.destination_ip_address, null)
  destination_port       = try(each.value.destination_port, null)
  enabled                = try(each.value.enabled, true)
  region                 = try(each.value.region, "ru-moscow-1")
  description            = try(each.value.description, "Created by Terraform")
}
### Outbound rules for security group
resource "sbercloud_network_acl_rule" "outbound_rules" {
  for_each = merge([
    for k, v in var.network_acl : can(v.outbound_rules) ? {
      for key, value in v.outbound_rules : format("%s_%s", k, key) => value
    } : {}
  ]...)

  name                   = each.key
  protocol               = try(each.value.protocol, "tcp")
  action                 = try(each.value.action, "allow")
  ip_version             = try(each.value.ip_version, "4")
  source_ip_address      = try(each.value.source_ip_address, null)
  source_port            = try(each.value.source_port, null)
  destination_ip_address = try(each.value.destination_ip_address, null)
  destination_port       = try(each.value.destination_port, null)
  enabled                = try(each.value.enabled, true)
  region                 = try(each.value.region, "ru-moscow-1")
  description            = try(each.value.description, "Created by Terraform")
}
