resource "google_compute_subnetwork" "subnetwork" {
  for_each = var.subnetworks

  name                     = each.key
  description              = try(each.value.description, "Created by Terraform")
  ip_cidr_range            = each.value.ip_cidr_range
  network                  = google_compute_network.network[each.value.network_name].id
  project                  = try(each.value.project, null)
  role                     = try(each.value.role, null)

  dynamic "secondary_ip_range" {
    for_each = try(each.value.secondary_ip_range, [])
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }

  private_ip_google_access   = try(each.value.private_ip_google_access , null)
  private_ipv6_google_access = try(each.value.private_ipv6_google_access , null)
  region                     = try(each.value.region , null)

  dynamic "log_config" {
    for_each = try(each.value.log_config, [])
    content {
      aggregation_interval = try(log_config.value.aggregation_interval, null)
      flow_sampling        = try(log_config.value.flow_sampling, null)
      metadata             = try(log_config.value.metadata , null)
      metadata_fields      = try(log_config.value.metadata_fields , null)
      filter_expr          = try(log_config.value.filter_expr , null)
    }
  }
  
  stack_type                       = try(each.value.stack_type , null)
  ipv6_access_type                 = try(each.value.ipv6_access_type , null)
  external_ipv6_prefix             = try(each.value.external_ipv6_prefix , null)

  depends_on = [google_compute_network.network]
}
