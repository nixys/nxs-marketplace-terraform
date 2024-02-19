resource "sbercloud_vpc_route_table" "route_table" {
  for_each = var.route_tables

  name        = try(each.value.name, each.key)
  vpc_id      = each.value.vpc_id
  subnets     = try(each.value.subnets, null)
  region      = try(each.value.region, "ru-moscow-1")
  description = try(each.value.description, "Created by Terraform")


  dynamic "route" {
    for_each = each.value.static_route
    content {
      destination = try(route.value.destination, null)
      nexthop     = try(route.value.nexthop, null)
      type        = try(route.value.type, null)
      description = try(route.value.description, "Created by Terraform")
    }
  }
}