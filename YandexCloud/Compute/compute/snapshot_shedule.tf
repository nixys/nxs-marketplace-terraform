resource "yandex_compute_snapshot_schedule" "snapshot_schedule" {
  for_each = var.snapshots_shedule

  name             = each.key
  description      = try(each.value.description, "Created by Terraform")
  retention_period = try(each.value.retention_period, null)
  snapshot_count   = try(each.value.snapshot_count, 7)

  dynamic "schedule_policy" {
    for_each = try(each.value.schedule_policy, [])
    content {
      expression = schedule_policy.value.expression
      start_at   = try(schedule_policy.value.start_at, null)
    }
  }

  dynamic "snapshot_spec" {
    for_each = try(each.value.snapshot_spec, [])
    content {
      description = try(snapshot_spec.value.description, "Created by Terraform")
      labels      = try(snapshot_spec.value.labels, {})
    }
  }

  labels = try(each.value.labels, {})

  depends_on = [yandex_compute_disk.disk]
}
