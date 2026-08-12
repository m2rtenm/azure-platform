# Application Gateway WAF v2

Phase 8 provisions public HTTPS ingress through Azure Application Gateway WAF v2.

## Design

- Static Standard public IP and a dedicated application-gateway subnet.
- HTTPS-only listener with a caller-provided PFX certificate.
- OWASP 3.2 managed WAF rules in Prevention mode.
- Autoscaling between one and two instances in development.
- An empty backend pool and `/healthz` probe reserved for later AKS ingress integration.

## Certificate handling

Provide the base64-encoded PFX and password in ignored Terraform variables or through a CI secret store. Never commit a certificate or its password. The current backend pool is intentionally empty until the ingress platform is deployed.
