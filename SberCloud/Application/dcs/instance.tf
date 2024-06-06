###Create DCS
resource "sbercloud_dcs_instance" "instance" {
  for_each = var.instances

  name                  = each.key
  enterprise_project_id = try(each.value.project_id, var.general_project_id)
  region                = try(each.value.region, var.general_region)
  flavor                = data.sbercloud_dcs_flavors.flavors_dcs[each.key].flavors[0].name
  description           = try(each.value.description, "Created by Terraform")
  engine                = each.value.engine
  engine_version        = each.value.engine == "Redis" ? each.value.engine_version : null
  capacity              = each.value.capacity
  availability_zones    = each.value.availability_zones
  vpc_id                = each.value.vpc_id
  subnet_id             = each.value.subnet_id
  security_group_id     = try(each.value.security_group_id, null)
  private_ip            = try(each.value.private_ip, null)
  port                  = can(regex("[4-5].0+", each.value.engine_version)) ? try(each.value.port, 6379) : null
  password              = random_password.admin_pass[each.key].result
  whitelist_enable      = try(each.value.whitelist_enable, null)
  maintain_begin        = try(each.value.maintain_begin, null)
  maintain_end          = try(each.value.maintain_end, null)
  rename_commands       = try(each.value.rename_commands, null)
  charging_mode         = try(each.value.charging_mode, null)
  period_unit           = try(each.value.period_unit, null)
  period                = try(each.value.period, null)
  auto_renew            = try(each.value.auto_renew, null)
  access_user           = try(each.value.access_user, null)
  tags                  = try(each.value.tags, {})
  
  dynamic "whitelists" {
    for_each = each.value.engine == "Redis" && can(regex("[4-5].0+", each.value.engine_version)) ? each.value.whitelists : []
    content {
      group_name = whitelists.value.group_name
      ip_address = whitelists.value.ip_address
    }
  }

  dynamic "backup_policy" {
    for_each = try(each.value.backup_policy, [])
    content {
      backup_type = try(backup_policy.value.backup_type, null)
      save_days   = try(backup_policy.value.save_days, null)
      period_type = try(backup_policy.value.period_type, null)
      backup_at   = backup_policy.value.backup_at
      begin_at    = backup_policy.value.begin_at
    }
  }
}