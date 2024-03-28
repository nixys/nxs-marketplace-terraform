resource "google_compute_snapshot" "snapshot" {
  for_each = var.snapshots

  name                        = each.key
  source_disk                 = google_compute_disk.disk[each.value.source_disk_name].id
  chain_name                  = try(each.value.chain_name, null)
  description                 = try(each.value.description, "Created by Terraform")
  storage_locations           = try(each.value.storage_locations, [])
  zone                        = try(each.value.zone, "us-central1-a")
  project                     = try(each.value.project, null)

  dynamic "snapshot_encryption_key" {
    for_each = try(each.value.snapshot_encryption_key, [])
    content {
      raw_key                 = try(snapshot_encryption_key.value.raw_key , null)
      sha256                  = try(snapshot_encryption_key.value.sha256 , null)
      kms_key_self_link       = try(snapshot_encryption_key.value.kms_key_self_link , null)
      kms_key_service_account = try(snapshot_encryption_key.value.rawkms_key_service_account_key , null)
    }
  }

  dynamic "source_disk_encryption_key" {
    for_each = try(each.value.source_disk_encryption_key, [])
    content {
      raw_key                 = try(source_disk_encryption_key.value.raw_key , null)
      kms_key_service_account = try(source_disk_encryption_key.value.rawkms_key_service_account_key , null)
    }
  }

  labels = try(each.value.labels, {})

  depends_on = [google_compute_region_disk.region_disk , google_compute_disk.disk]
}
