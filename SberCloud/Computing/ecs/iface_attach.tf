
### Attach interface to ECS instances
resource "sbercloud_compute_interface_attach" "interface_attach" {
  for_each           = local.iface_to_instance_map
  instance_id        = sbercloud_compute_instance.ecs[each.value.instance_name].id
  network_id         = each.value.network_id
  fixed_ip           = each.value.fixed_ip
  security_group_ids = each.value.security_group_ids
  source_dest_check  = each.value.source_dest_check
  port_id            = each.value.port_id
  region             = each.value.region
}