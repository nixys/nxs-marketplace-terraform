resource "google_compute_disk_resource_policy_attachment" "policy_attachment" {
  for_each = var.policy_attachments

  name    = each.value.name
  disk    = each.value.disk
  zone    = try(each.value.zone, "us-central1-a")
  project = try(each.value.project, null)

  depends_on = [google_compute_disk.disk]
}
