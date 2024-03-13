variable "networks" {
  description = "Create Network in VPC"
  type        = any
  default     = {}
}

variable "subnetworks" {
  description = "Create Subnetwork(s) in Network"
  type        = any
  default     = {}
}

variable "routers" {
  description = "Create Router(s) in Network"
  type        = any
  default     = {}
}

variable "static_ips" {
  description = "Create static Address(es) in Network"
  type        = any
  default     = {}
}

variable "router_nats" {
  description = "Create NAT Router(s) in Network"
  type        = any
  default     = {}
}

variable "firewalls" {
  description = "Create firewalls in Network"
  type        = any
  default     = {}
}