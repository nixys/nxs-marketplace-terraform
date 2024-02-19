# Compute

## Introduction

This is a set of terraform modules for the Yandex Cloud provider for building a Compute and creating any different Compute Cloud resources

## Features

- Supported disks
- Supported filesystems
- Supported gpu-clusters
- Supported images
- Supported instances
- Supported instance-groups
- Supported instance-placment-groups
- Supported snapshots
- Supported shedule snapshots

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `disks.description` | String | No | "Created by Terraform" | Description of the disk. Provide this property when you create a resource. |
| `disks.zone` | String | No | "ru-central1-a" | Availability zone where the disk will reside. |
| `disks.size` | Int | No | null | Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the image_id or snapshot_id parameter, or specify it alone to create an empty persistent disk. If you specify this field along with image_id or snapshot_id, the size value must not be less than the size of the source image or the size of the snapshot. |
| `disks.block_size` | Int | No | null | Block size of the disk, specified in bytes. |
| `disks.type` | String | No | null | Type of disk to create. Provide this when creating a disk. |
| `disks.image_name` | String | No | null | The source image to use for disk creation. |
| `disks.disk_placement_policy` | List | No | [] | Disk placement policy configuration. |
| `disks.disk_placement_policy.disk_placement_group_name` | String | Yes | null | Specifies Disk Placement Group name. |
| `disks.labels` | Map | No | {} | Labels to assign to this disk. A list of key/value pairs. |
| `disks_from_snapshot.description` | String | No | "Created by Terraform" | Description of the disk. Provide this property when you create a resource. |
| `disks_from_snapshot.zone` | String | No | "ru-central1-a" | Availability zone where the disk will reside. |
| `disks_from_snapshot.size` | Int | No | null | Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the image_id or snapshot_id parameter, or specify it alone to create an empty persistent disk. If you specify this field along with image_id or snapshot_id, the size value must not be less than the size of the source image or the size of the snapshot. |
| `disks_from_snapshot.block_size` | Int | No | null | Block size of the disk, specified in bytes. |
| `disks_from_snapshot.type` | String | No | null | Type of disk to create. Provide this when creating a disk. |
| `disks_from_snapshot.snapshot_name` | String | No | null | The source snapshot to use for disk creation. |
| `disks_from_snapshot.disk_placement_policy` | List | No | [] | Disk placement policy configuration. |
| `disks_from_snapshot.disk_placement_policy.disk_placement_group_name` | String | Yes | null | Specifies Disk Placement Group name. |
| `disks_from_snapshot.labels` | Map | No | {} | Labels to assign to this disk. A list of key/value pairs. |
| `disk_placement_groups.description` | String | No | "Created by Terraform" | A description of the Disk Placement Group. |
| `disk_placement_groups.zone` | String | No | "ru-central1-a" | ID of the zone where the Disk Placement Group resides. |
| `disk_placement_groups.labels` | Map | No | {} | A set of key/value label pairs to assign to the Disk Placement Group. |
| `filesystems.description` | String | No | "Created by Terraform" | Description of the filesystem. Provide this property when you create a resource. |
| `filesystems.zone` | String | No | "ru-central1-a" | Availability zone where the filesystem will reside. |
| `filesystems.size` | Int | No | null | Size of the filesystem, specified in GB. |
| `filesystems.block_size` | Int | No | null | Block size of the filesystem, specified in bytes. |
| `filesystems.type` | String | No | null | Type of filesystem to create. Type network-hdd is set by default. |
| `filesystems.labels` | Map | No | {} | Labels to assign to this filesystem. A list of key/value pairs.  |
| `gpu_clusters.description` | String | No | "Created by Terraform" | Description of the GPU cluster. Provide this property when you create a resource. |
| `gpu_clusters.zone` | String | No | "ru-central1-a" | Availability zone where the GPU cluster will reside. |
| `gpu_clusters.interconnect_type` | String | No | "infiniband" | Type of interconnect between nodes to use in GPU cluster. Type infiniband is set by default, and it is the only one available at the moment. |
| `gpu_clusters.labels` | Map | No | {} | Labels to assign to this GPU cluster. A list of key/value pairs. |
| `images.description` | String | No | "Created by Terraform" | An optional description of the image. Provide this property when you create a resource. |
| `images.family` | String | No | null | The name of the image family to which this image belongs. |
| `images.min_disk_size` | Int | No | 10 | Minimum size in GB of the disk that will be created from this image. |
| `images.os_type` | String | No | "LINUX" | Operating system type that is contained in the image. Possible values: "LINUX", "WINDOWS". |
| `images.source_family` | String | No | null | The name of the family to use as the source of the new image. The ID of the latest image is taken from the "standard-images" folder. Changing the family forces a new resource to be created. |
| `images.source_image` | String | No | null | The ID of an existing image to use as the source of the image. Changing this ID forces a new resource to be created. |
| `images.source_snapshot` | String | No | null | The ID of a snapshot to use as the source of the image. Changing this ID forces a new resource to be created. |
| `images.source_disk` | String | No | null | The ID of a disk to use as the source of the image. Changing this ID forces a new resource to be created. |
| `images.source_url` | String | No | null | The URL to use as the source of the image. Changing this URL forces a new resource to be created. |
| `images.labels` | Map | No | {} | A set of key/value label pairs to assign to the image. |
| `instances.description` | String | No | "Created by Terraform" | Description of the instance. |
| `instances.zone` | String | No | "ru-central1-a" | The availability zone where the virtual machine will be created. If it is not provided, the default provider folder is used. |
| `instances.hostname` | String | No | "ru-central1-a" | Host name for the instance. This field is used to generate the instance fqdn value. The host name must be unique within the network and region. If not specified, the host name will be equal to id of the instance and fqdn will be <id>.auto.internal. Otherwise FQDN will be <hostname>.<region_id>.internal. |
| `instances.platform_id` | String | No | "ru-central1-a" | The type of virtual machine to create. The default is 'standard-v1'. |
| `instances.isntance_default_ssh_keys` | Map | No | {} | SSH key and user name for authenticate. |
| `instances.service_account_id` | String | No | null | ID of the service account authorized for this instance. |
| `instances.allow_stopping_for_update` | Bool | No | false | If true, allows Terraform to stop the instance in order to update its properties. If you try to update a property that requires stopping the instance without setting this field, the update will fail. |
| `instances.network_acceleration_type` | String | No | "standard" | Type of network acceleration. The default is standard. Values: standard, software_accelerated |
| `instances.gpu_cluster_name` | String | No | null | Name of the GPU cluster to attach this instance to. The GPU cluster must exist in the same zone as the instance. |
| `instances.maintenance_policy` | String | No | "unspecified" | Behaviour on maintenance events. The default is unspecified. Values: unspecified, migrate, restart. |
| `instances.maintenance_grace_period` | String | No | "60s" | Time between notification via metadata service and maintenance. E.g., 60s. |
| `instances.preemptible` | Bool | No | false | Specifies if the instance is preemptible. Defaults to false. |
| `instances.placement_group_name` | String | No | "" | Specifies the id of the Placement Group to assign to the instance. |
| `instances.host_affinity_rules` | List | No | [] | List of host affinity rules. The structure is documented below. |
| `instances.local_disk` | List | No | [] | List of local disks that are attached to the instance. |
| `instances.local_disk.size_bytes` | Int | Yes | - | Size of the disk, specified in bytes. |
| `instances.filesystem` | List | No | [] | List of filesystems that are attached to the instance. |
| `instances.filesystem.filesystem_name` | String | Yes | - | Name of the filesystem that should be attached. |
| `instances.filesystem.device_name` | String | No | null | Name of the device representing the filesystem on the instance. |
| `instances.filesystem.mode` | String | No | "READ_WRITE" | Mode of access to the filesystem that should be attached. By default, filesystem is attached in READ_WRITE mode. |
| `instances.resources_cores` | Int | Yes | - | CPU cores for the instance. |
| `instances.resources_memory` | Int | Yes | - | Memory size in GB. |
| `instances.resources_core_fraction` | Int | No | null | If provided, specifies baseline performance for a core as a percent. |
| `instances.boot_disk` | List | No | [] | The boot disk for the instance. |
| `instances.boot_disk.auto_delete` | Bool | No | true | Defines whether the disk will be auto-deleted when the instance is deleted. The default value is True. |
| `instances.boot_disk.mode` | String | No | "READ_WRITE" | Type of access to the disk resource. By default, a disk is attached in READ_WRITE mode. |
| `instances.boot_disk.disk_name` | String | No | null | The name of the existing disk (such as those managed by yandex_compute_disk) to attach as a boot disk. |
| `instances.boot_disk.initialize_params` | List | No | [] | Parameters for a new disk that will be created alongside the new instance. Either initialize_params or disk_id must be set. |
| `instances.boot_disk.initialize_params.description` | String | No | "Created by Terraform" | Description of the boot disk. |
| `instances.boot_disk.initialize_params.size` | Int | No | null | Size of the disk in GB. |
| `instances.boot_disk.initialize_params.block_size` | Int | No | null | Block size of the disk, specified in bytes. |
| `instances.boot_disk.initialize_params.type` | String | No | null | Disk type. |
| `instances.boot_disk.initialize_params.image_name` | String | No | null | A disk image to initialize this disk from. |
| `instances.boot_disk.initialize_params.snapshot_name` | String | No | null | A snapshot to initialize this disk from. |
| `instances.subnet_id` | String | No | - | ID of the subnet to attach this interface to. The subnet must exist in the same zone where this instance will be created. |
| `instances.ipv4` | Bool | No | true | Allocate an IPv4 address for the interface. |
| `instances.ip_address` | String | No | null | The private IP address to assign to the instance. If empty, the address will be automatically assigned from the specified subnet. |
| `instances.ipv6` | Bool | No | false | If true, allocate an IPv6 address for the interface. The address will be automatically assigned from the specified subnet. |
| `instances.ipv6_address` | String | No | null | The private IPv6 address to assign to the instance. |
| `instances.nat` | Bool | No | true | Provide a public address, for instance, to access the internet over NAT. |
| `instances.nat_ip_address` | String | No | null | Provide a public address, for instance, to access the internet over NAT. Address should be already reserved in web UI. |
| `instances.security_group_ids` | List | No | [] | Security group ids for network interface. |
| `instances.dns_record` | List | No | [] | List of configurations for creating ipv4 DNS records. |
| `instances.dns_record.fqdn` | String | Yes | - | DNS record FQDN (must have a dot at the end). |
| `instances.dns_record.dns_zone_id` | String | No | null | DNS zone ID (if not set, private zone used). |
| `instances.dns_record.ttl` | Int | No | null | DNS record TTL. in seconds |
| `instances.dns_record.ptr` | String | No | null | When set to true, also create a PTR DNS record. |
| `instances.ipv6_dns_record` | List | No | [] | List of configurations for creating ipv6 DNS records. |
| `instances.ipv6_dns_record.fqdn` | String | Yes | - | DNS record FQDN (must have a dot at the end). |
| `instances.ipv6_dns_record.dns_zone_id` | String | No | null | DNS zone ID (if not set, private zone used). |
| `instances.ipv6_dns_record.ttl` | Int | No | null | DNS record TTL. in seconds |
| `instances.ipv6_dns_record.ptr` | String | No | null | When set to true, also create a PTR DNS record. |
| `instances.nat_dns_record` | List | No | [] | List of configurations for creating ipv4 NAT DNS records. |
| `instances.nat_dns_record.fqdn` | String | Yes | - | DNS record FQDN (must have a dot at the end). |
| `instances.nat_dns_record.dns_zone_id` | String | No | null | DNS zone ID (if not set, private zone used). |
| `instances.nat_dns_record.ttl` | Int | No | null | DNS record TTL. in seconds |
| `instances.nat_dns_record.ptr` | String | No | null | When set to true, also create a PTR DNS record. |
| `instances.secondary_disk` | List | No | [] | A list of disks to attach to the instance. The structure is documented below. Note: The allow_stopping_for_update property must be set to true in order to update this structure. |
| `instances.secondary_disk.disk_name` | String | No | - | Name of the disk that is attached to the instance. |
| `instances.secondary_disk.auto_delete` | Bool | No | false | Whether the disk is auto-deleted when the instance is deleted. The default value is false. |
| `instances.secondary_disk.device_name` | Bool | No | null | Name that can be used to access an attached disk under /dev/disk/by-id/. |
| `instances.secondary_disk.mode` | Bool | No | "READ_WRITE" | Type of access to the disk resource. By default, a disk is attached in READ_WRITE mode. |
| `instances.labels` | Map | No | {} | A set of key/value label pairs to assign to the instance. |
| `instance_groups.service_account_id` | String | Yes | null | The ID of the service account authorized for this instance group. |
| `instance_groups.fixed_scale` | List | No | [] | The fixed scaling policy of the instance group. |
| `instance_groups.fixed_scale.size` | Int | Yes | - | The number of instances in the instance group. |
| `instance_groups.auto_scale` | List | No | [] | The auto scaling policy of the instance group. |
| `instance_groups.auto_scale.initial_size` | Int | Yes | null | The initial number of instances in the instance group. |
| `instance_groups.auto_scale.measurement_duration` | Int | Yes | null | The amount of time, in seconds, that metrics are averaged for. If the average value at the end of the interval is higher than the cpu_utilization_target, the instance group will increase the number of virtual machines in the group. |
| `instance_groups.auto_scale.cpu_utilization_target` | Int | Yes | null | Target CPU load level. |
| `instance_groups.auto_scale.min_zone_size` | Int | No | null | The minimum number of virtual machines in a single availability zone. |
| `instance_groups.auto_scale.max_size` | Int | No | null | The maximum number of virtual machines in the group. |
| `instance_groups.auto_scale.warmup_duration` | Int | No | null | The warm-up time of the virtual machine, in seconds. During this time, traffic is fed to the virtual machine, but load metrics are not taken into account. |
| `instance_groups.auto_scale.stabilization_duration` | Int | No | null | The minimum time interval, in seconds, to monitor the load before an instance group can reduce the number of virtual machines in the group. During this time, the group will not decrease even if the average load falls below the value of cpu_utilization_target. |
| `instance_groups.auto_scale.custom_rule` | List | No | [] | A list of custom rules. |
| `instance_groups.auto_scale.custom_rule.rule_type` | String | Yes | null | Rule type: UTILIZATION - This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone. This type of metric must have the instance_id label. WORKLOAD - This type means that the metric applies to instances in one availability zone. This type of metric must have the zone_id label. |
| `instance_groups.auto_scale.custom_rule.metric_type` | String | Yes | null | Metric type, GAUGE or COUNTER. |
| `instance_groups.auto_scale.custom_rule.metric_name` | String | Yes | null | The name of metric. |
| `instance_groups.auto_scale.custom_rule.target` | String | Yes | null | Target metric value level. |
| `instance_groups.auto_scale.custom_rule.labels` | Map | No | {} | A map of labels of metric. |
| `instance_groups.auto_scale.custom_rule.service` | String | No | null | Service of custom metric in Yandex Monitoring that should be used for scaling. |
| `instance_groups.deploy_policy` | List | Yes | [] | The deployment policy of the instance group. |
| `instance_groups.deploy_policy.max_expansion` | Int | Yes | 2 | The maximum number of instances that can be temporarily allocated above the group's target size during the update process. |
| `instance_groups.deploy_policy.max_unavailable` | Int | Yes | 1 | The maximum number of running instances that can be taken offline (stopped or deleted) at the same time during the update process. |
| `instance_groups.deploy_policy.max_deleting` | Int | No | null | The maximum number of instances that can be deleted at the same time. |
| `instance_groups.deploy_policy.max_creating` | Int | No | null | The maximum number of instances that can be created at the same time. |
| `instance_groups.deploy_policy.startup_duration` | Int | No | null | The amount of time in seconds to allow for an instance to start. Instance will be considered up and running (and start receiving traffic) only after the startup_duration has elapsed and all health checks are passed. |
| `instance_groups.deploy_policy.strategy` | String | No | null | Affects the lifecycle of the instance during deployment. If set to proactive (default), Instance Groups can forcefully stop a running instance. If opportunistic, Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy. |
| `instance_groups.platform_id` | String | No | - | The ID of the hardware platform configuration for the instance. The default is 'standard-v1'. |
| `instance_groups.template_name` | String | No | null | Name template of the instance. In order to be unique it must contain at least one of instance unique placeholders:{instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id}It may also contain another placeholders, see metadata doc for full list. |
| `instance_groups.hostname` | String | No | null | Hostname template for the instance. This field is used to generate the FQDN value of instance. The hostname must be unique within the network and region. If not specified, the hostname will be equal to id of the instance and FQDN will be <id>.auto.internal. Otherwise FQDN will be <hostname>.<region_id>.internal. |
| `instance_groups.description` | String | No | "Created by Terraform" | A description of the instance. |
| `instance_groups.isntance_default_ssh_keys` | Map | No | {} | SSH key and user name for authenticate. |
| `instance_groups.resources_cores` | Int | Yes | - | The number of CPU cores for the instance. |
| `instance_groups.resources_memory` | Int | Yes | - | The memory size in GB. |
| `instance_groups.resources_core_fraction` | Int | No | null | If provided, specifies baseline core performance as a percent. |
| `instance_groups.boot_disk` | List | Yes | [] | Boot disk specifications for the instance. |
| `instance_groups.boot_disk.name` | String | No | null | When set can be later used to change DiskSpec of actual disk. |
| `instance_groups.boot_disk.mode` | String | No | "READ_WRITE" | The access mode to the disk resource. By default a disk is attached in READ_WRITE mode. |
| `instance_groups.boot_disk.device_name` | String | No | null | This value can be used to reference the device under /dev/disk/by-id/. |
| `instance_groups.boot_disk.initialize_params` | List | Yes | [] | The ID of the cluster network. |
| `instance_groups.boot_disk.initialize_params.description` | String | No | "Created by Terraform" | A description of the boot disk. |
| `instance_groups.boot_disk.initialize_params.size` | Int | No | null | The size of the disk in GB. |
| `instance_groups.boot_disk.initialize_params.type` | String | No | null | The disk type. |
| `instance_groups.boot_disk.initialize_params.image_name` | String | No | null | The disk image to initialize this disk from. |
| `instance_groups.boot_disk.initialize_params.snapshot_name` | String | No | null | The snapshot to initialize this disk from. |
| `instance_groups.preemptible` | Bool | No | false | Specifies if the instance is preemptible. Defaults to false. |
| `instance_groups.placement_group_name` | String | No | "" | Specifies the id of the Placement Group to assign to the instances. |
| `instance_groups.network_id` | String | No | - | The ID of the network. |
| `instance_groups.subnet_ids` | List | No | - | The ID of the subnets to attach this interface to. |
| `instance_groups.ip_address` | String | No | null | Manual set static IP address. |
| `instance_groups.ipv6_address` | String | No | null | Manual set static IPv6 address. |
| `instance_groups.nat` | Bool | No | true | Flag for using NAT. |
| `instance_groups.nat_ip_address` | String | No | null | A public address that can be used to access the internet over NAT. Use variables to set. |
| `instance_groups.security_group_ids` | List | No | [] | Security group ids for network interface. |
| `instance_groups.dns_record` | List | No | [] | List of dns records. |
| `instance_groups.dns_record.fqdn` | String | Yes | - | DNS record fqdn (must have dot at the end). |
| `instance_groups.dns_record.dns_zone_id` | String | No | null | DNS zone id (if not set, private zone used). |
| `instance_groups.dns_record.ttl` | Int | No | null | DNS record TTL. |
| `instance_groups.dns_record.ptr` | String | No | null | When set to true, also create PTR DNS record. |
| `instance_groups.ipv6_dns_record` | List | No | [] | List of ipv6 dns records. |
| `instance_groups.ipv6_dns_record.fqdn` | String | Yes | - | DNS record fqdn (must have dot at the end). |
| `instance_groups.ipv6_dns_record.dns_zone_id` | String | No | null | DNS zone id (if not set, private zone used). |
| `instance_groups.ipv6_dns_record.ttl` | Int | No | null | DNS record TTL. |
| `instance_groups.ipv6_dns_record.ptr` | String | No | null | When set to true, also create PTR DNS record. |
| `instance_groups.nat_dns_record` | List | No | [] | List of nat dns records. |
| `instance_groups.nat_dns_record.fqdn` | String | Yes | - | DNS record fqdn (must have dot at the end). |
| `instance_groups.nat_dns_record.dns_zone_id` | String | No | null | DNS zone id (if not set, private zone used). |
| `instance_groups.nat_dns_record.ttl` | Int | No | null | DNS record TTL. |
| `instance_groups.nat_dns_record.ptr` | String | No | null | When set to true, also create PTR DNS record. |
| `instance_groups.secondary_disk` | List | No | [] | A list of disks to attach to the instance. |
| `instance_groups.secondary_disk.disk_name` | String | No | null | Name of the existing disk. To set use variables. |
| `instance_groups.secondary_disk.device_name` | Bool | No | null | This value can be used to reference the device under /dev/disk/by-id/. |
| `instance_groups.secondary_disk.mode` | Bool | No | "READ_WRITE" | The access mode to the disk resource. By default a disk is attached in READ_WRITE mode. |
| `instance_groups.secondary_disk.initialize_params` | List | No | [] | Parameters used for creating a disk alongside the instance. |
| `instance_groups.secondary_disk.initialize_params.description` | String | No | "Created by Terraform" | A description of the boot disk. |
| `instance_groups.secondary_disk.initialize_params.size` | Int | No | null | The size of the disk in GB. |
| `instance_groups.secondary_disk.initialize_params.type` | String | No | null | The disk type. |
| `instance_groups.secondary_disk.initialize_params.image_name` | String | No | null | The disk image to initialize this disk from. |
| `instance_groups.secondary_disk.initialize_params.snapshot_name` | String | No | null | The snapshot to initialize this disk from. |
| `instance_groups.network_settings` | String | No | "STANDARD" | Network acceleration type. By default a network is in STANDARD mode. |
| `instance_groups.filesystem` | List | No | [] | List of filesystems to attach to the instance. |
| `instance_groups.filesystem.filesystem_name` | String | No | - | Name of the filesystem that should be attached. |
| `instance_groups.filesystem.device_name` | String | No | null | Name of the device representing the filesystem on the instance. |
| `instance_groups.filesystem.mode` | String | No | "READ_WRITE" | Mode of access to the filesystem that should be attached. By default, filesystem is attached in READ_WRITE mode. |
| `instance_groups.allocation_policy_zones` | List | Yes | ["ru-central1-a", "ru-central1-b", "ru-central1-d"] | A list of availability zones. |
| `instance_groups.instance_tags_pool` | List | No | [] | The ID of the cluster network. |
| `instance_groups.instance_tags_pool.zone` | String | Yes | null | Availability zone. |
| `instance_groups.instance_tags_pool.tags` | List | Yes | [] | List of tags for instances in zone. |
| `instance_groups.health_check` | List | No | [] | Health check specifications. |
| `instance_groups.health_check.interval` | Int | No | null | The interval to wait between health checks in seconds. |
| `instance_groups.health_check.timeout` | Int | No | null | The length of time to wait for a response before the health check times out in seconds. |
| `instance_groups.health_check.healthy_threshold` | Int | No | null | The number of successful health checks before the managed instance is declared healthy. |
| `instance_groups.health_check.unhealthy_threshold` | Int | No | null | The number of failed health checks before the managed instance is declared unhealthy. |
| `instance_groups.health_check.tcp_options` | List | No | [] | TCP check options. |
| `instance_groups.health_check.tcp_options.port` | Int | Yes | - | The port used for TCP health checks. |
| `instance_groups.health_check.http_options` | List | No | [] | HTTP check options. |
| `instance_groups.health_check.http_options.port` | Int | Yes | - | The port used for HTTP health checks. |
| `instance_groups.health_check.http_options.path` | String | Yes | - | The URL path used for health check requests. |
| `instance_groups.max_checking_health_duration` | Int | No | null | Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. |
| `instance_groups.load_balancer` | List | No | [] | Load balancing specifications. |
| `instance_groups.load_balancer.target_group_name` | String | No | null | The name of the target group. |
| `instance_groups.load_balancer.target_group_description` | String | No | "Created by Terraform" | A description of the target group. |
| `instance_groups.load_balancer.target_group_labels` | Map | No | {} | A set of key/value label pairs. |
| `instance_groups.load_balancer.max_opening_traffic_duration` | Int | No | null | Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. |
| `instance_groups.load_balancer.ignore_health_checks` | Bool | No | false | Do not wait load balancer health checks. |
| `instance_groups.application_load_balancer` | List | No | [] | Application Load balancing (L7) specifications. |
| `instance_groups.application_load_balancer.target_group_name` | String | No | null | The name of the target group. |
| `instance_groups.application_load_balancer.target_group_description` | String | No | "Created by Terraform" | A description of the target group. |
| `instance_groups.application_load_balancer.target_group_labels` | Map | No | {} | A set of key/value label pairs. |
| `instance_groups.application_load_balancer.max_opening_traffic_duration` | Int | No | null | Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. |
| `instance_groups.application_load_balancer.ignore_health_checks` | Bool | No | false | Do not wait load balancer health checks. |
| `instance_groups.variables` | Map | No | {} | A set of key/value variables pairs to assign to the instance group. |
| `instance_groups.deletion_protection` | Bool | No | false | Flag that protects the instance group from accidental deletion. |
| `instance_groups.labels` | Map | No | {} | A set of key/value label pairs to assign to the instance group. |
| `placement_groups.disk_name` | String | No | - | A description of the Placement Group. |
| `placement_groups.labels` | Map | No | {} | A set of key/value label pairs to assign to the Placement Group. |
| `snapshots.description` | String | No | "Created by Terraform" | Description of the resource. |
| `snapshots.disk_name` | String | Yes | - | Name of the disk to create a snapshot from. |
| `snapshots.labels` | Map | No | {} | A set of key/value label pairs to assign to the snapshot. |
| `snapshots_shedule.description` | String | No | "Created by Terraform" | Description of the resource. |
| `snapshots_shedule.retention_period` | Int | No | null | Time duration applied to snapshots created by this snapshot schedule. This is a signed sequence of decimal numbers, each with optional fraction and a unit suffix. Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h". Examples: "300ms", "1.5h" or "2h45m". |
| `snapshots_shedule.snapshot_count` | Int | No | 7 | Maximum number of snapshots for every disk of the snapshot schedule. |
| `snapshots_shedule.schedule_policy` | List | Yes | [] | Schedule policy of the snapshot schedule. |
| `snapshots_shedule.schedule_policy.expression` | String | Yes | - | Cron expression to schedule snapshots (in cron format "* * * * *"). |
| `snapshots_shedule.schedule_policy.start_at` | String | No | null | Time to start the snapshot schedule (in format RFC3339 "2006-01-02T15:04:05Z07:00"). If empty current time will be used. Unlike an expression that specifies regularity rules, the start_at parameter determines from what point these rules will be applied. |
| `snapshots_shedule.snapshot_spec` | List | No | [] | Additional attributes for snapshots created by this snapshot schedule. |
| `snapshots_shedule.snapshot_spec.description` | String | Yes | "Created by Terraform" | Description to assign to snapshots created by this snapshot schedule. |
| `snapshots_shedule.snapshot_spec.labels` | Map | No | {} | A set of key/value label pairs to assign to snapshots created by this snapshot schedule. |
| `snapshots_shedule.labels` | Map | No | {} | A set of key/value label pairs to assign to the snapshot schedule. |

## Example

Usage example located in this [directory](docs/example).
