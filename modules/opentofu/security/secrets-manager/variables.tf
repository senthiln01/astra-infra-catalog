variable "project_id" {
  description = "STACKIT project ID."
  type        = string
}
variable "name" {
  description = "Secrets Manager instance name."
  type        = string
}
variable "acls" {
  description = "Optional permitted IP addresses or CIDR ranges."
  type        = set(string)
  default     = []
}
variable "create_user" {
  description = "Whether to create a user."
  type        = bool
  default     = true
}
variable "user_description" {
  description = "Description of generated user."
  type        = string
  default     = "Astra catalog managed user"
}
variable "write_enabled" {
  description = "Whether the generated user can write secrets. Defaults to read-only."
  type        = bool
  default     = false
}
