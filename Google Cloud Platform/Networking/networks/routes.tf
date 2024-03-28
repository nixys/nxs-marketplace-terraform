resource "google_compute_router" "router" {
  for_each = var.routers

  name        = each.key
  description = try(each.value.description, "Created by Terraform")
  network     = each.value.network
  project     = try(each.value.project, null)
  region      = try(each.value.region , null)

  dynamic "bgp" {
    for_each = try(each.value.bgp, [])
    content {
      asn                = bgp.value.asn
      advertise_mode     = try(bgp.value.advertise_mode , null)
      advertised_groups  = try(bgp.value.advertised_groups , null)
      keepalive_interval = try(bgp.value.keepalive_interval , null)
      dynamic "advertised_ip_ranges" {
        for_each = try(bgp.value.advertised_ip_ranges, [])
        content {
          range       = advertised_ip_ranges.value.range
          description = try(advertised_ip_ranges.value.description, "Created by Terraform")
        }
      }
    }
  }

  depends_on = [google_compute_network.network]
}