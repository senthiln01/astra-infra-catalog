# Virtual Machine

Creates a STACKIT virtual machine using the official `stackitcloud/stackit` provider. The module exposes a curated interface rather than every provider argument.

## Requirements

| Name | Version |
|---|---|
| OpenTofu | `>= 1.6.0` |
| stackit provider | `>= 0.123.0, < 0.124.0` |

Configure the provider region and an approved STACKIT authentication method in the calling root module.

## Resources

| Name | Type | Description |
|---|---|---|
| `stackit_server.this` | Resource | Creates the virtual machine |

## Required Inputs

| Name | Description | Type |
|---|---|---|
| `project_id` | STACKIT project ID | `string` |
| `name` | VM name | `string` |
| `machine_type` | STACKIT machine type, e.g. `g2i.1` | `string` |
| `boot_volume` | Boot source object | `object` |
| `network_interfaces` | One or more existing network interface IDs | `list(string)` |

### `boot_volume` attributes

| Attribute | Description | Type | Required |
|---|---|---|---|
| `source_type` | `image` or `volume` | `string` | Yes |
| `source_id` | Image or volume ID | `string` | Yes |
| `size` | Boot size in GB; required for image source | `number` | Conditional |
| `performance_class` | Boot volume performance class | `string` | No |
| `delete_on_termination` | Delete image-created boot volume on server termination | `bool` | No |

## Optional Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| `availability_zone` | Zone, e.g. `eu01-1` | `string` | `null` |
| `keypair_name` | Existing SSH key pair name | `string` | `null` |
| `user_data` | Cloud-init user data; sensitive | `string` | `null` |
| `desired_status` | `active`, `inactive` or `deallocated` | `string` | `"active"` |
| `labels` | Server labels | `map(string)` | `{}` |

## Outputs

| Name | Description |
|---|---|
| `server_id` | STACKIT server ID |
| `name` | Created server name |
| `machine_type` | Configured machine type |
| `availability_zone` | Configured availability zone |

## Usage

```hcl
module "virtual_machine" {
  source = "git::https://git.onstackit.cloud/astra-platform/astra-infra-catalog.git//modules/opentofu/compute/virtual-machine?ref=virtual-machine/v0.1.0"
  project_id = var.project_id
  name = "nova-app-01"
  machine_type = "g2i.1"
  availability_zone = "eu01-1"
  keypair_name = var.keypair_name
  network_interfaces = var.network_interface_ids
  boot_volume = { source_type = "image", source_id = var.image_id, size = 30 }
  labels = { application = "nova", environment = "test" }
}
```

## Testing

`tests/virtual-machine.tftest.hcl` creates a real VM and checks its ID, name and machine type. Supply `TF_VAR_project_id`, `TF_VAR_name`, `TF_VAR_machine_type`, `TF_VAR_boot_volume`, plus `TF_VAR_network_interfaces`, zone and provider credentials.

```bash
tofu fmt -recursive
tofu init
tofu validate
tofu test -verbose
```

Use a dedicated test project. VM resources incur charges. Inspect for leftovers after interrupted test runs.

## Security and operations

- Use an existing approved SSH key pair; never commit private keys.
- Avoid long-lived credentials in cloud-init user data.
- Protect state and CI logs.
- Validate network interface requirements, image, flavor, quota and zone in the target STACKIT project before release.

## Provider documentation

[STACKIT server resource](https://registry.terraform.io/providers/stackitcloud/stackit/latest/docs/resources/server)
