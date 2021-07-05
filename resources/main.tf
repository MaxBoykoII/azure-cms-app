# To run the Terraform config on localhost with secrets:
# terraform plan -var-file="secrets.tfvars"

provider "azurerm" {
  version = "=2.66.0"
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_mssql_server" "database_server" {
  name                         = var.db_server_name
  resource_group_name          = azurerm_resource_group.main.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = var.password
  minimum_tls_version          = "1.2"
  public_network_access_enabled = true
}

resource "azurerm_mssql_database" "database" {
  name           = var.db_name
  server_id      = azurerm_mssql_server.database_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = "Basic"
  zone_redundant = false
}

resource "azurerm_mssql_firewall_rule" "firewall_rule_dev" {
  name                = "office"
  server_id           = azurerm_mssql_server.database_server.id
  start_ip_address    = var.ip_address
  end_ip_address      = var.ip_address
}

resource "azurerm_mssql_firewall_rule" "firewall_rule_azure" {
  name                = "azure-access"
  server_id           = azurerm_mssql_server.database_server.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
