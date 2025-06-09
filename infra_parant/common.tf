module "todo-rg" {
  source         = "../modules/azurerm_resource_group"
  resource_group = "abhi-todo-rg"
  location       = "Central India"
}
module "vnet-todo" {

  source              = "../modules/azurerm_virtual_network"
  vnet-name           = "abhivnet1"
  address_space       = ["50.0.0.0/22"]
  location            = "Central India"
  resource_group_name = "abhi-todo-rg"
}
module "subnet-todo" {
  depends_on           = [module.vnet-todo]
  source               = "../modules/azurerm_subnet"
  subnet_name          = "frontend"
  resource_group_name  = "abhi-todo-rg"
  virtual_network_name = "abhivnet1"
  address_prefixes     = ["50.0.1.0/24"]

}
module "subnet-todo1" {
  depends_on           = [module.vnet-todo]
  source               = "../modules/azurerm_subnet"
  subnet_name          = "backend"
  resource_group_name  = "abhi-todo-rg"
  virtual_network_name = "abhivnet1"
  address_prefixes     = ["50.0.2.0/24"]

}
module "todo-nic" {
  source              = "../modules/azurerm_network_interface"
  nic-name            = "abhi-nic1"
  nic-location        = "Central India"
  resource_group_name = "abhi-todo-rg"
  subnet_id           = "/subscriptions/d2df2a41-202d-4062-831a-7223cf0df18f/resourceGroups/abhi-todo-rg/providers/Microsoft.Network/virtualNetworks/abhivnet1/subnets/frontend"
  public_ip_id        = "/subscriptions/d2df2a41-202d-4062-831a-7223cf0df18f/resourceGroups/abhi-todo-rg/providers/Microsoft.Network/publicIPAddresses/abhi-pip1"
}
module "todo-nic1" {
  source              = "../modules/azurerm_network_interface"
  nic-name            = "abhi-nic2"
  nic-location        = "Central India"
  resource_group_name = "abhi-todo-rg"
  subnet_id           = "/subscriptions/d2df2a41-202d-4062-831a-7223cf0df18f/resourceGroups/abhi-todo-rg/providers/Microsoft.Network/virtualNetworks/abhivnet1/subnets/backend"
  public_ip_id        = "/subscriptions/d2df2a41-202d-4062-831a-7223cf0df18f/resourceGroups/abhi-todo-rg/providers/Microsoft.Network/publicIPAddresses/abhi-pip"
}

module "todo-pip" {
  source              = "../modules/azurerm_public_IP"
  public_ip_name      = "abhi-pip"
  location            = "Central India"
  resource_group_name = "abhi-todo-rg"

}
module "todo-pip1" {
  source              = "../modules/azurerm_public_IP"
  public_ip_name      = "abhi-pip1"
  location            = "Central India"
  resource_group_name = "abhi-todo-rg"

}
module "frontend-vm" {
  source                = "../modules/azurerm_virtual_machine"
  vm-name               = "abhi-vm1"
  resource_group_name   = "abhi-todo-rg"
  location              = "Central India"
  admin_username        = "abhiadmin"
  admin_password        = "Abhi@1234"
  network_interface_ids = ["/subscriptions/d2df2a41-202d-4062-831a-7223cf0df18f/resourceGroups/abhi-todo-rg/providers/Microsoft.Network/networkInterfaces/abhi-nic1"]
  image-publisher       = "Canonical"
  image-offer           = "0001-com-ubuntu-server-jammy"
  image-sku             = "22_04-lts"

}
module "backend-vm" {
  source                = "../modules/azurerm_virtual_machine"
  vm-name               = "abhi-vm2"
  resource_group_name   = "abhi-todo-rg"
  location              = "Central India"
  admin_username        = "abhiadmin"
  admin_password        = "Abhi@1234"
  network_interface_ids = ["/subscriptions/d2df2a41-202d-4062-831a-7223cf0df18f/resourceGroups/abhi-todo-rg/providers/Microsoft.Network/networkInterfaces/abhi-nic2"]
  image-publisher       = "Canonical"
  image-offer           = "0001-com-ubuntu-server-jammy"
  image-sku             = "22_04-lts"

}
module "mssqlserver" {
  source                     = "../modules/azurerm_sql_server"
  mssqlserver                = "todo-sql-server3"
  resource_group_name        = "abhi-todo-rg"
  location                   = "Central India"
  administrator_login        = "sqladmin"
  administrator_login_password = "Abhi@1234"
  
}
module "mssql_database" {
  source              = "../modules/azurerm_sql_database"
  sql_database_name   = "todosqldb"
  sql_server_id       = "/subscriptions/d2df2a41-202d-4062-831a-7223cf0df18f/resourceGroups/abhi-todo-rg/providers/Microsoft.Sql/servers/todo-sql-server3"
 
} 
module "todo-nsg" {
  source              = "../modules/azurerm_network_security_grp"
  network_security_name = "abhi-todo-nsg"
  location            = "Central India"
  resource_group_name = "abhi-todo-rg"
  
}