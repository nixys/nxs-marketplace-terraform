resource "yandex_kubernetes_node_group" "node_group" {
  for_each = var.node_groups

  name                   = each.key
  description            = try(each.value.description, "Created by Terraform")
  cluster_id             = yandex_kubernetes_cluster.cluster[each.value.cluster_name].id
  version                = try(each.value.node_version, var.kubernetes_version)
  node_labels            = try(each.value.node_labels, {})
  node_taints            = try(each.value.node_taints, [])
  allowed_unsafe_sysctls = try(each.value.allowed_unsafe_sysctls, null)

  instance_template {
    platform_id = each.value.platform_id
    name = try(each.value.template_name, null)
    metadata    = length(each.value.node_groups_default_ssh_keys) > 0 ? {
      ssh-keys  = join("\n", flatten([
        for username, ssh_keys in each.value.node_groups_default_ssh_keys : [
          for ssh_key in ssh_keys
          : "${username}:${ssh_key}"
        ]
      ]))
    } : {}
  
    resources {
      cores         = try(each.value.resources_cores, 2)
      core_fraction = try(each.value.resources_core_fraction, 100)
      memory        = try(each.value.resources_memory, 2)
      gpus          = try(each.value.resources_gpus, 0) 
    }

    boot_disk {
      type = try(each.value.boot_disk_type, "network-hdd")
      size = try(each.value.boot_disk_size, 30)
    }

    scheduling_policy {
      preemptible = try(each.value.preemptible, false)
    }

    network_interface {
      subnet_ids            = each.value.subnet_ids
      ipv4                  = try(each.value.ipv4, true)
      ipv6                  = try(each.value.ipv6, false)
      nat                   = try(each.value.nat, null)
      security_group_ids    = try(each.value.security_group_ids, [])
      dynamic "ipv4_dns_records" {
        for_each = try(each.value.ipv4_dns_records, [])
  
        content {
          fqdn        = ipv4_dns_records.value.fqdn
          dns_zone_id = try(ipv4_dns_records.value.dns_zone_id, null)
          ttl         = try(ipv4_dns_records.value.ttl, null)
          ptr         = try(ipv4_dns_records.value.ptr, null)
        }
      }
      dynamic "ipv6_dns_records" {
        for_each = try(each.value.ipv4_dns_records, [])
  
        content {
          fqdn        = ipv4_dns_records.value.fqdn
          dns_zone_id = try(ipv4_dns_records.value.dns_zone_id , null)
          ttl         = try(ipv4_dns_records.value.ttl , null)
          ptr         = try(ipv4_dns_records.value.ptr , null)
        }
      }
    }

    network_acceleration_type = try(each.value.network_acceleration_type, "standard")

    container_runtime {
      type = try(each.value.container_runtime, "containerd")
    }

    labels = try(each.value.instance_labels, {})
  }

  scale_policy {
    dynamic "fixed_scale" {
      for_each = try(each.value.fixed_scale, [])

      content {
        size = fixed_scale.value.size
      }
    }

    dynamic "auto_scale" {
      for_each = try(each.value.auto_scale, [])

      content {
        min     = auto_scale.value.min
        max     = auto_scale.value.max
        initial = auto_scale.value.initial
      }
    }
  }

  allocation_policy {
    dynamic "location" {
      for_each = each.value.node_hosts

      content {
        zone      = location.value.zone
      }
    }
  }

  maintenance_policy {
    auto_repair  = try(each.value.auto_repair, true)
    auto_upgrade = try(each.value.auto_upgrade, false)

    dynamic "maintenance_window" {
      for_each = try(each.value.maintenance_windows, [])

      content {
        day        = try(maintenance_window.value.day , "monday")
        start_time = try(maintenance_window.value.start_time , "23:00")
        duration   = try(maintenance_window.value.duration , "4h30m")
      }
    }
  }

  dynamic "deploy_policy" {
    for_each = try(each.value.deploy_policy, [])
    content {
      max_expansion   = try(deploy_policy.value.max_expansion , 2)
      max_unavailable = try(deploy_policy.value.max_unavailable , 1)
    }
  }

  labels = try(each.value.labels, {})

  depends_on = [yandex_kubernetes_cluster.cluster]
}
