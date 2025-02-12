resource "azurerm_databricks_workspace" "main" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name                        = local.name
  managed_resource_group_name = local.managed_resource_group_name

  sku = var.sku

  load_balancer_backend_address_pool_id = var.load_balancer_backend_address_pool_id

  managed_services_cmk_key_vault_key_id = var.managed_services_cmk_key_vault_key_id
  infrastructure_encryption_enabled     = var.infrastructure_encryption_enabled
  public_network_access_enabled         = var.public_network_access_enabled
  network_security_group_rules_required = "NoAzureDatabricksRules" # https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/private-link#--step-3-provision-an-azure-databricks-workspace-and-private-endpoints

  custom_parameters {
    machine_learning_workspace_id                        = var.custom_parameters.machine_learning_workspace_id
    nat_gateway_name                                     = var.custom_parameters.nat_gateway_name
    public_ip_name                                       = var.custom_parameters.public_ip_name
    no_public_ip                                         = var.custom_parameters.no_public_ip
    virtual_network_id                                   = var.virtual_network_id
    public_subnet_name                                   = module.subnet_frontend.name
    public_subnet_network_security_group_association_id  = module.nsg_frontend.id
    private_subnet_name                                  = module.subnet_backend.name
    private_subnet_network_security_group_association_id = module.nsg_backend.id
    storage_account_name                                 = var.custom_parameters.storage_account_name
    storage_account_sku_name                             = var.custom_parameters.storage_account_sku_name
  }

  tags = merge(local.default_tags, var.extra_tags)
}
