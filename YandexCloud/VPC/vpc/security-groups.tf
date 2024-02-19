resource "yandex_vpc_security_group" "security_group" {
  for_each = var.security_groups

  name        = each.key
  description = try(each.value.description, "Created by Terraform")
  network_id  = yandex_vpc_network.network[each.value.network_name].id
  
  dynamic "ingress" {
    for_each = each.value.firewall_ingress_rules
    content {
      protocol          = try(ingress.value.protocol, null)
      description       = try(ingress.value.description, null)
      labels            = try(ingress.value.labels, null)
      from_port         = try(ingress.value.from_port, null)
      to_port           = try(ingress.value.to_port, null)
      security_group_id = try(ingress.value.security_group_id, null)
      predefined_target = try(ingress.value.predefined_target, null)
      v4_cidr_blocks    = try(ingress.value.v4_cidr_blocks, null)
      v6_cidr_blocks    = try(ingress.value.v6_cidr_blocks, null)
      port              = try(ingress.value.port, null)
    }
  }

  dynamic "egress" {
    for_each = try(each.value.firewall_egress_rules, [local.default_egress_rules])
    content {
      protocol          = try(egress.value.protocol, null)
      description       = try(egress.value.description, null)
      labels            = try(egress.value.labels, null)
      from_port         = try(egress.value.from_port, null)
      to_port           = try(egress.value.to_port, null)
      security_group_id = try(egress.value.security_group_id, null)
      predefined_target = try(egress.value.predefined_target, null)
      v4_cidr_blocks    = try(egress.value.v4_cidr_blocks, null)
      v6_cidr_blocks    = try(egress.value.v6_cidr_blocks, null)
      port              = try(egress.value.port, null)
    }
  }
  labels      = try(each.value.labels, {})
}
