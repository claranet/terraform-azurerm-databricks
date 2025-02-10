variable "public_network_access_enabled" {
  description = "Whether the Azure Databricks is available from public network."
  type        = bool
  default     = false
}

variable "virtual_network_id" {
  description = "ID of the Virtual Network in which create the subnet and Private Endpoint."
  type        = string
}

variable "subnet_frontend_prefix" {
  description = "Prefix of the frontend subnet to create (/25 recommanded)."
  type        = string
}

variable "subnet_backend_prefix" {
  description = "Prefix of the backend subnet to create (/25 recommanded)."
  type        = string
}
