resource "yandex_compute_filesystem" "filesystem" {
  for_each = var.filesystems

  name        = each.key
  description = try(each.value.description, "Created by Terraform")
  zone        = try(each.value.zone, "ru-central1-a")
  size        = try(each.value.size, null)
  block_size  = try(each.value.block_size, null)
  type        = try(each.value.type, null)

  labels = try(each.value.labels, {})
}