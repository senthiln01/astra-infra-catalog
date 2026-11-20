# Implementation notes

This is an initial scaffold, not a production-validated release. The files have not been run through OpenTofu in this environment.

Before publishing a module version:

1. Run formatting, initialization and validation using the intended OpenTofu version.
2. Confirm every argument and computed attribute against the selected STACKIT provider version and lock file.
3. Confirm VM networking requirements in the target STACKIT project. Provider docs describe network interface behaviour as subject to server creation/recreation requirements.
4. Confirm image, flavor, performance class, region, availability zone, quotas and service enablement.
5. Run each integration test in a dedicated STACKIT test project.
6. Verify teardown; inspect for leftovers after interrupted/failed runs.
7. Review sensitive state handling, especially generated Secrets Manager credentials.
8. Replace the illustrative `apiVersion` in `catalog.yaml` with the agreed internal catalog metadata schema if one exists.

READMEs use an AVM-inspired documentation structure. This does not imply Microsoft AVM certification or conformance with all AVM requirements.
