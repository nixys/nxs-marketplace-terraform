resource "google_sql_ssl_cert" "ssl_cert" {
  for_each = var.ssl_certs

  common_name = each.key
  instance    = each.value.instance
  project     = try(each.value.project , null)

  depends_on = [google_sql_database_instance.database_instance]
}