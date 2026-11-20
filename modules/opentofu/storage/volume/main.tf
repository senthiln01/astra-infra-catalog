resource "stackit_volume" "this" {
  project_id = var.project_id
  availability_zone = var.availability_zone
  size = var.size
  name = var.name
  description = var.description
  performance_class = var.performance_class
  labels = var.labels
  source = var.source

  lifecycle {
    precondition {
      condition     = (var.size == null) != (var.source == null)
      error_message = "Supply exactly one of size or source."
    }
  }
}
resource "stackit_server_volume_attach" "this" {
  count = var.attach_to_server_id == null ? 0 : 1
  project_id = var.project_id
  server_id = var.attach_to_server_id
  volume_id = stackit_volume.this.volume_id
}
