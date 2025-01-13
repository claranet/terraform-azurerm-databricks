output "resource" {
  description = "Azure Databricks resource object."
  value       = azurerm_databricks_workspace.main
}

output "id" {
  description = "Azure Databricks ID."
  value       = azurerm_databricks_workspace.main.id
}

output "name" {
  description = "Azure Databricks name."
  value       = azurerm_databricks_workspace.main.name
}

output "identity_principal_id" {
  description = "Azure Databricks system identity principal ID."
  value       = try(azurerm_databricks_workspace.main.identity[0].principal_id, null)
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}
