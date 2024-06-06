###Create backup DCS
resource "sbercloud_dcs_restore" "restore" {
  for_each = var.restores

  project_id  = try(each.value.project_id, var.general_project_id)
  instance_id = sbercloud_dcs_instance.instance[each.value.instance_name].id
  backup_id   = sbercloud_dcs_backup.backup[each.value.backup_name].id
  remark      = try(each.value.remark, null)
}