
locals {
  iface_to_instance_map = merge([
    for k, v in var.ecs : can(v.interface_attach) ? {
      for key, value in v.interface_attach :
      "${k}_${key}" => {
        instance_name      = k
        network_id         = try(value.network_id, null)
        fixed_ip           = try(value.fixed_ip, null)
        security_group_ids = try(value.security_group_ids, sbercloud_compute_instance.ecs[k].security_group_ids)
        source_dest_check  = try(value.source_dest_check, false)
        port_id            = try(value.port_id, null)
        region             = try(value.region, var.general_region)
      }
    } : {}
  ]...)

  data_disk_to_instance_map = merge([
    for k, v in var.ecs : can(v.data_disks) ? {
      for key, value in v.data_disks :
      "${k}_${key}" => {
        instance_name     = k
        description       = try(value.description, "Created by Terraform")
        volume_type       = try(value.volume_type, "SAS")
        size              = value.size
        availability_zone = try(value.availability_zone, v.availability_zone)
        region            = try(value.region, var.general_region)
        project_id        = try(value.project_id, v.project_id)
      }
    } : {}
  ]...)

  eip_to_instance_map = merge([
    for k, v in var.ecs : can(v.eip) ? {
      for key, value in v.eip :
      "${k}_${key}" => {
        instance_name = k
        public_ip     = value.public_ip
        bandwidth_id  = try(value.bandwidth_id, null)
        fixed_ip      = try(value.fixed_ip, null)
        region        = try(value.region, var.general_region)
      }
    } : {}
  ]...)

  filtered_ecs_to_group_vm = { for k, v in var.ecs : k => v if can(v.servergroup_name) }

  instance_to_group_vm_list = {
    for name in distinct([for k, v in local.filtered_ecs_to_group_vm : v.servergroup_name]) :
    name => [for key, value in local.filtered_ecs_to_group_vm : sbercloud_compute_instance.ecs[key].id if value.servergroup_name == name]
  }
}
