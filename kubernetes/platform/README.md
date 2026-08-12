# Kubernetes platform

Phase 10 declares the in-cluster platform components as Helm releases through `helmfile`.

## Components

| Component | Purpose |
| --- | --- |
| ingress-nginx | Ingress routing and metrics |
| cert-manager | Certificate lifecycle management |
| External Secrets | Syncs Azure Key Vault secrets into Kubernetes Secrets |
| Secrets Store CSI Driver | Mounts external secrets as volumes |
| kube-prometheus-stack | Prometheus, Alertmanager, and Grafana |
| Loki | Cluster log aggregation |
| Argo CD | GitOps reconciliation |

## Bootstrap

1. Fetch AKS credentials and switch to the target context.
2. Apply namespaces:

   ```bash
   kubectl apply -f namespaces.yaml
   ```

3. Export non-secret environment configuration:

   ```bash
   export KEY_VAULT_URI="$(terraform -chdir=../../environments/dev output -raw key_vault_uri)"
   export KEY_VAULT_WORKLOAD_IDENTITY_CLIENT_ID="$(terraform -chdir=../../environments/dev output -raw key_vault_workload_identity_client_id)"
   ```

4. Apply the workload identity service account and External Secrets resources after installing External Secrets:

   ```bash
   envsubst < workload-identity/service-account.yaml | kubectl apply -f -
   helmfile sync
   envsubst < external-secrets/cluster-secret-store.yaml | kubectl apply -f -
   kubectl apply -f external-secrets/postgresql-secret.yaml
   ```

`GRAFANA_ADMIN_PASSWORD` is intentionally not committed. Provide it as a secure Helmfile environment value or integrate Grafana with Key Vault before deploying it.

## GitOps handoff

The Argo CD release is intentionally configured with no ingress and an example domain. Phase 11 promotes these Helm releases and application manifests into the Argo CD application tree.
