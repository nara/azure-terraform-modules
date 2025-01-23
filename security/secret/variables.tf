variable "location" {
  description = "Azure location"
  type        = string
}

# Define the module inputs
variable "key_vault_id" {
  description = "Key Vault Id"
  type        = string
}

variable "secret_data" {
  description = "Name of the secret to be created."
  type = list(object({
    name = string
    value = string
    content_type = optional(string)
    not_before_date = optional(string)
    expiration_date = optional(string)
  }))
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}