## Create Dedicate ELB pool 
resource "sbercloud_elb_pool" "pool" {
  for_each = { for k, v in var.pool : k => v if v.elb_type == "dedicated" }

  name                        = each.key
  loadbalancer_id             = sbercloud_elb_loadbalancer.loadbalancer[each.value.loadbalancer_name].id
  region                      = try(each.value.region, var.general_region)
  description                 = try(each.value.description, "Created by Terraform")
  protocol                    = try(each.value.protocol, "HTTP")
  listener_id                 = sbercloud_elb_listener.listener[each.value.listener_name].id
  lb_method                   = try(each.value.lb_method, "ROUND_ROBIN")

  dynamic "persistence" {
    for_each = try(each.value.persistence, [])
    content {
      type        = persistence.value.type
      cookie_name = persistence.value.type == "APP_COOKIE" ? persistence.value.cookie_name : null
      timeout     = persistence.value.timeout
    }
  }

  depends_on = [sbercloud_elb_loadbalancer.loadbalancer]
}

## Create Shared ELB pool 
resource "sbercloud_lb_pool" "pool" {
  for_each = { for k, v in var.pool : k => v if v.elb_type == "shared" }

  name                        = each.key
  loadbalancer_id             = each.value.listener_name != "" ? null : sbercloud_lb_loadbalancer.loadbalancer[each.value.loadbalancer_name].id
  region                      = try(each.value.region, var.general_region)
  description                 = try(each.value.description, "Created by Terraform")
  protocol                    = try(each.value.protocol, "HTTP")
  listener_id                 = each.value.loadbalancer_name != "" ? null : sbercloud_lb_listener.listener[each.value.listener_name].id
  lb_method                   = try(each.value.lb_method, "ROUND_ROBIN")
  admin_state_up              = try(each.value.admin_state_up, true)

  dynamic "persistence" {
    for_each = try(each.value.persistence, [])
    content {
      type        = persistence.value.type
      cookie_name = persistence.value.type == "APP_COOKIE" ? persistence.value.cookie_name : null
      timeout     = persistence.value.timeout
    }
  }

  depends_on = [sbercloud_lb_loadbalancer.loadbalancer]
}
