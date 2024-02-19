resource "random_password" "user_pass" {
  for_each = var.users

  length           = 32
  special          = false
}