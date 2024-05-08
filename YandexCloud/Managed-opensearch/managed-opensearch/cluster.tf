resource "yandex_mdb_opensearch_cluster" "cluster" {
  for_each = var.clusters

  name                = each.key
  environment         = try(each.value.environment, "PRODUCTION")
  network_id          = each.value.network_id
  description         = try(each.value.description, "Created by Terraform")
  security_group_ids  = try(each.value.security_group_id, [])
  deletion_protection = try(each.value.deletion_protection, false)
  labels              = try(each.value.labels, {})
  service_account_id  = try(each.value.service_account_id, "")

  config {
    admin_password = random_password.admin_pass[each.key].result
    version        = each.value.version
    opensearch {
      dynamic "node_groups" {
        for_each = each.value.opensearch_node_groups
        content {
          name             = node_groups.value.name
          hosts_count      = node_groups.value.hosts_count
          assign_public_ip = try(node_groups.value.assign_public_ip, false)
          zone_ids         = node_groups.value.zone_ids
          subnet_ids       = try(node_groups.value.subnet_ids, [])
          roles            = try(node_groups.value.roles, ["DATA", "MANAGER"])
          resources {
            resource_preset_id = node_groups.value.resources_preset_id
            disk_size          = node_groups.value.disk_size
            disk_type_id       = node_groups.value.disk_type_id
          }
        }
      }
      plugins = try(each.value.opensearch_plugins, [])
    }
    dynamic "dashboards" {
      for_each = try(each.value.dashboards_node_groups, [])
      content {
        dynamic "node_groups" {
          for_each = each.value.dashboards_node_groups
          content {
            name             = node_groups.value.name
            hosts_count      = node_groups.value.hosts_count
            assign_public_ip = try(node_groups.value.assign_public_ip, false)
            zone_ids         = node_groups.value.zone_ids
            subnet_ids       = try(node_groups.value.subnet_ids, [])
            resources {
              resource_preset_id = node_groups.value.resources_preset_id
              disk_size          = node_groups.value.disk_size
              disk_type_id       = node_groups.value.disk_type_id
            }
          }
        }
      }
    }
  }
  maintenance_window {
    type = try(each.value.maintenance_window_type, "ANYTIME")
    day  = each.value.maintenance_window_day
    hour = each.value.maintenance_window_hour
  }
}
