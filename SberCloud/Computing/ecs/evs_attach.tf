
### Attach EVS volumes to ECS instances
resource "sbercloud_compute_volume_attach" "volume_attach" {
  for_each = local.data_disk_to_instance_map

  instance_id = sbercloud_compute_instance.ecs[each.value.instance_name].id
  volume_id   = sbercloud_evs_volume.volume[each.key].id
}



