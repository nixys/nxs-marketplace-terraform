## Create Dedicated ELB monitor 
resource "sbercloud_elb_monitor" "monitor" {
  for_each = { for k, v in var.monitor : k => v if v.elb_type == "dedicated" }

  region                      = try(each.value.region, var.general_region)
  pool_id                     = sbercloud_elb_pool.pool[each.value.pool_name].id
  protocol                    = each.value.protocol
  interval                    = try(each.value.interval, 50)
  timeout                     = try(each.value.timeout, 49)
  max_retries                 = try(each.value.retries, 10)
  domain_name                 = each.value.protocol == "HTTP" || each.value.protocol == "HTTPS" ? try(each.value.domain_name, null) : null
  port                        = try(each.value.port, null)
  url_path                    = each.value.protocol == "HTTP" || each.value.protocol == "HTTPS" ? try(each.value.url_path, null) : null
  status_code                 = each.value.protocol == "HTTP" || each.value.protocol == "HTTPS" ? try(each.value.status_code, null) : null

  depends_on = [sbercloud_elb_pool.pool]
}

## Create Shared ELB monitor
resource "sbercloud_lb_monitor" "monitor" {
  for_each = { for k, v in var.monitor : k => v if v.elb_type == "shared" }

  region                      = try(each.value.region, var.general_region)
  pool_id                     = sbercloud_lb_pool.pool[each.value.pool_name].id
  type                        = each.value.type
  delay                       = try(each.value.delay, 50)
  timeout                     = try(each.value.timeout, 49)
  max_retries                 = try(each.value.retries, 10)
  http_method                 = try(each.value.http_method, null)
  port                        = try(each.value.port, null)
  url_path                    = try(each.value.url_path, null)
  expected_codes              = try(each.value.expected_codes, null)

  depends_on = [sbercloud_lb_pool.pool]
}
