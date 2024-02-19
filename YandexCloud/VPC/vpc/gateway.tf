resource "yandex_vpc_gateway" "gateway" {
  for_each = var.gateways

  name        = each.key
  description = try(each.value.description, "Created by Terraform")
  labels      = try(each.value.labels, {})
  shared_egress_gateway {}
}