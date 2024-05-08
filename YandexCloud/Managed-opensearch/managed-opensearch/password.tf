resource "random_password" "admin_pass" {
  for_each = var.clusters

  length  = 32
  special = false
}