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
  default = ""
}

variable "app_key" {
  description = "A 3 letter app key that is unique in org"
  type        = string
}

variable "environment" {
  description = "A max 4 letter word explaining the environment the resources belong to. e.g. dev, qa, uat, stg, prod"
  type        = string
}

variable "vpc_postfix" {
  description = "VPC postfix for naming."
  type = string
  default = "01"
}

variable "location" {
  description = "azure cloud location"
  type        = string
  default = ""
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "vnet_id" {
  type        = string
  description = "VNet Id where database is created"
}

variable "subnet_id" {
  type        = string
  description = "Subnet Id where database is created"
}

variable "db_managed_instance_id" {
  type        = string
  description = "Id of the managed instance"
}

variable "db_managed_private_fqdn" {
  type        = string
  description = "Private FQDN of the managed instance"
}
