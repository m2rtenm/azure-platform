# CI/CD

Azure authentication uses GitHub Actions OIDC federation. The Terraform module
creates an identity trusted only for the exact `dev` environment subject:
`repo:m2rtenm/azure-platform:environment:dev`. No Azure client secret is
stored in GitHub.

The identity has resource-group-scoped Contributor and User Access
Administrator roles to run Terraform, plus `AcrPush` on the registry. It has
no Kubernetes administrative role because Argo CD deploys workload changes. It
still needs `Storage Blob Data Contributor` on the separately bootstrapped
Terraform state storage.

Configure the `dev` GitHub Environment variables listed in
[`.github/workflows/README.md`](../.github/workflows/README.md), and protect
that environment with required reviewers. Configure the existing Application
Gateway PFX data and password as protected Environment secrets, not repository
variables. The workflows request only
`contents`, `id-token`, and, for the delivery workflow, the `contents: write`
needed to make the GitOps promotion commit.

Pull requests format, validate, and plan Terraform. Only `main` can apply.
App source changes scan the source tree with Trivy, produce SBOM/provenance
attestations, push SHA-tagged images to ACR, and promote those tags through
Git—not directly with `kubectl`.
