resource "yandex_vpc_network" "network" {
  for_each = var.networks
  
  name        = each.key
  description = try(each.value.description, "Created by Terraform")
  labels      = try(each.value.labels, {})
}