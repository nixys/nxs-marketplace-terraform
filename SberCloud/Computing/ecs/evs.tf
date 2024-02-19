
###Create EVS Disks

resource "sbercloud_evs_volume" "volume" {
  for_each = local.data_disk_to_instance_map

  name                  = each.key
  description           = each.value.description
  volume_type           = each.value.volume_type
  size                  = each.value.size
  availability_zone     = each.value.availability_zone
  region                = each.value.region
  enterprise_project_id = each.value.project_id
}