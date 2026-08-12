# GitHub Actions workflows

The Terraform workflow formats and validates every infrastructure change, plans
against the Azure AD-backed remote state, and applies only from `main` through
the protected `dev` GitHub Environment. It uses Azure workload identity
federation, not an Azure client secret.

The app-delivery workflow scans, builds, attests, and pushes immutable frontend
and backend images to ACR. It commits only the resulting image references to
the development Kustomize overlay; Argo CD performs the cluster deployment.

Configure these **GitHub Environment `dev` variables**:

| Variable | Value |
| --- | --- |
| `AZURE_CLIENT_ID` | `terraform output -raw github_actions_client_id` |
| `AZURE_TENANT_ID` | Microsoft Entra tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Azure subscription ID |
| `TF_BACKEND_RESOURCE_GROUP` | Terraform state resource group |
| `TF_BACKEND_STORAGE_ACCOUNT` | Terraform state storage account |
| `TF_BACKEND_CONTAINER` | Terraform state container |
| `TF_BACKEND_KEY` | Development state blob key |
| `ACR_NAME` | `terraform output -raw acr_name` |
| `ACR_LOGIN_SERVER` | `terraform output -raw acr_login_server` |

Use environment protection rules to require a reviewer before the `apply` and
delivery jobs. The federated identity also needs `Storage Blob Data Contributor`
on the separate state container or storage account.

The Terraform job also reads the existing Application Gateway certificate only
from these protected `dev` **secrets**: `APPLICATION_GATEWAY_SSL_CERTIFICATE_DATA`
(base64 PFX) and `APPLICATION_GATEWAY_SSL_CERTIFICATE_PASSWORD`. Never add
either value to a variable, tfvars file, workflow, or repository.
