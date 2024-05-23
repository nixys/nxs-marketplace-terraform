## Create Redis cluster

resource "yandex_mdb_redis_cluster" "cluster" {

  for_each = var.clusters

  name        = each.key
  network_id  = each.value.network_id
  environment = try(each.value.environment, "PRODUCTION")

  config {
    version                            = try(each.value.version, null)
    password                           = random_password.user_pass[each.key].result
    timeout                            = try(each.value.timeout, null)
    maxmemory_policy                   = try(each.value.maxmemory_policy, null)
    notify_keyspace_events             = try(each.value.notify_keyspace_events, null)
    slowlog_log_slower_than            = try(each.value.slowlog_log_slower_than, null)
    slowlog_max_len                    = try(each.value.slowlog_max_len, null)
    databases                          = try(each.value.databases, null)
    maxmemory_percent                  = try(each.value.maxmemory_percent, null)
    client_output_buffer_limit_normal  = try(each.value.client_output_buffer_limit_normal, null)
    client_output_buffer_limit_pubsub  = try(each.value.client_output_buffer_limit_pubsub, null)
  }
  
  resources {
    disk_size          = try(each.value.disk_size, 16)
    disk_type_id       = try(each.value.disk_type, "network-ssd")
    resource_preset_id = try(each.value.instance_type, "b3-c1-m4")
  }

  dynamic "host" {
    for_each = try(each.value.redis_hosts, [])
    content {
      zone                    = host.value.zone
      assign_public_ip        = try(host.value.assign_public_ip, null)
      subnet_id               = try(host.value.subnet_id, "test")
      replica_priority        = try(host.value.replica_priority, null)
      shard_name              = try(host.value.shard_name, null)
    }
  }

  description         = try(each.value.description, "Created by Terraform")
  folder_id           = try(each.value.folder_id, null)
  sharded             = try(each.value.sharded, null)
  tls_enabled         = try(each.value.tls_enabled, null)
  persistence_mode    = try(each.value.persistence_mode, null)
  security_group_ids  = try(each.value.security_group_ids, [])
  deletion_protection = try(each.value.deletion_protection, null)

  maintenance_window {
    type = try(each.value.maintenance_window_type, "WEEKLY")
    day  = try(each.value.maintenance_window_day, "WEN")
    hour = try(each.value.maintenance_window_hour, 23)
  }

  labels              = try(each.value.labels, {})
}
