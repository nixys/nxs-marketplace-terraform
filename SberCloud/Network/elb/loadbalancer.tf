## Create Dedicated ELB 
resource "sbercloud_elb_loadbalancer" "loadbalancer" {
  for_each = { for k, v in var.loadbalancer : k => v if v.elb_type == "dedicated" }

  name                  = each.key
  enterprise_project_id = try(each.value.project_id, var.general_project_id)
  region                = try(each.value.region, var.general_region)
  description           = try(each.value.description, "Created by Terraform")
  availability_zone     = try(each.value.availability_zone, ["ru-moscow-1a"])
  cross_vpc_backend     = try(each.value.cross_vpc_backend, true)
  vpc_id                = each.value.vpc_id
  ipv4_subnet_id        = each.value.ipv4_subnet_id
  ipv6_network_id       = try(each.value.ipv6_network_id, null)
  ipv6_bandwidth_id     = try(each.value.ipv6_bandwidth_id, null)
  ipv4_address          = try(each.value.ipv4_address, null)
  ipv4_eip_id           = try(each.value.ipv4_eip_id, null)
  iptype                = each.value.ipv4_eip_id != "" ? null : try(each.value.iptype, "5_bgp")
  bandwidth_charge_mode = each.value.ipv4_eip_id != "" ? null : try(each.value.bandwidth_charge_mode, "traffic")
  sharetype             = each.value.ipv4_eip_id != "" ? null : try(each.value.sharetype, "PER")
  bandwidth_size        = each.value.ipv4_eip_id != "" ? null : try(each.value.bandwidth_size, 10)
  l4_flavor_id          = each.value.type == "L4" ? data.sbercloud_elb_flavors.flavors[each.key].ids[0] : null
  l7_flavor_id          = each.value.type == "L7" ? data.sbercloud_elb_flavors.flavors[each.key].ids[0] : null
  auto_renew            = try(each.value.auto_renew, true)
  autoscaling_enabled   = try(each.value.autoscaling_enabled, false)
  min_l7_flavor_id      = try(each.value.min_l7_flavor_id, "HTTP")

  tags                  = try(each.value.tags, {})
}

## Create Shared ELB
resource "sbercloud_lb_loadbalancer" "loadbalancer" {
  for_each = { for k, v in var.loadbalancer : k => v if v.elb_type == "shared" }

  name                  = each.key
  enterprise_project_id = try(each.value.project_id, var.general_project_id)
  region                = try(each.value.region, var.general_region)
  description           = try(each.value.description, "Created by Terraform")
  vip_subnet_id         = each.value.vip_subnet_id
  vip_address           = try(each.value.vip_address, null)
  admin_state_up        = try(each.value.admin_state_up, true)

  tags                  = try(each.value.tags, {})
}
