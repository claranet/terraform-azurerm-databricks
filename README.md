# Azure Databricks
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/databricks/azurerm/latest)

Azure module to deploy a [Azure Databricks](https://docs.microsoft.com/en-us/azure/xxxxxxx).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
module "vnet" {
  source  = "claranet/vnet/azurerm"
  version = "x.x.x"

  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = module.rg.name

  cidrs       = ["10.10.0.0/16"]
  dns_servers = ["10.0.0.4", "10.0.0.5"] # Can be empty if not used
}

module "databricks" {
  source  = "claranet/databricks/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  virtual_network_id     = module.vnet.id
  subnet_backend_prefix  = "10.10.1.0/25"
  subnet_frontend_prefix = "10.10.2.0/25"

  logs_destinations_ids = [
    module.run.logs_storage_account_id,
    module.run.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2.29 |
| azurerm | ~> 4.31 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 8.2.0 |
| nsg\_backend | claranet/nsg/azurerm | ~> 8.1.0 |
| nsg\_frontend | claranet/nsg/azurerm | ~> 8.1.0 |
| subnet\_backend | claranet/subnet/azurerm | ~> 8.1.0 |
| subnet\_frontend | claranet/subnet/azurerm | ~> 8.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_databricks_workspace.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |
| [azurecaf_name.databricks](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.databricks_rg](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| custom\_name | Custom Azure Databricks, generated if not set. | `string` | `""` | no |
| custom\_parameters | Map of custom parameters. | <pre>object({<br/>    machine_learning_workspace_id = optional(string)<br/>    nat_gateway_name              = optional(string)<br/>    public_ip_name                = optional(string)<br/>    storage_account_name          = optional(string)<br/>    storage_account_sku_name      = optional(string)<br/>    no_public_ip                  = optional(bool, true)<br/>  })</pre> | `{}` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| diagnostic\_settings\_custom\_name | Custom name of the diagnostics settings, name will be `default` if not set. | `string` | `"default"` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Additional tags to add on resources. | `map(string)` | `{}` | no |
| infrastructure\_encryption\_enabled | Enable infrastructure encryption for the Azure Databricks Workspace. | `bool` | `true` | no |
| load\_balancer\_backend\_address\_pool\_id | Resource ID of the Outbound Load balancer Backend Address Pool for Secure Cluster Connectivity (No Public IP) workspace. | `string` | `null` | no |
| location | Azure region to use. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| managed\_resource\_group\_name | The name of the resource group where Azure should place the managed Databricks resources. | `string` | `null` | no |
| managed\_services\_cmk\_key\_vault\_key\_id | Customer managed encryption properties for the Databricks Workspace managed resources (e.g. Notebooks and Artifacts). | `string` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| public\_network\_access\_enabled | Whether the Azure Databricks is available from public network. | `bool` | `false` | no |
| resource\_group\_name | Name of the resource group. | `string` | n/a | yes |
| sku | The SKU of the Azure Databricks Workspace. Possible values are `standard`, `premium`, or `trial`. | `string` | `"premium"` | no |
| stack | Project stack name. | `string` | n/a | yes |
| subnet\_backend\_prefix | Prefix of the backend subnet to create (/25 recommanded). | `string` | n/a | yes |
| subnet\_frontend\_prefix | Prefix of the frontend subnet to create (/25 recommanded). | `string` | n/a | yes |
| virtual\_network\_id | ID of the Virtual Network in which create the subnet and Private Endpoint. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Azure Databricks ID. |
| managed\_resource\_group\_id | Managed Databricks resource group ID. |
| module\_diagnostics | Diagnostics settings module outputs. |
| module\_nsg\_backend | NSG backend used by Databricks workspace module outputs. |
| module\_nsg\_frontend | NSG frontend used by Databricks workspace module outputs. |
| module\_subnet\_backend | Subnet backend used by Databricks workspace module outputs. |
| module\_subnet\_frontend | Subnet frontend used by Databricks workspace module outputs. |
| name | Azure Databricks name. |
| resource | Azure Databricks resource object. |
| storage\_account\_identity | Identity block for Storage Account needed to provide access to the workspace for enabling Customer Managed Keys. |
| workspace\_id | ID of the Databricks workspace in Databricks control plane. |
| workspace\_url | Azure Databricks workspace URL. |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: xxxx
