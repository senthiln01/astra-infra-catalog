output "server_id" {
  description = "STACKIT server ID."
  value       = stackit_server.this.server_id
}
output "name" {
  description = "Created server name."
  value       = stackit_server.this.name
}
output "machine_type" {
  description = "Configured machine type."
  value       = stackit_server.this.machine_type
}
output "availability_zone" {
  description = "Configured availability zone."
  value       = stackit_server.this.availability_zone
}
