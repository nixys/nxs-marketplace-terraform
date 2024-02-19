## Create PostgreSQL cluster

resource "yandex_mdb_postgresql_cluster" "cluster" {

  for_each = var.clusters

  name = each.key

  config {

    resources {
      disk_size          = try(each.value.disk_size, 10)
      disk_type_id       = try(each.value.disk_type, "network-hdd")
      resource_preset_id = try(each.value.instance_type, "s2.micro")
    }

    version = try(each.value.postgresql_version, 13)
    
    access {
      data_lens     = try(each.value.access_data_lens, null)
      web_sql       = try(each.value.access_web_sql, null)
      serverless    = try(each.value.access_serverless, null)
      data_transfer = try(each.value.access_data_transfer, null)
    }

    performance_diagnostics {
      enabled                      = try(each.value.perfomance_diagnostics_enabled, false)
      sessions_sampling_interval   = try(each.value.sessions_sampling_interval, null)
      statements_sampling_interval = try(each.value.statements_sampling_interval, null)
    }

    disk_size_autoscaling {
      disk_size_limit           = try(each.value.disk_size_autoscaling_limit, null)
      planned_usage_threshold   = try(each.value.disk_size_autoscaling_planned_usage_threshold, null)
      emergency_usage_threshold = try(each.value.disk_size_autoscaling_emergency_usage_threshold, null)
    }

    autofailover              = try(each.value.autofailover, null)
    backup_retain_period_days = try(each.value.backup_retain_period_days, null)

    backup_window_start {
      hours   = try(each.value.backup_window_start_hours, null)
      minutes = try(each.value.backup_window_start_minutes, null)
    }

    pooler_config {
      pool_discard = try(each.value.pooler_config_pool_discard, null)
      pooling_mode = try(each.value.pooler_config_pooling_mode, null)
    }

    postgresql_config = try(each.value.postgresql_config, {})

  }

  environment = try(each.value.environment, "PRODUCTION")

  dynamic "host" {
    for_each = try(each.value.postgresql_hosts, [])
    content {
      zone                    = try(host.value.zone, "test")
      assign_public_ip        = try(host.value.assign_public_ip, null)
      subnet_id               = try(host.value.subnet_id, "test")
      name                    = try(host.value.name, null)
      priority                = try(host.value.priority, null)
    }
  }

  network_id          = each.value.network_id
  description         = try(each.value.description, "Created by Terraform")
  host_master_name    = try(each.value.host_master_name, null)
  security_group_ids  = try(each.value.security_group_ids, [])
  deletion_protection = try(each.value.deletion_protection, false)

  restore {
    backup_id      = try(each.value.restore_backup_id, null)
    time           = try(each.value.restore_time, null)
    time_inclusive = try(each.value.restore_time_inclusive, null)
  }

  maintenance_window {
    type = try(each.value.maintenance_window_type, "WEEKLY")
    day  = try(each.value.maintenance_window_day, "WEN")
    hour = try(each.value.maintenance_window_hour, 23)
  }

  labels              = try(each.value.labels, {})
}
