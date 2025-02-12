# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name."
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name."
  type        = string
  default     = ""
}

# Custom naming override
variable "custom_name" {
  description = "Custom Azure Databricks, generated if not set."
  type        = string
  default     = ""
}

variable "managed_resource_group_name" {
  description = "The name of the resource group where Azure should place the managed Databricks resources."
  type        = string
  default     = null
}
