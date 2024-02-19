## Create Dedicate ELB L7Policy
resource "sbercloud_elb_l7policy" "l7policy" {
  for_each = { for k, v in var.l7policy : k => v if v.elb_type == "dedicated" }

  name                        = each.key
  region                      = try(each.value.region, var.general_region)
  description                 = try(each.value.description, "Created by Terraform")
  listener_id                 = sbercloud_elb_listener.listener[each.value.listener_name].id
  redirect_pool_id            = sbercloud_elb_pool.pool[each.value.pool_name].id

  depends_on = [sbercloud_elb_pool.pool , sbercloud_elb_listener.listener]
}

## Create Shared ELB L7Policy
resource "sbercloud_lb_l7policy" "l7policy" {
  for_each = { for k, v in var.l7policy : k => v if v.elb_type == "shared" }

  name                        = each.key
  region                      = try(each.value.region, var.general_region)
  description                 = try(each.value.description, "Created by Terraform")
  action                      = each.value.need_redirect_http_to_https == true ? "REDIRECT_TO_LISTENER" : "REDIRECT_TO_POOL"
  listener_id                 = sbercloud_lb_listener.listener[each.value.listener_name].id
  position                    = try(each.value.position, 1)
  redirect_pool_id            = each.value.need_redirect_http_to_https == true ? null : sbercloud_lb_pool.pool[each.value.pool_name].id
  redirect_listener_id        = each.value.need_redirect_http_to_https == true ? sbercloud_lb_listener.listener[each.value.listener_https_name].id : null

  depends_on = [sbercloud_lb_pool.pool , sbercloud_lb_listener.listener]
}
