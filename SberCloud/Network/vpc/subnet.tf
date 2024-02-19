resource "sbercloud_vpc_subnet" "subnet" {

  for_each          = var.subnets
  name              = try(each.value.name, each.key)
  vpc_id            = try(each.value.vpc_id, sbercloud_vpc.vpc[each.value.vpc_name].id)
  cidr              = each.value.cidr
  gateway_ip        = each.value.gateway_ip
  description       = try(each.value.description, "Created by Terraform")
  ipv6_enable       = try(each.value.ipv6_enable, false)
  dhcp_enable       = try(each.value.dhcp_enable, true)
  dns_list          = try(each.value.dns_list, null)
  primary_dns       = try(each.value.primary_dns, null)
  secondary_dns     = try(each.value.secondary_dns, null)
  availability_zone = try(each.value.availability_zone, null)
  region            = try(each.value.region, "ru-moscow-1")
  tags              = try(each.value.tags, { created_by = "Terraform" })
}
