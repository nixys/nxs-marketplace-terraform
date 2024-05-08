# Managed-opensearch

## Introduction

This is a set of terraform modules for the Yandex Cloud provider for building a Managed-opensearch and creating any different opensearch resources

## Features

- Supported opensearch-cluster

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `clusters.description` | String | No | "Created by Terraform" | Description of the OpenSearch cluster. |
| `clusters.environment` | String | Yes | "PRODUCTION" | Deployment environment of the OpenSearch cluster. |
| `clusters.network_id` | String | Yes | - | ID of the network, to which the OpenSearch cluster uses. |
| `clusters.version` | String | Yes | - | Version of the OpenSearch cluster. (allowed versions are: 5.7, 8.0) |
| `clusters.security_group_ids` | List | No | - | A set of ids of security groups assigned to hosts of the cluster. |
| `clusters.deletion_protection` | Bool | No | false | Inhibits deletion of the cluster. Can be either true or false. |
| `clusters.maintenance_window_type` | String | No | "ANYTIME" | Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window. |
| `clusters.maintenance_window_day` | String | No | - | Day of the week (in DDD format). Allowed values: "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN" |
| `clusters.maintenance_window_hour` | Int | No | - | Hour of the day in UTC (in HH format). Allowed value is between 0 and 23. |
| `clusters.opensearch_node_groups` | List | Yes | - | A list with host of the OpenSearch cluster workers. |
| `clusters.opensearch_node_groups.name` | String | Yes | - | Name of node group. |
| `clusters.opensearch_node_groups.hosts_count` | Int | Yes | - | Number of hosts within node group. |
| `clusters.opensearch_node_groups.assign_public_ip` | Bool | No | False | Sets whether the hosts should get a public IP address on creation. |
| `clusters.opensearch_node_groups.zone_ids` | List | Yes | - | Set of availability zones where node group should be created. Allowed values: ["ru-central1-a", "ru-central1-b", "ru-central1-d",] |
| `clusters.opensearch_node_groups.subnet_ids` | List | No | - | Set of subnets where node group should be created. |
| `clusters.opensearch_node_groups.roles` | List | No | ["DATA", "MANAGER"] | Sets whether the hosts should get a public IP address on creation. |
| `clusters.opensearch_node_groups.resource_preset_id` | String | Yes | - | The ID of the preset for computational resources available to a OpenSearch host (CPU, memory etc.). |
| `clusters.opensearch_node_groups.disk_type` | String | Yes | - | Type of the storage of OpenSearch node group hosts. |
| `clusters.opensearch_node_groups.disk_size` | Int | Yes | - | Volume of the storage available to a OpenSearch host, in bytes, between 10737418240 and 4398046511105 |
| `clusters.dashboards_node_groups` | List | Yes | - | A list with host of the OpenSearch cluster dashboards. |
| `clusters.dashboards_node_groups.name` | String | Yes | - | Name of node group. |
| `clusters.dashboards_node_groups.hosts_count` | Int | Yes | - | Number of hosts within node group. |
| `clusters.dashboards_node_groups.assign_public_ip` | Bool | No | False | Sets whether the hosts should get a public IP address on creation. |
| `clusters.dashboards_node_groups.zone_ids` | List | Yes | - | Set of availability zones where node group should be created. Allowed values: ["ru-central1-a", "ru-central1-b", "ru-central1-d",] |
| `clusters.dashboards_node_groups.subnet_ids` | List | No | - | Set of subnets where node group should be created. |
| `clusters.dashboards_node_groups.roles` | List | No | ["DATA", "MANAGER"] | Sets whether the dashboard hosts should get a public IP address on creation. |
| `clusters.dashboards_node_groups.resource_preset_id` | String | Yes | - | The ID of the preset for computational resources available to a OpenSearch dashboard host (CPU, memory etc.). |
| `clusters.dashboards_node_groups.disk_type` | String | Yes | - | Type of the storage of OpenSearch dashboard node group hosts. |
| `clusters.dashboards_node_groups.disk_size` | Int | Yes | - | Volume of the storage available to a OpenSearch host, in bytes, between 10737418240 and 4398046511105 |
| `clusters.labels` | Map | No | {} | A set of key/value label pairs to assign to the OpenSearch cluster. |

## Example

Usage example located in this [directory](docs/example).
