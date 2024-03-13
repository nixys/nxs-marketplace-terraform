resource "google_compute_network" "network" {
  for_each = var.networks

  name                                      = each.key
  description                               = try(each.value.description, "Created by Terraform")
  project                                   = try(each.value.project, null)
  auto_create_subnetworks                   = try(each.value.auto_create_subnetworks, null)
  routing_mode                              = try(each.value.routing_mode, null)
  mtu                                       = try(each.value.mtu, null)
  enable_ula_internal_ipv6                  = try(each.value.enable_ula_internal_ipv6, null)
  internal_ipv6_range                       = try(each.value.internal_ipv6_range, null)
  network_firewall_policy_enforcement_order = try(each.value.network_firewall_policy_enforcement_order, null)
  delete_default_routes_on_create           = try(each.value.delete_default_routes_on_create, null)
}