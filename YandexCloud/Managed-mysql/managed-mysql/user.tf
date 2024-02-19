resource "yandex_mdb_mysql_user" "user" {
  for_each = var.users

  cluster_id = yandex_mdb_mysql_cluster.cluster[each.value.mysql_cluster_name].id
  name       = each.key
  password   = random_password.user_pass[each.key].result

  dynamic "permission" {
    for_each = try(each.value.permission, [])
    content {
      database_name = permission.value.database_name
      roles         = permission.value.roles
    }
  }

  connection_limits {
    max_questions_per_hour   = each.value.max_questions_per_hour
    max_updates_per_hour     = each.value.max_updates_per_hour
    max_connections_per_hour = each.value.max_connections_per_hour
    max_user_connections     = each.value.max_user_connections
  }

  global_permissions = try(each.value.global_permissions, [])

  authentication_plugin = try(each.value.authentication_plugin, "SHA256_PASSWORD")

  depends_on = [yandex_mdb_mysql_database.database]
}