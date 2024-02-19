resource "yandex_compute_instance" "instance" {
  for_each = var.instances

  name                      = each.key
  description               = try(each.value.description, "Created by Terraform")
  zone                      = try(each.value.zone, "ru-central1-a")
  hostname                  = try(each.value.hostname, null)
  platform_id               = each.value.platform_id
  metadata                  = length(each.value.isntance_default_ssh_keys) > 0 ? {
    ssh-keys  = join("\n", flatten([
      for username, ssh_keys in each.value.isntance_default_ssh_keys : [
        for ssh_key in ssh_keys
        : "${username}:${ssh_key}"
      ]
    ]))
  } : {}
  service_account_id        = try(each.value.service_account_id, null)
  allow_stopping_for_update = try(each.value.allow_stopping_for_update, false)
  network_acceleration_type = try(each.value.network_acceleration_type, "standard")
  gpu_cluster_id            = try(yandex_compute_gpu_cluster.gpu_cluster[each.value.gpu_cluster_name].id, null)
  maintenance_policy        = try(each.value.maintenance_policy, "unspecified")
  maintenance_grace_period  = try(each.value.maintenance_grace_period, "60s")

  scheduling_policy {
    preemptible = try(each.value.preemptible, false)
  }

  placement_policy {
    placement_group_id  = try(yandex_compute_placement_group.placement_group[each.value.placement_group_name].id, "")
    host_affinity_rules = try(each.value.host_affinity_rules, [])
  }
  
  dynamic "local_disk" {
    for_each = try(each.value.local_disk, [])
    content {
      size_bytes = local_disk.value.size_bytes
    }
  }

  dynamic "filesystem" {
    for_each = try(each.value.filesystem, [])
    content {
      filesystem_id = yandex_compute_filesystem.filesystem[filesystem.value.filesystem_name].id
      device_name   = try(filesystem.value.device_name, null)
      mode          = try(filesystem.value.mode, "READ_WRITE")
    }
  }

  resources {
    cores         = each.value.resources_cores
    memory        = each.value.resources_memory
    core_fraction = try(each.value.resources_core_fraction, null)
  }

  dynamic "boot_disk" {
    for_each = try(each.value.boot_disk, [])
    content {
      auto_delete = try(boot_disk.value.auto_delete, true)
      mode        = try(boot_disk.value.mode, "READ_WRITE")
      disk_id     = try(yandex_compute_disk.disk[boot_disk.value.disk_name].id, null)
      dynamic "initialize_params" {
        for_each = boot_disk.value.disk_name != "" ? [] : try(boot_disk.value.initialize_params, [])
        content {
          name        = each.key
          description = try(initialize_params.value.description, "Created by Terraform")
          size        = try(initialize_params.value.size, null)
          block_size  = try(initialize_params.value.block_size, null)
          type        = try(initialize_params.value.type, null)
          image_id    = try(yandex_compute_image.image[initialize_params.value.image_name].id, null)
          snapshot_id = try(yandex_compute_snapshot.snapshot[initialize_params.value.snapshot_name].id, null)
        }
      }
    }
  }

  network_interface {
    subnet_id          = each.value.subnet_id
    ipv4               = try(each.value.ipv4, true)
    ip_address         = try(each.value.ip_address, null)
    ipv6               = try(each.value.ipv6, false)
    ipv6_address       = try(each.value.ipv6_address, null)
    nat                = try(each.value.nat, true)
    nat_ip_address     = try(each.value.nat_ip_address, null)
    security_group_ids = try(each.value.security_group_ids, [])
    dynamic "dns_record" {
      for_each = try(each.value.dns_record, [])
      content {
        fqdn         = dns_record.value.fqdn
        dns_zone_id  = try(dns_record.value.dns_zone_id , null)
        ttl          = try(dns_record.value.ttl , null)
        ptr          = try(dns_record.value.ptr , null)
      }
    }
    dynamic "ipv6_dns_record" {
      for_each = try(each.value.ipv6_dns_record, [])
      content {
        fqdn         = ipv6_dns_record.value.fqdn
        dns_zone_id  = try(ipv6_dns_record.value.dns_zone_id , null)
        ttl          = try(ipv6_dns_record.value.ttl , null)
        ptr          = try(ipv6_dns_record.value.ptr , null)
      }
    }
    dynamic "nat_dns_record" {
      for_each = try(each.value.nat_dns_record, [])
      content {
        fqdn         = nat_dns_record.value.fqdn
        dns_zone_id  = try(nat_dns_record.value.dns_zone_id , null)
        ttl          = try(nat_dns_record.value.ttl , null)
        ptr          = try(nat_dns_record.value.ptr , null)
      }
    }
  }

  dynamic "secondary_disk" {
    for_each = try(each.value.secondary_disk, [])
    content {
      disk_id     = try(yandex_compute_disk.disk[secondary_disk.value.disk_name].id, null)
      auto_delete = try(secondary_disk.value.auto_delete , false)
      device_name = try(secondary_disk.value.device_name , null)
      mode        = try(secondary_disk.value.mode , "READ_WRITE")
    }
  }

  labels = try(each.value.labels, {})

  depends_on = [yandex_compute_image.image , yandex_compute_disk.disk]
}