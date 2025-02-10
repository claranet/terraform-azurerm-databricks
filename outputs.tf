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

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}
