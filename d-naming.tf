data "azurecaf_name" "databricks" {
  name          = var.stack
  resource_type = "azurerm_databricks_workspace"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "databricks_rg" {
  name          = var.stack
  resource_type = "azurerm_resource_group"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, "dtb", local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}
