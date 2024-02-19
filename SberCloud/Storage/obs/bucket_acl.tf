resource "sbercloud_obs_bucket_acl" "bucket_acl" {
  for_each = var.bucket_acls

  bucket             = each.value.bucket_name
  region             = try(each.value.region, var.general_region)

  owner_permission {
    access_to_bucket = each.value.owner_permission_access_to_bucket
    access_to_acl    = each.value.owner_permission_access_to_acl
  }

  dynamic "account_permission" {
    for_each = try(each.value.account_permission, [])
    content {
      access_to_bucket = try(account_permission.value.access_to_bucket, ["READ", "WRITE"])
      access_to_acl    = try(account_permission.value.access_to_acl, ["READ_ACP", "WRITE_ACP"])
      account_id       = account_permission.value.account_id
    }
  }

  public_permission {
    access_to_bucket = each.value.public_permission_access_to_bucket
  }

  log_delivery_user_permission {
    access_to_bucket = each.value.log_delivery_user_permission_access_to_bucket
    access_to_acl    = each.value.log_delivery_user_permission_access_to_acl
  }

  depends_on = [sbercloud_obs_bucket.bucket]
}