# Development networking

The development platform uses one North Europe VNet: `10.0.0.0/16`.

```text
10.0.0.0/16
├── 10.0.1.0/24  snet-aks
├── 10.0.2.0/24  snet-postgresql
├── 10.0.3.0/24  snet-appgw
└── 10.0.4.0/24  snet-private-endpoints
```

The PostgreSQL subnet is delegated to Azure Database for PostgreSQL Flexible Server, which will use private VNet integration rather than a public endpoint. A separate private-endpoint subnet remains available for services such as Azure Container Registry and Key Vault.

The Application Gateway subnet has the required `GatewayManager` inbound port range and public HTTPS rule. It should not be used by any other service.

The Phase 3 route table contains no user-defined routes. It establishes an explicit attachment point for later egress controls without changing Azure's default routing today.

## Deploy

```bash
cd environments/dev
terraform fmt -check
terraform validate
terraform plan -out network.tfplan
terraform apply network.tfplan
```

Before applying, review the plan and ensure the selected Azure CLI subscription is the intended one.
