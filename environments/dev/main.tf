# This environment root intentionally has no resources in Phase 2.
# Phase 3 composes the reusable network module here.
locals {
  name_prefix = "azplat-${var.environment}"
}
