terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = ">= 0.123.0, < 0.124.0"
    }
  }
}
provider "stackit" {
  default_region = var.region
}
module "virtual_machine" {
  source            = "../../"
  project_id        = var.project_id
  name              = "example-vm"
  machine_type      = "g2i.1"
  availability_zone = var.availability_zone
  keypair_name      = var.keypair_name
  network_interfaces = var.network_interface_ids
  boot_volume = {
    source_type = "image"
    source_id   = var.image_id
    size        = 30
  }
  labels = {
    managed-by = "opentofu"
    purpose    = "astra-example"
  }
}
