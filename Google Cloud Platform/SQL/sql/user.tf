resource "google_sql_user" "user" {
  for_each = var.users 

  name     = each.key
  instance = each.value.instance
  password = try(each.value.password, null)
  type     = try(each.value.type, null)
  host     = try(each.value.host, null)
  project  = try(each.value.project, null)

  dynamic "password_policy" {
    for_each = length(regexall("POSTGRES_.*", google_sql_database_instance.database_instance[each.value.instance].database_version)) > 0 ? [] : try(each.value.password_policy , [])
    content {
      allowed_failed_attempts      = try(password_policy.value.allowed_failed_attempts , null)
      password_expiration_duration = try(password_policy.value.password_expiration_duration , null)
      enable_failed_attempts_check = try(password_policy.value.enable_failed_attempts_check , null)
      enable_password_verification = try(password_policy.value.enable_password_verification , null)
    }
  }

  depends_on = [google_sql_database_instance.database_instance]
}