resource "google_container_node_pool" "primary" {
  for_each = var.node_pools

  name     = each.key
  cluster  = each.value.cluster
  location = try(each.value.location, null)

  autoscaling {
    min_node_count = try(each.value.min_node_count, null)
    max_node_count = try(each.value.max_node_count, null)
  }

  initial_node_count = try(each.value.initial_node_count_per_zone, null)

  management {
    auto_repair  = try(each.value.auto_repair, null)
    auto_upgrade = try(each.value.auto_upgrade, null)
  }

  max_pods_per_node = try(each.value.max_pods_per_node, null)
  node_locations    = try(each.value.node_locations, [])

  node_config {
    disk_size_gb = try(each.value.disk_size_gb, null)
    disk_type    = try(each.value.disk_type, null)
    image_type   = try(each.value.image_type, null)
    machine_type = try(each.value.machine_type, null)
    oauth_scopes = try(each.value.oauth_scopes, null)

    labels = try(each.value.labels, {})

    dynamic "taint" {
      for_each = try(each.value.taint, [])
      content {
        effect = try(taint.value.effect, null)
        key    = try (taint.value.key, null)
        value  = try (taint.value.value, null)
      }
    }
  }

  upgrade_settings {
    max_surge       = try(each.value.upgrade_max_surge, null)
    max_unavailable = try(each.value.upgrade_max_unavailable, null)
  }

  depends_on = [google_container_cluster.primary]

}

