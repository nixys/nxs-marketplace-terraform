resource "google_compute_forwarding_rule" "forwarding_rule" {
  for_each = var.forwarding_rules

  name                        = each.key
  is_mirroring_collector      = try(each.value.is_mirroring_collector, null)
  target                      = try(google_compute_region_target_tcp_proxy.region_target_tcp_proxy[each.value.target_tcp].id, google_compute_region_target_http_proxy.region_target_http_proxy[each.value.target_http].id, google_compute_region_target_https_proxy.region_target_https_proxy[each.value.target_https].id, null) 
  description                 = try(each.value.description, "Created by Terraform")
  ip_address                  = try(each.value.ip_address, null)
  ip_protocol                 = try(each.value.ip_protocol, null)
  backend_service             = try(google_compute_region_backend_service.region_backend_service[each.value.backend_service].id, null)
  ip_version                  = try(each.value.ip_version, null)
  load_balancing_scheme       = try(each.value.load_balancing_scheme, null)
  project                     = try(each.value.project, null)

  network                     = try(each.value.network, null)
  port_range                  = try(each.value.port_range, null)
  ports                       = try(each.value.ports, null)
  all_ports                   = try(each.value.all_ports, null)
  network_tier                = try(each.value.network_tier, null)
  subnetwork                  = try(each.value.subnetwork, null)

  dynamic "service_directory_registrations" {
    for_each = try(each.value.service_directory_registrations, [])
    content {
      namespace  = try(service_directory_registrations.value.namespace, null)
      service    = try(service_directory_registrations.value.service, null)
    }
  }

  service_label           = try(each.value.service_label, null)
  source_ip_ranges        = try(each.value.source_ip_ranges, null)
  allow_psc_global_access = try(each.value.allow_psc_global_access, null)
  no_automate_dns_zone    = try(each.value.no_automate_dns_zone, null)
  allow_global_access     = try(each.value.allow_global_access, null)
  region                  = try(each.value.region, null)
  recreate_closed_psc     = try(each.value.recreate_closed_psc, null)

  labels               = try(each.value.labels, {})

  depends_on = [google_compute_region_target_tcp_proxy.region_target_tcp_proxy, google_compute_region_target_http_proxy.region_target_http_proxy,  google_compute_region_target_https_proxy.region_target_https_proxy, google_compute_region_backend_service.region_backend_service]
}
