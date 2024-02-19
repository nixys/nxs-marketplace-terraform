## Create Dedicate ELB ipgroup
resource "sbercloud_elb_ipgroup" "ipgroup" {
  for_each = { for k, v in var.ipgroup : k => v if v.elb_type == "dedicated" }

  name                        = each.key
  region                      = try(each.value.region, var.general_region)
  description                 = try(each.value.description, "Created by Terraform")
  enterprise_project_id       = try(each.value.project_id, var.general_project_id)

  dynamic "ip_list" {
    for_each = try(each.value.ip_list, [])
    content {
      ip          = ip_list.value.ip
      description = try(ip_list.value.description, "Created by Terraform")
    }
  }

}

## Create shared ELB whitelist
resource "sbercloud_lb_whitelist" "whitelist" {
  for_each = { for k, v in var.whitelist : k => v if v.elb_type == "shared" }

  region           = try(each.value.region, var.general_region)
  enable_whitelist = try(each.value.enable_whitelist, true)
  whitelist        = try(each.value.whitelist, "192.168.11.1,192.168.0.1/24,192.168.201.18/8")
  listener_id      = sbercloud_lb_listener.listener[each.value.listener_name].id
}