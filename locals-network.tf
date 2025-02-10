locals {
  vnet_name = split("/", var.virtual_network_id)[8]
  vnet_rg   = split("/", var.virtual_network_id)[4]
}
