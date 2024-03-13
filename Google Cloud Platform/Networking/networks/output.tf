#==================== Network Outputs ==================== #
output "vpc_names" {
  value = [for k, v in google_compute_network.network : k]
}

output "vpc_ids" {
  value = { for k, v in google_compute_network.network : k => v.id }
}

