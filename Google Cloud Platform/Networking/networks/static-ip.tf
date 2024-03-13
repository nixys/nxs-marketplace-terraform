resource "google_compute_address" "address" {
  for_each = var.static_ips

  name                  = each.key
  address               = try(each.value.address , null)
  address_type          = try(each.value.address_type , null)
  description           = try(each.value.description, "Created by Terraform")
  region                = try(each.value.region , null)
  project               = try(each.value.project , null)
  purpose               = try(each.value.purpose , null)
  network_tier          = try(each.value.network_tier , null)
  subnetwork            = try(each.value.subnetwork , null)
  network               = try(each.value.network , null)
  prefix_length         = try(each.value.prefix_length , null)
  ip_version            = try(each.value.ip_version , null)
  ipv6_endpoint_type    = try(each.value.ipv6_endpoint_type , null)

  labels = try(each.value.labels, {})
}