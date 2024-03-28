## Region disk
resource "google_compute_region_disk" "region_disk" {
  for_each = var.region_disks

  name                        = each.key
  replica_zones               = each.value.replica_zones 
  description                 = try(each.value.description, "Created by Terraform")
  size                        = try(each.value.size, null)
  physical_block_size_bytes   = try(each.value.physical_block_size_bytes, null)
  type                        = try(each.value.type, null)
  source_disk                 = try(each.value.source_disk, null)
  licenses                    = try(each.value.licenses, [])
  region                      = try(each.value.region, null)
  snapshot                    = try(each.value.snapshot, null)
  project                     = try(each.value.project, null)

  dynamic "guest_os_features" {
    for_each = try(each.value.guest_os_features, [])
    content {
      type = guest_os_features.value.type
    }
  }

  dynamic "disk_encryption_key" {
    for_each = try(each.value.disk_encryption_key, [])
    content {
      raw_key                 = try(disk_encryption_key.value.raw_key , null)
      sha256                  = try(disk_encryption_key.value.sha256 , null)
      kms_key_name            = try(disk_encryption_key.value.kms_key_name , null)
    }
  }

  dynamic "source_snapshot_encryption_key" {
    for_each = try(each.value.source_snapshot_encryption_key, [])
    content {
      raw_key                 = try(disk_encryption_key.value.raw_key , null)
      sha256                  = try(disk_encryption_key.value.sha256 , null)
    }
  }

  labels                      = try(each.value.labels, {})
}

## Region disk
resource "google_compute_region_disk" "region_async_disk" {
  for_each = var.region_async_disks

  name                        = each.key
  replica_zones               = each.value.replica_zones 
  description                 = try(each.value.description, "Created by Terraform")
  size                        = try(each.value.size, null)
  physical_block_size_bytes   = try(each.value.physical_block_size_bytes, null)
  type                        = try(each.value.type, null)
  source_disk                 = try(each.value.source_disk, null)
  licenses                    = try(each.value.licenses, [])
  region                      = try(each.value.region, null)
  snapshot                    = try(each.value.snapshot, null)
  project                     = try(each.value.project, null)

  dynamic "async_primary_disk" {
    for_each = try(each.value.async_primary_disk, [])
    content {
      disk = try(google_compute_region_disk.region_disk[async_primary_disk.value.disk_name].id, null)
    }
  }

  dynamic "guest_os_features" {
    for_each = try(each.value.guest_os_features, [])
    content {
      type = guest_os_features.value.type
    }
  }

  dynamic "disk_encryption_key" {
    for_each = try(each.value.disk_encryption_key, [])
    content {
      raw_key                 = try(disk_encryption_key.value.raw_key , null)
      sha256                  = try(disk_encryption_key.value.sha256 , null)
      kms_key_name            = try(disk_encryption_key.value.kms_key_name , null)
    }
  }

  dynamic "source_snapshot_encryption_key" {
    for_each = try(each.value.source_snapshot_encryption_key, [])
    content {
      raw_key                 = try(disk_encryption_key.value.raw_key , null)
      sha256                  = try(disk_encryption_key.value.sha256 , null)
    }
  }

  labels                      = try(each.value.labels, {})
  depends_on = [google_compute_region_disk.region_disk]
}
