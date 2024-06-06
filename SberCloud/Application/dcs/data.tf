# Get flavor DCS
data "sbercloud_dcs_flavors" "flavors_dcs" {
  for_each = var.instances

  region            = try(each.value.region, null)
  capacity          = each.value.capacity
  engine            = try(each.value.engine, null)
  engine_version    = each.value.engine == "Redis" ? each.value.engine_version : null
  cache_mode        = try(each.value.cache_mode, null)
  cpu_architecture  = try(each.value.cpu_architecture, null)
}
