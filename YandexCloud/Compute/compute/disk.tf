resource "yandex_compute_disk" "disk" {
  for_each = var.disks

  name        = each.key
  description = try(each.value.description, "Created by Terraform")
  zone        = try(each.value.zone, "ru-central1-a")
  size        = try(each.value.size, null)
  block_size  = try(each.value.block_size, null)
  type        = try(each.value.type, null)
  image_id    = try(yandex_compute_image.image[each.value.image_name].id, null)

  dynamic "disk_placement_policy" {
    for_each = try(each.value.disk_placement_policy, [])
    content {
      disk_placement_group_id = try(yandex_compute_disk_placement_group.disk_placement_group[disk_placement_policy.value.disk_placement_group_name].id, null)
    }
  }

  labels = try(each.value.labels, {})
}

resource "yandex_compute_disk" "disks_from_snapshot" {
  for_each = var.disks_from_snapshot

  name        = each.key
  description = try(each.value.description, "Created by Terraform")
  zone        = try(each.value.zone, "ru-central1-a")
  size        = try(each.value.size, null)
  block_size  = try(each.value.block_size, null)
  type        = try(each.value.type, null)
  snapshot_id = try(yandex_compute_snapshot.snapshot[each.value.snapshot_name].id, null)
  
  dynamic "disk_placement_policy" {
    for_each = try(each.value.disk_placement_policy, [])
    content {
      disk_placement_group_id = try(yandex_compute_disk_placement_group.disk_placement_group[disk_placement_policy.value.disk_placement_group_name].id, null)
    }
  }

  labels = try(each.value.labels, {})

  depends_on = [yandex_compute_snapshot.snapshot]
}