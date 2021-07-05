
variable "prefix" {
    description = "The prefix used for all resources in this project"
    type = string
    default = "azure-cms-app"
}

variable "location" {
    description = "The location of the resources in this project"
    type = string
    default = "West US"
}

variable "db_name" {
    description = "The name of the MySQL database"
    type = string
    default = "azure-cms"
}

variable "password" {
    description = "Administrator password for MySQL server"
    type = string
}

variable "ip_address" {
    description = "Trusted ip address for accessing the MySQL server"
    type = string
}