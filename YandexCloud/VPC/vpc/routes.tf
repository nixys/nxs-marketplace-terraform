resource "yandex_vpc_route_table" "route" {
  for_each = var.routes

  name        = each.key
  description = try(each.value.description, "Created by Terraform")

  network_id  = yandex_vpc_network.network[each.value.network_name].id

  dynamic "static_route" {
    for_each = each.value.static_route
    content {
      destination_prefix = try(static_route.value.destination_prefix, null)
      next_hop_address   = static_route.value.need_gateway == "true" ? null : try(static_route.value.next_hop_address, null)
      gateway_id         = static_route.value.need_gateway == "true" ? try(yandex_vpc_gateway.gateway[static_route.value.gateway_name].id, null) : null
    }
  }
  labels      = try(each.value.labels, {})
}
