resource "google_redis_cluster" "redis_cluster" {
  for_each = { for k, v in var.redis : k => v if v.is_cluster }

  name        = each.key
  shard_count = each.value.shard_count

  dynamic "psc_configs" {
    for_each = each.value.psc_configs
    content {
      network = psc_configs.value.network
    }
  }

  authorization_mode      = try(each.value.authorization_mode, null)
  transit_encryption_mode = try(each.value.transit_encryption_mode, null)
  node_type               = try(each.value.node_type, null)
  replica_count           = try(each.value.replica_count, null)
  redis_configs           = try(each.value.redis_configs, null)
  region                  = try(each.value.region, null)
  project                 = try(each.value.project, null)
}