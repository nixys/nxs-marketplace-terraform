## Create pvc from cluster
resource "sbercloud_cce_pvc" "pvc" {
  for_each = var.pvc

  cluster_id         = sbercloud_cce_cluster.cluster[each.value.cluster_name].id
  name               = each.key
       
  region             = try(each.value.region, var.general_region)
  namespace          = try(each.value.namespace, "default")
  annotations        = try(each.value.annotations, null)
  labels             = try(each.value.labels, null)
  storage_class_name = try(each.value.storage_class_name, "ssd")
  access_modes       = try(each.value.access_modes, ["ReadWriteOnce"])
  storage            = try(each.value.storage, "10Gi")
}