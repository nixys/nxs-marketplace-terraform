resource "yandex_mdb_postgresql_database" "database" {
  for_each = var.databases

  cluster_id  = yandex_mdb_postgresql_cluster.cluster[each.value.cluster_name].id
  name        = each.key
  owner       = each.value["owner_user"]
  lc_collate  = try(each.value.lc_collate, "")
  lc_type     = try(each.value.lc_type, "")
  template_db = try(each.value.template_db, null)

  dynamic "extension" {
    for_each = try(each.value.extension, {})
    content {
      name                = extension.value.extension_name
      version             = try(extension.value.extension_version, null)
      deletion_protection = try(extension.value.deletion_protection, false)
    }
  }

  depends_on = [yandex_mdb_postgresql_user.user]
}
