resource "yandex_mdb_mysql_cluster" "cluster" {
  for_each = var.clusters

  name                      = each.key
  environment               = try(each.value.environment, "PRODUCTION")
  network_id                = each.value.network_id
  version                   = each.value.version
  description               = try(each.value.description, "Created by Terraform")
  backup_retain_period_days = try(each.value.backup_retain_period_days, null)
  security_group_ids        = each.value.security_group_id
  deletion_protection       = try(each.value.deletion_protection, false)

  maintenance_window {
    type = try(each.value.maintenance_window_type, "ANYTIME")
    day  = each.value.maintenance_window_day
    hour = each.value.maintenance_window_hour
  }

  resources {
    resource_preset_id = each.value.resource_preset_id
    disk_type_id       = try(each.value.disk_type, "network-hdd")
    disk_size          = try(each.value.disk_size, 10)
  }

  backup_window_start {
    hours   = try(each.value.backup_window_start_hours, null)
    minutes = try(each.value.backup_window_start_minutes, null)
  }

  dynamic "host" {
    for_each = each.value.mysql_hosts
    content {
      subnet_id = host.value.subnet_id
      zone      = host.value.zone
      name      = host.value.zone
    }
  }

  mysql_config = try(each.value.mysql_config, {})

  access {
    data_lens     = try(each.value.access_data_lens, false)
    web_sql       = try(each.value.access_web_sql, false)
    data_transfer = try(each.value.access_data_transfer, false)
  }
  performance_diagnostics {
    enabled                      = try(each.value.performance_diagnostics_enabled, false)
    sessions_sampling_interval   = try(each.value.sessions_sampling_interval, 86400)
    statements_sampling_interval = try(each.value.statements_sampling_interval, 86400)
  }
  labels      = try(each.value.labels, {})
}
