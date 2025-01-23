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

variable "layer_key" {
  description = "Layer key for the application"
  type        = string
  default = "app"
}

variable "environment" {
  description = "A max 4 letter word explaining the environment the resources belong to. e.g. dev, qa, uat, stg, prod"
  type        = string
}

variable "naming_postfix" {
  description = "Post fix for naming"
  type = string
  default = ""
}

variable "vpc_postfix" {
  description = "VPC postfix for naming."
  type = string
  default = "01"
}

variable "location" {
  description = "region or location"
  type        = string
}

variable "location_short" {
  description = "Azure location short form"
  type        = string
  default = ""
}

variable "db_type" {
  description = "Type of database for cloud sql"
  type = string
  default = "pg"
}