## Main disk
resource "google_compute_disk" "disk" {
  for_each = var.disks

  name                        = each.key
  description                 = try(each.value.description, "Created by Terraform")
  zone                        = try(each.value.zone, "us-central1-a")
  size                        = try(each.value.size, null)
  physical_block_size_bytes   = try(each.value.physical_block_size_bytes, null)
  source_disk                 = try(each.value.source_disk, null)
  type                        = try(each.value.type, null)
  image                       = try(each.value.image, null)
  enable_confidential_compute = try(each.value.enable_confidential_compute, null)
  provisioned_iops            = try(each.value.provisioned_iops, null)
  provisioned_throughput      = try(each.value.provisioned_throughput, null)
  project                     = try(each.value.project, null)
  snapshot                    = try(each.value.snapshot, null)
  licenses                    = try(each.value.licenses, [])

  dynamic "guest_os_features" {
    for_each = try(each.value.guest_os_features, [])
    content {
      type = guest_os_features.value.type
    }
  }

  dynamic "source_image_encryption_key" {
    for_each = try(each.value.source_image_encryption_key, [])
    content {
      raw_key                 = try(source_image_encryption_key.value.raw_key , null)
      sha256                  = try(source_image_encryption_key.value.sha256 , null)
      kms_key_self_link       = try(source_image_encryption_key.value.kms_key_self_link , null)
      kms_key_service_account = try(source_image_encryption_key.value.rawkms_key_service_account_key , null)
    }
  }

  dynamic "disk_encryption_key" {
    for_each = try(each.value.disk_encryption_key, [])
    content {
      raw_key                 = try(disk_encryption_key.value.raw_key , null)
      rsa_encrypted_key       = try(disk_encryption_key.value.rsa_encrypted_key , null)
      sha256                  = try(disk_encryption_key.value.sha256 , null)
      kms_key_self_link       = try(disk_encryption_key.value.kms_key_self_link , null)
      kms_key_service_account = try(disk_encryption_key.value.rawkms_key_service_account_key , null)
    }
  }

  dynamic "source_snapshot_encryption_key" {
    for_each = try(each.value.source_snapshot_encryption_key, [])
    content {
      raw_key                 = try(source_snapshot_encryption_key.value.raw_key , null)
      sha256                  = try(source_snapshot_encryption_key.value.sha256 , null)
      kms_key_self_link       = try(source_snapshot_encryption_key.value.kms_key_self_link , null)
      kms_key_service_account = try(source_snapshot_encryption_key.value.rawkms_key_service_account_key , null)
    }
  }

  labels = try(each.value.labels, {})
  depends_on = [google_compute_image.image]
}

## async disk
resource "google_compute_disk" "async_disks" {
  for_each = var.async_disks

  name                        = each.key
  description                 = try(each.value.description, "Created by Terraform")
  zone                        = try(each.value.zone, "us-central1-a")
  size                        = try(each.value.size, null)
  physical_block_size_bytes   = try(each.value.physical_block_size_bytes, null)
  source_disk                 = try(each.value.source_disk, null)
  type                        = try(each.value.type, null)
  image                       = try(each.value.image, null)
  enable_confidential_compute = try(each.value.enable_confidential_compute, null)
  provisioned_iops            = try(each.value.provisioned_iops, null)
  provisioned_throughput      = try(each.value.provisioned_throughput, null)
  project                     = try(each.value.project, null)
  licenses                    = try(each.value.licenses, [])

  dynamic "async_primary_disk" {
    for_each = try(each.value.async_primary_disk, [])
    content {
      disk = try(google_compute_disk.disk[async_primary_disk.value.disk_name].id, null)
    }
  }

  dynamic "guest_os_features" {
    for_each = try(each.value.guest_os_features, [])
    content {
      type = guest_os_features.value.type
    }
  }

  dynamic "source_image_encryption_key" {
    for_each = try(each.value.source_image_encryption_key, [])
    content {
      raw_key                 = try(source_image_encryption_key.value.raw_key , null)
      sha256                  = try(source_image_encryption_key.value.sha256 , null)
      kms_key_self_link       = try(source_image_encryption_key.value.kms_key_self_link , null)
      kms_key_service_account = try(source_image_encryption_key.value.rawkms_key_service_account_key , null)
    }
  }

  dynamic "disk_encryption_key" {
    for_each = try(each.value.disk_encryption_key, [])
    content {
      raw_key                 = try(disk_encryption_key.value.raw_key , null)
      rsa_encrypted_key       = try(disk_encryption_key.value.rsa_encrypted_key , null)
      sha256                  = try(disk_encryption_key.value.sha256 , null)
      kms_key_self_link       = try(disk_encryption_key.value.kms_key_self_link , null)
      kms_key_service_account = try(disk_encryption_key.value.rawkms_key_service_account_key , null)
    }
  }

  dynamic "source_snapshot_encryption_key" {
    for_each = try(each.value.source_snapshot_encryption_key, [])
    content {
      raw_key                 = try(source_snapshot_encryption_key.value.raw_key , null)
      sha256                  = try(source_snapshot_encryption_key.value.sha256 , null)
      kms_key_self_link       = try(source_snapshot_encryption_key.value.kms_key_self_link , null)
      kms_key_service_account = try(source_snapshot_encryption_key.value.rawkms_key_service_account_key , null)
    }
  }

  labels = try(each.value.labels, {})
  depends_on = [google_compute_disk.disk]
}
