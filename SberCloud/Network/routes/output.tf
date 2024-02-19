#==================== Network Outputs ==================== #
output "route_table_names" {
  value = [for k, v in sbercloud_vpc_route_table.route_table : k]
}

output "route_table_ids" {
  value = { for k, v in sbercloud_vpc_route_table.route_table : k => v.id }
}

