variable "instances" {
  description = "Create instance in Compute Cloud"
  type        = any
  default     = {}
}

variable "instance_groups" {
  description = "Create instance groups in Compute Cloud"
  type        = any
  default     = {}
}

variable "placement_groups" {
  description = "Create placement groups for instance"
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

variable "disks_from_snapshot" {
  description = "Create disks from exists snapshot"
  type        = any
  default     = {}
}

variable "disk_placement_groups" {
  description = "Create disk_placement_groups from disks"
  type        = any
  default     = {}
}

variable "filesystems" {
  description = "Create file storage for instance"
  type        = any
  default     = {}
}

variable "gpu_clusters" {
  description = "Create GPU Clusters and connects multiple Compute GPU Instances"
  type        = any
  default     = {}
}

variable "snapshots" {
  description = "Create snapshots from disk"
  type        = any
  default     = {}
}

variable "snapshots_shedule" {
  description = "Create shedule snapshots from disk"
  type        = any
  default     = {}
}
