resource "google_compute_backend_service" "backend_service" {
  for_each = var.backend_services

  name                        = each.key
  affinity_cookie_ttl_sec     = try(each.value.check_interval_sec, null)

  dynamic "backend" {
    for_each = try(each.value.backend, [])
    content {
      balancing_mode               = try(backend.value.balancing_mode, null)
      capacity_scaler              = try(backend.value.capacity_scaler, null)
      description                  = try(backend.value.description, null)
      group                        = try(backend.value.group, null)
      max_connections              = try(backend.value.max_connections, null)
      max_connections_per_instance = try(backend.value.max_connections_per_instance, null)
      max_connections_per_endpoint = try(backend.value.max_connections_per_endpoint, null)
      max_rate                     = try(backend.value.max_rate, null)
      max_rate_per_instance        = try(backend.value.max_rate_per_instance, null)
      max_rate_per_endpoint        = try(backend.value.max_rate_per_endpoint, null)
      max_utilization              = try(backend.value.max_utilization, [])
    }
  }

  dynamic "circuit_breakers" {
    for_each = try(each.value.circuit_breakers, [])
    content {
      max_requests_per_connection  = try(circuit_breakers.value.max_requests_per_connection, null)
      max_connections              = try(circuit_breakers.value.max_connections, null)
      max_pending_requests         = try(circuit_breakers.value.max_pending_requests, null)
      max_requests                 = try(circuit_breakers.value.max_requests, null)
      max_retries                  = try(circuit_breakers.value.max_retries, null)
    }
  }

  compression_mode            = try(each.value.compression_mode, null)

  dynamic "consistent_hash" {
    for_each = try(each.value.consistent_hash, [])
    content {
      dynamic "http_cookie" {
        for_each = try(consistent_hash.value.http_cookie, [])
        content {
          dynamic "ttl" {
            for_each = try(http_cookie.value.ttl, [])
            content {
              seconds = try(ttl.value.seconds, null)
              nanos   = try(ttl.value.nanos, null)
            }
          }
          name = try(http_cookie.value.name, null)
          path = try(http_cookie.value.path, null)
        }
      }
      http_header_name  = try(consistent_hash.value.http_header_name, null)
      minimum_ring_size = try(consistent_hash.value.minimum_ring_size, null)
    }
  }

  dynamic "cdn_policy" {
    for_each = try(each.value.cdn_policy, [])
    content {
      dynamic "cache_key_policy" {
        for_each = try(cdn_policy.value.cache_key_policy, [])
        content {
          include_host           = try(cache_key_policy.value.include_host, null)
          include_protocol       = try(cache_key_policy.value.include_protocol, null)
          include_query_string   = try(cache_key_policy.value.include_query_string, null)
          query_string_blacklist = try(cache_key_policy.value.query_string_blacklist, null)
          query_string_whitelist = try(cache_key_policy.value.query_string_whitelist, null)
          include_http_headers   = try(cache_key_policy.value.include_http_headers, [])
          include_named_cookies  = try(cache_key_policy.value.include_named_cookies, [])
        }
      }

      signed_url_cache_max_age_sec = try(each.value.signed_url_cache_max_age_sec, null)
      default_ttl                  = try(each.value.default_ttl, null)
      max_ttl                      = try(each.value.max_ttl, null)
      client_ttl                   = try(each.value.client_ttl, null)
      negative_caching             = try(each.value.negative_caching, null)

      dynamic "negative_caching_policy" {
        for_each = try(cdn_policy.value.negative_caching_policy, [])
        content {
          code                   = try(negative_caching_policy.value.code, null)
          ttl                    = try(negative_caching_policy.value.ttl, null)
        }
      }

      cache_mode                 = try(each.value.cache_mode, null)
      serve_while_stale          = try(each.value.serve_while_stale, null)

      dynamic "bypass_cache_on_request_headers" {
        for_each = try(cdn_policy.value.bypass_cache_on_request_headers, [])
        content {
          header_name            = bypass_cache_on_request_headers.value.header_name
        }
      }
    }
  }

  description                     = try(each.value.description, "Created by Terraform")
  connection_draining_timeout_sec = try(each.value.connection_draining_timeout_sec, null)
  custom_request_headers          = try(each.value.custom_request_headers, [])
  custom_response_headers         = try(each.value.custom_response_headers, [])
  enable_cdn                      = try(each.value.enable_cdn, null)
  health_checks                   = try([for health_checks in each.value.health_checks : google_compute_health_check.health_check[health_checks].id], [])

  dynamic "iap" {
    for_each = try(each.value.iap, [])
    content {
      oauth2_client_id      = iap.value.oauth2_client_id
      oauth2_client_secret  = iap.value.oauth2_client_secret
    }
  }

  load_balancing_scheme     = try(each.value.load_balancing_scheme, null)
  locality_lb_policy        = try(each.value.locality_lb_policy, null)

  dynamic "locality_lb_policies" {
    for_each = try(each.value.locality_lb_policies, [])
    content {
      dynamic "policy" {
        for_each = try(locality_lb_policies.value.policy, [])
        content {
          name      = policy.value.name
        }
      }
      dynamic "custom_policy" {
        for_each = try(locality_lb_policies.value.custom_policy, [])
        content {
          name      = custom_policy.value.name
          data      = try(custom_policy.value.data, null)
        }
      }
    }
  }

  dynamic "outlier_detection" {
    for_each = try(each.value.outlier_detection, [])
    content {
      dynamic "base_ejection_time" {
        for_each = try(outlier_detection.value.base_ejection_time, [])
        content {
          seconds = base_ejection_time.value.seconds
          nanos   = try(base_ejection_time.value.nanos, null)
        }
      }

      consecutive_errors                    = try(outlier_detection.value.consecutive_errors, null)
      consecutive_gateway_failure           = try(outlier_detection.value.consecutive_gateway_failure, null)
      enforcing_consecutive_errors          = try(outlier_detection.value.enforcing_consecutive_errors, null)
      enforcing_consecutive_gateway_failure = try(outlier_detection.value.enforcing_consecutive_gateway_failure, null)
      enforcing_success_rate                = try(outlier_detection.value.enforcing_success_rate, null)
      dynamic "interval" {
        for_each = try(outlier_detection.value.interval, [])
        content {
          seconds = base_ejection_time.value.seconds
          nanos   = try(base_ejection_time.value.nanos, null)
        }
      }

      max_ejection_percent                  = try(outlier_detection.value.max_ejection_percent, null)
      success_rate_minimum_hosts            = try(outlier_detection.value.success_rate_minimum_hosts, null)
      success_rate_request_volume           = try(outlier_detection.value.success_rate_request_volume, null)
      success_rate_stdev_factor             = try(outlier_detection.value.success_rate_stdev_factor, null)
    }
  }

  port_name            = try(each.value.port_name, null)
  protocol             = try(each.value.protocol, null)
  security_policy      = try(each.value.security_policy, null)
  edge_security_policy = try(each.value.edge_security_policy, null)

  dynamic "security_settings" {
    for_each = try(each.value.security_settings, [])
    content {
      client_tls_policy = security_settings.value.client_tls_policy
      subject_alt_names = security_settings.value.subject_alt_names 
    }
  }

  session_affinity      = try(each.value.session_affinity, null)
  timeout_sec           = try(each.value.timeout_sec, null)

  dynamic "log_config" {
    for_each = try(each.value.log_config, [])
    content {
      enable      = try(log_config.value.enable, null)
      sample_rate = try(log_config.value.sample_rate, null)
    }
  }
  project               = try(each.value.project, null)

  depends_on = [google_compute_health_check.health_check]
}
