
#==================== Outputs ==================== #

output "keypair_public_key" {
  value = { for k, v in sbercloud_compute_keypair.keypair : k => v.public_key }
}

output "ecs_servergroup_member_names" {
  value = {
    for name in distinct([for k, v in local.filtered_ecs_to_group_vm : v.servergroup_name]) :
    name => [for key, value in local.filtered_ecs_to_group_vm : key if value.servergroup_name == name]
  }
}

output "ecs_servergroup_ids" {
  value = { for k, v in sbercloud_compute_servergroup.servergroup : k => v.id }
}

output "ecs_names" {
  value = [for k, v in sbercloud_compute_instance.ecs : k]
}

output "ecs_ids" {
  value = { for k, v in sbercloud_compute_instance.ecs : k => v.id }
}

output "ecs_private_ip_v4" {
  value = { for k, v in sbercloud_compute_instance.ecs : k => v.access_ip_v4 }
}

output "ecs_private_ip_v6" {
  value = { for k, v in sbercloud_compute_instance.ecs : k => v.access_ip_v6 }
}

output "ecs_security_group_ids" {
  value = { for k, v in sbercloud_compute_instance.ecs : k => v.security_group_ids }
}

output "ecs_security_group_names" {
  value = { for k, v in sbercloud_compute_instance.ecs : k => v.security_groups }
}

output "ecs_image_ids" {
  value = { for k, v in sbercloud_compute_instance.ecs : k => v.image_id }
}

output "ecs_attached_data_disk_names" {
  value = {
    for k, v in var.ecs : k => can(v.data_disks) ? [
      for key, value in v.data_disks : "${k}_${key}"
    ] : []
  }
}

output "ecs_attached_data_disk_ids" {
  value = {
    for k, v in var.ecs : k => can(v.data_disks) ? [
      for key, value in v.data_disks : sbercloud_compute_volume_attach.volume_attach["${k}_${key}"].volume_id
    ] : []
  }
}

output "ecs_attached_interface_names" {
  value = {
    for k, v in var.ecs : k => can(v.interface_attach) ? [
      for key, value in v.interface_attach : "${k}_${key}"
    ] : []
  }
}

output "ecs_attached_interface_ids" {
  value = {
    for k, v in var.ecs : k => can(v.interface_attach) ? [
      for key, value in v.interface_attach : sbercloud_compute_interface_attach.interface_attach["${k}_${key}"].id
    ] : []
  }
}

output "ecs_attached_eip_public_ips" {
  value = {
    for k, v in var.ecs : k => can(v.eip) ? [
      for key, value in v.eip : sbercloud_compute_eip_associate.eip_associate["${k}_${key}"].public_ip
    ] : []
  }
}

output "ecs_attached_eip_ids" {
  value = {
    for k, v in var.ecs : k => can(v.eip) ? [
      for key, value in v.eip : sbercloud_compute_eip_associate.eip_associate["${k}_${key}"].id
    ] : []
  }
}