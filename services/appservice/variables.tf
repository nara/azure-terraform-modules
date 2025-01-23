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
variable "os_type" {
  description = " The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer. Changing this forces a new resource to be created."
  type = string
  validation {
      condition     = contains(["Windows", "Linux"], var.os_type)
      error_message = " The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer. Changing this forces a new resource to be created."
  }
}

variable "enable_appinsights" {
  description = "Enable app insights or not. Defaults to False"
  type = bool
  default = false
}

variable "application_type" {
  description = "The type of application being monitored. Possible values include web, other, and java."
  type = string
  default = "web"
}

variable "app_insights_name" {
  description = "The name of the Application Insights Component. Changing this forces a new resource to be created."
  type = string
  default = ""
}

variable "analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace that should be associated with this Application Insights Component."
  type = string
  default = ""
}

variable "analytics_destination_type" {
  description = "The destination type of the diagnostic setting. Possible values include AzureDiagnostics, AzureActivity, and AzureSecurityCenter."
  type = string
  default = "AzureDiagnostics"
}

variable "retention_in_days" {
  description = "The number of days to retain data in the Log Analytics Workspace. Defaults to 30."
  type = number
  default = 30
}

variable "analytics_workspace_sku" {
  description = "The SKU of the Log Analytics Workspace. Possible values include Free, PerGB2018, Standard, and Premium."
  type = string
  default = "PerGB2018"
}

#service_plan
variable "sku_name" {
  description = " The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1."
  type        = string
  # validation {
  #   condition     = contains(["B1", "B2", "B3", "D1", "F1", "I1", "I2", "I3", "I1v2", "I2v2", "I3v2", "P1v2", "P2v2", "P3v2", "P1v3", "P2v3", "P3v3", "S1", "S2", "S3", "SHARED", "EP1", "EP2", "EP3", "WS1", "WS2", "WS3"], var.sku_name)
  #   error_message = " The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1."
  # }
  default = ""
}

variable "app_service_environment_id" {
  description = " The ID of the App Service Environment to create this Service Plan in."
  type        = string
  default     = null
}

variable "maximum_elastic_worker_count" {
  description = " The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU."
  type        = number
  default     = null
}

variable "worker_count" {
  description = " The number of Workers (instances) to be allocated."
  type        = number
  default     = null
}

variable "per_site_scaling_enabled" {
  description = " Should Per Site Scaling be enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "zone_balancing_enabled" {
  description = " Should the Service Plan balance across Availability Zones in the region. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

#azurerm_linux_web_app

variable "resource_group_name" {
  description = " The name of the Resource Group where the Linux Web App should exist. Changing this forces a new Linux Web App to be created."
  type        = string
}

variable "service_plan_id" {
  description = " The ID of the Service Plan that this Linux App Service will be created in."
  type        = string
  default = ""
}

variable "site_config" {
  description = " A site_config block as defined below."
  type = object({
    always_on             = optional(string)
    api_definition_url    = optional(string)
    api_management_api_id = optional(string)
    app_command_line      = optional(string)
    application_stack = optional(object({
      docker_image        = optional(string)
      docker_image_tag    = optional(string)
      dotnet_version      = optional(string)
      go_version          = optional(string)
      java_server         = optional(string)
      java_server_version = optional(string)
      java_version        = optional(string)
      node_version        = optional(string)
      php_version         = optional(string)
      python_version      = optional(string)
      ruby_version        = optional(string)
    }))
    auto_heal_enabled = optional(string)
    auto_heal_setting = optional(object({
      action = optional(object({
        action_type                    = string
        minimum_process_execution_time = optional(string)
      }))
      trigger = optional(object({
        requests = optional(object({
          count    = string
          interval = string
        }))
        slow_request = optional(string)
        status_code  = optional(string)
      }))
    }))
    container_registry_managed_identity_client_id = optional(string)
    container_registry_use_managed_identity       = optional(string)
    cors = optional(object({
      allowed_origins     = string
      support_credentials = optional(string)
    }))
    default_documents                 = optional(list(string))
    ftps_state                        = optional(string)
    health_check_path                 = optional(string)
    health_check_eviction_time_in_min = optional(string)
    http2_enabled                     = optional(string)
    ip_restriction                    = optional(string)
    load_balancing_mode               = optional(string)
    local_mysql_enabled               = optional(string)
    managed_pipeline_mode             = optional(string)
    minimum_tls_version               = optional(string)
    remote_debugging_enabled          = optional(string)
    remote_debugging_version          = optional(string)
    scm_ip_restriction                = optional(string)
    scm_minimum_tls_version           = optional(string)
    scm_use_main_ip_restriction       = optional(string)
    use_32_bit_worker                 = optional(string)
    vnet_route_all_enabled            = optional(string)
    websockets_enabled                = optional(string)
    worker_count                      = optional(string)
  })
}

variable "app_settings" {
  description = " A map of key-value pairs of App Settings."
  type        = map(string)
  default     = {}
}

variable "auth_settings" {
  description = " A auth_settings block as defined below."
  type = object({
    enabled = string
    active_directory = optional(object({
      client_id                  = string
      allowed_audiences          = optional(string)
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
    }))
    additional_login_parameters    = optional(string)
    allowed_external_redirect_urls = optional(string)
    default_provider               = optional(string)
    facebook = optional(object({
      app_id                  = string
      app_secret              = optional(string)
      app_secret_setting_name = optional(string)
      oauth_scopes            = optional(string)
    }))
    github = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(string)
    }))
    google = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(string)
    }))
    issuer = optional(string)
    microsoft = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(string)
    }))
    runtime_version               = optional(string)
    token_refresh_extension_hours = optional(string)
    token_store_enabled           = optional(string)
    twitter = optional(object({
      consumer_key                 = string
      consumer_secret              = optional(string)
      consumer_secret_setting_name = optional(string)
    }))
    unauthenticated_client_action = optional(string)
  })
  default = null
}

