
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
variable "web_server_address_prefix" {}
variable "web_server_name" {}
variable "environment" {}

# azure resource manager
provider "azurerm" {
    # We recommend pinning to the specific version of the Azure Provider you're using
    # since new versions are released frequently
    #version = "=2.5.0"
    #features {}
    
    #version = "=1.27.0"     #0.12 min
    version = "=1.44.0"
    # More information on the authentication methods supported by
    # the AzureRM Provider can be found here:
    # http://terraform.io/docs/providers/azurerm/index.html

    client_id       = var.client_id
    client_secret   = var.client_secret
    tenant_id       = var.tenant_id
    subscription_id = var.subscription_id
}

# resource group : Logical Resource , put all resource into a resource group.
resource "azurerm_resource_group" "web_server_rg" {
    name     = var.web_server_rg
    location = var.web_server_location
}

# VNET
resource "azurerm_virtual_network" "web_server_vnet" {
    name                = "${var.resource_prefix}_vnet"
    location            = "${azurerm_resource_group.web_server_rg.location}"
    resource_group_name = "${azurerm_resource_group.web_server_rg.name}"
    address_space       = ["${var.web_server_address_space}"]
    depends_on          = ["azurerm_resource_group.web_server_rg"]

    
    tags = {
        environment = "${var.environment}"
    }
}
# Subnet
resource "azurerm_subnet" "web_server_subnet" {
  name = "${var.resource_prefix}_subnet"
  resource_group_name = "${azurerm_resource_group.web_server_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.web_server_vnet.name}"
  address_prefix = "${var.web_server_address_prefix}"
}

# Azure Network Interface (private/public<Static/Dynamic>, DNS)
resource "azurerm_network_interface" "web_server_nic" {
  name                      = "${var.web_server_name}-nic"
  location                  = "${azurerm_resource_group.web_server_rg.location}"
  resource_group_name       = "${azurerm_resource_group.web_server_rg.name}"
  network_security_group_id = "${azurerm_network_security_group.web_server_nsg.id}"

  ip_configuration {
    name                          = "${var.web_server_name}-ip"
    subnet_id                     = "${azurerm_subnet.web_server_subnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.web_server_public_ip.id}"
  }
}

resource "azurerm_public_ip" "web_server_public_ip" {
  name                          = "${var.web_server_name}-public-ip"
  location                      = "${azurerm_resource_group.web_server_rg.location}"
  resource_group_name           = "${azurerm_resource_group.web_server_rg.name}"
  allocation_method             = "Dynamic"
}

resource "azurerm_network_security_group" "web_server_nsg" {
  name                          = "${var.web_server_name}-nsg"
  location                      = "${azurerm_resource_group.web_server_rg.location}"
  resource_group_name           = "${azurerm_resource_group.web_server_rg.name}"

}

resource "azurerm_network_security_rule" "web_server_nsg_rule_rdp" {
  name                          = "RDP Inbound"
  priority                      = 100
  direction                     = "Inbound"
  access                        = "Allow"
  protocol                      = "TCP"
  source_port_range             = "*"
  destination_port_range        = "3389"   #RDP
  source_address_prefix         = "*"
  destination_address_prefix    = "*"
  resource_group_name           = "${azurerm_resource_group.web_server_rg.name}"
  network_security_group_name   = "${azurerm_network_security_group.web_server_nsg.name}"
}
# VM Window
resource "azurerm_virtual_machine" "web_server" {
  name  = "${var.web_server_name}"
  location                  = "${azurerm_resource_group.web_server_rg.location}"
  resource_group_name       = "${azurerm_resource_group.web_server_rg.name}"
  network_interface_ids     = ["${azurerm_network_interface.web_server_nic.id}"]
  vm_size                   = "Standard_B1s"

  storage_image_reference {
    publisher   = "MicrosoftWindowsServer"
    offer       = "WindowsServer"
    sku         = "2016-Datacenter-Server-Core-smalldisk"
    version     = "latest"
  }

  storage_os_disk {
    name = "${var.web_server_name}-os"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "${var.web_server_name}"
    admin_username = "webserver"
    admin_password = "Passw0rd1234"
  }
  os_profile_windows_config{

  }
}

