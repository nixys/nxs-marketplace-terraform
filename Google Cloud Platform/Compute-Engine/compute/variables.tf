variable "instances" {
  description = "Create instance in Compute Cloud"
  type        = any
  default     = {}
}

variable "images" {
  description = "Source images for create instances"
  type        = any
  default     = {}
}

variable "disks" {
  description = "Create disks for create instances"
  type        = any
  default     = {}
}

variable "async_disks" {
  description = "Create async disks for create instances"
  type        = any
  default     = {}
}

variable "region_disks" {
  description = "Create region disks for create instances"
  type        = any
  default     = {}
}

variable "region_async_disks" {
  description = "Create region async disks for create instances"
  type        = any
  default     = {}
}

variable "snapshots" {
  description = "Create snapshot from disks"
  type        = any
  default     = {}
}

variable "tpu_nodes" {
  description = "Create a Cloud TPU instance."
  type        = any
  default     = {}
}

variable "policy_attachments" {
  description = "Create policy attachments with disk and policy."
  type        = any
  default     = {}
}

variable "policys" {
  description = "Create shedule policy from disk."
  type        = any
  default     = {}
}

variable "instance_groups" {
  description = "Creates a group of dissimilar Compute Engine virtual machine instances."
  type        = any
  default     = {}
}