variable "auth_settings_v2" {
  description = " An auth_settings_v2 block as defined below."
  type = object({
    auth_enabled                            = optional(string)
    runtime_version                         = optional(string)
    config_file_path                        = optional(string)
    require_authentication                  = optional(string)
    unauthenticated_action                  = optional(string)
    default_provider                        = optional(string)
    excluded_paths                          = optional(string)
    require_https                           = optional(string)
    http_route_api_prefix                   = optional(string)
    forward_proxy_convention                = optional(string)
    forward_proxy_custom_host_header_name   = optional(string)
    forward_proxy_custom_scheme_header_name = optional(string)
    apple_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
    }))
    active_directory_v2 = optional(object({
      client_id                            = string
      tenant_auth_endpoint                 = string
      client_secret_setting_name           = optional(string)
      client_secret_certificate_thumbprint = optional(string)
      jwt_allowed_groups                   = optional(string)
      jwt_allowed_client_applications      = optional(string)
      www_authentication_disabled          = optional(string)
      allowed_groups                       = optional(string)
      allowed_identities                   = optional(string)
      allowed_applications                 = optional(string)
      login_parameters                     = optional(string)
      allowed_audiences                    = optional(string)
    }))
    azure_static_web_app_v2 = optional(object({
      client_id = string
    }))
    custom_oidc_v2 = optional(string)
    facebook_v2 = optional(object({
      app_id                  = string
      app_secret_setting_name = string
      graph_api_version       = optional(string)
      login_scopes            = optional(string)
    }))
    github_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      login_scopes               = optional(string)
    }))
    google_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(string)
      login_scopes               = optional(string)
    }))
    microsoft_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(string)
      login_scopes               = optional(string)
    }))
    twitter_v2 = optional(object({
      consumer_key                 = string
      consumer_secret_setting_name = string
    }))
    login = optional(object({
      logout_endpoint                   = optional(string)
      token_store_enabled               = optional(string)
      token_refresh_extension_time      = optional(string)
      token_store_path                  = optional(string)
      token_store_sas_setting_name      = optional(string)
      preserve_url_fragments_for_logins = optional(string)
      allowed_external_redirect_urls    = optional(string)
      cookie_expiration_convention      = optional(string)
      cookie_expiration_time            = optional(string)
      validate_nonce                    = optional(string)
      nonce_expiration_time             = optional(string)
    }))
  })
  default = null
}

variable "backup" {
  description = " A backup block as defined below."
  type = object({
    name = string
    schedule = object({
      frequency_interval       = string
      frequency_unit           = string
      keep_at_least_one_backup = optional(string)
      retention_period_days    = optional(string)
      start_time               = optional(string)

    })
    storage_account_url = string
    enabled             = optional(string)
  })
  default = null
}

variable "client_affinity_enabled" {
  description = " Should Client Affinity be enabled?"
  type        = bool
  default     = false
}

variable "client_certificate_enabled" {
  description = " Should Client Certificates be enabled?"
  type        = bool
  default     = false
}

variable "client_certificate_mode" {
  description = " The Client Certificate mode. Possible values are Required, Optional, and OptionalInteractiveUser. This property has no effect when client_certificate_enabled is false"
  type        = string
  default     = null
}

variable "client_certificate_exclusion_paths" {
  description = " Paths to exclude when using client certificates, separated by ;"
  type        = string
  default     = null
}

variable "connection_string" {
  description = " One or more connection_string blocks as defined below."
  type        = string
  default     = null
}

variable "enabled" {
  description = " Should the Linux Web App be enabled? Defaults to true."
  type        = bool
  default     = true
}

variable "https_only" {
  description = " Should the Linux Web App require HTTPS connections."
  type        = bool
  default     = false
}

variable "identity" {
  description = " An identity block as defined below."
  type = object({
    type         = string
    identity_ids = optional(string)
  })
  default = null
}

variable "key_vault_reference_identity_id" {
  description = " The User Assigned Identity ID used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block. For more information see - Access vaults with a user-assigned identity."
  type        = string
  default     = null
}

variable "logs" {
  description = " A logs block as defined below."
  type = object({
    application_logs = optional(object({
      azure_blob_storage = optional(object({
        level             = string
        retention_in_days = string
        sas_url           = string
      }))
      file_system_level = string
    }))
    detailed_error_messages = optional(string)
    failed_request_tracing  = optional(string)
    http_logs = optional(object({
      azure_blob_storage = optional(object({
        level             = string
        retention_in_days = string
        sas_url           = string
      }))
      file_system = optional(object({
        retention_in_days = string
        retention_in_mb   = string
      }))
    }))
  })
  default = null
}

variable "storage_account" {
  description = " One or more storage_account blocks as defined below."
  type        = string
  default     = ""
}

variable "sticky_settings" {
  description = " A sticky_settings block as defined below."
  type = object({
  })
  default = null
}

variable "virtual_network_subnet_id" {
  description = " The subnet id which will be used by this Web App for regional virtual network integration."
  type        = string
  default     = null
}

variable "zip_deploy_file" {
  description = " The local path and filename of the Zip packaged application to deploy to this Linux Web App."
  type        = string
  default     = null
}

variable "tags" {
  description = " A mapping of tags which should be assigned to the Linux Web App."
  type        = map(string)
  default     = {}
}

