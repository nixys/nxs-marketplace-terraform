## Create namespace from cluster
resource "sbercloud_cce_namespace" "namespace" {
  for_each = var.namespaces

  cluster_id  = sbercloud_cce_cluster.cluster[each.value.cluster_name].id
  name        = each.key
  region      = try(each.value.region, var.general_region)
  annotations = try(each.value.annotations, {})
  labels      = try(merge(each.value.labels, {"kubernetes.io/metadata.name" = each.key}), {})
}
