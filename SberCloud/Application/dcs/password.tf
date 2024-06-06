resource "random_password" "admin_pass" {
  for_each = var.instances

  length  = 32
  special = false
}