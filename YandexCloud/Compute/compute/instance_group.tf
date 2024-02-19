resource "yandex_compute_instance_group" "instance_group" {
  for_each = var.instance_groups

  name               = each.key
  service_account_id = try(each.value.service_account_id, null)

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
        initial_size           = try(auto_scale.value.initial_size , null)
        measurement_duration   = try(auto_scale.value.measurement_duration , null)
        cpu_utilization_target = try(auto_scale.value.cpu_utilization_target , null)
        min_zone_size          = try(auto_scale.value.min_zone_size , null)
        max_size               = try(auto_scale.value.max_size , null)
        warmup_duration        = try(auto_scale.value.warmup_duration , null)
        stabilization_duration = try(auto_scale.value.stabilization_duration , null)
        dynamic "custom_rule" {
          for_each = try(auto_scale.value.custom_rule, [])
          content {
            rule_type   = try(custom_rule.value.rule_type , null)
            metric_type = try(custom_rule.value.metric_type , null)
            metric_name = try(custom_rule.value.metric_name , null)
            target      = try(custom_rule.value.target , null)
            labels      = try(custom_rule.value.labels , {})
            service     = try(custom_rule.value.service , null)
          }
        }
      }
    }
  }

  dynamic "deploy_policy" {
    for_each = try(each.value.deploy_policy, [])
    content {
      max_expansion    = try(deploy_policy.value.max_expansion , 2)
      max_unavailable  = try(deploy_policy.value.max_unavailable , 1)
      max_deleting     = try(deploy_policy.value.max_deleting , null)
      max_creating     = try(deploy_policy.value.max_creating , null)
      startup_duration = try(deploy_policy.value.startup_duration , null)
      strategy         = try(deploy_policy.value.strategy , null)
    }
  }

  instance_template {
    platform_id = each.value.platform_id
    name        = try(each.value.template_name, null)
    hostname    = try(each.value.hostname, null)
    description = try(each.value.description, "Created by Terraform")
    metadata    = length(each.value.isntance_default_ssh_keys) > 0 ? {
      ssh-keys  = join("\n", flatten([
        for username, ssh_keys in each.value.isntance_default_ssh_keys : [
          for ssh_key in ssh_keys
          : "${username}:${ssh_key}"
        ]
      ]))
    } : {}
  
    resources {
      cores         = try(each.value.resources_cores, 2)
      core_fraction = try(each.value.resources_core_fraction, 100)
      memory        = try(each.value.resources_memory, 2)
    }

    dynamic "boot_disk" {
      for_each = try(each.value.boot_disk, [])
      content {
        name        = try(boot_disk.value.name, null)
        mode        = try(boot_disk.value.mode, "READ_WRITE")
        device_name = try(boot_disk.value.device_name, null)
        dynamic "initialize_params" {
          for_each = try(boot_disk.value.initialize_params, [])
          content {
            description = try(initialize_params.value.description, "Created by Terraform")
            size        = try(initialize_params.value.size, null)
            type        = try(initialize_params.value.type, null)
            image_id    = try(yandex_compute_image.image[initialize_params.value.image_name].id, null)
            snapshot_id = try(yandex_compute_snapshot.snapshot[initialize_params.value.snapshot_name].id, null)
          }
        }
      }
    }

    scheduling_policy {
      preemptible = try(each.value.preemptible, false)
    }

    placement_policy {
      placement_group_id  = try(yandex_compute_placement_group.placement_group[each.value.placement_group_name].id, "")
    }

    network_interface {
      network_id            = each.value.network_id
      subnet_ids            = each.value.subnet_ids
      ip_address            = try(each.value.ip_address, null)
      ipv6_address          = try(each.value.ipv6_address, null)
      nat                   = try(each.value.nat, true)
      nat_ip_address        = try(each.value.nat_ip_address, null)
      security_group_ids    = try(each.value.security_group_ids, [])
      dynamic "dns_record" {
        for_each = try(each.value.dns_record, [])
  
        content {
          fqdn        = dns_record.value.fqdn
          dns_zone_id = try(dns_record.value.dns_zone_id, null)
          ttl         = try(dns_record.value.ttl, null)
          ptr         = try(dns_record.value.ptr, null)
        }
      }
      dynamic "nat_dns_record" {
        for_each = try(each.value.nat_dns_record, [])
  
        content {
          fqdn        = nat_dns_record.value.fqdn
          dns_zone_id = try(nat_dns_record.value.dns_zone_id, null)
          ttl         = try(nat_dns_record.value.ttl, null)
          ptr         = try(nat_dns_record.value.ptr, null)
        }
      }
      dynamic "ipv6_dns_record" {
        for_each = try(each.value.ipv6_dns_record, [])
  
        content {
          fqdn        = ipv6_dns_record.value.fqdn
          dns_zone_id = try(ipv6_dns_record.value.dns_zone_id , null)
          ttl         = try(ipv6_dns_record.value.ttl , null)
          ptr         = try(ipv6_dns_record.value.ptr , null)
        }
      }
    }

    dynamic "secondary_disk" {
      for_each = try(each.value.secondary_disk, [])
      content {
        disk_id     = try(yandex_compute_disk.disk[secondary_disk.value.disk_name].id, null)
        device_name = try(secondary_disk.value.device_name , null)
        mode        = try(secondary_disk.value.mode , "READ_WRITE")
        dynamic "initialize_params" {
          for_each = try(secondary_disk.value.initialize_params, [])
          content {
            description = try(initialize_params.value.description, "Created by Terraform")
            size        = try(initialize_params.value.size, null)
            type        = try(initialize_params.value.type, null)
            image_id    = try(yandex_compute_image.image[initialize_params.value.image_name].id, null)
            snapshot_id = try(yandex_compute_snapshot.snapshot[initialize_params.value.snapshot_name].id, null)
          }
        }
      }
    }

    network_settings {
      type = try(each.value.network_settings, "STANDARD")
    }

    dynamic "filesystem" {
      for_each = try(each.value.filesystem, [])
      content {
        filesystem_id = yandex_compute_filesystem.filesystem[filesystem.value.filesystem_name].id
        device_name   = try(filesystem.value.device_name, null)
        mode          = try(filesystem.value.mode, "READ_WRITE")
      }
    }

    service_account_id = try(each.value.service_account_id, null)

    labels = try(each.value.instance_labels, {})
  }

  allocation_policy {
    zones              = try(each.value.allocation_policy_zones, ["ru-central1-a", "ru-central1-b", "ru-central1-d"])
    dynamic "instance_tags_pool" {
      for_each = try(each.value.instance_tags_pool, [])
      content {
        zone = try(instance_tags_pool.value.zone, null)
        tags = try(instance_tags_pool.value.tags, [])
      }
    }
  }

  dynamic "health_check" {
    for_each = try(each.value.health_check, [])
    content {
      interval            = try(health_check.value.interval , null)
      timeout             = try(health_check.value.timeout , null)
      healthy_threshold   = try(health_check.value.healthy_threshold , null)
      unhealthy_threshold = try(health_check.value.unhealthy_threshold , null)
      dynamic "tcp_options" {
        for_each = try(health_check.value.tcp_options, [])
        content {
          port = tcp_options.value.port
        }
      }
      dynamic "http_options" {
        for_each = try(health_check.value.http_options, [])
        content {
          port = http_options.value.port
          path = http_options.value.path
        }
      }
    }
  }

  max_checking_health_duration = try(each.value.max_checking_health_duration, null)

  dynamic "load_balancer" {
    for_each = try(each.value.load_balancer, [])
    content {
      target_group_name            = try(health_check.value.target_group_name , null)
      target_group_description     = try(health_check.value.target_group_description , "Created by Terraform")
      target_group_labels          = try(health_check.value.target_group_labels , {})
      max_opening_traffic_duration = try(health_check.value.max_opening_traffic_duration , null)
      ignore_health_checks         = try(health_check.value.ignore_health_checks , false)
    }
  }

  dynamic "application_load_balancer" {
    for_each = try(each.value.application_load_balancer, [])
    content {
      target_group_name            = try(health_check.value.target_group_name , null)
      target_group_description     = try(health_check.value.target_group_description , "Created by Terraform")
      target_group_labels          = try(health_check.value.target_group_labels , {})
      max_opening_traffic_duration = try(health_check.value.max_opening_traffic_duration , null)
      ignore_health_checks         = try(health_check.value.ignore_health_checks , false)
    }
  }

  description               = try(each.value.description, "Created by Terraform")
  variables                 = try(each.value.variables, {})
  deletion_protection       = try(each.value.deletion_protection, false)

  labels = try(each.value.labels, {})

  depends_on = [yandex_compute_image.image , yandex_compute_disk.disk]
}