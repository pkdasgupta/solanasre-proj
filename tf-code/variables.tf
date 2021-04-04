variable "location" {
  description = "The location where resources are created"
  default     = "West US"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources are created"
  default     = "solanasre-rg"
}

variable "application_port" {
    description = "The port that you want to expose to the external load balancer"
    default     = 5000
}

variable "admin_password" {
    description = "Default password for admin"
    default = "Sol@n@$r3"
}

variable "mysql_admin_login" {
  type = string
  description = "Login to authenticate to MySQL Server"
  default = "pkd@pkdmysql"
}

variable "mysql_admin_password" {
  type = string
  description = "Password to authenticate to MySQL Server"
  default = "mysql2021!@"
}

variable "mysql_version" {
  type = string
  description = "MySQL Server version to deploy"
  default = "8.0"
}

variable "mysql_sku_name" {
  type = string
  description = "MySQL SKU Name"
  default = "B_Gen5_2"
}
variable "mysql_storage" {
  type = string
  description = "MySQL Storage in MB"
  default = "5120"
}