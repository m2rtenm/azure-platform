# Network module

Creates the development platform network in North Europe:

| Subnet | CIDR | Purpose |
| --- | --- | --- |
| `snet-aks` | `10.0.1.0/24` | AKS system and user node pools |
| `snet-postgresql` | `10.0.2.0/24` | Delegated exclusively to PostgreSQL Flexible Server |
| `snet-appgw` | `10.0.3.0/24` | Application Gateway v2 only |
| `snet-private-endpoints` | `10.0.4.0/24` | Future private endpoints, including ACR and Key Vault |

The module also creates NSGs for AKS, PostgreSQL, and Application Gateway. PostgreSQL allows TCP 5432 from the AKS subnet; Application Gateway permits its required Gateway Manager ports and public HTTPS. The route table is intentionally empty until a future firewall, NAT Gateway, or forced-tunnelling design is introduced.

## Important constraints

- Do not deploy other workloads into the PostgreSQL delegated subnet.
- Do not deploy anything except Application Gateway into `snet-appgw`.
- Keep the AKS and Application Gateway subnet address ranges stable after deployment; changing them requires disruptive replacement.
- The private-endpoint subnet has private-endpoint network policies disabled, as required for future private endpoints.
