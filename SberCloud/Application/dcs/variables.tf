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

variable "instances" {
  description = "instances"
  type        = any
  default     = {}
}

variable "backups" {
  description = "backups"
  type        = any
  default     = {}
}

variable "restores" {
  description = "restores"
  type        = any
  default     = {}
}
