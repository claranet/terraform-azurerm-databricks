resource "azurerm_databricks_workspace" "main" {
  name = local.databricks_name

  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
