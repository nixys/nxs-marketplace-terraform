## Create Dedicate ELB Listener
resource "sbercloud_elb_listener" "listener" {
  for_each = { for k, v in var.listener : k => v if v.elb_type == "dedicated" }

  name                        = each.key
  loadbalancer_id             = sbercloud_elb_loadbalancer.loadbalancer[each.value.loadbalancer_name].id
  region                      = try(each.value.region, var.general_region)
  description                 = try(each.value.description, "Created by Terraform")
  protocol                    = try(each.value.protocol, "HTTP")
  protocol_port               = try(each.value.protocol_port, 8080)
  default_pool_id             = try(each.value.default_pool_id, null)
  http2_enable                = each.value.protocol == "HTTPS" ? try(each.value.http2_enable, false) : null
  forward_eip                 = each.value.protocol == "HTTP" || each.value.protocol == "HTTPS" ? try(each.value.forward_eip, false) : null
  access_policy               = try(each.value.access_policy, "white")
  ip_group                    = try(sbercloud_elb_ipgroup.ipgroup[each.value.ipgroup_name].id, null)
  server_certificate          = each.value.protocol == "HTTPS" ? try(sbercloud_elb_certificate.certificate[each.value.server_certificate_name].id, null) : null
  sni_certificate             = each.value.protocol == "HTTPS" ? [for sni_certificate_name in each.value.sni_certificate_name : sbercloud_elb_certificate.certificate[sni_certificate_name].id] : null
  ca_certificate              = each.value.protocol == "HTTPS" ? try(sbercloud_elb_certificate.certificate[each.value.certificate_name].id, null) : null
  tls_ciphers_policy          = each.value.protocol == "HTTPS" ? try(each.value.tls_ciphers_policy, null) : null
  idle_timeout                = try(each.value.idle_timeout, 0)
  request_timeout             = each.value.protocol == "HTTP" || each.value.protocol == "HTTPS" ? try(each.value.request_timeout, 60) : null
  response_timeout            = each.value.protocol == "HTTP" || each.value.protocol == "HTTPS" ? try(each.value.response_timeout, 60) : null
  advanced_forwarding_enabled = try(each.value.advanced_forwarding_enabled, false)

  tags                        = try(each.value.tags, {})

  depends_on = [sbercloud_elb_loadbalancer.loadbalancer]
}

## Create Shared ELB Listener
resource "sbercloud_lb_listener" "listener" {
  for_each = { for k, v in var.listener : k => v if v.elb_type == "shared" }

  name                        = each.key
  loadbalancer_id             = sbercloud_lb_loadbalancer.loadbalancer[each.value.loadbalancer_name].id
  region                      = try(each.value.region, var.general_region)
  description                 = try(each.value.description, "Created by Terraform")
  protocol                    = try(each.value.protocol, "HTTP")
  protocol_port               = try(each.value.protocol_port, 8080)
  default_pool_id             = try(each.value.default_pool_id, null)
  connection_limit            = try(each.value.connection_limit, -1)
  http2_enable                = each.value.protocol == "TERMINATED_HTTPS" ? try(each.value.http2_enable, false) : null
  default_tls_container_ref   = each.value.protocol == "TERMINATED_HTTPS" ? try(each.value.default_tls_container_ref, null) : null
  sni_container_refs          = each.value.protocol == "TERMINATED_HTTPS" ? [for sni_certificate_name in each.value.sni_certificate_name : sbercloud_lb_certificate.certificate[sni_certificate_name].id] : null
  tags                        = try(each.value.tags, {})

  depends_on = [sbercloud_lb_loadbalancer.loadbalancer]
}
