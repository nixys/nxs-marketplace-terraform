## Create custom backup for Database
resource "sbercloud_rds_backup" "custom_backup" {
  for_each = var.custom_database_backup

  name        = each.key
  region      = try(each.value.region, var.general_region)
  description = try(each.value.description, "Created by Terraform")
  instance_id = sbercloud_rds_instance.instance[each.value.instance_rds_name].id

  dynamic "databases" {
    for_each = try(each.value.databases, [])
    content {
      name = databases.value.database_name
    }
  }
}