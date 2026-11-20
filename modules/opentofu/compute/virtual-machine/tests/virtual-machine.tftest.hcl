provider "stackit" {
  default_region = "eu01"
}

run "create_and_verify_virtual_machine" {
  command = apply

  assert {
    condition     = stackit_server.this.server_id != ""
    error_message = "STACKIT did not return a server ID."
  }
  assert {
    condition     = stackit_server.this.name == var.name
    error_message = "Server name mismatch."
  }
  assert {
    condition     = stackit_server.this.machine_type == var.machine_type
    error_message = "Machine type mismatch."
  }
}
