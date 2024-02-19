#==================== Network Outputs ====================#
output "network_names" {
  value = [for k, v in yandex_vpc_network.network : k]
}

output "network_ids" {
  value = { for k, v in yandex_vpc_network.network : k => v.id }
}

#==================== Subnets Outputs ====================#
output "subnet_names" {
  value = [for k, v in yandex_vpc_subnet.subnet : v.name]
}

output "subnet_ids" {
  value = zipmap([for k, v in yandex_vpc_subnet.subnet : v.name], [for k, v in yandex_vpc_subnet.subnet : yandex_vpc_subnet.subnet[v.name].id])
}

#==================== Static ips Outputs ====================#
output "external_ips_names" {
  value = {
    for v in yandex_vpc_address.address : "${v.name}" => v.external_ipv4_address[0].address
  }
}

#==================== SG Outputs ====================#
output "sg_names" {
  value = [for k, v in yandex_vpc_security_group.security_group : v.name]
}

output "sg_ids" {
  value = zipmap([for k, v in yandex_vpc_security_group.security_group : v.name], [for k, v in yandex_vpc_security_group.security_group : yandex_vpc_security_group.security_group[v.name].id])
}