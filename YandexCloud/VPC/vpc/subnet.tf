resource "yandex_vpc_subnet" "subnet" {
  for_each = var.subnets

  name           = each.key
  description    = try(each.value.description, "Created by Terraform")
  network_id     = yandex_vpc_network.network[each.value.network_name].id

  v4_cidr_blocks = each.value.cidr
  zone           = each.value.zone

  route_table_id = try(yandex_vpc_route_table.route[each.value.route_table_name].id, null)

  labels         = try(each.value.labels, {})
}
