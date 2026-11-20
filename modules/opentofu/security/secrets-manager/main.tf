resource "stackit_secretsmanager_instance" "this" {
  project_id = var.project_id
  name = var.name
  acls = var.acls
}
resource "stackit_secretsmanager_user" "this" {
  count = var.create_user ? 1 : 0
  project_id = var.project_id
  instance_id = stackit_secretsmanager_instance.this.instance_id
  description = var.user_description
  write_enabled = var.write_enabled
}
