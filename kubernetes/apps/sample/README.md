# Sample application

The sample application is a small static frontend and Go backend. The backend
uses `DATABASE_URL` from an `ExternalSecret`; the value is read from the
private PostgreSQL connection string stored in Azure Key Vault. The connection
never appears in Git, image layers, or GitHub Actions.

The development overlay starts with intentionally non-routable image names.
The **App delivery** workflow replaces them with immutable ACR image tags and
commits that manifest-only change. Argo CD then performs the deployment.

Before exposing the ingress, replace `sample.example.invalid` with a DNS name,
point it at the ingress endpoint (or the Application Gateway integration), and
create `sample-app-tls` with cert-manager or a managed certificate. The
Application Gateway backend pool remains an explicit operational integration;
see `docs/runbooks.md`.
