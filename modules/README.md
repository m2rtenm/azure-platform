# Terraform modules

Modules contain reusable Azure resource implementations. They do not configure Terraform backends or providers; environment roots own those concerns.

| Module | Added in phase | Purpose |
| --- | --- | --- |
| `network` | 3 | VNet, subnets, NSGs, and route tables |
| `acr` | 4 | Azure Container Registry |
| `aks` | 5 | Azure Kubernetes Service |
| `postgresql` | 6 | PostgreSQL Flexible Server |
| `key_vault` | 7 | Azure Key Vault |
| `application_gateway` | 8 | Application Gateway WAF |
| `monitoring` | 9 | Azure Monitor and Log Analytics |
| `identity` | Later | Managed identities and role assignments |

Every implemented module will contain `main.tf`, `variables.tf`, `outputs.tf`, and a module-specific README.
