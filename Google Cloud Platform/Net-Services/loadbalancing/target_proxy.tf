resource "google_compute_target_grpc_proxy" "target_grpc_proxy" {
  for_each = var.targets_grpc_proxy

  name                        = each.key
  url_map                     = google_compute_url_map.url_map[each.value.url_map].id
  description                 = try(each.value.description, "Created by Terraform")
  validate_for_proxyless      = try(each.value.validate_for_proxyless, null)
  project                     = try(each.value.project, null)

  depends_on = [google_compute_url_map.url_map]
}

resource "google_compute_target_http_proxy" "target_http_proxy" {
  for_each = var.targets_http_proxy

  name                        = each.key
  url_map                     = google_compute_url_map.url_map[each.value.url_map].id
  description                 = try(each.value.description, "Created by Terraform")
  proxy_bind                  = try(each.value.proxy_bind, null)
  http_keep_alive_timeout_sec = try(each.value.http_keep_alive_timeout_sec, null)
  project                     = try(each.value.project, null)

  depends_on = [google_compute_url_map.url_map]
}

resource "google_compute_target_https_proxy" "target_https_proxy" {
  for_each = var.targets_https_proxy

  name                             = each.key
  url_map                          = google_compute_url_map.url_map[each.value.url_map].id
  description                      = try(each.value.description, "Created by Terraform")
  quic_override                    = try(each.value.quic_override, null)
  ssl_certificates                 = try(each.value.ssl_certificates, [])
  certificate_map                  = try(each.value.certificate_map, null)
  ssl_policy                       = try(each.value.ssl_policy, null)
  proxy_bind                       = try(each.value.proxy_bind, null)
  http_keep_alive_timeout_sec      = try(each.value.http_keep_alive_timeout_sec, null)
  server_tls_policy                = try(each.value.server_tls_policy, null)
  project                          = try(each.value.project, null)

  depends_on = [google_compute_url_map.url_map]
}

resource "google_compute_target_ssl_proxy" "target_ssl_proxy" {
  for_each = var.targets_ssl_proxy

  name                             = each.key
  backend_service                  = google_compute_backend_service.backend_service[each.value.backend_service].id
  description                      = try(each.value.description, "Created by Terraform")
  proxy_header                     = try(each.value.proxy_header, null)
  ssl_certificates                 = try(each.value.ssl_certificates, [])
  certificate_map                  = try(each.value.certificate_map, null)
  ssl_policy                       = try(each.value.ssl_policy, null)
  project                          = try(each.value.project, null)

  depends_on = [google_compute_backend_service.backend_service]
}

resource "google_compute_target_tcp_proxy" "target_tcp_proxy" {
  for_each = var.targets_tcp_proxy

  name                             = each.key
  backend_service                  = try(google_compute_backend_service.backend_service[each.value.backend_service].id, null)
  description                      = try(each.value.description, "Created by Terraform")
  proxy_header                     = try(each.value.proxy_header, null)
  proxy_bind                       = try(each.value.proxy_bind, null)
  project                          = try(each.value.project, null)

  depends_on = [google_compute_backend_service.backend_service]
}