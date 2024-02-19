
resource "sbercloud_compute_eip_associate" "eip_associate" {
  for_each     = local.eip_to_instance_map
  public_ip    = each.value.public_ip
  instance_id  = sbercloud_compute_instance.ecs[each.value.instance_name].id
  bandwidth_id = each.value.bandwidth_id
  fixed_ip     = each.value.fixed_ip
  region       = each.value.region

  depends_on = [sbercloud_compute_interface_attach.interface_attach]
}