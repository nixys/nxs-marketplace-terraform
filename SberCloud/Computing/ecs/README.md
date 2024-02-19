# Elastic Cloud Server (ECS)

## Introduction

This is a set of terraform modules for the SberCloud provider for building a Computing and creating Elastic Cloud Server resources.

## Features

- Supported ECS
- Supported ECS Group
- Supported Elastic IP
- Supported Key Pair
- Supported Disks and security group rules
- Supported peering, routes, EIP and virtual IP

## Settings

| Option | Type | Required | Default value | Description |
| --- | --- | --- | --- | --- |
| `general_project_id` | String | No | `null` | Default project |
| `general_region` | String | No | `null` | Default region |
| `keypair.name` | String | Yes | - | The keypair name will be the key of the element in the map. Specifies a unique name for the keypair. Changing this creates a new keypair. |
| `keypair.public_key` | String | No | null | Specifies the imported OpenSSH-formatted public key. Changing this creates a new keypair. This parameter and key_file are alternative. |
| `keypair.key_file` | String | No | null | Specifies the path of the created private key. The private key file (.pem) is created only after the resource is created. By default, the private key file will be created in the same folder as the current script file. If you need to create it in another folder, please specify the path for key_file. Changing this creates a new keypair. |
| `keypair.region` | String | No | var.general_region | Specifies the region in which to create the keypair resource. If omitted, the provider-level region will be used. Changing this creates a new keypair. |
| `ecs.name` | String | Yes | - | The ECS name will be the key of the element in the map. Specifies a unique name for the instance. The name consists of 1 to 64 characters, including letters, digits, underscores (_), hyphens (-), and periods (.). |
| `ecs.image_os_name` | String | Yes | - | The name of the image. |
| `ecs.cpu_core_count` | String | Yes | - | Specifies the number of vCPUs in the ECS flavor. |
| `ecs.memory_size` | String | Yes | - | Specifies the memory size(GB) in the ECS flavor. |
| `ecs.security_group_ids` | List | No | - | Specifies an array of one or more security group IDs to associate with the instance. |
| `ecs.availability_zone` | String | No | - | Specifies the availability zone in which to create the instance. Changing this creates a new instance. |
| `ecs.admin_pass` | String | No | null | Specifies the administrative password to assign to the instance. |
| `ecs.key_pair` | String | No | null | Specifies the SSH keypair name used for logging in to the instance. |
| `ecs.system_disk_type` | String | No | "SAS" | Specifies the system disk type of the instance. Defaults to GPSSD. Changing this creates a new instance. Available options are:<br> - SAS: high I/O disk type.<br> - SSD: ultra-high I/O disk type.<br> - GPSSD: general purpose SSD disk type.<br> - ESSD: Extreme SSD type. |
| `ecs.system_disk_size` | Int | No | null | Specifies the system disk size in GB, The value range is 1 to 1024. Shrinking the disk is not supported. |
| `ecs.user_data` | String | No | null | Specifies the user data to be injected during the instance creation. Text and text files can be injected. Changing this creates a new instance. If the user_data field is specified for a Linux ECS that is created using an image with Cloud-Init installed, the admin_pass field becomes invalid. |
| `ecs.servergroup_name` | String | No | null | If this parameter has a value, the resource "sbercloud_compute_servergroup" will be created. Specifies a unique name for the server group. This parameter can contain a maximum of 255 characters, which may consist of letters, digits, underscores (_), and hyphens (-). Changing this creates a new server group. |
| `ecs.image_os_visibility` | String | No | "public" | The visibility of the image. Must be one of public, private, market or shared. |
| `ecs.performance_type` | String | No | null | Specifies the ECS flavor type. |
| `ecs.generation` | String | No | null | Specifies the generation of an ECS type. |
| `ecs.region` | String | No | var.general_region | Specifies the region in which to create the instance. If omitted, the provider-level region will be used. Changing this creates a new instance. |
| `ecs.project_id` | String | No | var.general_project_id | Specifies a unique id in UUID format of enterprise project. |
| `ecs.tags` | Map | No | {created_by = "Terraform"} | Specifies the key/value pairs to associate with the instance. |
| `ecs.network` | List | Yes | - | Specifies an array of one or more networks to attach to the instance. The network object structure is documented below. Changing this creates a new instance. |
| `ecs.eip` | Map | No | "{}" | If this parameter has a value, the resource "sbercloud_compute_eip_associate" will be created. Specifies the key/value pairs to associate with the instance. The eip object structure is documented below. |
| `ecs.interface_attach` | Map | No | "{}" | If this parameter has a value, the resource "sbercloud_compute_interface_attach" will be created. Specifies the key/value pairs to associate with the instance. The interface_attach object structure is documented below. |
| `ecs.data_disks` | Map | No | "{}" | If this parameter has a value, the resources "sbercloud_evs_volume" and "sbercloud_compute_volume_attach" will be created. Specifies the key/value pairs to associate with the instance. The data_disks object structure is documented below. |
| `network.uuid` | String | Yes | - | Specifies the network UUID to attach to the instance. Changing this creates a new instance. |
| `network.fixed_ip_v4` | String | No | null | Specifies a fixed IPv4 address to be used on this network. Changing this creates a new instance. |
| `network.ipv6_enable` | Bool | No | false | Specifies whether the IPv6 function is enabled for the nic. Defaults to false. Changing this creates a new instance. |
| `network.source_dest_check` | Bool | No | true | Specifies whether the ECS processes only traffic that is destined specifically for it. This function is enabled by default but should be disabled if the ECS functions as a SNAT server or has a virtual IP address bound to it. |
| `network.access_network` | Bool | No | false | Specifies if this network should be used for provisioning access. Accepts true or false. Defaults to false. |
| `eip.public_ip` | String | No | null | Specifies the EIP address to associate. It's mandatory when you want to associate the ECS instance with an EIP. Changing this creates a new resource. |
| `eip.bandwidth_id` | String | No | null | Specifies the shared bandwidth ID to associate. It's mandatory when you want to associate the ECS instance with a specified shared bandwidth. Changing this creates a new resource.   |
| `eip.fixed_ip` | String | No | null | Specifies the private IP address to direct traffic to. It's mandatory and must be a valid IPv6 address when you want to associate the ECS instance with a specified shared bandwidth. Changing this creates a new resource. |
| `eip.region` | String | No | var.general_region | Specifies the region in which to create the associated resource. If omitted, the provider-level region will be used. Changing this creates a new resource. |
| `interface_attach.port_id` | String | No | null | The ID of the Port to attach to an Instance. This option and network_id are mutually exclusive. |
| `interface_attach.network_id` | String | No | null | The ID of the Network to attach to an Instance. A port will be created automatically. This option and port_id are mutually exclusive. |
| `interface_attach.fixed_ip` | String | No | null | An IP address to assosciate with the port. |
| `interface_attach.source_dest_check` | Bool | No | false | Specifies whether the ECS processes only traffic that is destined specifically for it. This function is enabled by default but should be disabled if the ECS functions as a SNAT server or has a virtual IP address bound to it. |
| `interface_attach.security_group_ids` | String | No | var.ecs.security_group_ids | Specifies the list of security group IDs bound to the specified port. Defaults to the ecs's security group. |
| `interface_attach.region` | String | No | var.general_region | The region in which to create the network interface attache resource. If omitted, the provider-level region will be used. Changing this creates a new network interface attache resource. |
| `data_disks.name` | String | Yes | - | The data disk name will be the "ECS name"_"key of the element in the map". Specifies the disk name. If you create disks one by one, the name value is the disk name. The value can contain a maximum of 255 bytes. If you create multiple disks (the count value is greater than 1), the system automatically adds a hyphen followed by a four-digit incremental number, such as -0000, to the end of each disk name. For example, the disk names can be volume-0001 and volume-0002. The value can contain a maximum of 250 bytes. |
| `data_disks.volume_type` | String | No | "SAS" | Specifies the disk type. Currently, the value can be SSD, SAS, or SATA.<br> - SSD: specifies the ultra-high I/O disk type.<br> - SAS: specifies the high I/O disk type.<br> - SATA: specifies the common I/O disk type. If the specified disk type is not available in the AZ, the disk will fail to create. |
| `data_disks.size` | Int | Yes | - | Specifies the disk size, in GB. Its value can be as follows: Data disk: 10 GB to 32768 GB This parameter is mandatory when you create an empty disk. You can specify the parameter value as required within the value range. This parameter is mandatory when you create the disk from a snapshot. Ensure that the disk size is greater than or equal to the snapshot size. This parameter is mandatory when you create the disk from an image. Ensure that the disk size is greater than or equal to the minimum disk capacity required by min_disk in the image attributes. This parameter is optional when you create the disk from a backup. If this parameter is not specified, the disk size is equal to the backup size. Changing this parameter will update the disk. You can extend the disk by setting this parameter to a new value, which must be between current size and the max size(System disk: 1024 GB; Data disk: 32768 GB). Shrinking the disk is not supported.   |
| `data_disks.description` | String | No | "Created by Terraform" | Specifies the enterprise project id of the disk. Changing this creates a new disk. |
| `data_disks.project_id` | String | No | var.general_project_id | Specifies a unique id in UUID format of enterprise project. |
| `data_disks.region` | String | No | var.general_region | The region in which to create the EVS volume resource. If omitted, the provider-level region will be used. Changing this creates a new EVS resource. |

## Example

Usage example located in this [directory](docs/example).
