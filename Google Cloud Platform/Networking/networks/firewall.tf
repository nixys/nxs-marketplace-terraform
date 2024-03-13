resource "google_compute_firewall" "firewall" {
  for_each = var.firewalls

  name        = each.key
  description = try(each.value.description, "Created by Terraform")
  network     = each.value.network
  project     = try(each.value.project, null)

  dynamic "allow" {
    for_each = try(each.value.allow, [])
    content {
      protocol          = allow.value.protocol
      ports             = try(allow.value.ports, [])
    }
  }

  dynamic "deny" {
    for_each = try(each.value.deny, [])
    content {
      protocol          = deny.value.protocol
      ports             = try(deny.value.ports, [])
    }
  }

  destination_ranges = try(each.value.destination_ranges , null)
  direction          = try(each.value.direction , null)
  disabled           = try(each.value.disabled , null)

  dynamic "log_config" {
    for_each = try(each.value.log_config, [])
    content {
      metadata = log_config.value.metadata
    }
  }

  priority                 = try(each.value.priority , null)            
  source_ranges            = try(each.value.source_ranges , null)            
  source_service_accounts  = try(each.value.source_service_accounts , null)            
  source_tags              = try(each.value.source_tags , [])
  target_service_accounts  = try(each.value.target_service_accounts , null)            
  target_tags              = try(each.value.target_tags , [])

  depends_on = [google_compute_network.network]
}