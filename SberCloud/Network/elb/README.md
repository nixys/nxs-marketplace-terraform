# Elastic Load Balance (elb)

## Introduction

This is a set of terraform modules for the SberCloud provider for building a network and creating network resources.

## Features

- Supported Shared/Dedicated LoadBalancer
- Supported Shared/Dedicated Certificate
- Supported Shared/Dedicated L7Policy and L7Policy rules
- Supported Shared/Dedicated Listeners
- Supported Shared/Dedicated Member
- Supported Shared/Dedicated Monitor
- Supported Shared/Dedicated Pool
- Supported Shared whitelist and Dedicated ipgroup

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `general_project_id` | String | No | `null` | Default project |
| `general_region` | String | No | `null` | Default region |
| `certificate.elb_type` | String | Yes | - | You can specify the resource type for the balancer type. Example: shared, dedicated. Changing this creates a new resource. |
| `certificate.region` | String | No | var.general_region | This parameter works for two types of balancer (shared and dedicated).The region in which to create the ELB certificate resource. If omitted, the provider-level region will be used. Changing this creates a new certificate. |
| `certificate.description` | String | No | - | This parameter works for two types of balancer (shared and dedicated).Human-readable description for the Certificate. |
| `certificate.enterprise_project_id` | String | Yes | var.general_project_id | This parameter works for two types of balancer (shared and dedicated).The enterprise project ID of the certificate. Changing this creates a new certificate. |
| `certificate.type` | String | No | - | This parameter works for two types of balancer (shared and dedicated).Specifies the certificate type. Example: server, client.Changing this creates a new resource. |
| `certificate.certificate` | String | Yes | - | This parameter works for two types of balancer (shared and dedicated).The public encrypted key of the Certificate, PEM format. |
| `certificate.private_key` | String | No | - | This parameter works for two types of balancer (shared and dedicated).The private encrypted key of the Certificate, PEM format. This parameter is valid and mandatory only when type is set to "server". |
| `certificate.domain` | String | No | - | This parameter works for two types of balancer (shared and dedicated).The domain of the Certificate. The value contains a maximum of 100 characters. This parameter is valid only when type is set to "server". |
| `loadbalancer.elb_type` | String | Yes | - | You can specify the resource type for the balancer type. Example: shared, dedicated. Changing this creates a new resource. |
| `loadbalancer.enterprise_project_id` | String | No | var.general_project_id | This parameter works for two types of balancer (shared and dedicated).The enterprise project id of the loadbalancer. Changing this creates a new loadbalancer. |
| `loadbalancer.region` | String | No | var.general_region | This parameter works for two types of balancer (shared and dedicated).The region in which to create the loadbalancer resource. If omitted, the provider-level region will be used. Changing this creates a new loadbalancer. |
| `loadbalancer.description` | String | No | "Created by Terraform" | This parameter works for two types of balancer (shared and dedicated).Human-readable description for the loadbalancer. |
| `loadbalancer.tags` | Map | No | {} | This parameter works for two types of balancer (shared and dedicated).The key/value pairs to associate with the loadbalancer. |
| `loadbalancer.availability_zone` | List | Yes | ["ru-moscow-1a"] | This parameter works for one type of balancer (dedicated).Specifies the list of AZ names. Changing this parameter will create a new resource. |
| `loadbalancer.cross_vpc_backend` | Bool | No | true | This parameter works for one type of balancer (dedicated).Enable this if you want to associate the IP addresses of backend servers with your load balancer. Can only be true when updating. |
| `loadbalancer.vpc_id` | String | No | - | This parameter works for one type of balancer (dedicated).The vpc on which to create the loadbalancer. Changing this creates a new loadbalancer. |
| `loadbalancer.ipv4_subnet_id` | String | No | - | This parameter works for one type of balancer (dedicated).The IPv4 subnet ID of the subnet on which to allocate the loadbalancer's ipv4 address. |
| `loadbalancer.ipv6_network_id` | String | No | - | This parameter works for one type of balancer (dedicated).The ID of the subnet on which to allocate the loadbalancer's ipv6 address. |
| `loadbalancer.ipv6_bandwidth_id` | String | No | - | This parameter works for one type of balancer (dedicated).The ipv6 bandwidth id. Only support shared bandwidth. |
| `loadbalancer.ipv4_address` | String | No | - | This parameter works for one type of balancer (dedicated).The ipv4 address of the load balancer. |
| `loadbalancer.ipv4_eip_id` | String | No | - | This parameter works for one type of balancer (dedicated).The ID of the EIP. Changing this parameter will create a new resource. |
| `loadbalancer.iptype` | String | No | "5_bgp" | This parameter works for one type of balancer (dedicated).Elastic IP type. Changing this parameter will create a new resource. |
| `loadbalancer.bandwidth_charge_mode` | String | No | "traffic" | This parameter works for one type of balancer (dedicated).Bandwidth billing type. Changing this parameter will create a new resource. |
| `loadbalancer.sharetype` | String | No | "PER" | This parameter works for one type of balancer (dedicated).Bandwidth sharing type. Changing this parameter will create a new resource. |
| `loadbalancer.bandwidth_size` | Int | No | 10 | This parameter works for one type of balancer (dedicated).Bandwidth size. Changing this parameter will create a new resource. |
| `loadbalancer.type` | String | No | - | This parameter works for one type of balancer (dedicated). The type for traffic. Example: L4, L7 |
| `loadbalancer.max_connections` | Int | No | - | This parameter works for one type of balancer (dedicated).Specifies the maximum connections in the flavor. |
| `loadbalancer.cps` | Int | No | - | This parameter works for one type of balancer (dedicated).Specifies the cps in the flavor. |
| `loadbalancer.bandwidth` | Int | No | - | This parameter works for one type of balancer (dedicated).Specifies the bandwidth size(Mbit/s) in the flavor. |
| `loadbalancer.auto_renew` | Bool | No | true | This parameter works for one type of balancer (dedicated).Specifies whether auto renew is enabled. Valid values are true and false. |
| `loadbalancer.autoscaling_enabled` | Bool | No | false | This parameter works for one type of balancer (dedicated).Specifies whether autoscaling is enabled. Valid values are true and false. |
| `loadbalancer.min_l7_flavor_id` | String | No | "HTTP" | This parameter works for one type of balancer (dedicated).Specifies the ID of the minimum Layer-7 flavor for elastic scaling. This parameter cannot be left blank if there are HTTP or HTTPS listeners. |
| `loadbalancer.vip_subnet_id` | String | Yes | - | This parameter works for one type of balancer (shared).The network on which to allocate the loadbalancer's address. A tenant can only create Loadbalancers on networks authorized by policy (e.g. networks that belong to them or networks that are shared). Changing this creates a new loadbalancer. |
| `loadbalancer.vip_address` | String | No | - | This parameter works for one type of balancer (shared).The domain of the Certificate. The ip address of the load balancer. Changing this creates a new loadbalancer. |
| `ipgroup.elb_type` | String | Yes | - | You can specify the resource type for the balancer type. Example: shared, dedicated. Changing this creates a new resource. |
| `ipgroup.enterprise_project_id` | String | No | var.general_project_id | This parameter works for one type of balancer (dedicated). |
| `ipgroup.region` | String | No | var.general_region | This parameter works for one type of balancer (dedicated). |
| `ipgroup.description` | String | No | "Created by Terraform" | This parameter works for one type of balancer (dedicated). |
| `ipgroup.ip_list` | List | Yes | [] | This parameter works for one type of balancer (dedicated). Specifies an array of one or more ip addresses. The ip_list object structure is documented below. |
| `whitelist.elb_type` | String | Yes | - | You can specify the resource type for the balancer type. Example: shared, dedicated. Changing this creates a new resource. |
| `whitelist.region` | String | No | var.general_region | This parameter works for one type of balancer (shared). The region in which to create the ELB whitelist resource. If omitted, the provider-level region will be used. Changing this creates a new whitelist. |
| `whitelist.enable_whitelist` | Bool | No | true | This parameter works for one type of balancer (shared). Specify whether to enable access control. |
| `whitelist.whitelist` | String | No | "192.168.11.1,192.168.0.1/24,192.168.201.18/8" | This parameter works for one type of balancer (shared). Specifies an array of one or more ip addresses. The ip_list object structure is documented below. |
| `whitelist.listener_name` | String | Yes | null | This parameter works for one type of balancer (shared). The Listener name that the whitelist will be associated with. Changing this creates a new whitelist. |
| `listener.elb_type` | String | Yes | - | You can specify the resource type for the balancer type. Example: shared, dedicated. Changing this creates a new resource. |
| `listener.region` | String | No | var.general_region | This parameter works for two types of balancer (shared and dedicated).The region in which to create the listener resource. If omitted, the provider-level region will be used. Changing this creates a new listener. |
| `listener.description` | String | No | "Created by Terraform" | This parameter works for two types of balancer (shared and dedicated).Human-readable description for the listener. |
| `listener.loadbalancer_name` | String | Yes | null | This parameter works for two types of balancer (shared and dedicated).The load balancer on which to provision this listener. Changing this creates a new listener. |
| `listener.protocol` | String | Yes | "HTTP" | This parameter works for two types of balancer (shared and dedicated).The protocol can either be TCP, UDP, HTTP or HTTPS. Changing this creates a new listener. |
| `listener.protocol_port` | Int | Yes | 8080 | This parameter works for two types of balancer (shared and dedicated).The port on which to listen for client traffic. Changing this creates a new listener. |
| `listener.http2_enable` | Bool | No | false | This parameter works for two types of balancer (shared and dedicated).Specifies whether to use HTTP/2. The default value is false. This parameter is valid only when the protocol is set to HTTPS. |
| `listener.tags` | Map | No | {} | This parameter works for two types of balancer (shared and dedicated).The key/value pairs to associate with the listener. |
| `listener.forward_eip` | Bool | No | false | This parameter works for one type of balancer (dedicated).Specifies whether transfer the load balancer EIP in the X-Forward-EIP header to backend servers. The default value is false. This parameter is valid only when the protocol is set to HTTP or HTTPS. |
| `listener.access_policy` | String | No | "white" | This parameter works for one type of balancer (dedicated).Specifies the access policy for the listener. Valid options are white and black. |
| `listener.ipgroup_name` | String | No | null | This parameter works for one type of balancer (dedicated).Specifies the ip group name for the listener. |
| `listener.server_certificate_name` | String | No | null | This parameter works for one type of balancer (dedicated).Specifies the name of the server certificate used by the listener. This parameter is mandatory when protocol is set to HTTPS. |
| `listener.sni_certificate_name` | List | No | [] | This parameter works for one type of balancer (dedicated).Lists the name of SNI certificates (server certificates with a domain name) used by the listener. This parameter is valid when protocol is set to HTTPS. |
| `listener.ca_certificate_name` | String | No | null | This parameter works for one type of balancer (dedicated).Specifies the name of the CA certificate used by the listener. This parameter is valid when protocol is set to HTTPS. |
| `listener.tls_ciphers_policy` | String | No | null | This parameter works for one type of balancer (dedicated).Specifies the TLS cipher policy for the listener. Valid options are: tls-1-0-inherit, tls-1-0, tls-1-1, tls-1-2, tls-1-2-strict, tls-1-2-fs, tls-1-0-with-1-3, and tls-1-2-fs-with-1-3. This parameter is valid when protocol is set to HTTPS. |
| `listener.idle_timeout` | Int | No | 0 | This parameter works for one type of balancer (dedicated).Specifies the idle timeout for the listener. Value range: 0 to 4000. |
| `listener.request_timeout` | Int | No | 60 | This parameter works for one type of balancer (dedicated).Specifies the request timeout for the listener. Value range: 1 to 300. This parameter is valid when protocol is set to HTTP or HTTPS. |
| `listener.response_timeout` | Int | No | 60 | This parameter works for one type of balancer (dedicated).Specifies the response timeout for the listener. Value range: 1 to 300. This parameter is valid when protocol is set to HTTP or HTTPS. |
| `listener.advanced_forwarding_enabled` | Bool | No | false | This parameter works for one type of balancer (dedicated).Specifies whether to enable advanced forwarding. If advanced forwarding is enabled, more flexible forwarding policies and rules are supported. |
| `listener.connection_limit` | Int | No | -1 | This parameter works for one type of balancer (shared).The maximum number of connections allowed for the listener. The value ranges from -1 to 2,147,483,647. This parameter is reserved and has been not used. Only the administrator can specify the maximum number of connections. |
| `listener.default_tls_container_ref` | String | No | null | This parameter works for one type of balancer (shared).Specifies the name of the server certificate used by the listener. This parameter is mandatory when protocol is set to TERMINATED_HTTPS. |
| `listener.sni_container_refs` | List | No | null| This parameter works for one type of balancer (shared).Specifies the name of the server certificate used by the listener. This parameter is mandatory when protocol is set to TERMINATED_HTTPS. |
| `pool.elb_type` | String | Yes | - | You can specify the resource type for the balancer type. Example: shared, dedicated. Changing this creates a new resource. |
| `pool.region` | String | No | var.general_region | This parameter works for two types of balancer (shared and dedicated).The region in which to create the ELB pool resource. If omitted, the the provider-level region will be used. Changing this creates a new pool. |
| `pool.description` | String | No | "Created by Terraform" | This parameter works for two types of balancer (shared and dedicated).Human-readable description for the pool. |
| `pool.loadbalancer_name` | String | Yes | null | This parameter works for two types of balancer (shared and dedicated).The load balancer on which to provision this pool. Changing this creates a new pool. Note: Exactly one of LoadbalancerID or ListenerID must be provided. |
| `pool.protocol` | String | Yes | "HTTP" | This parameter works for two types of balancer (shared and dedicated).The protocol - can either be TCP, UDP, HTTP, HTTPS or QUIC. |
| `pool.listener_name` | Int | No | 8080 | This parameter works for two types of balancer (shared and dedicated).The Listener on which the members of the pool will be associated with. Changing this creates a new pool. Note: Exactly one of LoadbalancerID or ListenerID must be provided. |
| `pool.lb_method` | Bool | Yes | "ROUND_ROBIN" | This parameter works for two types of balancer (shared and dedicated).The load balancing algorithm to distribute traffic to the pool's members. Must be one of ROUND_ROBIN, LEAST_CONNECTIONS, or SOURCE_IP. |
| `pool.persistence` | List | Yes | {} | This parameter works for two types of balancer (shared and dedicated).Omit this field to prevent session persistence. Indicates whether connections in the same session will be processed by the same Pool member or not. Changing this creates a new pool. |
| `member.elb_type` | String | Yes | null | You can specify the resource type for the balancer type. Example: shared, dedicated. Changing this creates a new resource. |
| `member.region` | String | No | var.general_region | This parameter works for two types of balancer (shared and dedicated).The region in which to create the ELB member resource. If omitted, the the provider-level region will be used. Changing this creates a new member. |
| `member.pool_name` | String | Yes | null | This parameter works for two types of balancer (shared and dedicated).The name of the pool that this member will be assigned to. |
| `member.subnet_id` | String | No | null | This parameter works for two types of balancer (shared and dedicated).The IPv4 or IPv6 subnet name of the subnet in which to access the member.|
| `member.address` | String | Yes | null | This parameter works for two types of balancer (shared and dedicated).The IP address of the member to receive traffic from the load balancer. Changing this creates a new member. |
| `member.protocol_port` | Int | Yes | null | This parameter works for two types of balancer (shared and dedicated).The port on which to listen for client traffic. Changing this creates a new member. |
| `member.weight` | Int | No | null | This parameter works for two types of balancer (shared and dedicated).A positive integer value that indicates the relative portion of traffic that this member should receive from the pool. For example, a member with a weight of 10 receives five times as much traffic as a member with a weight of 2. |
| `monitor.elb_type` | String | Yes | null | You can specify the resource type for the balancer type. Example: shared, dedicated. Changing this creates a new resource. |
| `monitor.region` | String | No | var.general_region | This parameter works for two types of balancer (shared and dedicated).The region in which to create the ELB member resource. If omitted, the the provider-level region will be used. Changing this creates a new member. |
| `monitor.pool_name` | String | Yes | null | This parameter works for two types of balancer (shared and dedicated).Specifies the name of the pool that this monitor will be assigned to. Changing this creates a new monitor. |
| `monitor.type` | String | Yes | null | This parameter works for two types of balancer (shared and dedicated).Specifies the monitor protocol. The value can be TCP, UDP_CONNECT, or HTTP. If the listener protocol is UDP, the monitor protocol must be UDP_CONNECT. Changing this creates a new monitor. |
| `monitor.timeout` | Int | Yes | 49 | This parameter works for two types of balancer (shared and dedicated).Specifies the health check timeout duration in the unit of second. The value ranges from 1 to 50 and must be less than the delay value.|
| `monitor.max_retries` | Int | No | 10 | This parameter works for two types of balancer (shared and dedicated).Specifies the maximum number of consecutive health checks after which the backend servers are declared healthy. The value ranges from 1 to 10. |
| `monitor.url_path` | String | No | null | This parameter works for two types of balancer (shared and dedicated).Specifies the HTTP request path for the health check. Required for HTTP type. The value starts with a slash (/) and contains a maximum of 255 characters. |
| `monitor.port` | Int | No | null | This parameter works for two types of balancer (shared and dedicated).Specifies the health check port. The port number ranges from 1 to 65535. If not specified, the port of the backend server will be used as the health check port. |
| `monitor.interval` | Int | Yes | 50 | This parameter works for one type of balancer (dedicated).Specifies the interval between health checks, in seconds. Value ranges from 1 to 50. |
| `monitor.domain_name` | String | No | null | This parameter works for one type of balancer (dedicated).Specifies the domain name that HTTP requests are sent to during the health check. The domain name consists of 1 to 100 characters, can contain only digits, letters, hyphens (-), and periods (.) and must start with a digit or letter. The value is left blank by default, indicating that the virtual IP address of the load balancer is used as the destination address of HTTP requests. This parameter is available only when protocol is set to HTTP or HTTPS. |
| `monitor.status_code` | String | No | null | This parameter works for one type of balancer (dedicated).Specifies the expected HTTP status code. This parameter will take effect only when protocol is set to HTTP or HTTPS. |
| `monitor.delay` | Int | Yes | 50 | This parameter works for one type of balancer (shared).Specifies the maximum time between health checks in the unit of second. The value ranges from 1 to 50. |
| `monitor.http_method` | String | No | null | This parameter works for one type of balancer (shared).Specifies the HTTP request method. Required for HTTP type. The default value is GET. |
| `monitor.expected_codes` | String | No | null | This parameter works for one type of balancer (shared).Specifies the expected HTTP status code. Required for HTTP type. You can either specify a single status like "200", or a range like "200-202". |
| `l7policy.elb_type` | String | Yes | null | You can specify the resource type for the balancer type. Example: shared, dedicated. Changing this creates a new resource. |
| `l7policy.region` | String | No | var.general_region | This parameter works for two types of balancer (shared and dedicated).The region in which to create the L7 Policy resource. If omitted, the provider-level region will be used. Changing this creates a new L7 Policy. |
| `l7policy.description` | String | No | "Created by Terraform" | This parameter works for two types of balancer (shared and dedicated).Human-readable description for the L7 Policy. |
| `l7policy.listener_name` | String | Yes | null | This parameter works for two types of balancer (shared and dedicated).The Listener on which the L7 Policy will be associated with. Changing this creates a new L7 Policy. |
| `l7policy.pool_name` | String | Yes | null | This parameter works for two types of balancer (shared and dedicated).Requests matching this policy will be redirected to the pool with this name. |
| `l7policy.need_redirect_http_to_https` | Bool | Yes | null | This parameter works for one type of balancer (shared).If need enable redicret http from https. |
| `l7policy.listener_https_name` | String | No | null | This parameter works for one type of balancer (shared).Specifies the name of the listener to which the traffic is redirected. |
| `l7policy.position` | Int | No | null | This parameter works for one type of balancer (shared).The position of this policy on the listener. Positions start at 1. Changing this creates a new L7 Policy.. |
| `l7policy_rule.elb_type` | String | Yes | null | You can specify the resource type for the balancer type. Example: shared, dedicated. Changing this creates a new resource. |
| `l7policy_rule.region` | String | No | var.general_region | This parameter works for two types of balancer (shared and dedicated).The region in which to create the L7 Rule resource. If omitted, the provider-level region will be used. Changing this creates a new L7 Rule. |
| `l7policy_rule.l7policy_name` | String | No | null | This parameter works for two types of balancer (shared and dedicated).The name of the L7 Policy to query. Changing this creates a new L7 Rule. |
| `l7policy_rule.type` | String | Yes | null | This parameter works for two types of balancer (shared and dedicated).The L7 Rule type - can either be HOST_NAME or PATH. Changing this creates a new L7 Rule. |
| `l7policy_rule.compare_type` | String | Yes | null | This parameter works for two types of balancer (shared and dedicated).The comparison type for the L7 rule - can either be STARTS_WITH, EQUAL_TO or REGEX |
| `l7policy_rule.value` | String | Yes | null | This parameter works for two types of balancer (shared and dedicated).The value to use for the comparison. For example, the file type to compare. |
| `l7policy_rule.key` | String | No | null | This parameter works for one type of balancer (shared).The key to use for the comparison. For example, the name of the cookie to evaluate. Valid when type is set to COOKIE or HEADER. Changing this creates a new L7 Rule. |

## Example

Usage example located in this [directory](docs/example).
