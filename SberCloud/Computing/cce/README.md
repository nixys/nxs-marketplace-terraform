# Cloud Container Engine (CCE)

## Introduction

This is a set of terraform modules for the SberCloud provider for building a Computing and creating Cloud Container Engine resources.

## Features

- Supported CCE
- Supported node-pools standard
- Supported Addons
- Supported PVC
- Supported Namespace
- Supported attach exist nodes from ECS
- Supported create custom nodes in cluster

## Settings

| Option | Type | Required | Default value | Description |
| --- | --- | --- | --- | --- |
| `general_project_id` | String | No | `null` | Default project |
| `general_region` | String | No | `null` | Default region |
| `clusters.project_id` | String | Yes | var.general_project_id | Specifies a unique id in UUID format of enterprise project.  |
| `clusters.cluster_type` | String | No | null | Specifies the cluster Type, possible values are VirtualMachine and ARM64. Defaults to VirtualMachine. Changing this parameter will create a new cluster resource. |
| `clusters.flavor_id` | String | Yes | null | Specifies the cluster specifications. Changing this parameter will create a new cluster resource. |
| `clusters.vpc_id` | String | Yes | null | Specifies the ID of the VPC used to create the node. Changing this parameter will create a new cluster resource. |
| `clusters.subnet_id` | String | Yes | null | Specifies the ID of the subnet used to create the node which should be configured with a DNS address. Changing this parameter will create a new cluster resource. |
| `clusters.container_network_type` | String | Yes | null | Specifies the container network type. Changing this parameter will create a new cluster resource. |
| `clusters.authentication_mode` | String | No | "rbac" | Specifies the authentication mode of the cluster, possible values are rbac and authenticating_proxy. |
| `clusters.kube_proxy_mode` | String | No | "iptables" | Specifies the service forwarding mode. Changing this parameter will create a new cluster resource. |
| `clusters.delete_all` | Bool | No | false | Specified whether to delete all associated storage resources when deleting the CCE cluster. valid values are true, try and false.  |
| `clusters.description` | String | No | "Created by Terraform" | Specifies the cluster description. |
| `clusters.container_network_cidr` | String | No | "192.168.0.0/20" | Specifies the container network segment. Changing this parameter will create a new cluster resource. |
| `clusters.service_network_cidr` | String | No | "10.247.0.0/16" | Specifies the service network segment. Changing this parameter will create a new cluster resource. |
| `clusters.cluster_version` | String | Yes | null | Specifies the cluster version, defaults to the latest supported version. Changing this parameter will create a new cluster resource. |
| `clusters.hibernate` | Bool | No | false | Specifies whether to hibernate the CCE cluster. Defaults to false. After a cluster is hibernated, resources such as workloads cannot be created or managed in the cluster, and the cluster cannot be deleted. |
| `clusters.master_zone_list` | List | No | null | Specifies the list with regions for created multi-zone cluster |
| `node_pools.cluster_name` | String | Yes | null | Cluster name when will create resources. |
| `node_pools.os` | String | No | "CentOS 7.6" | Specifies the operating system of the node. Changing this parameter will create a new resource. |
| `node_pools.performance_type` | String | No | null | Specifies the ECS flavor type. |
| `node_pools.cpu_core_count` | String | Yes | null | Specifies the number of vCPUs in the ECS flavor. |
| `node_pools.memory_size` | String | Yes | null | Specifies the memory size(GB) in the ECS flavor. |
| `node_pools.generation` | String | No | null | Specifies the generation of an ECS type. |
| `node_pools.initial_node_count` | Int | Yes | 1 | pecifies the initial number of expected nodes in the node pool. |
| `node_pools.availability_zone` | String | No | "ru-moscow-1a" | Specifies the name of the available partition (AZ). Default value is random to create nodes in a random AZ in the node pool. Changing this parameter will create a new resource. |
| `node_pools.key_pair` | String | No | null | Specifies the key pair name when logging in to select the key pair mode. This parameter and 'password' are alternative. Changing this parameter will create a new resource. |
| `node_pools.password` | String | No | null | Specifies the root password when logging in to select the password mode. This parameter can be plain or salted and is alternative to 'key_pair'. Changing this parameter will create a new resource. |
| `node_pools.scall_enable` | Bool | No | false | Specifies whether to enable auto scaling. If Autoscaler is enabled, install the autoscaler add-on to use the auto scaling feature. |
| `node_pools.min_node_count` | Int | No | 0 | Specifies the minimum number of nodes allowed if auto scaling is enabled. |
| `node_pools.max_node_count` | Int | No | 0 | Specifies the maximum number of nodes allowed if auto scaling is enabled. |
| `node_pools.scale_down_cooldown_time` | Int | No | 0 | Specifies the time interval between two scaling operations, in minutes. |
| `node_pools.priority` | Int | No | 0 | Specifies the weight of the node pool. A node pool with a higher weight has a higher priority during scaling. |
| `node_pools.type` | String | No | "vm" | Specifies the node pool type. Possible values are: vm and ElasticBMS. |
| `node_pools.postinstall` | String | No | null | Specifies the script to be executed after installation. Changing this parameter will create a new resource.|
| `node_pools.preinstall` | String | No | null | Specifies the script to be executed before installation. Changing this parameter will create a new resource.|
| `node_pools.max_pods` | Int | No | 256 | Specifies the maximum number of instances a node is allowed to create. Changing this parameter will create a new resource. |
| `node_pools.runtime` | String | No | "containerd" | Specifies the runtime of the CCE node pool. Valid values are docker and containerd. Changing this creates a new resource. |
| `node_pools.labels` | Map | No | {} | Specifies the tags of a Kubernetes node, key/value pair format. |
| `node_pools.tags` | Map | No | {} | Specifies the tags of a VM node, key/value pair format. |
| `node_pools.root_main_volume_size` | Int | Yes | 40 | Specifies the disk size in GB. Changing this parameter will create a new resource. |
| `node_pools.root_main_volumetype` | String | Yes | "SAS" | Specifies the disk type. Changing this parameter will create a new resource. |
| `node_pools.data_main_volume_size` | Int | Yes | 100 | Specifies the disk size in GB. Changing this parameter will create a new resource. |
| `node_pools.data_main_volumetype` | String | Yes | "SAS" | Specifies the disk type. Changing this parameter will create a new resource. |
| `node_pools.kms_key_id` | String | No | null | Specifies the KMS key ID. This is used to encrypt the volume. Changing this parameter will create a new resource. |
| `node_pools.additional_data_disks` | List | No | null | Specifies an array of one or more data_disks to attach to the node in node-pool. Changing this creates a new instance. |
| `node_pools.data_main_runtime_virtual_size` | String | No | null | Specifies the size of a virtual space. Only an integer percentage is supported. Example: 90%. Note that the total percentage of all virtual spaces in a group cannot exceed 100%. Changing this parameter will create a new resource. |
| `node_pools.data_main_kubernetes_virtual_size` | String | No | null | Specifies the LVM write mode, values can be linear and striped. This parameter takes effect only in kubernetes and user configuration. Changing this parameter will create a new resource. |
| `custom_node.cluster_name` | String | Yes | null | Cluster name when will create resources. |
| `custom_node.os` | String | No | "CentOS 7.6" | Specifies the operating system of the node. Changing this parameter will create a new resource. |
| `custom_node.performance_type` | String | No | null | Specifies the ECS flavor type. |
| `custom_node.cpu_core_count` | String | Yes | null | Specifies the number of vCPUs in the ECS flavor. |
| `custom_node.memory_size` | String | Yes | null | Specifies the memory size(GB) in the ECS flavor. |
| `custom_node.generation` | String | No | null | Specifies the generation of an ECS type. |
| `custom_node.initial_node_count` | Int | Yes | 1 | pecifies the initial number of expected nodes in the node pool. |
| `custom_node.availability_zone` | String | No | "ru-moscow-1a" | Specifies the name of the available partition (AZ). Default value is random to create nodes in a random AZ in the node pool. Changing this parameter will create a new resource. |
| `custom_node.key_pair` | String | No | null | Specifies the key pair name when logging in to select the key pair mode. This parameter and 'password' are alternative. Changing this parameter will create a new resource. |
| `custom_node.password` | String | No | null | Specifies the root password when logging in to select the password mode. This parameter can be plain or salted and is alternative to 'key_pair'. Changing this parameter will create a new resource. |
| `custom_node.postinstall` | String | No | null | Specifies the script to be executed after installation. Changing this parameter will create a new resource.|
| `custom_node.preinstall` | String | No | null | Specifies the script to be executed before installation. Changing this parameter will create a new resource.|
| `custom_node.max_pods` | Int | No | 256 | Specifies the maximum number of instances a node is allowed to create. Changing this parameter will create a new resource. |
| `custom_node.runtime` | String | No | "containerd" | Specifies the runtime of the CCE node pool. Valid values are docker and containerd. Changing this creates a new resource. |
| `custom_node.eip_id` | String | No | null | Specifies the ID of the EIP. Changing this parameter will create a new resource. |
| `custom_node.ecs_group_id` | String | No | null | Specifies the ECS group ID. If specified, the node will be created under the cloud server group. Changing this parameter will create a new resource. |
| `custom_node.labels` | Map | No | {} | Specifies the tags of a Kubernetes node, key/value pair format. |
| `custom_node.tags` | Map | No | {} | Specifies the tags of a VM node, key/value pair format. |
| `custom_node.root_main_volume_size` | Int | Yes | 40 | Specifies the disk size in GB. Changing this parameter will create a new resource. |
| `custom_node.root_main_volumetype` | String | Yes | "SAS" | Specifies the disk type. Changing this parameter will create a new resource. |
| `custom_node.data_main_volume_size` | Int | Yes | 100 | Specifies the disk size in GB. Changing this parameter will create a new resource. |
| `custom_node.data_main_volumetype` | String | Yes | "SAS" | Specifies the disk type. Changing this parameter will create a new resource. |
| `custom_node.kms_key_id` | String | No | null | Specifies the KMS key ID. This is used to encrypt the volume. Changing this parameter will create a new resource. |
| `custom_node.additional_data_disks` | List | No | null | Specifies an array of one or more data_disks to attach to the node in node-pool. Changing this creates a new instance. |
| `custom_node.data_main_runtime_virtual_size` | String | No | null | Specifies the size of a virtual space. Only an integer percentage is supported. Example: 90%. Note that the total percentage of all virtual spaces in a group cannot exceed 100%. Changing this parameter will create a new resource. |
| `custom_node.data_main_kubernetes_virtual_size` | String | No | null | Specifies the LVM write mode, values can be linear and striped. This parameter takes effect only in kubernetes and user configuration. Changing this parameter will create a new resource. |
| `addon.cluster_name` | String | Yes | null | Specifies the cluster ID. Changing this parameter will create a new resource. |
| `addon.version` | String | Yes | null | Specifies the version of the add-on. Changing this parameter will create a new resource. |
| `addon.custom_block` | String | Yes | null | Specifies the add-on template installation parameters. These parameters vary depending on the add-on. Structure is documented below. Changing this parameter will create a new resource. |
| `pvc.cluster_name` | String | Yes | null | Specifies the cluster ID to which the CCE PVC belongs. |
| `pvc.region` | String | No | var.general_region | Specifies the region in which to create the PVC resource. If omitted, the provider-level region will be used. Changing this will create a new PVC resource. |
| `pvc.namespace` | String | Yes | "default" | Specifies the namespace to logically divide your containers into different group. Changing this will create a new PVC resource. |
| `pvc.annotations` | Map | No | null | Specifies the unstructured key value map for external parameters. Changing this will create a new PVC resource. |
| `pvc.labels` | Map | No | null | Specifies the map of string keys and values for labels. Changing this will create a new PVC resource. |
| `pvc.storage_class_name` | String | Yes | "ssd" | Specifies the type of the storage bound to the CCE PVC.  |
| `pvc.access_modes` | List | Yes | ["ReadWriteOnce"] | Specifies the desired access modes the volume should have. |
| `pvc.storage` | String | Yes | "10Gi" | Specifies the minimum amount of storage resources required. Changing this creates a new PVC resource. |
| `namespaces.cluster_name` | String | Yes | null | Specifies the cluster ID to which the CCE namespace belongs. Changing this will create a new namespace resource. |
| `namespaces.region` | String | No | var.general_region | Specifies the region in which to create the namespace resource. If omitted, the provider-level region will be used. Changing this will create a new namespace resource. |
| `namespaces.annotations` | Map | No | null | Specifies an unstructured key value map for external parameters. Changing this will create a new namespace resource. |
| `namespaces.labels` | Map | No | null | Specifies the map of string keys and values for labels. Changing this will create a new namespace resource. |

## Example

Usage example located in this [directory](docs/example).
