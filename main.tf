
# Load From Terraform.tfvars
## IAM
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}
## Resource Group
variable "web_server_location" {}
variable "web_server_rg" {}
variable "resource_prefix" {}
variable "web_server_address_space" {}

## VNET


# azure resource manager
provider "azurerm" {
    # We recommend pinning to the specific version of the Azure Provider you're using
    # since new versions are released frequently
    #version = "=2.5.0"
    #features {}
    version = "=1.27.0"
    #version = "=1.44.0"
    # More information on the authentication methods supported by
    # the AzureRM Provider can be found here:
    # http://terraform.io/docs/providers/azurerm/index.html

    client_id       = var.client_id
    client_secret   = var.client_secret
    tenant_id       = var.tenant_id
    subscription_id = var.subscription_id
    #skip_provider_registration = false
}

# resource group : Logical Resource , put all resource into a resource group.
resource "azurerm_resource_group" "web_server_rg" {
    name     = var.web_server_rg
    location = var.web_server_location
}
# NSG
# resource "azurerm_network_security_group" "web_server_rg" {
#   name                = "acceptanceTestSecurityGroup1"
#   location            = var.web_server_location
#   resource_group_name = var.web_server_rg
# }


# VNET
resource "azurerm_virtual_network" "web_server_vnet" {
    name                = "${var.resource_prefix}_vnet"
    location            = "${azurerm_resource_group.web_server_rg.location}"
    resource_group_name = "${azurerm_resource_group.web_server_rg.name}"
    address_space       = ["${var.web_server_address_space}"]
}

