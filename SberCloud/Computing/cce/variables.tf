
variable "general_project_id" {
  description = "Default project"
  type        = string
  default     = null
}

variable "general_region" {
  description = "Default region"
  type        = string
  default     = null
}

variable "clusters" {
  description = "Create Cluster"
  type        = any
  default     = {}
}

variable "node_pools" {
  description = "Create node-pool for cluster"
  type        = any
  default     = {}
}

variable "node_attach" {
  description = "Attach exist node to cluster from ECS"
  type        = any
  default     = {}
}

variable "custom_node" {
  description = "Create custom node and attach to cluster"
  type        = any
  default     = {}
}

variable "addon" {
  description = "Install addon to cluster"
  type        = any
  default     = {}
}

variable "namespaces" {
  description = "Create namespaces in cluster"
  type        = any
  default     = {}
}

variable "pvc" {
  description = "Create pvc in cluster"
  type        = any
  default     = {}
}