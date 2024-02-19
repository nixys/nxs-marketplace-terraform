resource "sbercloud_vpc_eip" "eip" {
  for_each = var.eips
  publicip {
    type       = try(each.value.type, "5_bgp")
    ip_address = try(each.value.ip_address, null)
    port_id    = try(each.value.port_id, null)
  }
  bandwidth {
    share_type  = try(each.value.share_type, "PER")
    name        = try(each.value.bandwidth_name, null)
    size        = try(each.value.bandwidth_size, null)
    id          = try(each.value.bandwidth_id, null)
    charge_mode = try(each.value.charge_mode, "bandwidth")
  }
  auto_renew            = try(each.value.auto_renew, true)
  tags                  = try(each.value.tags, { created_by = "Terraform" })
  region                = try(each.value.region, "ru-moscow-1")
  enterprise_project_id = try(each.value.project_id, var.general_project_id)

}

