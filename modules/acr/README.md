# Azure Container Registry module

Creates a private Azure Container Registry with a stable, globally unique name, Microsoft Entra authentication, and the admin user disabled.

## Defaults

- **SKU:** Basic, the lowest-cost registry tier and appropriate for development and learning.
- **Admin user:** disabled. Authenticate with `az acr login` and Azure RBAC instead.
- **Anonymous pulls:** disabled.
- **Public network access:** enabled initially so local development and future GitHub-hosted runners can push images. This is not anonymous access.

The registry name includes a Terraform-managed random suffix and remains stable after deployment.

## Future hardening

Private Link and private endpoints require the Premium SKU. Upgrade only when that security requirement is introduced; upgrading is supported without recreating the registry. Before AKS is created, a later phase will grant its managed identity the `AcrPull` role.
