resource "yandex_compute_placement_group" "placement_group" {
  for_each = var.placement_groups

  name        = each.key
  description = try(each.value.description, "Created by Terraform")

  labels      = try(each.value.labels, {})
}
