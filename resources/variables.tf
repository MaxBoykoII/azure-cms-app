
variable "prefix" {
  description = "The prefix used for all resources in this project"
  type        = string
  default     = "azure-cms-app"
}

variable "location" {
  description = "The location of the resources in this project"
  type        = string
  default     = "West US"
}

variable "db_server_name" {
  description = "The name of the SQL database server"
  type        = string
  default     = "azure-cms-db-server"

}

variable "db_name" {
  description = "The name of the SQL database"
  type        = string
  default     = "azure-cms-db"
}

variable "storage_name" {
  description = "The name of the Azure storage account"
  type        = string
  default     = "cmsstorageazurexl"
}

variable "password" {
  description = "Administrator password for MySQL server"
  type        = string
}

variable "ip_address" {
  description = "Trusted ip address for accessing the MySQL server"
  type        = string
}

variable "app_image" {
  description = "The image for the cms application"
  type        = string
  default     = "maxboyko/azure-cms-app:latest"
}
