resource "yandex_compute_gpu_cluster" "gpu_cluster" {
  for_each = var.gpu_clusters

  name              = each.key
  description       = try(each.value.description, "Created by Terraform")
  zone              = try(each.value.zone, "ru-central1-a")
  interconnect_type = try(each.value.interconnect_type, "infiniband")

  labels = try(each.value.labels, {})
}