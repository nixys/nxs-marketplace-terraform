resource "google_compute_region_url_map" "region_url_map" {
  for_each = var.region_url_maps

  name                        = each.key
  region                      = try(each.value.region, null)
  description                 = try(each.value.description, "Created by Terraform")
  default_service             = try(google_compute_region_backend_service.region_backend_service[each.value.default_service].id, null)

  dynamic "host_rule" {
    for_each = try(each.value.host_rule, [])
    content {
      hosts        = host_rule.value.hosts
      path_matcher = host_rule.value.path_matcher
      description  = try(host_rule.value.description, "Created by Terraform")
    }
  }

  dynamic "path_matcher" {
    for_each = try(each.value.path_matcher, [])
    content {
      name            = path_matcher.value.name
      default_service = try(google_compute_region_backend_service.region_backend_service[path_matcher.value.default_service].id, null)

      dynamic "path_rule" {
        for_each = try(path_matcher.value.path_rule, [])
        content {
          paths   = path_rule.value.paths
          service = try(google_compute_region_backend_service.region_backend_service[path_rule.value.service].id, null)
        }
      }
    }
  }

  dynamic "test" {
    for_each = try(each.value.test, [])
    content {
      description = try(test.value.description, "Created by Terraform")
      host        = test.value.host
      path        = test.value.path
      service     = google_compute_region_backend_service.region_backend_service[test.value.service].id
    }
  }

  depends_on = [google_compute_region_backend_service.region_backend_service]
}