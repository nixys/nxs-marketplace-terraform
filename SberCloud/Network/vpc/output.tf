#==================== Network Outputs ==================== #
output "vpc_names" {
  value = [for k, v in sbercloud_vpc.vpc : k]
}

output "vpc_ids" {
  value = { for k, v in sbercloud_vpc.vpc : k => v.id }
}

output "vpc_cidrs" {
  value = { for k, v in sbercloud_vpc.vpc : k => v.cidr }
}

output "subnet_names" {
  value = [for k, v in sbercloud_vpc_subnet.subnet : k]
}

output "subnet_ids" {
  value = { for k, v in sbercloud_vpc_subnet.subnet : k => v.id }
}

output "subnet_ipv4_ids" {
  value = { for k, v in sbercloud_vpc_subnet.subnet : k => v.subnet_id }
}

output "subnet_ipv6_ids" {
  value = { for k, v in sbercloud_vpc_subnet.subnet : k => v.ipv6_subnet_id }
}

output "peering_names" {
  value = [for k, v in sbercloud_vpc_peering_connection.peering : k]
}

output "peering_ids" {
  value = { for k, v in sbercloud_vpc_peering_connection.peering : k => v.id }
}

output "accepter_peering_names" {
  value = [for k, v in sbercloud_vpc_peering_connection_accepter.accepter_peering : k]
}

output "accepter_peering_ids" {
  value = { for k, v in sbercloud_vpc_peering_connection_accepter.accepter_peering : k => v.id }
}

output "nat_gateway_names" {
  value = [for k, v in sbercloud_nat_gateway.nat : k]
}

output "nat_gateway_ids" {
  value = { for k, v in sbercloud_nat_gateway.nat : k => v.id }
}

output "network_acl_names" {
  value = [
    for k, v in sbercloud_network_acl.nacl : v.name
  ]
}

output "network_acl_ids" {
  value = {
    for k, v in sbercloud_network_acl.nacl : v.name => v.id
  }
}

output "network_acl_inbound_rules_names" {
  value = [
    for k, v in sbercloud_network_acl_rule.inbound_rules : v.name
  ]
}

output "network_acl_inbound_rules_ids" {
  value = { for k, v in sbercloud_network_acl_rule.inbound_rules : v.name => v.id }
}

output "network_acl_outbound_rules_names" {
  value = [
    for k, v in sbercloud_network_acl_rule.outbound_rules : v.name
  ]
}

output "network_acl_outbound_rules_ids" {
  value = { for k, v in sbercloud_network_acl_rule.outbound_rules : v.name => v.id }
}

output "eip_addresses" {
  value = { for k, v in sbercloud_vpc_eip.eip : k => v.address }
}

output "eip_ids" {
  value = { for k, v in sbercloud_vpc_eip.eip : k => v.id }
}

output "virtual_ip_names" {
  value = [for k, v in sbercloud_networking_vip.vip : k]
}

output "virtual_ip_addresses" {
  value = { for k, v in sbercloud_networking_vip.vip : k => v.ip_address }
}

output "security_group_names" {
  value = [for k, v in sbercloud_networking_secgroup.security_groups : k]
}

output "security_group_ids" {
  value = { for k, v in sbercloud_networking_secgroup.security_groups : k => v.id }
}

output "security_group_ingress_rules_names" {
  value = [for k, v in sbercloud_networking_secgroup_rule.ingress_rules : k]
}

output "security_group_ingress_rules_ids" {
  value = { for k, v in sbercloud_networking_secgroup_rule.ingress_rules : k => v.id }
}

output "security_group_egress_rules_names" {
  value = [for k, v in sbercloud_networking_secgroup_rule.egress_rules : k]
}

output "security_group_egress_rules_ids" {
  value = { for k, v in sbercloud_networking_secgroup_rule.egress_rules : k => v.id }
}

output "snat_ids" {
  value = { for k, v in sbercloud_nat_snat_rule.snat : k => v.id }
}

output "dnat_ids" {
  value = { for k, v in sbercloud_nat_dnat_rule.dnat : k => v.id }
}


