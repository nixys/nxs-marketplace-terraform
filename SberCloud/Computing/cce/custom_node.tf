## Create custom node for CCE
resource "sbercloud_cce_node" "custom_node" {
  for_each = var.custom_node
  
  cluster_id               = sbercloud_cce_cluster.cluster[each.value.cluster_name].id
  name                     = each.key
  os                       = each.value.os
  flavor_id                = data.sbercloud_compute_flavors.flavors_custom_node[each.key].ids[0]
  availability_zone        = try(each.value.availability_zone, "ru-moscow-1a")
  key_pair                 = try(each.value.key_pair, null)
  password                 = try(each.value.password, null)

  postinstall              = try(base64encode(each.value.postinstall), null)
  preinstall               = try(base64encode(each.value.preinstall), null)
  max_pods                 = try(each.value.max_pods, 256)
  runtime                  = try(each.value.runtime, "containerd")
  eip_id                   = try(each.value.eip_id, null)
  ecs_group_id             = try(each.value.ecs_group_id, null)

  labels           = try(each.value.labels, {})
          
  tags             = try(each.value.tags, {})

  root_volume {
    size       = each.value.root_main_volume_size
    volumetype = each.value.root_main_volumetype
  }

  data_volumes {
    size       = try(each.value.data_main_volume_size, 40)
    volumetype = try(each.value.data_main_volumetype, "SAS")
    kms_key_id = try(each.value.kms_key_id, null)
  }

  dynamic "data_volumes" {
    for_each = try(each.value.additional_data_disks, [])
    content {
      size       = try(data_volumes.value.size, 40)
      volumetype = try(data_volumes.value.volumetype, "SAS")
      kms_key_id = try(data_volumes.value.kms_key_id, null)
    }
  }

  storage {
    selectors {
      name                    = "cceUse"
      type                    = "evs"
      match_label_volume_type = try(each.value.data_main_volumetype, "SAS")
      match_label_size        = try(each.value.data_main_volume_size, 100)
      match_label_count       = "1"
    }

    dynamic "selectors" {
      for_each = try(each.value.additional_data_disks, [])
      content {
        match_label_count              = "1"
        name                           = selectors.value.name
        type                           = "evs"
        match_label_size               = selectors.value.size
        match_label_volume_type        = selectors.value.volumetype
        match_label_metadata_encrypted = selectors.value.kms_key_id != "" ? 1 : 0
        match_label_metadata_cmkid     = try(selectors.value.kms_key_id, null)
      }
    }

    groups {
      name           = "vgpaas"
      selector_names = ["cceUse"]
      cce_managed    = true

      virtual_spaces {
        name        = "kubernetes"
        size        = try(each.value.data_main_kubernetes_virtual_size, "10%")
        lvm_lv_type = "linear"
      }

      virtual_spaces {
        name        = "runtime"
        size        = try(each.value.data_main_runtime_virtual_size, "90%")
      }
    }

    dynamic "groups" {
      for_each = try(each.value.additional_data_disks, [])
      content {
        name           = "group_${groups.value.name}"
        selector_names = [groups.value.name]

        dynamic "virtual_spaces" {
          for_each = try(groups.value.virtual_spaces, [])
          content {
            name        = "user"
            size        = try(virtual_spaces.value.data_additional_virtual_size, "100%")
            lvm_path    = try(virtual_spaces.value.data_additional_lvm_path, "/data_${virtual_spaces.value.name}")
          }
        }

      }
    }
  }

  depends_on = [sbercloud_cce_cluster.cluster]
}