resource "google_container_cluster" "primary" {
  for_each = var.clusters

  name                     = each.key
  location                 = try(each.value.location, null)
  node_locations           = try(each.value.node_locations, [])
  deletion_protection      = try(each.value.deletion_protection, null)

  addons_config {
    http_load_balancing {
      disabled = ! each.value.enable_http_load_balancing
    }

    horizontal_pod_autoscaling {
      disabled = ! each.value.enable_horizontal_pod_autoscaling
    }
  }

  cluster_autoscaling {
    enabled = try(each.value.cluster_autoscaling_enabled, null)

    dynamic "resource_limits" {
      for_each = try(each.value.resource_limits, [])
      content {
        resource_type = try(resource_limits.value.autoscaling_resource_type, "cpu")
        minimum       = try(resource_limits.value.autoscaling_resource_min, null)
        maximum       = try(resource_limits.value.autoscaling_resource_max, null)
      }
    }
  }

  default_max_pods_per_node = try(each.value.default_max_pods_per_node, null)
  initial_node_count        = try(each.value.initial_node_count, null)

  ip_allocation_policy {
    services_secondary_range_name = try(each.value.services_range_name, null) # SERVICE range
    cluster_secondary_range_name  = try(each.value.pods_range_name, null)     # POD range
  }

  dynamic "master_authorized_networks_config" {
    for_each = try (each.value.master_authorized_networks_config, [])
    content {
      cidr_blocks {
        cidr_block    = try(master_authorized_networks_config.value.cidr_block, "")
        display_name  = try(master_authorized_networks_config.value.display_name, "")
      }
    }
  }

  min_master_version = try(each.value.min_master_version, null)
  network            = try(each.value.network, null)

  private_cluster_config {
    enable_private_nodes    = try(each.value.enable_private_nodes, null)
    enable_private_endpoint = try(each.value.enable_private_endpoint, null)
    master_ipv4_cidr_block  = each.value.enable_private_nodes == true ? each.value.master_ipv4_cidr_block : null
  }

  release_channel {
    channel = try(each.value.channel, null)
  }

  remove_default_node_pool = try(each.value.remove_default_node_pool, null)

  vertical_pod_autoscaling {
    enabled = try(each.value.enable_vertical_pod_autoscaling, null)
  }

  subnetwork = try(each.value.subnetwork, null)

  timeouts {
    create = try(each.value.timeout_create, null)
    update = try(each.value.timeout_update, null)
    delete = try(each.value.timeout_delete, null)
  }

}

