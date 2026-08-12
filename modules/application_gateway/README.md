# Application Gateway module

Creates a public Azure Application Gateway WAF v2 baseline:

- Static Standard public IP.
- WAF v2 autoscaling with the OWASP 3.2 managed ruleset.
- HTTPS-only frontend listener using a supplied PFX certificate.
- WAF Prevention mode by default.
- An empty AKS ingress backend pool and HTTPS health probe, ready for a later Application Gateway Ingress Controller or ingress deployment.

## Certificate handling

The listener certificate and its password are sensitive Terraform inputs. Keep them in an ignored local `.tfvars` file or supply them through a secure CI secret store. Do not place PFX data in source control. Phase 10 will move TLS lifecycle management to cert-manager and Key Vault integration.

## Cost

Application Gateway WAF v2 incurs hourly, capacity-unit, and data-processing charges. The development configuration begins at one autoscaled instance; destroy it when the platform is not in use.
