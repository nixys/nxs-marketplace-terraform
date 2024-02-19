## Create Dedicate ELB L7Policy rule
resource "sbercloud_elb_l7rule" "l7policy_rule" {
  for_each = { for k, v in var.l7policy_rule : k => v if v.elb_type == "dedicated" }

  region                      = try(each.value.region, var.general_region)
  type                        = each.value.type
  compare_type                = each.value.compare_type 
  l7policy_id                 = sbercloud_elb_l7policy.l7policy[each.value.l7policy_name].id
  value                       = each.value.value

  depends_on = [sbercloud_elb_l7policy.l7policy]
}

## Create Shared ELB L7Policy rule
resource "sbercloud_lb_l7rule" "l7policy_rule" {
  for_each = { for k, v in var.l7policy_rule : k => v if v.elb_type == "shared" }

  region                      = try(each.value.region, var.general_region)
  type                        = each.value.type
  compare_type                = each.value.compare_type 
  l7policy_id                 = sbercloud_lb_l7policy.l7policy[each.value.l7policy_name].id
  value                       = each.value.value
  key                         = each.value.type == "COOKIE" || each.value.type == "HEADER" ? each.value.key : null

  depends_on = [sbercloud_lb_l7policy.l7policy]
}
