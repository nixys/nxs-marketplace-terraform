resource "yandex_compute_snapshot" "snapshot" {
  for_each = var.snapshots

  name           = each.key
  source_disk_id = yandex_compute_disk.disk[each.value.disk_name].id
  description    = try(each.value.description, "Created by Terraform")

  labels = try(each.value.labels, {})

  depends_on = [yandex_compute_disk.disk]
}
