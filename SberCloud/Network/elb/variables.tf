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

variable "loadbalancer" {
  description = "Create loadbalancer"
  type        = any
  default     = {}
}

variable "listener" {
  description = "Create listener from loadbalancer"
  type        = any
  default     = {}
}

variable "pool" {
  description = "Create pool from loadbalancer"
  type        = any
  default     = {}
}

variable "ipgroup" {
  description = "Create ipgroup for listener"
  type        = any
  default     = {}
}

variable "certificate" {
  description = "Create certificate for HTTPS listener"
  type        = any
  default     = {}
}

variable "l7policy" {
  description = "Create l7policy for HTTPS and HTTP listener"
  type        = any
  default     = {}
}

variable "l7policy_rule" {
  description = "Create l7policy_rule for l7policy"
  type        = any
  default     = {}
}

variable "member" {
  description = "Create member in pool"
  type        = any
  default     = {}
}

variable "monitor" {
  description = "Create monitor for check pool"
  type        = any
  default     = {}
}

variable "whitelist" {
  description = "Create whitelist for listener"
  type        = any
  default     = {}
}
