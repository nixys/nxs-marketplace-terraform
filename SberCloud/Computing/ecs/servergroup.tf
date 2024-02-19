
resource "sbercloud_compute_servergroup" "servergroup" {
  for_each = local.instance_to_group_vm_list
  name     = each.key
  policies = ["anti-affinity"]
  members  = each.value
}