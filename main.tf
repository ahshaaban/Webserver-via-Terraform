
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.32.0"
    }
  }
 
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

    tags = {
    Environment = "Production"
   
  }
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "web-srv-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Create a sunbet

resource "azurerm_subnet" "subnetl" {
  name                 = "web-srv-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name   # create dependancy to VNET
  address_prefixes     = ["10.0.2.0/24"]
}

#Create Public IP address

 resource "azurerm_public_ip" "pip" {
   name                         = "publicIPForLB"
   location                     = var.location
   resource_group_name          = var.resource_group_name
   allocation_method            = "Static"
 }

#Create Load Balancer

 resource "azurerm_lb" "LB" {
   name                = "loadBalancer"
   location            = var.location
   resource_group_name = var.resource_group_name

   frontend_ip_configuration {
     name                 = "publicIPAddress"
     public_ip_address_id = azurerm_public_ip.pip.id
   }
 }
 resource "azurerm_lb_backend_address_pool" "Bpool" {
   loadbalancer_id     = azurerm_lb.LB.id
   name                = "BackEndAddressPool"
 }

resource "azurerm_lb_probe" "LBbrobe" {
  loadbalancer_id     = azurerm_lb.LB.id
  name                = "ssh-running-probe"
  port                = var.application_port
}


resource "azurerm_lb_rule" "lbnatrule" {
  loadbalancer_id                = azurerm_lb.LB.id
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = var.application_port
  backend_port                   = var.application_port
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.Bpool.id]
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.LBbrobe.id
}

data "azurerm_resource_group" "image" {
  name                = var.packer_resource_group_name
}

data "azurerm_image" "image" {
  name                = var.managed_image_name
  resource_group_name = data.azurerm_resource_group.image.name
}

resource "azurerm_virtual_machine_scale_set" "vmss" {
  name                = "vmscaleset"
  location            = var.location
  resource_group_name = var.resource_group_name
  upgrade_policy_mode = "Manual"

  sku {
    name     = "Standard_DS1_v2"
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_image_reference {
    id=data.azurerm_image.image.id
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun          = 0
    caching        = "ReadWrite"
    create_option  = "Empty"
    disk_size_gb   = 10
  }

  os_profile {
    computer_name_prefix = "vmlab"
    admin_username       = var.admin_user
    admin_password       = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = true

    
   ### ssh_keys {
    ###  path     = "/home/azureuser/.ssh/authorized_keys"
     ### key_data = file("~/.ssh/id_rsa.pub")
   ### }
    
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "IPConfiguration"
      subnet_id                              = azurerm_subnet.subnetl.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.Bpool.id]
      primary = true
    }
  }
  
}





