variable "project_id" { type = string }
variable "region" {
  type    = string
  default = "eu01"
}
variable "availability_zone" { type = string }
variable "image_id" { type = string }
variable "keypair_name" { type = string }

variable "network_interface_ids" { type = list(string) }
