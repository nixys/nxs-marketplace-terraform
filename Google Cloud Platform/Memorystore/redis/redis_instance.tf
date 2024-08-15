resource "google_redis_instance" "redis_instance" {
  for_each = { for k, v in var.redis : k => v if !v.is_cluster }

  name                    = each.key
  memory_size_gb          = each.value.memory_size_gb
  location_id             = try(each.value.location_id, null)
  alternative_location_id = try(each.value.alternative_location_id, null)
  auth_enabled            = try(each.value.auth_enabled, null)
  authorized_network      = try(each.value.authorized_network, null)
  connect_mode            = try(each.value.connect_mode, null)
  display_name            = try(each.value.display_name, null)
  labels                  = try(each.value.labels, null)
  redis_configs           = try(each.value.redis_configs, null)

  dynamic "persistence_config" {
    for_each = try(each.value.persistence_config, [])
    content {
      persistence_mode        = persistence_config.value.persistence_mode
      rdb_snapshot_period     = try(persistence_config.value.rdb_snapshot_period, null)
      rdb_snapshot_start_time = try(persistence_config.value.rdb_snapshot_start_time, null)
    }
  }

  dynamic "maintenance_policy" {
    for_each = try(each.value.maintenance_policy, [])
    content {
      description = try(maintenance_policy.value.description, null)
      dynamic "weekly_maintenance_window" {
        for_each = try(maintenance_policy.value.weekly_maintenance_window, [])
        content {
          day = weekly_maintenance_window.value.day
          dynamic "start_time" {
            for_each = weekly_maintenance_window.value.start_time
            content {
              hours   = try(start_time.value.hours, null)
              minutes = try(start_time.value.minutes, null)
              seconds = try(start_time.value.seconds, null)
              nanos   = try(start_time.value.nanos, null)
            }
          }
        }
      }
    }
  }

  redis_version           = try(each.value.redis_version, null)
  reserved_ip_range       = try(each.value.reserved_ip_range, null)
  tier                    = try(each.value.tier, null)
  transit_encryption_mode = try(each.value.transit_encryption_mode, null)
  replica_count           = try(each.value.replica_count, null)
  read_replicas_mode      = try(each.value.read_replicas_mode, null)
  secondary_ip_range      = try(each.value.secondary_ip_range, null)
  customer_managed_key    = try(each.value.customer_managed_key, null)
  region                  = try(each.value.region, null)
  project                 = try(each.value.project, null)
}