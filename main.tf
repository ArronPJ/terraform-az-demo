
# From Terraform.tfvars

variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

variable "web_server_location" {}
variable "web_rg_name" {}


# azure resource manager
provider "azurerm" {
    # We recommend pinning to the specific version of the Azure Provider you're using
    # since new versions are released frequently
    #version = "=2.0.0"
    #features {}
    version = "=1.44.0"
    # More information on the authentication methods supported by
    # the AzureRM Provider can be found here:
    # http://terraform.io/docs/providers/azurerm/index.html

    client_id       = var.client_id
    client_secret   = var.client_secret
    tenant_id       = var.tenant_id
    subscription_id = var.subscription_id
    skip_provider_registration = true
}

# resource group : Logical Resource , put all resource into a resource group.
resource "azurerm_resource_group" "web-rg" {
    name = var.web_rg_name
    location = var.web_server_location
}

# 
