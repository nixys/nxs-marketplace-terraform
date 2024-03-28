resource "google_compute_instance_group" "instance_group" {
  for_each = var.instance_groups

  name        = each.key
  zone        = each.value.zone
  description = try(each.value.description, "Created by Terraform")
  instances   = [for instance_name in each.value.instance_name : google_compute_instance.instance[instance_name].self_link]
  network     = try(each.value.network, null)
  project     = try(each.value.project, null)

  dynamic "named_port" {
    for_each = try(each.value.named_port, [])
    content {
      name = named_port.value.name
      port = named_port.value.port
    }
  }
}