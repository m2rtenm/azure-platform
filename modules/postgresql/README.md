# PostgreSQL Flexible Server module

Creates Azure Database for PostgreSQL Flexible Server with no public network access.

- Deploys into the delegated `snet-postgresql` subnet.
- Creates and links the required PostgreSQL private DNS zone to the platform VNet.
- Generates a 32-character administrator password and marks it sensitive in Terraform output.
- Enables storage autogrow and automated backups.
- Creates an initial UTF-8 application database.

## Security and operational notes

The server is accessible only from the linked VNet through private DNS. The generated administrator password is stored in Terraform state; use the existing encrypted remote backend and restrict state access. Phase 7 will place the credential in Key Vault and workloads should consume it through a managed secret integration.

The development defaults use burstable compute, seven-day backups, and no high availability to control cost. Production should use a memory-optimized or general-purpose SKU, zone-redundant high availability, and longer backup retention.
