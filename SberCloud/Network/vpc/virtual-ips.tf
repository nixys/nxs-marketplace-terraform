resource "sbercloud_networking_vip" "vip" {
  for_each   = var.virtual_ips
  name       = try(each.value.name, each.key)
  network_id = try(each.value.network_id, sbercloud_vpc_subnet.subnet[each.value.network_name].id)
  ip_address = try(each.value.ip_address, null)
  ip_version = try(each.value.ip_version, "4")
  region     = try(each.value.region, "ru-moscow-1")
}