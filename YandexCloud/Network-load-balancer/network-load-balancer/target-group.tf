resource "yandex_lb_target_group" "target_group" {
  for_each = var.target_groups

  name        = each.key
  description = try(each.value.description, "Created by Terraform")

  dynamic "target" {
    for_each = each.value.target
    content {
      subnet_id = target.value.subnet_id
      address   = target.value.address
    }
  }

  labels = try(each.value.labels, {})
}