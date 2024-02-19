# Get flavor workerks node-pool

data "sbercloud_compute_flavors" "flavors_node" {
  for_each = var.node_pools

  performance_type  = try(each.value.performance_type, null)
  cpu_core_count    = each.value.cpu_core_count
  memory_size       = each.value.memory_size
  availability_zone = each.value.availability_zone
  generation        = try(each.value.generation, null)
}

# Get flavor workerks node-pool

data "sbercloud_compute_flavors" "flavors_custom_node" {
  for_each = var.custom_node

  performance_type  = try(each.value.performance_type, null)
  cpu_core_count    = each.value.cpu_core_count
  memory_size       = each.value.memory_size
  availability_zone = each.value.availability_zone
  generation        = try(each.value.generation, null)
}

## Addon template

data "sbercloud_cce_addon_template" "addon" {
  for_each = var.addon

  cluster_id    = sbercloud_cce_cluster.cluster[each.value.cluster_name].id
  name          = each.key
  version       = each.value.version
}

