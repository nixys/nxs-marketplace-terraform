variable "targets_grpc_proxy" {
  description = "Create grpc targets in Net-services"
  type        = any
  default     = {}
}

variable "url_maps" {
  description = "Create url maps in Net-services"
  type        = any
  default     = {}
}

variable "region_url_maps" {
  description = "Create region url maps in Net-services"
  type        = any
  default     = {}
}

variable "targets_http_proxy" {
  description = "Create http targets in Net-services"
  type        = any
  default     = {}
}

variable "targets_https_proxy" {
  description = "Create https targets in Net-services"
  type        = any
  default     = {}
}

variable "targets_ssl_proxy" {
  description = "Create ssl targets in Net-services"
  type        = any
  default     = {}
}

variable "targets_tcp_proxy" {
  description = "Create tcp targets in Net-services"
  type        = any
  default     = {}
}

variable "health_checks" {
  description = "Source health checks for Net-Services"
  type        = any
  default     = {}
}

variable "region_health_checks" {
  description = "Source region health checks for Net-Services"
  type        = any
  default     = {}
}

variable "global_forwarding_rules" {
  description = "Source global forwarding rules for Net-Services"
  type        = any
  default     = {}
}

variable "forwarding_rules" {
  description = "Source forwarding rules for Net-Services"
  type        = any
  default     = {}
}

variable "backend_services" {
  description = "Source backend services for Net-Services"
  type        = any
  default     = {}
}

variable "region_backend_services" {
  description = "Source region backend services for Net-Services"
  type        = any
  default     = {}
}

variable "region_targets_http_proxy" {
  description = "Source region http targets in Net-Services"
  type        = any
  default     = {}
}

variable "region_targets_https_proxy" {
  description = "Source region https targets in Net-Services"
  type        = any
  default     = {}
}

variable "region_targets_tcp_proxy" {
  description = "Source region tcp targets in Net-Services"
  type        = any
  default     = {}
}
