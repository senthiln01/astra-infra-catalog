# Astra Infrastructure Catalog

Reusable STACKIT infrastructure modules maintained in a centrally governed OpenTofu monorepo. Each module has an AVM-inspired README, input/output contract, usage example and real-cloud OpenTofu integration test.

## Modules

| Module | Purpose | STACKIT resources |
|---|---|---|
| [Virtual machine](modules/opentofu/compute/virtual-machine/README.md) | Create a VM | `stackit_server` |
| [Volume](modules/opentofu/storage/volume/README.md) | Create block storage and optionally attach it | `stackit_volume`, `stackit_server_volume_attach` |
| [Secrets Manager](modules/opentofu/security/secrets-manager/README.md) | Create instance and user | `stackit_secretsmanager_instance`, `stackit_secretsmanager_user` |

## Structure

```text
astra-infra-catalog/
├── modules/opentofu/
│   ├── compute/virtual-machine/
│   ├── storage/volume/
│   └── security/secrets-manager/
├── examples/integration-stack/
├── .forgejo/workflows/validate.yml
└── catalog.yaml
```

## Requirements

- OpenTofu >= 1.6.0
- STACKIT provider `stackitcloud/stackit` (each module pins the tested minor line)
- STACKIT project, service enablement, quota and resource permissions

## Consumption

```hcl
module "virtual_machine" {
  source = "git::https://git.onstackit.cloud/astra-platform/astra-infra-catalog.git//modules/opentofu/compute/virtual-machine?ref=virtual-machine/v0.1.0"
  project_id = var.project_id
  name = "example-vm"
  machine_type = "g2i.1"
  boot_volume = { source_type = "image", source_id = var.image_id, size = 30 }
}
```

Use protected release tags. Example independent tag names: `virtual-machine/v0.1.0`, `volume/v0.1.0`, `secrets-manager/v0.1.0`. These are repository-level Git tags, not separate directory-level tags; protect them from modification/deletion.

## Testing and release gates

1. `tofu fmt -check -recursive`
2. `tofu init -backend=false`
3. `tofu validate`
4. `tofu test -verbose` against a dedicated STACKIT test project
5. Review, approve and create the module-specific release tag

Integration tests create real, billable cloud resources. Serialize test jobs per test project and inspect for orphaned resources after interrupted runs. Protect state and CI logs. Sensitive values can still be present in state.

Prefer workload identity federation where supported by the Forgejo runner and STACKIT trust configuration; otherwise use protected credentials for a least-privilege service account.

## Provider references

- [STACKIT provider](https://registry.terraform.io/providers/stackitcloud/stackit/latest)
- [Server](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/resources/server)
- [Volume](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/resources/volume)
- [Volume attachment](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/resources/server_volume_attach)
- [Secrets Manager instance](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/resources/secretsmanager_instance)
- [Secrets Manager user](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/resources/secretsmanager_user)
- [OpenTofu test](https://opentofu.org/docs/cli/commands/test/)
