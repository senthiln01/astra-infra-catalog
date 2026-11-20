variable "project_id" {
  description = "STACKIT project ID."
  type        = string
}
variable "name" {
  description = "Virtual machine name."
  type        = string
}
variable "machine_type" {
  description = "STACKIT machine type, e.g. g2i.1."
  type        = string
}
variable "boot_volume" {
  description = "Boot volume source. For image sources, size is required by STACKIT."
  type = object({
    source_type           = string
    source_id             = string
    size                  = optional(number)
    performance_class     = optional(string)
    delete_on_termination = optional(bool)
  })
  validation {
    condition     = contains(["image", "volume"], var.boot_volume.source_type)
    error_message = "source_type must be image or volume."
  }
}
variable "availability_zone" {
  description = "Availability zone, e.g. eu01-1."
  type        = string
  default     = null
}
variable "keypair_name" {
  description = "Existing SSH key pair name."
  type        = string
  default     = null
}
variable "network_interfaces" {
  description = "Existing STACKIT network interface IDs. The provider documentation notes these are required when creating/recreating a server."
  type        = list(string)
  validation {
    condition     = length(var.network_interfaces) > 0
    error_message = "At least one existing network interface ID must be supplied for server creation."
  }
}
variable "user_data" {
  description = "Cloud-init user data. Do not embed long-lived secrets."
  type        = string
  default     = null
  sensitive   = true
}
variable "desired_status" {
  description = "Desired status: active, inactive or deallocated."
  type        = string
  default     = "active"
  validation {
    condition     = contains(["active", "inactive", "deallocated"], var.desired_status)
    error_message = "Invalid desired_status."
  }
}
variable "labels" {
  description = "Server labels."
  type        = map(string)
  default     = {}
}
