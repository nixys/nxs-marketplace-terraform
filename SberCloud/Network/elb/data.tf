## Get flavor ELB
data "sbercloud_elb_flavors" "flavors" {
  for_each = var.loadbalancer

  region          = try(each.value.region, var.general_region)
  type            = try(each.value.type ,"L7")
  max_connections = try(each.value.max_connections ,200000)
  cps             = try(each.value.cps ,2000)
  bandwidth       = try(each.value.bandwidth ,50)
}