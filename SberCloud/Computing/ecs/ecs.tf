
# Create ECSs
resource "sbercloud_compute_instance" "ecs" {
  for_each              = var.ecs
  name                  = each.key
  image_id              = data.sbercloud_images_image.images[each.key].id
  flavor_id             = data.sbercloud_compute_flavors.flavors[each.key].ids[0]
  enterprise_project_id = try(each.value.project_id, var.general_project_id)
  security_group_ids    = try(each.value.security_group_ids, null)
  availability_zone     = each.value.availability_zone
  region                = try(each.value.region, var.general_region)
  dynamic "network" {
    for_each = each.value.network
    content {
      uuid              = network.value.uuid
      fixed_ip_v4       = try(network.value.fixed_ip_v4, null)
      ipv6_enable       = try(network.value.ipv6_enable, false)
      source_dest_check = try(network.value.source_dest_check, true)
      access_network    = try(network.value.access_network, false)
    }
  }
  admin_pass       = try(each.value.admin_pass, null)
  key_pair         = try(each.value.key_pair, null)
  system_disk_type = try(each.value.each.value.system_disk_type, "SAS")
  system_disk_size = try(each.value.system_disk_size, null)
  user_data        = try(each.value.user_data, null)
  tags             = try(each.value.tags, { created_by = "Terraform" })

  depends_on = [sbercloud_compute_keypair.keypair]
}
