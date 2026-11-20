output "volume_id" {
  description = "STACKIT volume ID."
  value       = stackit_volume.this.volume_id
}
output "name" {
  description = "Volume name."
  value       = stackit_volume.this.name
}
output "size" {
  description = "Configured volume size in GB."
  value       = stackit_volume.this.size
}
output "availability_zone" {
  description = "Volume availability zone."
  value       = stackit_volume.this.availability_zone
}
output "attached_server_id" {
  description = "Server ID if attached by this module; otherwise null."
  value       = try(stackit_server_volume_attach.this[0].server_id, null)
}
