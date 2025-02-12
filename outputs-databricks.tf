output "managed_resource_group_id" {
  description = "Managed Databricks resource group ID."
  value       = azurerm_databricks_workspace.main.managed_resource_group_id
}

output "workspace_url" {
  description = "Azure Databricks workspace URL."
  value       = azurerm_databricks_workspace.main.workspace_url
}

output "workspace_id" {
  description = "ID of the Databricks workspace in Databricks control plane."
  value       = azurerm_databricks_workspace.main.workspace_id
}

output "storage_account_identity" {
  description = "Identity block for Storage Account needed to provide access to the workspace for enabling Customer Managed Keys."
  value       = azurerm_databricks_workspace.main.storage_account_identity
}

output "module_nsg_backend" {
  description = "NSG backend used by Databricks workspace module outputs."
  value       = module.nsg_backend
}

output "module_subnet_backend" {
  description = "Subnet backend used by Databricks workspace module outputs."
  value       = module.subnet_backend
}

output "module_nsg_frontend" {
  description = "NSG frontend used by Databricks workspace module outputs."
  value       = module.nsg_frontend
}

output "module_subnet_frontend" {
  description = "Subnet frontend used by Databricks workspace module outputs."
  value       = module.subnet_frontend
}
