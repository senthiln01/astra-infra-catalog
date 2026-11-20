provider "stackit" {
  default_region = "eu01"
}

run "create_and_verify_secrets_manager" {
  command = apply

  assert {
    condition     = stackit_secretsmanager_instance.this.instance_id != ""
    error_message = "Secrets Manager instance ID is empty."
  }
  assert {
    condition     = length(stackit_secretsmanager_user.this) == 1
    error_message = "Expected one Secrets Manager user."
  }
  assert {
    condition     = stackit_secretsmanager_user.this[0].user_id != ""
    error_message = "Secrets Manager user ID is empty."
  }
  assert {
    condition     = stackit_secretsmanager_user.this[0].write_enabled == var.write_enabled
    error_message = "User write permission mismatch."
  }
  assert {
    condition     = length(stackit_secretsmanager_user.this[0].password) > 0
    error_message = "Generated password is empty."
  }
}
