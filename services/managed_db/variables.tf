variable "org_key" {
  description = "The organization 3 letter word"
  type        = string
}

variable "org_email_domain" {
  description = "The organization domain (e.g. example.com )"
  type        = string
}

variable "line_of_business_key" {
  description = "A 3 letter word for line of business that is unique in org"
  type        = string
}

variable "team_key" {
  description = "Opitonal. A 3 letter word for team managing the resources in this project"
  type        = string
  default     = ""
}

variable "app_key" {
  description = "A 3 letter app key that is unique in org"
  type        = string
}

variable "environment" {
  description = "A max 4 letter word explaining the environment the resources belong to. e.g. dev, qa, uat, stg, prod"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

# Define the module inputs
variable "db_type" {
  type        = string
  description = "Type of the database. acceptable values are sql_mi, pg_flex, mysql_mi"
  default     = "sql_mi"
}

variable "db_name" {
  description = " The name which should be used for this Azure PostgreSQL Flexible Server Database. Changing this forces a new Azure PostgreSQL Flexible Server Database to be created."
  type        = string
}

variable "server_id" {
  description = " The ID of the Azure PostgreSQL Flexible Server from which to create this PostgreSQL Flexible Server Database. Changing this forces a new Azure PostgreSQL Flexible Server Database to be created."
  type        = string
}

variable "charset" {
  description = " Specifies the Charset for the Azure PostgreSQL Flexible Server Database, which needs to be a valid PostgreSQL Charset. Defaults to UTF8. Changing this forces a new Azure PostgreSQL Flexible Server Database to be created."
  type        = string
  default     = "UTF8"
}

variable "collation" {
  description = " Specifies the Collation for the Azure PostgreSQL Flexible Server Database, which needs to be a valid PostgreSQL Collation. Defaults to en_US.utf8. Changing this forces a new Azure PostgreSQL Flexible Server Database to be created."
  type        = string
  default     = "en_US.utf8"
}

#pg
variable "server_name" {
  description = " Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = " The name of the resource group in which the PostgreSQL Server exists. Changing this forces a new resource to be created."
  type        = string
  default = ""
}