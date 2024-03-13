resource "google_compute_router_nat" "router_nat" {
  for_each = var.router_nats

  name                               = each.key
  project                            = try(each.value.project, null)
  region                             = try(each.value.region , null)
  source_subnetwork_ip_ranges_to_nat = each.value.source_subnetwork_ip_ranges_to_nat
  router                             = each.value.router
  nat_ip_allocate_option             = try(each.value.nat_ip_allocate_option, null)
  nat_ips                            = each.value.nat_ip_allocate_option == "MANUAL_ONLY" ? try(each.value.nat_ips, []) : []
  drain_nat_ips                      = try(each.value.drain_nat_ips, [])
  
  dynamic "subnetwork" {
    for_each = try(each.value.subnetwork, [])
    content {
      name                     = google_compute_subnetwork.subnetwork[subnetwork.value.name].id
      source_ip_ranges_to_nat  = try(subnetwork.value.source_ip_ranges_to_nat, null)
      secondary_ip_range_names = try(subnetwork.value.secondary_ip_range_names, null)
    }
  }
  
  min_ports_per_vm                 = try(each.value.min_ports_per_vm , null)
  max_ports_per_vm                 = try(each.value.max_ports_per_vm , null)
  enable_dynamic_port_allocation   = try(each.value.enable_dynamic_port_allocation , null)
  udp_idle_timeout_sec             = try(each.value.udp_idle_timeout_sec , null)
  icmp_idle_timeout_sec            = try(each.value.icmp_idle_timeout_sec , null)
  tcp_established_idle_timeout_sec = try(each.value.tcp_established_idle_timeout_sec , null)
  tcp_transitory_idle_timeout_sec  = try(each.value.tcp_transitory_idle_timeout_sec , null)
  tcp_time_wait_timeout_sec        = try(each.value.tcp_time_wait_timeout_sec , null)

  dynamic "log_config" {
    for_each = try(each.value.log_config, [])
    content {
      enable = log_config.value.enable
      filter = log_config.value.filter
    }
  }

  dynamic "rules" {
    for_each = try(each.value.rules, [])
    content {
      rule_number = rules.value.rule_number
      description = try(rules.value.description, "Created by Terraform")
      match       = rules.value.match
      dynamic "action" {
        for_each = try(rules.value.action, [])
        content {
          source_nat_active_ips = try(action.value.source_nat_active_ips , null)
          source_nat_drain_ips  = try(action.value.source_nat_drain_ips , null)
        }
      }
    }
  }

  enable_endpoint_independent_mapping = try(each.value.enable_endpoint_independent_mapping, null)

  depends_on = [google_compute_router.router, google_compute_address.address]
}



