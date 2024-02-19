## Create parametrgroup for Database
resource "sbercloud_rds_parametergroup" "pg" {
  for_each = var.custom_database_template

  name        = each.key
  region      = try(each.value.region, var.general_region)
  description = try(each.value.description, "Created by Terraform")
  values      = try(each.value.values, {})

  datastore {
    type    = lower(each.value.database_type)
    version = each.value.database_version
  }
}