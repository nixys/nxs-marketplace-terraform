#==================== Outputs ==================== #

output "project_ids" {
  value = { for k, v in sbercloud_enterprise_project.projects : k => v.id }
}
