output "cms_app_client_id" {
  value = azuread_application.cms_app.application_id
}

output "cms_app_client_secret" {
  value     = azuread_application_password.cms_app_pw.value
  sensitive = true
}

output "cms_images_blob_storage_key" {
  value     = azurerm_storage_account.storage_account.primary_access_key
  sensitive = true
}
