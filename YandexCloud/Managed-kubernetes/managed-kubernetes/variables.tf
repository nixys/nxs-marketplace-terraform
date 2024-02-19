variable "kubernetes_version" {
  description = "Kubernetes Globale version"
  type        = string
  default     = null
}

variable "clusters" {
  description = "Create Kuberenetes cluster"
  type        = any
  default     = {}
}

variable "node_groups" {
  description = "Create node groups for k8s cluster"
  type        = any
  default     = {}
}
