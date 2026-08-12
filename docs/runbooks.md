# Platform runbooks

## Failed Argo CD synchronization

1. Inspect `argocd app get sample-app-dev` and `argocd app history sample-app-dev`.
2. Inspect the failing object with `kubectl -n sample-app describe`.
3. Correct and commit the manifest. Do not patch a live object as a permanent
   fix; Argo CD self-healing will revert it.
4. If recovery cannot wait, sync the known-good history with Argo CD, then
   revert the Git commit to make Git authoritative again.

## Database secret or backend unavailable

1. Check `kubectl -n sample-app get externalsecret sample-database` and its
   Ready condition.
2. Check the External Secrets controller logs and the
   `ClusterSecretStore/azure-key-vault` status.
3. Verify the Key Vault private DNS path, workload identity federation, and
   `postgresql-connection-string` secret. Rotate/update the Key Vault secret;
   never create the production connection string manually in Kubernetes.
4. Wait for the refresh or restart the backend only after the ExternalSecret
   reports Ready.

## Roll back a bad application release

1. Find the prior image SHA in `git log -- kubernetes/apps/sample/overlays/dev`.
2. Revert the promotion commit or set the prior immutable SHA in a reviewed
   commit.
3. Confirm Argo CD has synced and both deployments are Available.

## TLS or ingress incident

1. Check the ingress address and events:
   `kubectl -n sample-app describe ingress sample-app`.
2. Verify DNS and the `sample-app-tls` certificate Secret/Certificate status.
3. If Application Gateway fronts ingress-nginx, verify its backend pool,
   HTTPS probe `/healthz`, and WAF logs before changing rules.
4. Restore a valid certificate or DNS record; do not disable TLS redirect as a
   workaround.

## Terraform apply failure

1. Re-run the plan from the protected `dev` environment and inspect the exact
   failed resource.
2. Confirm the OIDC identity has state `Storage Blob Data Contributor` and the
   documented resource-group roles.
3. Reconcile Azure drift with a reviewed Terraform change. Do not edit remote
   state or use broad owner permissions to bypass a failed role assignment.
