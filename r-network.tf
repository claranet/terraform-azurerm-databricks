module "nsg_backend" {
  source  = "claranet/nsg/azurerm"
  version = "~> 8.0.0"

  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack
  location       = var.location
  location_short = var.location_short

  resource_group_name = var.resource_group_name

  all_inbound_denied = false

  name_suffix = "backend"

  extra_tags = merge(local.default_tags, local.nsg_back_default_tags, var.extra_tags)
}

module "subnet_backend" {
  source  = "claranet/subnet/azurerm"
  version = "~> 8.0.1"

  environment    = var.environment
  location_short = var.location_short
  client_name    = var.client_name
  stack          = "backend"

  resource_group_name  = local.vnet_rg
  virtual_network_name = local.vnet_name
  cidrs                = [var.subnet_backend_prefix]

  delegations = {
    databricks_delegation = [
      {
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
        name = "Microsoft.Databricks/workspaces"
      }
    ]
  }

  network_security_group_name = module.nsg_backend.name
  network_security_group_rg   = module.nsg_backend.resource_group_name
}


module "nsg_frontend" {
  source  = "claranet/nsg/azurerm"
  version = "~> 8.0.0"

  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack
  location       = var.location
  location_short = var.location_short

  resource_group_name = var.resource_group_name

  all_inbound_denied = false

  name_suffix = "frontend"

  extra_tags = merge(local.default_tags, local.nsg_front_default_tags, var.extra_tags)
}

module "subnet_frontend" {
  source  = "claranet/subnet/azurerm"
  version = "~> 8.0.1"

  environment    = var.environment
  location_short = var.location_short
  client_name    = var.client_name
  stack          = "frontend"

  resource_group_name  = local.vnet_rg
  virtual_network_name = local.vnet_name
  cidrs                = [var.subnet_frontend_prefix]

  delegations = {
    databricks_delegation = [
      {
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
        name = "Microsoft.Databricks/workspaces"
      }
    ]
  }

  network_security_group_name = module.nsg_frontend.name
  network_security_group_rg   = module.nsg_frontend.resource_group_name
}
