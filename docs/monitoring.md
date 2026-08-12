# Monitoring and diagnostics

Phase 9 centralizes platform diagnostics in Log Analytics.

## Coverage

- AKS control-plane logs and metrics
- PostgreSQL Flexible Server logs and metrics
- Key Vault audit and operation logs
- Application Gateway access, performance, and firewall logs
- Azure Container Registry logs and metrics

AKS Container Insights is configured as an AKS add-on and uses the same workspace. The diagnostic settings use Azure Monitor `allLogs` category groups, so newly supported categories are collected automatically.

## Retention

Development retains data for 30 days. Log Analytics ingestion and retention can incur charges; adjust retention, table plans, and collection rules once actual usage is known.
