# Secrets Manager

Creates a STACKIT Secrets Manager instance and optionally a user. The default user is read-only (`write_enabled = false`). Generated credentials are exposed as sensitive outputs for controlled downstream use.

## Requirements

| Name | Version |
|---|---|
| OpenTofu | `>= 1.6.0` |
| stackit provider | `>= 0.123.0, < 0.124.0` |

Secrets Manager must be available/enabled for the project. Configure a STACKIT provider region and approved authentication.

## Resources

| Name | Type | Description |
|---|---|---|
| `stackit_secretsmanager_instance.this` | Resource | Creates the instance |
| `stackit_secretsmanager_user.this` | Resource | Optionally creates an instance user |

## Required Inputs

| Name | Description | Type |
|---|---|---|
| `project_id` | STACKIT project ID | `string` |
| `name` | Instance name | `string` |

## Optional Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| `acls` | Allowed IPs/CIDR ranges | `set(string)` | `[]` |
| `create_user` | Whether to create a user | `bool` | `true` |
| `user_description` | Generated user description | `string` | `"Astra catalog managed user"` |
| `write_enabled` | Enable write access; false means read-only | `bool` | `false` |

## Outputs

| Name | Description | Sensitive |
|---|---|---|
| `instance_id` | Instance ID | No |
| `user_id` | User ID, or null if no user is created | No |
| `username` | Generated username | Yes |
| `password` | Generated password | Yes |

Sensitive outputs can still be stored in state. Protect state, backups and CI logs. Never print credentials or publish them as ordinary job artifacts.

## Usage

```hcl
module "secrets_manager" {
  source = "git::https://git.onstackit.cloud/astra-platform/astra-infra-catalog.git//modules/opentofu/security/secrets-manager?ref=secrets-manager/v0.1.0"
  project_id = var.project_id
  name = "nova-secrets"
  acls = var.approved_egress_cidrs
  create_user = true
  write_enabled = false
}
```

## Testing

`tests/secrets-manager.tftest.hcl` creates a real instance and user, then verifies instance/user IDs, write permission and that a password was generated. It does not print the password.

```bash
tofu fmt -recursive
tofu init
tofu validate
tofu test -verbose
```

Use a dedicated test project. Service usage may incur charges. Verify cleanup after interrupted runs.

## Security

- Default to read-only users.
- Restrict ACLs to approved CIDRs; avoid broad ranges.
- Never commit generated credentials.
- Sensitive outputs do not prevent secrets being stored in state.
- Use protected CI secrets and least-privilege service accounts.
- Prefer separate users per consumer instead of sharing credentials.

## Provider documentation

- [STACKIT Secrets Manager instance](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/resources/secretsmanager_instance)
- [STACKIT Secrets Manager user](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/resources/secretsmanager_user)
