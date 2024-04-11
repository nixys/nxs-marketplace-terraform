resource "google_sql_source_representation_instance" "source_representation_instance" {
  for_each = var.source_representation_instances

  name                   = each.key
  region                 = each.value.region
  project                = try(each.value.project , null)
  database_version       = each.value.database_version
  host                   = each.value.host
  port                   = try(each.value.port , null)
  username               = try(each.value.username , null)
  password               = try(each.value.password , null)
  dump_file_path         = try(each.value.dump_file_path , null)
  ca_certificate         = try(each.value.ca_certificate , null)
  client_certificate     = try(each.value.client_certificate , null)
  client_key             = try(each.value.client_key , null)
}