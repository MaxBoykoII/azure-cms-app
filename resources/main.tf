# To run the Terraform config on localhost with secrets:
# terraform plan -var-file="secrets.tfvars"

provider "azurerm" {
  version = "=2.20.0"
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_mysql_server" "database" {
    name = var.db_name
    location = var.location
    resource_group_name = azurerm_resource_group.main.name

    administrator_login = "mysqladmin"
    administrator_login_password = var.password

    sku_name = "B_Gen5_1"
    storage_mb = 5120
    version = "8.0"

    auto_grow_enabled = false
    backup_retention_days = 7
    geo_redundant_backup_enabled = false
    infrastructure_encryption_enabled = false
    public_network_access_enabled = true
    ssl_enforcement_enabled = false
}

resource "azurerm_mysql_firewall_rule" "firewall_rule" {
  name = "office"
  resource_group_name = azurerm_mysql_server.database.resource_group_name
  server_name = azurerm_mysql_server.database.name
  start_ip_address = var.ip_address
  end_ip_address = var.ip_address
}