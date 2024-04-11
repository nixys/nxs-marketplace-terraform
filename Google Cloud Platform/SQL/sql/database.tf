resource "google_sql_database" "database" {
  for_each = var.databases

  name            = each.key
  instance        = each.value.instance
  charset         = length(regexall("POSTGRES_.*", google_sql_database_instance.database_instance[each.value.instance].database_version)) > 0 ? "UTF8" : try(each.value.charset , null)
  collation       = length(regexall("POSTGRES_.*", google_sql_database_instance.database_instance[each.value.instance].database_version)) > 0  ? "en_US.UTF8" : try(each.value.collation , null)
  project         = try(each.value.project , null)
  deletion_policy = try(each.value.deletion_policy , "DELETE")

  depends_on = [google_sql_database_instance.database_instance]
}