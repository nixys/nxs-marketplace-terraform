resource "random_password" "user_pass" {
  for_each = toset(flatten([ for k in var.clusters : [ for user in k.user : user.name ] ]))

  length           = 16
  special          = true
}

resource "random_password" "admin_pass" {

  length           = 16
  special          = true
}