provider "azurerm" {
  version = ">=2.4.0"
  subscription_id = "56a41315-78dc-492c-87ee-f8771705b3ad"
  tenant_id = "9ef4f69c-e182-4897-abb7-acda150149f8"

  features {}
  
}
data "azurerm_resource_group" "image" {
  name = "testapp-rg"
}

data "azurerm_image" "image" {
  name                = "myPackerImagenew"
  resource_group_name = "${data.azurerm_resource_group.image.name}"
}

resource "azurerm_resource_group" "main" {
  name     = "mani-resources"
  location = "east us"
}

resource "azurerm_public_ip" "example" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_virtual_network" "example" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  
  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule  {

    name = "test12345"
    access = "deny"
    description = "Deny access from Internet"
    direction = "Inbound"
    priority = 102
    protocol = "TCP"
    source_address_prefix = "Internet"
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
    
  } 

}


resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.4.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "new-nic"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb" "example" {
  name                = "TestLoadBalancer"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_lb_backend_address_pool" "example" {
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id     = azurerm_lb.example.id
  name                = "BackEndAddressPool"
}

resource "azurerm_availability_set" "example" {
  name                = "example-aset"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    environment = "Production"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

 storage_profile_image_reference {
    id="${data.azurerm_image.image.id}"
  }

  
  os_disk {

    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    create_option     = "FromImage"
    
     }

  
}


