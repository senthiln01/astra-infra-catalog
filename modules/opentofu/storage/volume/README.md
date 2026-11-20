# Block Storage Volume

Creates a STACKIT block storage volume and optionally attaches it to an existing STACKIT server.

## Requirements

| Name | Version |
|---|---|
| OpenTofu | `>= 1.6.0` |
| stackit provider | `>= 0.123.0, < 0.124.0` |

## Resources

| Name | Type | Description |
|---|---|---|
| `stackit_volume.this` | Resource | Creates block storage |
| `stackit_server_volume_attach.this` | Resource | Created when `attach_to_server_id` is set |

## Required Inputs

| Name | Description | Type |
|---|---|---|
| `project_id` | STACKIT project ID | `string` |
| `availability_zone` | Volume availability zone, e.g. `eu01-1` | `string` |
| `size` | Volume size in GB for a new empty volume; mutually exclusive with `source` | `number` | No*

## Optional Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| `name` | Volume name | `string` | `null` |
| `description` | Volume description | `string` | `null` |
| `performance_class` | STACKIT block storage performance class | `string` | `null` |
| `labels` | Volume labels | `map(string)` | `{}` |
| `source` | Object containing source `type` and `id` | `object` | `null` |
| `attach_to_server_id` | Existing server ID for attachment | `string` | `null` |

Supply exactly one of `size` or `source`. When `size` is supplied, the module creates a new empty volume. When `source` is supplied, follow STACKIT's source-based volume rules. *One of these two inputs is required.

## Outputs

| Name | Description |
|---|---|
| `volume_id` | STACKIT volume ID |
| `name` | Volume name |
| `size` | Configured size in GB |
| `availability_zone` | Volume availability zone |
| `attached_server_id` | Attached server ID, or `null` |

## Usage: standalone volume

```hcl
module "data_volume" {
  source = "git::https://git.onstackit.cloud/astra-platform/astra-infra-catalog.git//modules/opentofu/storage/volume?ref=volume/v0.1.0"
  project_id = var.project_id
  name = "nova-data-01"
  availability_zone = "eu01-1"
  size = 100
  performance_class = "storage_premium_perf6"
  labels = { application = "nova", purpose = "data" }
}
```

## Usage: attach to a VM

```hcl
module "data_volume" {
  source = "git::https://git.onstackit.cloud/astra-platform/astra-infra-catalog.git//modules/opentofu/storage/volume?ref=volume/v0.1.0"
  project_id = var.project_id
  name = "nova-data-01"
  availability_zone = "eu01-1"
  size = 100
  attach_to_server_id = module.virtual_machine.server_id
}
```

## Testing

`tests/volume.tftest.hcl` creates a real volume and checks ID, size and zone.

```bash
tofu fmt -recursive
tofu init
tofu validate
tofu test -verbose
```

Use a dedicated test project. Storage may incur charges. Inspect for leftovers after interrupted test runs.

## Operational considerations

- STACKIT documents volume expansion; do not assume shrinking is supported.
- Confirm performance class availability and availability-zone compatibility.
- Confirm server/volume attachment constraints in the target region.

## Provider documentation

- [STACKIT volume](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/resources/volume)
- [STACKIT server volume attachment](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/resources/server_volume_attach)
