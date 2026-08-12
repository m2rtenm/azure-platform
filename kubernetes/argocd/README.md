# Argo CD applications

Argo CD itself is installed by the Phase 10 Helmfile. Bootstrap the declarative
application tree only after that release is healthy:

```bash
kubectl -n argocd rollout status deployment/argocd-server --timeout=5m
./kubernetes/argocd/bootstrap.sh
```

`platform-applications` is the root application. It reconciles the project and
child applications in this directory; `sample-app-dev` then reconciles the
sample application overlay. Both follow `main`, prune removed resources, and
repair drift. The `platform` project limits sources to this repository and
workloads to the `sample-app` namespace.

The bootstrap command deliberately uses the checked-out files, while steady
state comes from `main`. Run it after the change containing these manifests has
merged, or update the child `targetRevision` temporarily for a test branch.
