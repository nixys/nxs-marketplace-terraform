variable "clusters" {
  description = "Create Cluster in GKE"
  type        = any
  default     = {}
}

variable "node_pools" {
  description = "Create Node Pool in Cluster"
  type        = any
  default     = {}
}
