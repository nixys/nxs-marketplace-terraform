## Create Dedicated ELB member
resource "sbercloud_elb_member" "member" {
  for_each = { for k, v in var.member : k => v if v.elb_type == "dedicated" }

  name                        = each.key
  region                      = try(each.value.region, var.general_region)
  pool_id                     = sbercloud_elb_pool.pool[each.value.pool_name].id
  subnet_id                   = try(each.value.subnet_id, null)
  address                     = each.value.address
  protocol_port               = each.value.protocol_port
  weight                      = try(each.value.weight, null)

  depends_on = [sbercloud_elb_pool.pool]
}

## Create Shared ELB member
resource "sbercloud_lb_member" "member" {
  for_each = { for k, v in var.member : k => v if v.elb_type == "shared" }

  name                        = each.key
  region                      = try(each.value.region, var.general_region)
  pool_id                     = sbercloud_lb_pool.pool[each.value.pool_name].id
  subnet_id                   = try(each.value.subnet_id, null)
  address                     = each.value.address
  protocol_port               = each.value.protocol_port
  weight                      = try(each.value.weight, null)
  admin_state_up              = try(each.value.admin_state_up, true)

  depends_on = [sbercloud_lb_pool.pool]
}
