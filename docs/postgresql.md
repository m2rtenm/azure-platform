# PostgreSQL Flexible Server

Phase 6 provisions a private Azure Database for PostgreSQL Flexible Server.

## Design

- The server uses the delegated `snet-postgresql` subnet and has public access disabled.
- Private DNS uses `privatelink.postgres.database.azure.com` and is linked to the platform VNet.
- A generated administrator password and TLS-required connection string are passed to Key Vault in Phase 7.
- Storage autogrow and seven days of backups are enabled by default.

## Development defaults

The development configuration uses burstable `B_Standard_B1ms` compute, 32 GiB storage, and no high availability to control cost. Production should use a general-purpose or memory-optimized SKU, zone-redundant high availability, and longer retention.

## Connectivity

Workloads use the private FQDN and require TLS:

```text
postgresql://<user>:<password>@<private-fqdn>:5432/platform?sslmode=require
```

Applications should retrieve this connection string from Key Vault rather than Terraform outputs.
