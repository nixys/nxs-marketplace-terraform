###Create backup DCS
resource "sbercloud_dcs_backup" "backup" {
  for_each = var.backups

  region        = try(each.value.region, var.general_region)
  instance_id   = sbercloud_dcs_instance.instance[each.value.instance_name].id
  description   = try(each.value.description, "Created by Terraform")
  backup_format = try(each.value.backup_format, null)
}