# Create CCE
resource "sbercloud_cce_cluster" "cluster" {
  for_each = var.clusters
  
  name                   = each.key
  enterprise_project_id  = try(each.value.project_id, var.general_project_id)
  cluster_type           = try(each.value.cluster_type, null)
  flavor_id              = each.value.flavor_id
  vpc_id                 = each.value.vpc_id
  subnet_id              = each.value.subnet_id
  container_network_type = each.value.container_network_type
  authentication_mode    = try(each.value.authentication_mode, "rbac")
  delete_all             = try(each.value.delete_all, false)
  kube_proxy_mode        = try(each.value.kube_proxy_mode, "iptables")
  description            = try(each.value.description, "Created by Terraform")
  container_network_cidr = try(each.value.container_network_cidr, "192.168.0.0/20")
  service_network_cidr   = try(each.value.service_network_cidr, "10.247.0.0/16")
  cluster_version        = each.value.cluster_version
  hibernate              = try(each.value.hibernate, false)

  dynamic "masters" {
    for_each = each.value.master_zone_list
    content {
      availability_zone = masters.value
    }
  }
}
