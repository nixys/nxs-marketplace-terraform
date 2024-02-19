resource "random_password" "user_pass" {
  for_each = var.users

  length           = 16
  special          = true
  override_special = "_%@"
}