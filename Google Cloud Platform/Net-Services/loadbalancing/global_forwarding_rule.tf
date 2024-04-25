resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  for_each = var.global_forwarding_rules

  name                        = each.key
  target                      = try(google_compute_target_tcp_proxy.target_tcp_proxy[each.value.target_tcp].id, google_compute_target_http_proxy.target_http_proxy[each.value.target_http].id, google_compute_target_grpc_proxy.target_grpc_proxy[each.value.target_grpc].id, google_compute_target_https_proxy.target_https_proxy[each.value.target_https].id, google_compute_target_ssl_proxy.target_ssl_proxy[each.value.target_ssl].id, null)
  description                 = try(each.value.description, "Created by Terraform")
  ip_address                  = try(each.value.ip_address, null)
  ip_protocol                 = try(each.value.ip_protocol, null)
  ip_version                  = try(each.value.ip_version, null)
  load_balancing_scheme       = try(each.value.load_balancing_scheme, null)
  project                     = try(each.value.project, null)

  dynamic "metadata_filters" {
    for_each = try(each.value.metadata_filters, [])
    content {
      filter_match_criteria  = try(metadata_filters.value.filter_match_criteria, null)
      dynamic "filter_labels" {
        for_each = try(metadata_filters.value.filter_labels, [])
        content {
          name  = filter_labels.value.name
          value = filter_labels.value.value
        }
      }
    }
  }

  network              = try(each.value.network, null)
  port_range           = try(each.value.port_range, null)
  subnetwork           = try(each.value.subnetwork, null)

  dynamic "service_directory_registrations" {
    for_each = try(each.value.service_directory_registrations, [])
    content {
      namespace                = try(service_directory_registrations.value.namespace, null)
      service_directory_region = try(service_directory_registrations.value.service_directory_region, null)
    }
  }

  source_ip_ranges     = try(each.value.source_ip_ranges, null)
  no_automate_dns_zone = try(each.value.no_automate_dns_zone, null)

  labels               = try(each.value.labels, {})

  depends_on = [google_compute_target_tcp_proxy.target_tcp_proxy, google_compute_target_http_proxy.target_http_proxy,  google_compute_target_https_proxy.target_https_proxy, google_compute_backend_service.backend_service]
}
