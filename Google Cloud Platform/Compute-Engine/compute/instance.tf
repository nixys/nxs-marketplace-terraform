resource "google_compute_instance" "instance" {
  for_each = var.instances

  name         = each.key
  zone         = try(each.value.zone, null)
  machine_type = each.value.machine_type

  boot_disk {
    auto_delete             = try(each.value.boot_disk_auto_delete, null)
    device_name             = try(each.value.device_name , null)
    mode                    = try(each.value.mode , null)
    disk_encryption_key_raw = try(each.value.disk_encryption_key_raw , null)
    kms_key_self_link       = try(each.value.kms_key_self_link , null)
    source                  = try(each.value.source , null)

      dynamic "initialize_params" {
        for_each = each.value.source != "" ? [] : try(each.value.initialize_params, [])
        content {
          size                        = try(initialize_params.value.size , null)
          type                        = try(initialize_params.value.type, null)
          image                       = try(initialize_params.value.image , null)
          resource_manager_tags       = try(initialize_params.value.resource_manager_tags , null)
          provisioned_iops            = try(initialize_params.value.provisioned_iops , null)
          provisioned_throughput      = try(initialize_params.value.provisioned_throughput , null)
          enable_confidential_compute = try(initialize_params.value.enable_confidential_compute , null)
    
          labels = try(initialize_params.value.labels, {})
        }
      }
  }

  network_interface {
    network            = try(each.value.network , null) 
    subnetwork         = try(each.value.subnetwork , null)
    subnetwork_project = try(each.value.subnetwork_project , null)
    network_ip         = try(each.value.network_ip , null)
    nic_type           = try(each.value.nic_type , null)
    stack_type         = try(each.value.stack_type , null)
    queue_count        = try(each.value.queue_count , null)

    dynamic "alias_ip_range" {
      for_each = try(each.value.alias_ip_range, [])
      content {
        ip_cidr_range         = try(alias_ip_range.value.ip_cidr_range , null)
        subnetwork_range_name = try(alias_ip_range.value.subnetwork_range_name , null)
      }
    }

    dynamic "ipv6_access_config" {
      for_each = try(each.value.ipv6_access_config, [])
      content {
        external_ipv6               = try(ipv6_access_config.value.external_ipv6 , null)
        external_ipv6_prefix_length = try(ipv6_access_config.value.external_ipv6_prefix_length , null)
        name                        = try(ipv6_access_config.value.name , null)
        network_tier                = try(ipv6_access_config.value.network_tier , null)
        public_ptr_domain_name      = try(ipv6_access_config.value.public_ptr_domain_name , null)
      }
    }

    dynamic "access_config" {
      for_each = try(each.value.access_config, [])
      content {
        nat_ip                 = try(access_config.value.nat_ip , null)
        public_ptr_domain_name = try(access_config.value.public_ptr_domain_name , null)
        network_tier           = try(access_config.value.network_tier , null)
      }
    }
  }

  allow_stopping_for_update = try(each.value.allow_stopping_for_update, null)
 
  dynamic "attached_disk" {
    for_each = try(each.value.attached_disk, [])
    content {
      source                  = try(attached_disk.value.source , null)
      device_name             = try(attached_disk.value.device_name , null)
      mode                    = try(attached_disk.value.mode , null)
      disk_encryption_key_raw = try(attached_disk.value.disk_encryption_key_raw , null)
      kms_key_self_link       = try(attached_disk.value.kms_key_self_link , null)
    }
  }

  can_ip_forward          = try(each.value.can_ip_forward, null)
  desired_status          = try(each.value.desired_status, null)
  deletion_protection     = try(each.value.deletion_protection, false)
  hostname                = try(each.value.hostname, null)
  metadata_startup_script = try(each.value.metadata_startup_script , null)
  min_cpu_platform        = try(each.value.min_cpu_platform , null)
  project                 = try(each.value.project , null)

  dynamic "guest_accelerator" {
    for_each = try(each.value.guest_accelerator, [])
    content {
      type  = try(guest_accelerator.value.type , null)
      count = try(guest_accelerator.value.count , null)
    }
  }

  dynamic "scheduling" {
    for_each = try(each.value.scheduling, [])
    content {
      preemptible                 = try(scheduling.value.preemptible , null) 
      on_host_maintenance         = try(scheduling.value.on_host_maintenance , null)
      automatic_restart           = try(scheduling.value.automatic_restart , null)
      min_node_cpus               = try(scheduling.value.min_node_cpus , null)
      provisioning_model          = try(scheduling.value.provisioning_model , null)
      instance_termination_action = try(scheduling.value.instance_termination_action , null)

      dynamic "node_affinities" {
        for_each = try(scheduling.value.node_affinities, [])
        content {
          key      = node_affinities.value.key
          operator = node_affinities.value.operator
          values    = node_affinities.value.values
        }
      }

      dynamic "local_ssd_recovery_timeout" {
        for_each = try(scheduling.value.local_ssd_recovery_timeout, [])
        content {
          nanos                       = try(local_ssd_recovery_timeout.value.nanos , null)
          seconds                     = local_ssd_recovery_timeout.value.seconds
        }
      }
    }
  }

  dynamic "scratch_disk" {
    for_each = try(each.value.scratch_disk, [])
    content {
      interface = scratch_disk.value.interface
    }
  }

  dynamic "service_account" {
    for_each = try(each.value.service_account, [])
    content {
      email  = try(service_account.value.email, null)
      scopes = service_account.value.scopes
    }
  }

  dynamic "shielded_instance_config" {
    for_each = try(each.value.shielded_instance_config, [])
    content {
      enable_secure_boot          = try(shielded_instance_config.value.enable_secure_boot , null)
      enable_vtpm                 = try(shielded_instance_config.value.enable_vtpm , null)
      enable_integrity_monitoring = try(shielded_instance_config.value.enable_integrity_monitoring , null)
    }
  }

  dynamic "params" {
    for_each = try(each.value.params, [])
    content {
      resource_manager_tags = try(params.value.resource_manager_tags , null)
    }
  }

  dynamic "confidential_instance_config" {
    for_each = try(each.value.confidential_instance_config, [])
    content {
      enable_confidential_compute = try(confidential_instance_config.value.enable_confidential_compute , null) 
    }
  }

  dynamic "advanced_machine_features" {
    for_each = try(each.value.advanced_machine_features, [])
    content {
      enable_nested_virtualization = try(advanced_machine_features.value.enable_nested_virtualization , null) 
      threads_per_core             = try(advanced_machine_features.value.threads_per_core , null)
      visible_core_count           = try(advanced_machine_features.value.visible_core_count , null)
    }
  }

  dynamic "reservation_affinity" {
    for_each = try(each.value.reservation_affinity, [])
    content {
      type                 = reservation_affinity.value.type
      dynamic "specific_reservation" {
        for_each = try(reservation_affinity.value.specific_reservation, [])
        content {
          key    = specific_reservation.value.key
          values = specific_reservation.value.values
        }
      }
    }
  }

  dynamic "network_performance_config" {
    for_each = try(each.value.network_performance_config, [])
    content {
      total_egress_bandwidth_tier   = network_performance_config.value.total_egress_bandwidth_tier
    }
  }

  enable_display    = try(each.value.enable_display , null)
  resource_policies = try(each.value.resource_policies , null) 

  tags             = try(each.value.tags, [])
  labels           = try(each.value.labels, {})
  metadata                  = length(each.value.isntance_default_ssh_keys) > 0 ? {
    ssh-keys  = join("\n", flatten([
      for username, ssh_keys in each.value.isntance_default_ssh_keys : [
        for ssh_key in ssh_keys
        : "${username}:${ssh_key}"
      ]
    ]))
  } : {}

  depends_on = [google_compute_image.image , google_compute_disk.disk]
}