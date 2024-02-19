resource "sbercloud_obs_bucket_policy" "bucket_policy" {
  for_each = var.bucket_policys

  bucket        = sbercloud_obs_bucket.bucket[each.value.bucket_name].id
  policy_format = each.value.policy_format
  region        = try(each.value.region, var.general_region)
  policy        = each.value.policy

  depends_on = [sbercloud_obs_bucket.bucket]
}
