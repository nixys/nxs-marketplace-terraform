resource "sbercloud_cce_addon" "addon" {
  for_each = var.addon

  cluster_id    = sbercloud_cce_cluster.cluster[each.value.cluster_name].id
  template_name = each.key
  version       = each.value.version
  values {
    basic_json  = jsonencode(jsondecode(data.sbercloud_cce_addon_template.addon[each.key].spec).basic)
    custom_json = jsonencode(merge(
      jsondecode(data.sbercloud_cce_addon_template.addon[each.key].spec).parameters.custom,
      
      try(each.value.custom_block, {})
    ))
  flavor_json = jsonencode(jsondecode(data.sbercloud_cce_addon_template.addon[each.key].spec).parameters.flavor2)
  }

}
