resource "google_tpu_node" "tpu_node" {
  for_each = var.tpu_nodes

  name                   = each.key
  accelerator_type       = each.value.accelerator_type
  tensorflow_version     = each.value.tensorflow_version
  description            = try(each.value.description, "Created by Terraform")
  network                = try(each.value.network, null)
  cidr_block             = try(each.value.cidr_block, null)
  use_service_networking = try(each.value.use_service_networking, null)
  zone                   = try(each.value.zone, null)
  project                = try(each.value.project, null)

  dynamic "scheduling_config" {
    for_each = try(each.value.scheduling_config, [])
    content {
      preemptible        = try(scheduling_config.value.preemptible , null)
    }
  }

  labels = try(each.value.labels, {})
}