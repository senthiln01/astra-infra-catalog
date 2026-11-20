output "instance_id" {
  description = "Secrets Manager instance ID."
  value       = stackit_secretsmanager_instance.this.instance_id
}
output "user_id" {
  description = "Generated user ID, or null when no user is created."
  value       = try(stackit_secretsmanager_user.this[0].user_id, null)
}
output "username" {
  description = "Generated username."
  value       = try(stackit_secretsmanager_user.this[0].username, null)
  sensitive   = true
}
output "password" {
  description = "Generated password."
  value       = try(stackit_secretsmanager_user.this[0].password, null)
  sensitive   = true
}
