resource "google_compute_region_target_http_proxy" "region_target_http_proxy" {
  for_each = var.region_targets_http_proxy

  name                        = each.key
  url_map                     = each.value.url_map
  description                 = try(each.value.description, "Created by Terraform")
  region                      = try(each.value.region, null)
  project                     = try(each.value.project, null)

  depends_on = [google_compute_region_url_map.region_url_map]
}

resource "google_compute_region_target_https_proxy" "region_target_https_proxy" {
  for_each = var.region_targets_https_proxy

  name                             = each.key
  url_map                          = each.value.url_map
  certificate_manager_certificates = try(each.value.certificate_manager_certificates, [])
  ssl_certificates                 = try(each.value.ssl_certificates, [])
  ssl_policy                       = try(each.value.ssl_policy, null)
  description                      = try(each.value.description, "Created by Terraform")
  region                           = try(each.value.region, null)
  project                          = try(each.value.project, null)

  depends_on = [google_compute_region_url_map.region_url_map]
}

resource "google_compute_region_target_tcp_proxy" "region_target_tcp_proxy" {
  for_each = var.region_targets_tcp_proxy

  name                        = each.key
  backend_service             = google_compute_region_backend_service.region_backend_service[each.value.backend_service].id
  description                 = try(each.value.description, "Created by Terraform")
  proxy_header                = try(each.value.proxy_header, null)
  proxy_bind                  = try(each.value.proxy_bind, null)
  region                      = try(each.value.region, null)
  project                     = try(each.value.project, null)

  depends_on = [google_compute_region_backend_service.region_backend_service]
}
