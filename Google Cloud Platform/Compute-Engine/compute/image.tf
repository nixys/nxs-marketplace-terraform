resource "google_compute_image" "image" {
  for_each = var.images

  name              = each.key
  description       = try(each.value.description, "Created by Terraform")
  project           = try(each.value.project, null)
  storage_locations = try(each.value.storage_locations, [])
  disk_size_gb      = try(each.value.disk_size_gb , null)
  family            = try(each.value.family, null)
  licenses          = try(each.value.licenses , null)
  source_disk       = try(each.value.source_disk , null)
  source_image      = try(each.value.source_image , null)
  source_snapshot   = try(each.value.source_snapshot , null)

  dynamic "raw_disk" {
    for_each = try(each.value.raw_disk, [])
    content {
      container_type = try(raw_disk.value.container_type , null) 
      sha1           = try(raw_disk.value.sha1 , null)
      source         = raw_disk.value.source
    }
  }

  dynamic "guest_os_features" {
    for_each = try(each.value.guest_os_features, [])
    content {
      type = guest_os_features.value.type
    }
  }

  dynamic "image_encryption_key" {
    for_each = try(each.value.image_encryption_key, [])
    content {
      kms_key_self_link       = try(image_encryption_key.value.kms_key_self_link , null)
      kms_key_service_account = try(image_encryption_key.value.kms_key_service_account , null)
    }
  }

  labels = try(each.value.labels, {})
}