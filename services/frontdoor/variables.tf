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

variable "layer_key" {
  description = "Layer key for the application"
  type        = string
  default = "app"
}

variable "environment" {
  description = "A max 4 letter word explaining the environment the resources belong to. e.g. dev, qa, uat, stg, prod"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "location_short" {
  description = "Azure location short form"
  type        = string
}

# Define the module inputs
variable "name" {
  description = " Specifies the name of the Front Door Profile. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = " The name of the Resource Group where this Front Door Profile should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "sku_name" {
  description = " Specifies the SKU for this Front Door Profile. Possible values include Standard_AzureFrontDoor and Premium_AzureFrontDoor. Changing this forces a new resource to be created."
  type        = string
  # validation {
  #   condition     = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.sku_name)
  #   error_message = " Specifies the SKU for this Front Door Profile. Possible values include Standard_AzureFrontDoor and Premium_AzureFrontDoor. Changing this forces a new resource to be created."
  # }
}

variable "response_timeout_seconds" {
  description = " Specifies the maximum response timeout in seconds. Possible values are between 16 and 240 seconds (inclusive). Defaults to 120 seconds."
  type        = number
  default     = 120
}

variable "tags" {
  description = " Specifies a mapping of tags to assign to the resource."
  type        = map(string)
  default     = null
}

variable "cdn_frontdoor_profile_id" {
  description = " The ID of the Front Door Profile within which this Front Door Origin Group should exist. Changing this forces a new Front Door Origin Group to be created."
  type        = string
  default     = ""
}

variable "load_balancing" {
  description = " A load_balancing block as defined below."
  type = object({
    additional_latency_in_milliseconds = optional(string)
    sample_size                        = optional(string)
    successful_samples_required        = optional(string)
  })
  default = {}
}

variable "health_probe" {
  description = " A health_probe block as defined below."
  type = object({
    protocol            = string
    interval_in_seconds = string
    request_type        = optional(string)
    path                = optional(string)
  })
  default = null
}

variable "restore_traffic_time_to_healed_or_new_endpoint_in_minutes" {
  description = " Specifies the amount of time which should elapse before shifting traffic to another endpoint when a healthy endpoint becomes unhealthy or a new endpoint is added. Possible values are between 0 and 50 minutes (inclusive). Default is 10 minutes."
  type        = string
  default     = null
}

variable "session_affinity_enabled" {
  description = " Specifies whether session affinity should be enabled on this host. Defaults to true."
  type        = bool
  default     = true
}

#origin
variable "cdn_frontdoor_origin_group_id" {
  description = " The ID of the Front Door Origin Group within which this Front Door Origin should exist. Changing this forces a new Front Door Origin to be created."
  type        = string
  default     = ""
}

variable "cdn_frontdoor_origins" {
  type = list(object({
    name                           = string
    host_name                      = string
    certificate_name_check_enabled = bool
    http_port                      = optional(number)
    https_port                     = optional(number)
    origin_host_header             = optional(string)
    priority                       = optional(number)
    enabled                        = optional(bool)
    weight                         = optional(number)
    private_link = optional(object({
      request_message        = optional(string)
      target_type            = optional(string)
      location               = string
      private_link_target_id = string
    }))
  }))
  default = []
}

#route
variable "cdn_frontdoor_endpoint_id" {
  description = " The resource ID of the Front Door Endpoint where this Front Door Route should exist. Changing this forces a new Front Door Route to be created."
  type        = string
  default = ""
}

variable "forwarding_protocol" {
  description = " The Protocol that will be use when forwarding traffic to backends. Possible values are HttpOnly, HttpsOnly or MatchRequest."
  type        = string
  default     = null
}

variable "patterns_to_match" {
  description = " The route patterns of the rule."
  type        = list(string)
  default     = ["/*"]
}

variable "supported_protocols" {
  description = " One or more Protocols supported by this Front Door Route. Possible values are Http or Https."
  type        = list(string)
  default = ["Http", "Https"]
}

variable "cache" {
  description = " A cache block as defined below."
  type = object({
    query_string_caching_behavior = optional(string)
    query_strings                 = optional(string)
    compression_enabled           = optional(string)
    content_types_to_compress     = optional(string)
  })
  default = null
}

variable "cdn_frontdoor_custom_domain_ids" {
  description = " The IDs of the Front Door Custom Domains which are associated with this Front Door Route."
  type        = list(string)
  default     = []
}

variable "cdn_frontdoor_origin_path" {
  description = " A directory path on the Front Door Origin that can be used to retrieve content (e.g. contoso.cloudapp.net/originpath)."
  type        = string
  default     = null
}

variable "cdn_frontdoor_rule_set_ids" {
  description = " A list of the Front Door Rule Set IDs which should be assigned to this Front Door Route."
  type        = list(string)
  default     = []
}

variable "enabled" {
  description = " Is this Front Door Route enabled? Possible values are true or false. Defaults to true."
  type        = bool
  default     = true
}

variable "https_redirect_enabled" {
  description = " Automatically redirect HTTP traffic to HTTPS traffic? Possible values are true or false. Defaults to true."
  type        = bool
  default     = true
}

variable "link_to_default_domain" {
  description = " Should this Front Door Route be linked to the default endpoint? Possible values include true or false. Defaults to true."
  type        = bool
  default     = true
}

