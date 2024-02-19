resource "yandex_kubernetes_cluster" "cluster" {
  for_each = var.clusters

  name                     = each.key
  description              = try(each.value.description, "Created by Terraform")
  network_id               = each.value.network_id
  service_account_id       = try(each.value.service_account_id, null)
  node_service_account_id  = try(each.value.service_account_id, null)
  release_channel          = try(each.value.release_channel, "STABLE")
  cluster_ipv4_range       = try(each.value.cluster_ipv4_range, null)
  cluster_ipv6_range       = try(each.value.cluster_ipv6_range, null)
  service_ipv4_range       = try(each.value.service_ipv4_range, null)
  service_ipv6_range       = try(each.value.service_ipv6_range, null)
  node_ipv4_cidr_mask_size = try(each.value.node_ipv4_cidr_mask_size, null)
  network_policy_provider  = try(each.value.network_policy_provider, "CALICO")

  master {
    version   = try(each.value.master_version, var.kubernetes_version)
    public_ip = try(each.value.master_public_ip, false)
    security_group_ids = try(each.value.security_group_ids, [])

    dynamic "zonal" {
      for_each = length(each.value.masters_hosts) > 1 ? [] : each.value.masters_hosts

      content {
        zone      = zonal.value.zone
        subnet_id = zonal.value.subnet_id
      }
    }

    dynamic "regional" {
      for_each = length(each.value.masters_hosts) > 1 ? var.clusters : {}

      content {
        region = "ru-central1"

        dynamic "location" {
          for_each = regional.value.masters_hosts

          content {
            zone      = location.value.zone
            subnet_id = location.value.subnet_id
          }
        }
      }
    }

    maintenance_policy {
      auto_upgrade = try(each.value.master_auto_upgrade, false)

      dynamic "maintenance_window" {
        for_each = try(each.value.master_maintenance_windows, [])

        content {
          day        = try(maintenance_window.value.day , "friday")
          start_time = try(maintenance_window.value.start_time , "23:00")
          duration   = try(maintenance_window.value.duration , "3h30m")
        }
      }
    }

    dynamic "master_logging" {
      for_each = try(each.value.master_logging, [])
  
      content {
        enabled                    = try(master_logging.value.enabled, false)
        log_group_id               = try(master_logging.value.log_group_id , null)
        kube_apiserver_enabled     = try(master_logging.value.kube_apiserver_enabled , false)
        cluster_autoscaler_enabled = try(master_logging.value.cluster_autoscaler_enabled , false)
        events_enabled             = try(master_logging.value.events_enabled , false)
        audit_enabled              = try(master_logging.value.audit_enabled , false)
      }
    }
  }

  dynamic "kms_provider" {
    for_each = try(each.value.kms_provider, [])

    content {
      key_id = try(kms_provider.value.key_id, null)
    }
  }

  labels = try(each.value.labels, {})
}