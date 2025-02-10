variable "sku" {
  description = "The SKU of the Azure Databricks Workspace. Possible values are `standard`, `premium`, or `trial`."
  type        = string
  default     = "premium"
}

variable "load_balancer_backend_address_pool_id" {
  description = "Resource ID of the Outbound Load balancer Backend Address Pool for Secure Cluster Connectivity (No Public IP) workspace."
  type        = string
  default     = null
}

variable "managed_services_cmk_key_vault_key_id" {
  description = "Customer managed encryption properties for the Databricks Workspace managed resources (e.g. Notebooks and Artifacts)."
  type        = string
  default     = null
}

variable "custom_parameters" {
  description = "Map of custom parameters."
  type = object({
    machine_learning_workspace_id = optional(string)
    nat_gateway_name              = optional(string)
    public_ip_name                = optional(string)
    storage_account_name          = optional(string)
    storage_account_sku_name      = optional(string)
    no_public_ip                  = optional(bool, true)
  })
  default  = {}
  nullable = false
}

variable "infrastructure_encryption_enabled" {
  description = "Enable infrastructure encryption for the Azure Databricks Workspace."
  type        = bool
  default     = true
  nullable    = false
}
