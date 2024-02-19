resource "sbercloud_obs_bucket" "log_bucket" {
  for_each = { for key, value in var.buckets : key => value if value.enable_logging == true}

  bucket = "${each.key}-log-bucket"
  acl    = "log-delivery-write"
}

resource "sbercloud_obs_bucket" "bucket" {
  for_each = var.buckets

  bucket                 = each.key
  enterprise_project_id  = try(each.value.project_id, var.general_project_id)
  acl                    = try(each.value.acl, "private")
  versioning             = try(each.value.versioning, true)
  storage_class          = try(each.value.storage_class, "STANDARD")
  quota                  = try(each.value.quota, 0)
  force_destroy          = try(each.value.force_destroy, false)
  region                 = try(each.value.region, var.general_region)
  multi_az               = try(each.value.multi_az, true)
  policy_format          = try(each.value.policy_format, "obs")
  encryption             = each.value.kms_key_id != "" && each.value.kms_key_project_id != "" ? true : false
  kms_key_id             = try(each.value.kms_key_id, null)
  kms_key_project_id     = try(each.value.kms_key_project_id, null)

  dynamic "logging" {
    for_each = try({ for key, value in var.buckets : key => value if value.enable_logging == true}, [])
    content {
      target_bucket = sbercloud_obs_bucket.log_bucket[each.key].id
      target_prefix = "log/"
    }
  }

  dynamic "website" {
    for_each = try(each.value.website, [])
    content {
      index_document           = try(website.value.index_document, "index.html")
      error_document           = try(website.value.error_document, null)
      redirect_all_requests_to = try(website.value.redirect_all_requests_to, null)
      routing_rules            = try(website.value.routing_rules, null)
    }
  }

  dynamic "cors_rule" {
    for_each = try(each.value.cors_rule, [])
    content {
      allowed_origins = try(cors_rule.value.allowed_origins, ["*"])
      allowed_methods = try(cors_rule.value.allowed_methods, ["PUT", "POST", "GET", "DELETE", "HEAD"])
      allowed_headers = try(cors_rule.value.allowed_headers, null)
      expose_headers  = try(cors_rule.value.expose_headers, null)
      max_age_seconds = try(cors_rule.value.max_age_seconds, 100)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = try(each.value.lifecycle_rule, [])
    content {
      name                     = lifecycle_rule.value.name
      prefix                   = lifecycle_rule.value.prefix
      enabled                  = lifecycle_rule.value.enabled

      dynamic "expiration" {
        for_each = try(lifecycle_rule.value.expiration, [])
        content {
          days                 = try(expiration.value.days, 365)
        }
      }

      dynamic "transition" {
        for_each = try(lifecycle_rule.value.transition, [])
        content {
          days                 = try(transition.value.days, 180)
          storage_class        = try(transition.value.storage_class, "COLD")
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = try(lifecycle_rule.value.noncurrent_version_expiration, [])
        content {
          days                 = try(noncurrent_version_expiration.value.days, 180)
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = try(lifecycle_rule.value.noncurrent_version_transition, [])
        content {
          days                 = try(noncurrent_version_transition.value.days, 180)
          storage_class        = try(noncurrent_version_transition.value.storage_class, "COLD")
        }
      }

    }
  }
  tags = try(each.value.tags, {})
}