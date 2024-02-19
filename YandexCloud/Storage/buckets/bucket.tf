resource "yandex_storage_bucket" "log_bucket" {
  for_each = { for key, value in var.buckets : key => value if value.enable_logging == true}

  bucket                = "${each.key}-log-bucket"
  default_storage_class = try(each.value.default_storage_class, "COLD")

  lifecycle_rule {
    id      = "cleanupoldlogs"
    enabled = true
    expiration {
      days = 365
    }
  }
}

resource "yandex_storage_bucket" "bucket" {
  for_each = var.buckets

  bucket = each.key
  acl    = try(each.value.acl, "private")

  max_size = try(each.value.max_size, 1048576)

  dynamic "website" {
    for_each = try(each.value.website, [])
    content {
      index_document           = try(website.value.index_document, "index.html")
      error_document           = try(website.value.error_document, null)
      redirect_all_requests_to = try(website.value.redirect_all_requests_to, null)
      routing_rules            = try(website.value.routing_rules, null)
    }
  }

  dynamic "grant" {
    for_each = try(each.value.grant, [])
    content {
      id          = try(grant.value.grant_name, null)
      permissions = try(grant.value.permissions, ["READ", "WRITE"])
      type        = try(grant.value.type, null)
      uri         = try(grant.value.uri, null)
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

  versioning {
    enabled = try(each.value.versioning_enabled, true)
  }

  object_lock_configuration {
    object_lock_enabled = try(each.value.object_lock_enabled, "Enabled")
    rule {
      default_retention {
        mode = try(each.value.object_lock_configuration_mode, null)
        years = try(each.value.object_lock_configuration_years, null)
        days = try(each.value.object_lock_configuration_days, null)
      }
    }
  }

  dynamic "logging" {
    for_each = try({ for key, value in var.buckets : key => value if value.enable_logging == true}, [])
    content {
      target_bucket = yandex_storage_bucket.log_bucket[each.key].id
      target_prefix = "log/"
    }
  }


  dynamic "lifecycle_rule" {
    for_each = try(each.value.lifecycle_rule, [])
    content {
      id                       = lifecycle_rule.value.name
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

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = try(each.value.kms_master_key_id, null)
        sse_algorithm     = try(each.value.sse_algorithm, "aws:kms")
      }
    }
  }

  policy = try(each.value.policy, null)

  tags = try(each.value.tags, {})

  anonymous_access_flags {
    read        = try(each.value.anonymous_access_flags_read , true)
    list        = try(each.value.anonymous_access_flags_list , false)
    config_read = try(each.value.anonymous_access_flags_config_read , true)
  }

  dynamic "https" {
    for_each = try(each.value.https, [])
    content {
      certificate_id = https.value.certificate_id
    }
  }

  default_storage_class = try(each.value.default_storage_class, "COLD")

}