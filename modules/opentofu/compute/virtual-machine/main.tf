resource "stackit_server" "this" {
  project_id   = var.project_id
  name         = var.name
  machine_type = var.machine_type
  boot_volume = {
    source_type = var.boot_volume.source_type
    source_id = var.boot_volume.source_id
    size = var.boot_volume.size
    performance_class = var.boot_volume.performance_class
    delete_on_termination = var.boot_volume.delete_on_termination
  }
  availability_zone = var.availability_zone
  keypair_name = var.keypair_name
  network_interfaces = var.network_interfaces
  user_data = var.user_data
  desired_status = var.desired_status
  labels = var.labels
}
