locals {
  default_tags = var.default_tags_enabled ? {
    env   = var.environment
    stack = var.stack
  } : {}
  nsg_back_default_tags = var.default_tags_enabled ? {
    databricks_workspace = "backend"
  } : {}
  nsg_front_default_tags = var.default_tags_enabled ? {
    databricks_workspace = "frontend"
  } : {}
}
