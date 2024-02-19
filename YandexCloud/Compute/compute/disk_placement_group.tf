resource "yandex_compute_disk_placement_group" "disk_placement_group" {
  for_each = var.disk_placement_groups

  name        = each.key
  description = try(each.value.description, "Created by Terraform")
  zone        = try(each.value.zone, "ru-central1-a")

  labels = try(each.value.labels, {})
}