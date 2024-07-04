# Kubernetes

## Introduction

This is a set of terraform modules for the Google Cloud Platform provider for building a Kubernetes Engine and creating any different kubernetes's resources

## Features

- Supported clusters
- Supported node pools

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `clusters.location` | String | No | null | The location (region or zone) in which the cluster master will be created, as well as the default node location. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well |
| `clusters.node_locations` | List | No | [] | The list of zones in which the cluster's nodes are located. Nodes must be in the region of their regional cluster or in the same region as their cluster's zone for zonal clusters. If this is specified for a zonal cluster, omit the cluster's zone. |
| `clusters.deletion_protection` | Bool | No | null | Whether or not to allow Terraform to destroy the cluster. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply that would delete the cluster will fail. |
| `clusters.enable_http_load_balancing` | Bool | Yes | - | The status of the HTTP (L7) load balancing controller addon, which makes it easy to set up HTTP load balancers for services in a cluster. It is enabled by default; set false to disable. |
| `clusters.enable_horizontal_pod_autoscaling` | Bool | Yes | - | The status of the Horizontal Pod Autoscaling addon, which increases or decreases the number of replica pods a replication controller has based on the resource usage of the existing pods. It is enabled by default; set false to disable. |
| `clusters.cluster_autoscaling_enabled` | Bool | No | null | Whether node auto-provisioning is enabled. Must be supplied for GKE Standard clusters, true is implied for autopilot clusters. Resource limits for cpu and memory must be defined to enable node auto-provisioning for GKE Standard. |
| `clusters.resource_limits` | List | No | [] | Global constraints for machine resources in the cluster. Configuring the cpu and memory types is required if node auto-provisioning is enabled. These limits will apply to node pool autoscaling in addition to node auto-provisioning. |
| `clusters.resource_limits.autoscaling_resource_type` | String | No | "cpu" | The type of the resource. For example, cpu and memory. See the guide to using Node Auto-Provisioning for a list of types. |
| `clusters.resource_limits.autoscaling_resource_min` | Int | No | null | Minimum amount of the resource in the cluster. |
| `clusters.resource_limits.autoscaling_resource_max` | Int | No | null | Maximum amount of the resource in the cluster. |
| `clusters.default_max_pods_per_node` | Int | No | null | The default maximum number of pods per node in this cluster. This doesn't work on "routes-based" clusters, clusters that don't have IP Aliasing enabled. |
| `clusters.initial_node_count` | Int | No | null | The number of nodes to create in this cluster's default node pool. In regional or multi-zonal clusters, this is the number of nodes per zone. Must be set if node_pool is not set. If you're using google_container_node_pool objects with no default node pool, you'll need to set this to a value of at least 1, alongside setting remove_default_node_pool to true. |
| `clusters.services_range_name` | String | No | null | The name of the existing secondary range in the cluster's subnetwork to use for service ClusterIPs. Alternatively, services_ipv4_cidr_block can be used to automatically create a GKE-managed one. |
| `clusters.pods_range_name` | String | No | null | The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses. Alternatively, cluster_ipv4_cidr_block can be used to automatically create a GKE-managed one. |
| `clusters.master_authorized_networks_config` | List | No | [] | The desired configuration options for master authorized networks. Omit the nested cidr_blocks attribute to disallow external access (except the cluster node IPs, which GKE automatically whitelists). |
| `clusters.master_authorized_networks_config.cidr_block` | String | No | "" | External networks that can access the Kubernetes cluster master through HTTPS. |
| `clusters.master_authorized_networks_config.display_name` | String | No | "" | Whether Kubernetes master is accessible via Google Compute Engine Public IPs. |
| `clusters.min_master_version` | String | No | null | The minimum version of the master. GKE will auto-update the master to new versions, so this does not guarantee the current master version--use the read-only master_version field to obtain that. If unset, the cluster's version will be set by GKE to the version of the most recent official release (which is not necessarily the latest version). |
| `clusters.network` | String | No | null | The name or self_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network. |
| `clusters.enable_private_nodes` | Bool | No | null | Enables the private cluster feature, creating a private endpoint on the cluster. In a private cluster, nodes only have RFC 1918 private addresses and communicate with the master's private endpoint via private networking. |
| `clusters.enable_private_endpoint` | Bool | No | null | When true, the cluster's private endpoint is used as the cluster endpoint and access through the public endpoint is disabled. When false, either endpoint can be used. This field only applies to private clusters, when enable_private_nodes is true. |
| `clusters.master_ipv4_cidr_block` | String | No | null | The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning private IP addresses to the cluster master(s) and the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network, and it must be a /28 subnet. See Private Cluster Limitations for more details. This field only applies to private clusters, when enable_private_nodes is true. |
| `clusters.channel` | String | No | null | The selected release channel. |
| `clusters.remove_default_node_pool` | String | No | null | If true, deletes the default node pool upon cluster creation. If you're using google_container_node_pool resources with no default node pool, this should be set to true, alongside setting initial_node_count to at least 1. |
| `clusters.enable_vertical_pod_autoscaling` | Bool | No | null | Enables vertical pod autoscaling. |
| `clusters.subnetwork` | String | No | null | The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched. |
| `clusters.timeout_create` | String | No | null | Timeout create. |
| `clusters.timeout_update` | String | No | null | Timeout update. |
| `clusters.timeout_delete` | String | No | null | Timeout delete. |
| `node_pools.cluster` | String | Yes | - | The cluster to create the node pool for. Cluster must be present in location provided for clusters.  |
| `node_pools.location` | String | No | null | The location (region or zone) of the cluster. |
| `node_pools.min_node_count` | Int | No | null | Minimum number of nodes per zone in the NodePool. Must be >=0 and <= max_node_count. Cannot be used with total limits. |
| `node_pools.max_node_count` | Int | No | null | Maximum number of nodes per zone in the NodePool. Must be >= min_node_count. Cannot be used with total limits. |
| `node_pools.initial_node_count_per_zone` | Int | No | null | The initial number of nodes for the pool. In regional or multi-zonal clusters, this is the number of nodes per zone. Changing this will force recreation of the resource. WARNING: Resizing your node pool manually may change this value in your existing cluster, which will trigger destruction and recreation on the next Terraform run (to rectify the discrepancy).  |
| `node_pools.auto_repair` | Bool | No | null | Whether the nodes will be automatically repaired. Enabled by default. |
| `node_pools.auto_upgrade` | Bool | No | null | Whether the nodes will be automatically upgraded. Enabled by default. |
| `node_pools.max_pods_per_node` | Int | No | null | The maximum number of pods per node which use this pod network. |
| `node_pools.node_locations` | List | No | [] | The list of zones in which the node pool's nodes should be located. Nodes must be in the region of their regional cluster or in the same region as their cluster's zone for zonal clusters. If unspecified, the cluster-level node_locations will be used. |
| `node_pools.disk_size_gb` | Int | No | null | Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. Defaults to 100GB. |
| `node_pools.disk_type` | String | No | null | Type of the disk attached to each node (e.g. 'pd-standard', 'pd-balanced' or 'pd-ssd'). If unspecified, the default disk type is 'pd-standard' |
| `node_pools.image_type` | String | No | null | The image type to use for this node. Note that changing the image type will delete and recreate all nodes in the node pool. |
| `node_pools.oauth_scopes` | String | No | null | The set of Google API scopes to be made available on all of the node VMs under the "default" service account. Use the "https://www.googleapis.com/auth/cloud-platform" scope to grant access to all APIs. It is recommended that you set service_account to a non-default service account and grant IAM roles to that service account for only the resources that it needs. |
| `node_pools.labels` | Map | No | {} | The Kubernetes labels (key/value pairs) to be applied to each node. The kubernetes.io/ and k8s.io/ prefixes are reserved by Kubernetes Core components and cannot be specified. |
| `node_pools.taint` | List | No | [] | A list of Kubernetes taints to apply to nodes. This field will only report drift on taint keys that are already managed with Terraform, use effective_taints to view the list of GKE-managed taints on the node pool from all sources. Importing this resource will not record any taints as being Terraform-managed, and will cause drift with any configured taints. |
| `node_pools.taint.effect` | String | No | null | Effect for taint. Accepted values are NO_SCHEDULE, PREFER_NO_SCHEDULE, and NO_EXECUTE. |
| `node_pools.taint.key` | String | No | null | Key for taint. |
| `node_pools.taint.value` | String | No | null | Value for taint. |
| `node_pools.upgrade_max_surge` | Int | No | null | The number of additional nodes that can be added to the node pool during an upgrade. Increasing max_surge raises the number of nodes that can be upgraded simultaneously. Can be set to 0 or greater. |
| `node_pools.upgrade_max_unavailable` | Int | No | null | The number of nodes that can be simultaneously unavailable during an upgrade. Increasing max_unavailable raises the number of nodes that can be upgraded in parallel. Can be set to 0 or greater. |

## Example

Usage example located in this [directory](docs/example).
