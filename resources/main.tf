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
  name                          = var.db_server_name
  resource_group_name           = azurerm_resource_group.main.name
  location                      = var.location
  version                       = "12.0"
  administrator_login           = "missadministrator"
  administrator_login_password  = var.password
  minimum_tls_version           = "1.2"
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
  name             = "office"
  server_id        = azurerm_mssql_server.database_server.id
  start_ip_address = var.ip_address
  end_ip_address   = var.ip_address
}

resource "azurerm_mssql_firewall_rule" "firewall_rule_azure" {
  name             = "azure-access"
  server_id        = azurerm_mssql_server.database_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Cool"
  allow_blob_public_access = true
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "container"
}

resource "azuread_application" "cms_app" {
  display_name     = "${var.prefix}-app-registration"
  sign_in_audience = "AzureADMultipleOrgs"

  web {
    redirect_uris = ["http://localhost:5004/getAToken"]
  }
}

resource "azuread_application_password" "cms_app_pw" {
  application_object_id = azuread_application.cms_app.object_id
}

resource "azurerm_app_service_plan" "cms_app_service_plan" {
  name     = "${var.prefix}-app-service-plan"
  resource_group_name = azurerm_resource_group.main.name
  location = var.location

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "cms_app_service" {
  name                = "${var.prefix}-app-service"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.cms_app_service_plan.id

  app_settings = {
    SQL_SERVER = "${var.db_server_name}.database.windows.net"
    SQL_DATABASE = "${var.db_name}"
    SQL_USER_NAME = "missadministrator"
    SQL_PASSWORD = var.password
    BLOB_ACCOUNT = "cmsstorageazurexl"
    BLOB_STORAGE_KEY = azurerm_storage_account.storage_account.primary_access_key
    BLOB_CONTAINER ="images"
    CLIENT_ID = azuread_application.cms_app.application_id
    CLIENT_SECRET = azuread_application_password.cms_app_pw.value
  }
}
