resource "google_compute_resource_policy" "policy" {
  for_each = var.policys

  name         = each.key
  description  = try(each.value.description, "Created by Terraform")
  project      = try(each.value.project, null)
  region       = try(each.value.region, null)

  dynamic "snapshot_schedule_policy" {
    for_each = try(each.value.snapshot_schedule_policy, [])
    content {
      dynamic "schedule" {
        for_each = try(snapshot_schedule_policy.value.schedule, [])
        content {
          dynamic "daily_schedule" {
            for_each = try(schedule.value.daily_schedule , [])
            content {
              days_in_cycle  = daily_schedule.value.days_in_cycle
              start_time     = daily_schedule.value.start_time
            }
          }
          dynamic "hourly_schedule" {
            for_each = try(schedule.value.hourly_schedule , [])
            content {
              hours_in_cycle = hourly_schedule.value.hours_in_cycle
              start_time     = hourly_schedule.value.start_time
            }
          }
          dynamic "weekly_schedule" {
            for_each = try(schedule.value.weekly_schedule , [])
            content {
              day_of_weeks {
                day          = weekly_schedule.value.day
                start_time   = weekly_schedule.value.start_time
              }
            }
          }
        }
      }
      dynamic "retention_policy" {
        for_each = try(snapshot_schedule_policy.value.retention_policy, [])
        content {
          max_retention_days    = retention_policy.value.max_retention_days
          on_source_disk_delete = try(retention_policy.value.on_source_disk_delete, null)
        }
      }
  
      dynamic "snapshot_properties" {
        for_each = try(snapshot_schedule_policy.value.snapshot_properties , [])
        content {
          storage_locations  = try(snapshot_properties.value.storage_locations, null)
          guest_flush        = try(snapshot_properties.value.guest_flush, null)
          chain_name         = try(snapshot_properties.value.chain_name, null)
          labels             = try(snapshot_properties.value.labels, {})
        }
      }
    }
  }

  dynamic "group_placement_policy" {
    for_each = try(each.value.group_placement_policy, [])
    content {
      vm_count                  = try(group_placement_policy.value.vm_count , null)   
      availability_domain_count = try(group_placement_policy.value.availability_domain_count , null)       
      collocation               = try(group_placement_policy.value.collocation , null)
    }
  }

  dynamic "instance_schedule_policy" {
    for_each = try(each.value.instance_schedule_policy, [])
    content {
      vm_start_schedule {
        schedule = instance_schedule_policy.value.vm_start_schedule
      }
      vm_stop_schedule {
        schedule = instance_schedule_policy.value.vm_stop_schedule
      }
      time_zone         = instance_schedule_policy.value.time_zone
      start_time        = try(instance_schedule_policy.value.start_time , null)
      expiration_time   = try(instance_schedule_policy.value.expiration_time , null)
    }
  }
  
  dynamic "disk_consistency_group_policy" {
    for_each = try(each.value.disk_consistency_group_policy, [])
    content {
      enabled = try(disk_consistency_group_policy.value.enabled, null)
    }
  }
}
