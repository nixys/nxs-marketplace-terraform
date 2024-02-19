resource "yandex_mdb_postgresql_user" "user" {
  for_each = var.users

  cluster_id  = yandex_mdb_postgresql_cluster.cluster[each.value.cluster_name].id

  name                = each.key
  password            = random_password.user_pass[each.key].result
  conn_limit          = try(each.value.conn_limit, null)
  login               = try(each.value.login, true)
  deletion_protection = try(each.value.deletion_protection, false)
  grants              = try(each.value.grants, [])

  settings            = try(each.value.settings, {})

  depends_on = [yandex_mdb_postgresql_cluster.cluster]
}