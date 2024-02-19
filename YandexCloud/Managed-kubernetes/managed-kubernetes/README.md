# Managed-kubernetes

## Introduction

This is a set of terraform modules for the Yandex Cloud provider for building a Managed-kubernetes and creating any different cluster resources

## Features

- Supported Cluster K8S
- Supported node groups

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `kubernetes_version` | String | No | - | Globale bersion for cluster and node_pools |
| `clusters.description` | String | No | "Created by Terraform" | A description of the Kubernetes cluster. |
| `clusters.network_id` | String | No | - | The ID of the cluster network. |
| `clusters.service_account_id` | String | No | null | Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have edit role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides. |
| `clusters.release_channel` | String | No | "STABLE" | Cluster release channel. |
| `clusters.cluster_ipv4_range` | String | No | null | CIDR block. IP range for allocating pod addresses. It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets. |
| `clusters.cluster_ipv6_range` | String | No | null | Identical to cluster_ipv4_range but for IPv6 protocol. |
| `clusters.service_ipv4_range` | String | No | null | CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. It should not overlap with any subnet in the network the Kubernetes cluster located in. |
| `clusters.service_ipv6_range` | String | No | null | Identical to service_ipv4_range but for IPv6 protocol. |
| `clusters.node_ipv4_cidr_mask_size` | String | No | null | Size of the masks that are assigned to each node in the cluster. Effectively limits maximum number of pods for each node. |
| `clusters.network_policy_provider` | String | No | "CALICO" | Network policy provider for the cluster. Possible values: CALICO. |
| `clusters.master_version` | String | No | var.kubernetes_version | Version of Kubernetes that will be used for master. |
| `clusters.master_public_ip` | Bool | No | false | When true, Kubernetes master will have visible ipv4 address. |
| `clusters.security_group_ids` | List | No | [] | List of security group IDs to which the Kubernetes cluster belongs. |
| `clusters.masters_hosts` | List | No | - | Description of the zone location of hosts. |
| `clusters.master_auto_upgrade` | Bool | Yes | false | Boolean flag that specifies if master can be upgraded automatically. When omitted, default value is TRUE. |
| `clusters.master_maintenance_windows` | List | No | [] | This structure specifies maintenance window, when update for master is allowed. When omitted, it defaults to any time. To specify time of day interval, for all days, one element should be provided, with two fields set, start_time and duration. Please see zonal_cluster_resource_name config example. |
| `clusters.master_maintenance_windows.day` | String | No | "friday" | Maintenance windows day. |
| `clusters.master_maintenance_windows.start_time` | String | No | "23:00" | Maintenance windows start time.  |
| `clusters.master_maintenance_windows.duration` | String | No | "3h30m" | Maintenance windows duration. |
| `clusters.master_logging` | List | No | [] | Master Logging options. The structure is documented below. |
| `clusters.master_logging.enabled` | Bool | No | false | Boolean flag that specifies if master components logs should be sent to Yandex Cloud Logging. The exact components that will send their logs must be configured via the options described below. |
| `clusters.master_logging.log_group_id` | String | No | null | ID of the Yandex Cloud Logging Log group. |
| `clusters.master_logging.kube_apiserver_enabled` | Bool | No | false | Boolean flag that specifies if kube-apiserver logs should be sent to Yandex Cloud Logging. |
| `clusters.master_logging.cluster_autoscaler_enabled` | Bool | No | false | Boolean flag that specifies if cluster-autoscaler logs should be sent to Yandex Cloud Logging. |
| `clusters.master_logging.events_enabled` | Bool | No | false | Boolean flag that specifies if kubernetes cluster events should be sent to Yandex Cloud Logging. |
| `clusters.master_logging.audit_enabled` | Bool | No | false | Boolean flag that specifies if kube-apiserver audit logs should be sent to Yandex Cloud Logging. |
| `clusters.labels` | Map| No| {} | A set of key/value label pairs to assign to the Kubernetes cluster. |
| `node_groups.description` | String | No | "Created by Terraform" | A description of the Kubernetes node group. |
| `node_groups.cluster_name` | String | Yes | - | The cluster name when create node-groups |
| `node_groups.node_version` | String | No | var.kubernetes_version | Version of Kubernetes that will be used for Kubernetes node group. |
| `node_groups.node_labels` | Map | Yes | {} | A set of key/value label pairs, that are assigned to all the nodes of this Kubernetes node group. Force new if change. |
| `node_groups.node_taints` | List | No | [] | A list of Kubernetes taints, that are applied to all the nodes of this Kubernetes node group.Force new if change. |
| `node_groups.allowed_unsafe_sysctls` | String | No | null | A list of allowed unsafe sysctl parameters for this node group. Force new if change. |
| `node_groups.platform_id` | String | Yes | - | The ID of the hardware platform configuration for the node group compute instances. |
| `node_groups.template_name` | String | No | null | Name template of the instance. |
| `node_groups.node_groups_default_ssh_keys` | Map | No | {} | SSH user wih root privilledges and his public key. |
| `node_groups.resources_cores` | Int | Yes | 2 | Number of CPU cores allocated to the instance. |
| `node_groups.resources_core_fraction` | Int | Yes | 100 | Baseline core performance as a percent. |
| `node_groups.resources_memory` | Int | Yes | 2 | The memory size allocated to the instance. |
| `node_groups.resources_gpus` | Int | Yes | 0 | Number of GPU cores allocated to the instance. |
| `node_groups.boot_disk_type` | String | Yes | "network-hdd" | The disk type. |
| `node_groups.boot_disk_size` | Int | Yes | 30 | The size of the disk in GB. |
| `node_groups.preemptible` | Bool | No | false | Specifies if the instance is preemptible. |
| `node_groups.ipv4` | String | No | true | Allocate an IPv4 address for the interface.  |
| `node_groups.ipv6` | String | No | false | If true, allocate an IPv6 address for the interface. The address will be automatically assigned from the specified subnet. |
| `node_groups.nat` | String | No | null | A public address that can be used to access the internet over NAT. |
| `node_groups.security_group_ids` | List | No | [] | Security group ids for network interface. |
| `node_groups.ipv4_dns_records` | String | No | - | List of configurations for creating ipv4 DNS records. |
| `node_groups.ipv6_dns_records` | String | No | - | List of configurations for creating ipv6 DNS records. |
| `node_groups.network_acceleration_type` | String | No | "standard" | Type of network acceleration. Values: standard, software_accelerated. |
| `node_groups.container_runtime` | String | Yes | "containerd" | Container runtime configuration. |
| `node_groups.fixed_scale` | List | Yes | [] | Scale policy for a fixed scale node group. |
| `node_groups.fixed_scale.size` | String | Yes | - | The number of instances in the node group. |
| `node_groups.auto_scale` | List | No | [] | Scale policy for an autoscaled node group. |
| `node_groups.auto_scale.min` | String | Yes | - | Minimum number of instances in the node group. |
| `node_groups.auto_scale.max` | String | Yes | - | Maximum number of instances in the node group. |
| `node_groups.auto_scale.initial` | String | Yes | - | Initial number of instances in the node group. |
| `node_groups.node_hosts` | List | No | [] | Description of the zone location of hosts. |
| `node_groups.node_hosts.zone` | String | Yes | - | Description of the zone location of hosts. |
| `node_groups.auto_repair` | Bool | Yes | true | Boolean flag that specifies if node group can be repaired automatically. |
| `node_groups.auto_upgrade` | Bool | Yes | false | Boolean flag that specifies if node group can be upgraded automatically.  |
| `node_groups.maintenance_window` | List | No | [] | Set of day intervals, when maintenance is allowed for this node group. When omitted, it defaults to any time. |
| `node_groups.maintenance_window.day` | String | No | "monday" | Maintenance windows day. |
| `node_groups.maintenance_window.start_time` | String | No | "23:00" | Maintenance windows start time. |
| `node_groups.maintenance_window.duration` | String | No | "4h30m" | Maintenance windows duration. |
| `node_groups.deploy_policy` | List | No | [] | Deploy policy of the node group. |
| `node_groups.deploy_policy.max_expansion` | Int | Yes | 2 | The maximum number of instances that can be temporarily allocated above the group's target size during the update. |
| `node_groups.deploy_policy.max_unavailable` | Int | Yes | 1 | The maximum number of running instances that can be taken offline during update. |
| `node_groups.labels` | Map | No | {} | An optional description of the target group. Provide this property when you create the resource. |

## Example

Usage example located in this [directory](docs/example).
