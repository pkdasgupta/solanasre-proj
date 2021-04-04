# Setting Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Specifying Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Creating a resource group
resource "azurerm_resource_group" "vmss" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "solanasre"
  }
}

# Creating a virtual network within the resource group
resource "azurerm_virtual_network" "vmss" {
  name                = "vmss-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.vmss.name

  tags = {
    environment = "solanasre"
  }
}

# Creating a Subnet
resource "azurerm_subnet" "vmss" {
  name                   = "vmss-subnet"
  resource_group_name    = azurerm_resource_group.vmss.name
  virtual_network_name   = azurerm_virtual_network.vmss.name
  address_prefixes       = ["10.0.2.0/24"]
}

# Creating a Public IP for VMSS LoadBalancer
resource "azurerm_public_ip" "vmss" {
  name                         = "vmss-public-ip"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.vmss.name
  allocation_method            = "Static"
  domain_name_label            = azurerm_resource_group.vmss.name

  tags = {
    environment = "solanasre"
  }
}

# Creating VMSS Load Balancer
resource "azurerm_lb" "vmss" {
  name                = "vmss-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.vmss.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.vmss.id
  }

  tags = {
    environment = "solanasre"
  }
}

# Creating the Backend Address Pool for Load Balancer
resource "azurerm_lb_backend_address_pool" "bpepool" {
  loadbalancer_id     = azurerm_lb.vmss.id
  name                = "BackEndAddressPool"
}

# Creating a health probe port used by the application and configured on the load balancer
resource "azurerm_lb_probe" "vmss" {
  resource_group_name = azurerm_resource_group.vmss.name
  loadbalancer_id     = azurerm_lb.vmss.id
  name                = "app-running-probe"
  port                = var.application_port
}

# Creating Load Balancer NAT Rule
resource "azurerm_lb_rule" "lbnatrule" {
  resource_group_name            = azurerm_resource_group.vmss.name
  loadbalancer_id                = azurerm_lb.vmss.id
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = var.application_port
  backend_port                   = var.application_port
  backend_address_pool_id        = azurerm_lb_backend_address_pool.bpepool.id
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.vmss.id
}

data "azurerm_resource_group" "image" {
  name = "pkd-rg"
}

data "azurerm_image" "image" {
  name                = "pkdwebserver"
  resource_group_name = data.azurerm_resource_group.image.name
}

# Creating the VM Scale Set
resource "azurerm_virtual_machine_scale_set" "vmss" {
  name                = "vmscaleset"
  location            = var.location
  resource_group_name = azurerm_resource_group.vmss.name
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
    computer_name_prefix = "solana-sre-vm"
    admin_username       = "azureuser"
    admin_password       = "Passwword1234"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "IPConfiguration"
      subnet_id                              = azurerm_subnet.vmss.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      primary = true
    }
  }

  tags = {
    environment = "solanasre"
  }
}

# Creating an instance of Managed MySQL Database Server
resource "azurerm_mysql_server" "mysql-server" {
  name = "solanasre-mysql-server"
  location = azurerm_resource_group.vmss.location
  resource_group_name = azurerm_resource_group.vmss.name
 
  administrator_login = var.mysql_admin_login
  administrator_login_password = var.mysql_admin_password
 
  sku_name = var.mysql_sku_name
  version = var.mysql_version
 
  storage_mb = var.mysql_storage
  auto_grow_enabled = true
  
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  public_network_access_enabled = true
  ssl_enforcement_enabled = false
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

# Creating a MySQL Database on the Server
resource "azurerm_mysql_database" "hello_world" {
  name                = "hello_world"
  resource_group_name = azurerm_resource_group.vmss.name
  server_name         = azurerm_mysql_server.mysql-server.name

  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Creating a VNET rule for the MySQL Server
resource "azurerm_mysql_virtual_network_rule" "mysql-vnet-rule" {
  name                = "mysql-vnet-rule"
  resource_group_name = azurerm_resource_group.vmss.name
  server_name         = azurerm_mysql_server.mysql-server.name
  subnet_id           = azurerm_subnet.vmss.id
}