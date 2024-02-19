## Get flavor for rds
data "sbercloud_rds_flavors" "flavors_rds" {
  for_each = var.instance

  db_type            = each.value.database_type
  db_version         = each.value.database_version
  instance_mode      = length(each.value.availability_zone) > 1 ? "ha" : "single"
  vcpus              = each.value.cpu
  memory             = each.value.memory
  group_type         = each.value.group_type
}

## Get flavor read replica (rr) for rds
data "sbercloud_rds_flavors" "flavors_rds_rr" {
  for_each = var.custom_replicas

  db_type            = each.value.database_type
  db_version         = each.value.database_version
  instance_mode      = "replica"
  vcpus              = each.value.cpu
  memory             = each.value.memory
  group_type         = each.value.group_type
}
