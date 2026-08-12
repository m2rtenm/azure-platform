# Monitoring module

Creates a Log Analytics workspace and sends platform diagnostics to it.

| Resource | Logs and metrics |
| --- | --- |
| AKS | Control-plane logs and platform metrics |
| PostgreSQL Flexible Server | Server logs and metrics |
| Key Vault | Audit and secret-operation logs, plus metrics |
| Application Gateway | Access, performance, firewall logs, and metrics |
| Azure Container Registry | Registry logs and metrics |

The module uses the Azure Monitor `allLogs` category group so new supported log categories are collected automatically. Container Insights remains configured directly in the AKS module because it is an AKS add-on, while this module provides the platform-wide diagnostics workspace.

## Retention and cost

The development default retains telemetry for 30 days. Log Analytics ingestion and retention may incur charges; adjust the retention value and use Azure Monitor data collection rules or workspace tables when the platform’s usage is known.
