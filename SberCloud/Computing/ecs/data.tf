
## Get image info
data "sbercloud_images_image" "images" {
  for_each = var.ecs

  name        = each.value.image_os_name
  visibility  = try(each.value.image_os_visibility, "public")
  most_recent = true
}

# Get flavor ECS
data "sbercloud_compute_flavors" "flavors" {
  for_each = var.ecs

  performance_type  = try(each.value.performance_type, null)
  cpu_core_count    = each.value.cpu_core_count
  memory_size       = each.value.memory_size
  availability_zone = each.value.availability_zone
  generation        = try(each.value.generation, null)
}
