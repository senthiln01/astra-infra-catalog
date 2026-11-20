provider "stackit" {
  default_region = var.region
}
module "virtual_machine" {
  source            = "../../modules/opentofu/compute/virtual-machine"
  project_id        = var.project_id
  name              = "astra-example-vm"
  machine_type      = "g2i.1"
  availability_zone = var.availability_zone
  keypair_name      = var.keypair_name
  network_interfaces = var.network_interface_ids
  boot_volume = {
    source_type = "image"
    source_id   = var.image_id
    size        = 30
  }
}
module "data_volume" {
  source              = "../../modules/opentofu/storage/volume"
  project_id          = var.project_id
  name                = "astra-example-data"
  availability_zone   = var.availability_zone
  size                = 20
  attach_to_server_id = module.virtual_machine.server_id
}
module "secrets_manager" {
  source        = "../../modules/opentofu/security/secrets-manager"
  project_id    = var.project_id
  name          = "astra-example-secrets"
  acls          = var.secretsmanager_acls
  create_user   = true
  write_enabled = false
}
