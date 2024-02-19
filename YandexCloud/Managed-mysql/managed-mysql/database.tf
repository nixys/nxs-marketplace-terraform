resource "yandex_mdb_mysql_database" "database" {
  for_each = var.databases

  name       = each.key
  cluster_id = yandex_mdb_mysql_cluster.cluster[each.value.mysql_cluster_name].id

  depends_on = [yandex_mdb_mysql_cluster.cluster]
}