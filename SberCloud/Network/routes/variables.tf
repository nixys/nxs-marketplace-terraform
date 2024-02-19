variable "route_tables" {
  description = "Route tables settings"
  type        = any

  validation {
    condition     = alltrue([for j in var.route_tables : alltrue([for z in j.static_route : contains(["ecs", "eni", "vip", "nat", "peering", "vpn", "dc", "cc"], z.type)])])
    error_message = "Only ecs, eni, vip, nat, peering, vpn, dc, cc route type supported!"
  }
}

