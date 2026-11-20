# Integration stack example

Composes the virtual-machine, volume and Secrets Manager modules. The data volume is attached to the VM. The Secrets Manager user is read-only.

Configure STACKIT credentials and variables, then run `tofu init`, `tofu plan` and `tofu apply`. This is a manual composition example; module-level integration tests are located in each module's `tests/` directory.

Use a dedicated test project. Resources may incur charges. Protect state because generated Secrets Manager credentials are sensitive.
