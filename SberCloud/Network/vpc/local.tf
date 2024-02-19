locals {
  ingress_rules_to_security_group_map = merge([
    for k, v in var.security_groups : can(v.ingress_rules) ? {
      for key, value in v.ingress_rules :
      "${k}_${key}" => {
        ethertype               = try(value.ethertype, "IPv4")
        protocol                = try(value.protocol, null)
        port_range_min          = try(value.port_range_min, null)
        port_range_max          = try(value.port_range_max, null)
        ports                   = try(value.ports, null)
        remote_address_group_id = try(value.remote_address_group_id, null)
        action                  = try(value.action, "allow")
        priority                = try(value.priority, "1")
        remote_ip_prefix        = try(value.remote_ip_prefix, null)
        remote_group_id         = try(value.remote_group_id, null)
        security_group_id       = sbercloud_networking_secgroup.security_groups[k].id
        region                  = try(value.region, "ru-moscow-1")
        description             = try(value.description, "Created by Terraform")
      }
    } : {}
  ]...)

  egress_rules_to_security_group_map = merge([
    for k, v in var.security_groups : can(v.egress_rules) ? {
      for key, value in v.egress_rules :
      "${k}_${key}" => {
        ethertype               = try(value.ethertype, "IPv4")
        protocol                = try(value.protocol, null)
        port_range_min          = try(value.port_range_min, null)
        port_range_max          = try(value.port_range_max, null)
        ports                   = try(value.ports, null)
        remote_address_group_id = try(value.remote_address_group_id, null)
        action                  = try(value.action, "allow")
        priority                = try(value.priority, "1")
        remote_ip_prefix        = try(value.remote_ip_prefix, null)
        remote_group_id         = try(value.remote_group_id, null)
        security_group_id       = sbercloud_networking_secgroup.security_groups[k].id
        region                  = try(value.region, "ru-moscow-1")
        description             = try(value.description, "Created by Terraform")
      }
    } : {}
  ]...)

}