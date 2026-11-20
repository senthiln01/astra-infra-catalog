variable "project_id" {
  description = "STACKIT project ID."
  type        = string
}
variable "availability_zone" {
  description = "Volume availability zone, e.g. eu01-1."
  type        = string
}
variable "size" {
  description = "Volume size in GB. Supply this when creating a new empty volume; mutually exclusive with source."
  type        = number
  default     = null
  validation {
    condition     = var.size == null || var.size > 0
    error_message = "Volume size must be greater than zero when supplied."
  }
}
variable "name" {
  description = "Volume name."
  type        = string
  default     = null
}
variable "description" {
  description = "Volume description."
  type        = string
  default     = null
}
variable "performance_class" {
  description = "STACKIT block storage performance class."
  type        = string
  default     = null
}
variable "labels" {
  description = "Volume labels."
  type        = map(string)
  default     = {}
}
variable "source" {
  description = "Optional source object. Supply either size or source, not both. Supported source types are volume, image, snapshot and backup."
  type = object({
    type = string
    id   = string
  })
  default = null
  validation {
    condition     = var.source == null || contains(["volume", "image", "snapshot", "backup"], var.source.type)
    error_message = "source.type must be volume, image, snapshot or backup."
  }
}
variable "attach_to_server_id" {
  description = "Optional existing server ID to attach this volume to."
  type        = string
  default     = null
}
