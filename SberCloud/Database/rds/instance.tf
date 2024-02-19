## Create instance for Database
resource "sbercloud_rds_instance" "instance" {
  for_each = var.instance

  name                  = each.key
  enterprise_project_id = try(each.value.project_id, var.general_project_id)
  region                = try(each.value.region, var.general_region)
  flavor                = data.sbercloud_rds_flavors.flavors_rds[each.key].flavors[0].name
  vpc_id                = each.value.vpc_id
  subnet_id             = each.value.subnet_id
  security_group_id     = each.value.security_group_id
  availability_zone     = try(each.value.availability_zone, ["ru-moscow-1a"])
  ha_replication_mode   = length(each.value.availability_zone) > 1 ? each.value.ha_replication_mode : null
  param_group_id        = try(sbercloud_rds_parametergroup.pg[each.value.database_template].id, null)
  time_zone             = try(each.value.time_zone, "UTC+03:00")
  fixed_ip              = try(each.value.fixed_ip, null)
  tags                  = try(each.value.tags, {})

  db {
    type     = each.value.database_type
    version  = each.value.database_version
    password = try(each.value.database_password, "wdWt0MeKH4g08tJMrLksJpgUKCBv!12")
    port     = try(each.value.database_port, null)
  }

  volume {
    type               = try(each.value.volume_type, "ULTRAHIGH")
    size               = try(each.value.volume_size, 40)
    disk_encryption_id = try(each.value.volume_disk_encryption_id, null)
  }

  backup_strategy {
    start_time = try(each.value.backup_start_time, "08:00-09:00")
    keep_days  = try(each.value.backup_keep_days, 1)
  }

  dynamic "parameters" {
    for_each = try(each.value.parameters, [])
    content {
      name  = parameters.value.name
      value = parameters.value.value
    }
  }
}