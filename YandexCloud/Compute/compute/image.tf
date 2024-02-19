resource "yandex_compute_image" "image" {
  for_each = var.images

  name            = each.key
  description     = try(each.value.description, "Created by Terraform")
  family          = try(each.value.family, null)
  min_disk_size   = try(each.value.min_disk_size, 10)
  os_type         = try(each.value.os_type, "LINUX")
  source_family   = try(each.value.source_family, null)
  source_image    = try(each.value.source_image, null)
  source_snapshot = try(each.value.source_snapshot, null)
  source_disk     = try(each.value.source_disk, null)
  source_url      = try(each.value.source_url, null)

  labels = try(each.value.labels, {})
}