provider "stackit" {
  default_region = "eu01"
}

run "create_and_verify_volume" {
  command = apply

  assert {
    condition     = stackit_volume.this.volume_id != ""
    error_message = "STACKIT did not return a volume ID."
  }
  assert {
    condition     = stackit_volume.this.size == var.size
    error_message = "Volume size mismatch."
  }
  assert {
    condition     = stackit_volume.this.availability_zone == var.availability_zone
    error_message = "Volume availability zone mismatch."
  }
}
