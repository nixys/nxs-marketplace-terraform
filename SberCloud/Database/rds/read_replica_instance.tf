## Create custom replica for exist Database
resource "sbercloud_rds_read_replica_instance" "replica_instance" {
  for_each = var.custom_replicas

  name                  = each.key
  enterprise_project_id = try(each.value.project_id, var.general_project_id)
  region                = try(each.value.region, var.general_region)
  flavor                = data.sbercloud_rds_flavors.flavors_rds_rr[each.key].flavors[0].name
  primary_instance_id   = sbercloud_rds_instance.instance[each.value.primary_instance_name].id
  availability_zone     = try(each.value.availability_zone, "ru-moscow-1a")
  tags                  = try(each.value.tags, {})

  volume {
    type               = try(each.value.volume_type, "ULTRAHIGH")
    disk_encryption_id = try(each.value.volume_disk_encryption_id, null)
  }
}