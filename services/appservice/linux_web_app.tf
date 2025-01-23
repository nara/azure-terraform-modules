resource "azurerm_linux_web_app" "linux_web_app" {
  count = lower(var.os_type) == "linux" ? 1 : 0

  location            = var.location
  name                = module.naming_conv.naming_for_app.app_service.name
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id == "" ? azurerm_service_plan.service_plan[0].id : var.service_plan_id

  dynamic "site_config" {
    for_each = var.site_config != null ? [var.site_config] : []
    content {
      always_on             = lookup(site_config.value, "always_on", null)
      api_definition_url    = lookup(site_config.value, "api_definition_url", null)
      api_management_api_id = lookup(site_config.value, "api_management_api_id", null)
      app_command_line      = lookup(site_config.value, "app_command_line", null)

      dynamic "application_stack" {
        for_each = lookup(site_config.value, "application_stack", null) != null ? [lookup(site_config.value, "application_stack", null)] : []
        content {
          docker_image        = lookup(application_stack.value, "docker_image", null)
          docker_image_tag    = lookup(application_stack.value, "docker_image_tag", null)
          dotnet_version      = lookup(application_stack.value, "dotnet_version", null)
          go_version          = lookup(application_stack.value, "go_version", null)
          java_server         = lookup(application_stack.value, "java_server", null)
          java_server_version = lookup(application_stack.value, "java_server_version", null)
          java_version        = lookup(application_stack.value, "java_version", null)
          node_version        = lookup(application_stack.value, "node_version", null)
          php_version         = lookup(application_stack.value, "php_version", null)
          python_version      = lookup(application_stack.value, "python_version", null)
          ruby_version        = lookup(application_stack.value, "ruby_version", null)

        }
      }
      auto_heal_enabled = lookup(site_config.value, "auto_heal_enabled", null)

      dynamic "auto_heal_setting" {
        for_each = lookup(site_config.value, "auto_heal_setting", null) != null ? [lookup(site_config.value, "auto_heal_setting", null)] : []
        content {

          dynamic "action" {
            for_each = lookup(auto_heal_setting.value, "action", null) != null ? [lookup(auto_heal_setting.value, "action", null)] : []
            content {
              action_type                    = lookup(action.value, "action_type", null)
              minimum_process_execution_time = lookup(action.value, "minimum_process_execution_time", null)

            }
          }

          dynamic "trigger" {
            for_each = lookup(auto_heal_setting.value, "trigger", null) != null ? [lookup(auto_heal_setting.value, "trigger", null)] : []
            content {

              dynamic "requests" {
                for_each = lookup(trigger.value, "requests", null) != null ? [lookup(trigger.value, "requests", null)] : []
                content {
                  count    = lookup(requests.value, "count", null)
                  interval = lookup(requests.value, "interval", null)

                }
              }
              #slow_request = lookup(trigger.value, "slow_request", null)
              #status_code  = lookup(trigger.value, "status_code", null)

            }
          }

        }
      }
      container_registry_managed_identity_client_id = lookup(site_config.value, "container_registry_managed_identity_client_id", null)
      container_registry_use_managed_identity       = lookup(site_config.value, "container_registry_use_managed_identity", null)

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", null) != null ? [lookup(site_config.value, "cors", null)] : []
        content {
          allowed_origins     = lookup(cors.value, "allowed_origins", null)
          support_credentials = lookup(cors.value, "support_credentials", null)

        }
      }
      default_documents                 = lookup(site_config.value, "default_documents", null)
      ftps_state                        = lookup(site_config.value, "ftps_state", null)
      health_check_path                 = lookup(site_config.value, "health_check_path", null)
      health_check_eviction_time_in_min = lookup(site_config.value, "health_check_eviction_time_in_min", null)
      http2_enabled                     = lookup(site_config.value, "http2_enabled", null)
      #ip_restriction                    = lookup(site_config.value, "ip_restriction", null)
      load_balancing_mode               = lookup(site_config.value, "load_balancing_mode", null)
      local_mysql_enabled               = lookup(site_config.value, "local_mysql_enabled", null)
      managed_pipeline_mode             = lookup(site_config.value, "managed_pipeline_mode", null)
      minimum_tls_version               = lookup(site_config.value, "minimum_tls_version", null)
      remote_debugging_enabled          = lookup(site_config.value, "remote_debugging_enabled", null)
      remote_debugging_version          = lookup(site_config.value, "remote_debugging_version", null)
      #scm_ip_restriction                = lookup(site_config.value, "scm_ip_restriction", null)
      scm_minimum_tls_version           = lookup(site_config.value, "scm_minimum_tls_version", null)
      scm_use_main_ip_restriction       = lookup(site_config.value, "scm_use_main_ip_restriction", null)
      use_32_bit_worker                 = lookup(site_config.value, "use_32_bit_worker", null)
      vnet_route_all_enabled            = lookup(site_config.value, "vnet_route_all_enabled", null)
      websockets_enabled                = lookup(site_config.value, "websockets_enabled", null)
      worker_count                      = lookup(site_config.value, "worker_count", null)

    }
  }
  app_settings = var.app_settings

  dynamic "auth_settings" {
    for_each = var.auth_settings != null ? [var.auth_settings] : []
    content {
      enabled = lookup(auth_settings.value, "enabled", null)

      dynamic "active_directory" {
        for_each = lookup(auth_settings.value, "active_directory", null) != null ? [lookup(auth_settings.value, "active_directory", null)] : []
        content {
          client_id                  = lookup(active_directory.value, "client_id", null)
          allowed_audiences          = lookup(active_directory.value, "allowed_audiences", null)
          client_secret              = lookup(active_directory.value, "client_secret", null)
          client_secret_setting_name = lookup(active_directory.value, "client_secret_setting_name", null)

        }
      }
      additional_login_parameters    = lookup(auth_settings.value, "additional_login_parameters", null)
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls", null)
      default_provider               = lookup(auth_settings.value, "default_provider", null)

      dynamic "facebook" {
        for_each = lookup(auth_settings.value, "facebook", null) != null ? [lookup(auth_settings.value, "facebook", null)] : []
        content {
          app_id                  = lookup(facebook.value, "app_id", null)
          app_secret              = lookup(facebook.value, "app_secret", null)
          app_secret_setting_name = lookup(facebook.value, "app_secret_setting_name", null)
          oauth_scopes            = lookup(facebook.value, "oauth_scopes", null)

        }
      }

      dynamic "github" {
        for_each = lookup(auth_settings.value, "github", null) != null ? [lookup(auth_settings.value, "github", null)] : []
        content {
          client_id                  = lookup(github.value, "client_id", null)
          client_secret              = lookup(github.value, "client_secret", null)
          client_secret_setting_name = lookup(github.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(github.value, "oauth_scopes", null)

        }
      }

      dynamic "google" {
        for_each = lookup(auth_settings.value, "google", null) != null ? [lookup(auth_settings.value, "google", null)] : []
        content {
          client_id                  = lookup(google.value, "client_id", null)
          client_secret              = lookup(google.value, "client_secret", null)
          client_secret_setting_name = lookup(google.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(google.value, "oauth_scopes", null)

        }
      }
      issuer = lookup(auth_settings.value, "issuer", null)

      dynamic "microsoft" {
        for_each = lookup(auth_settings.value, "microsoft", null) != null ? [lookup(auth_settings.value, "microsoft", null)] : []
        content {
          client_id                  = lookup(microsoft.value, "client_id", null)
          client_secret              = lookup(microsoft.value, "client_secret", null)
          client_secret_setting_name = lookup(microsoft.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(microsoft.value, "oauth_scopes", null)

        }
      }
      runtime_version               = lookup(auth_settings.value, "runtime_version", null)
      token_refresh_extension_hours = lookup(auth_settings.value, "token_refresh_extension_hours", null)
      token_store_enabled           = lookup(auth_settings.value, "token_store_enabled", null)

      dynamic "twitter" {
        for_each = lookup(auth_settings.value, "twitter", null) != null ? [lookup(auth_settings.value, "twitter", null)] : []
        content {
          consumer_key                 = lookup(twitter.value, "consumer_key", null)
          consumer_secret              = lookup(twitter.value, "consumer_secret", null)
          consumer_secret_setting_name = lookup(twitter.value, "consumer_secret_setting_name", null)

        }
      }
      unauthenticated_client_action = lookup(auth_settings.value, "unauthenticated_client_action", null)

    }
  }

  dynamic "auth_settings_v2" {
    for_each = var.auth_settings_v2 != null ? [var.auth_settings_v2] : []
    content {
      auth_enabled                            = lookup(auth_settings_v2.value, "auth_enabled", null)
      runtime_version                         = lookup(auth_settings_v2.value, "runtime_version", null)
      config_file_path                        = lookup(auth_settings_v2.value, "config_file_path", null)
      require_authentication                  = lookup(auth_settings_v2.value, "require_authentication", null)
      unauthenticated_action                  = lookup(auth_settings_v2.value, "unauthenticated_action", null)
      default_provider                        = lookup(auth_settings_v2.value, "default_provider", null)
      excluded_paths                          = lookup(auth_settings_v2.value, "excluded_paths", null)
      require_https                           = lookup(auth_settings_v2.value, "require_https", null)
      http_route_api_prefix                   = lookup(auth_settings_v2.value, "http_route_api_prefix", null)
      forward_proxy_convention                = lookup(auth_settings_v2.value, "forward_proxy_convention", null)
      forward_proxy_custom_host_header_name   = lookup(auth_settings_v2.value, "forward_proxy_custom_host_header_name", null)
      forward_proxy_custom_scheme_header_name = lookup(auth_settings_v2.value, "forward_proxy_custom_scheme_header_name", null)

      dynamic "apple_v2" {
        for_each = lookup(auth_settings_v2.value, "apple_v2", null) != null ? [lookup(auth_settings_v2.value, "apple_v2", null)] : []
        content {
          client_id                  = lookup(apple_v2.value, "client_id", null)
          client_secret_setting_name = lookup(apple_v2.value, "client_secret_setting_name", null)

        }
      }

      dynamic "active_directory_v2" {
        for_each = lookup(auth_settings_v2.value, "active_directory_v2", null) != null ? [lookup(auth_settings_v2.value, "active_directory_v2", null)] : []
        content {
          client_id                            = lookup(active_directory_v2.value, "client_id", null)
          tenant_auth_endpoint                 = lookup(active_directory_v2.value, "tenant_auth_endpoint", null)
          client_secret_setting_name           = lookup(active_directory_v2.value, "client_secret_setting_name", null)
          client_secret_certificate_thumbprint = lookup(active_directory_v2.value, "client_secret_certificate_thumbprint", null)
          jwt_allowed_groups                   = lookup(active_directory_v2.value, "jwt_allowed_groups", null)
          jwt_allowed_client_applications      = lookup(active_directory_v2.value, "jwt_allowed_client_applications", null)
          www_authentication_disabled          = lookup(active_directory_v2.value, "www_authentication_disabled", null)
          allowed_groups                       = lookup(active_directory_v2.value, "allowed_groups", null)
          allowed_identities                   = lookup(active_directory_v2.value, "allowed_identities", null)
          allowed_applications                 = lookup(active_directory_v2.value, "allowed_applications", null)
          login_parameters                     = lookup(active_directory_v2.value, "login_parameters", null)
          allowed_audiences                    = lookup(active_directory_v2.value, "allowed_audiences", null)

        }
      }

      dynamic "azure_static_web_app_v2" {
        for_each = lookup(auth_settings_v2.value, "azure_static_web_app_v2", null) != null ? [lookup(auth_settings_v2.value, "azure_static_web_app_v2", null)] : []
        content {
          client_id = lookup(azure_static_web_app_v2.value, "client_id", null)

        }
      }
      #custom_oidc_v2 = lookup(auth_settings_v2.value, "custom_oidc_v2", null)

      dynamic "facebook_v2" {
        for_each = lookup(auth_settings_v2.value, "facebook_v2", null) != null ? [lookup(auth_settings_v2.value, "facebook_v2", null)] : []
        content {
          app_id                  = lookup(facebook_v2.value, "app_id", null)
          app_secret_setting_name = lookup(facebook_v2.value, "app_secret_setting_name", null)
          graph_api_version       = lookup(facebook_v2.value, "graph_api_version", null)
          login_scopes            = lookup(facebook_v2.value, "login_scopes", null)

        }
      }

      dynamic "github_v2" {
        for_each = lookup(auth_settings_v2.value, "github_v2", null) != null ? [lookup(auth_settings_v2.value, "github_v2", null)] : []
        content {
          client_id                  = lookup(github_v2.value, "client_id", null)
          client_secret_setting_name = lookup(github_v2.value, "client_secret_setting_name", null)
          login_scopes               = lookup(github_v2.value, "login_scopes", null)

        }
      }

      dynamic "google_v2" {
        for_each = lookup(auth_settings_v2.value, "google_v2", null) != null ? [lookup(auth_settings_v2.value, "google_v2", null)] : []
        content {
          client_id                  = lookup(google_v2.value, "client_id", null)
          client_secret_setting_name = lookup(google_v2.value, "client_secret_setting_name", null)
          allowed_audiences          = lookup(google_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(google_v2.value, "login_scopes", null)

        }
      }

      dynamic "microsoft_v2" {
        for_each = lookup(auth_settings_v2.value, "microsoft_v2", null) != null ? [lookup(auth_settings_v2.value, "microsoft_v2", null)] : []
        content {
          client_id                  = lookup(microsoft_v2.value, "client_id", null)
          client_secret_setting_name = lookup(microsoft_v2.value, "client_secret_setting_name", null)
          allowed_audiences          = lookup(microsoft_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(microsoft_v2.value, "login_scopes", null)

        }
      }

      dynamic "twitter_v2" {
        for_each = lookup(auth_settings_v2.value, "twitter_v2", null) != null ? [lookup(auth_settings_v2.value, "twitter_v2", null)] : []
        content {
          consumer_key                 = lookup(twitter_v2.value, "consumer_key", null)
          consumer_secret_setting_name = lookup(twitter_v2.value, "consumer_secret_setting_name", null)

        }
      }

      dynamic "login" {
        for_each = lookup(auth_settings_v2.value, "login", null) != null ? [lookup(auth_settings_v2.value, "login", null)] : []
        content {
          logout_endpoint                   = lookup(login.value, "logout_endpoint", null)
          token_store_enabled               = lookup(login.value, "token_store_enabled", null)
          token_refresh_extension_time      = lookup(login.value, "token_refresh_extension_time", null)
          token_store_path                  = lookup(login.value, "token_store_path", null)
          token_store_sas_setting_name      = lookup(login.value, "token_store_sas_setting_name", null)
          preserve_url_fragments_for_logins = lookup(login.value, "preserve_url_fragments_for_logins", null)
          allowed_external_redirect_urls    = lookup(login.value, "allowed_external_redirect_urls", null)
          cookie_expiration_convention      = lookup(login.value, "cookie_expiration_convention", null)
          cookie_expiration_time            = lookup(login.value, "cookie_expiration_time", null)
          validate_nonce                    = lookup(login.value, "validate_nonce", null)
          nonce_expiration_time             = lookup(login.value, "nonce_expiration_time", null)

        }
      }

    }
  }

  dynamic "backup" {
    for_each = var.backup != null ? [var.backup] : []
    content {
      name = lookup(backup.value, "name", null)

      dynamic "schedule" {
        for_each = lookup(backup.value, "schedule", null) != null ? [lookup(backup.value, "schedule", null)] : []
        content {
          frequency_interval       = lookup(schedule.value, "frequency_interval", null)
          frequency_unit           = lookup(schedule.value, "frequency_unit", null)
          keep_at_least_one_backup = lookup(schedule.value, "keep_at_least_one_backup", null)
          retention_period_days    = lookup(schedule.value, "retention_period_days", null)
          start_time               = lookup(schedule.value, "start_time", null)

        }
      }
      storage_account_url = lookup(backup.value, "storage_account_url", null)
      enabled             = lookup(backup.value, "enabled", null)

    }
  }
  client_affinity_enabled            = var.client_affinity_enabled
  client_certificate_enabled         = var.client_certificate_enabled
  client_certificate_mode            = var.client_certificate_mode
  client_certificate_exclusion_paths = var.client_certificate_exclusion_paths
  #connection_string                  = var.connection_string
  enabled                            = var.enabled
  https_only                         = var.https_only

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)

    }
  }
  key_vault_reference_identity_id = var.key_vault_reference_identity_id

  dynamic "logs" {
    for_each = var.logs != null ? [var.logs] : []
    content {

      dynamic "application_logs" {
        for_each = lookup(logs.value, "application_logs", null) != null ? [lookup(logs.value, "application_logs", null)] : []
        content {

          dynamic "azure_blob_storage" {
            for_each = lookup(application_logs.value, "azure_blob_storage", null) != null ? [lookup(application_logs.value, "azure_blob_storage", null)] : []
            content {
              level             = lookup(azure_blob_storage.value, "level", null)
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days", null)
              sas_url           = lookup(azure_blob_storage.value, "sas_url", null)

            }
          }
          file_system_level = lookup(application_logs.value, "file_system_level", null)

        }
      }
      detailed_error_messages = lookup(logs.value, "detailed_error_messages", null)
      failed_request_tracing  = lookup(logs.value, "failed_request_tracing", null)

      dynamic "http_logs" {
        for_each = lookup(logs.value, "http_logs", null) != null ? [lookup(logs.value, "http_logs", null)] : []
        content {

          dynamic "azure_blob_storage" {
            for_each = lookup(http_logs.value, "azure_blob_storage", null) != null ? [lookup(http_logs.value, "azure_blob_storage", null)] : []
            content {
              #level             = lookup(azure_blob_storage.value, "level", null)
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days", null)
              sas_url           = lookup(azure_blob_storage.value, "sas_url", null)

            }
          }

          dynamic "file_system" {
            for_each = lookup(http_logs.value, "file_system", null) != null ? [lookup(http_logs.value, "file_system", null)] : []
            content {
              retention_in_days = lookup(file_system.value, "retention_in_days", null)
              retention_in_mb   = lookup(file_system.value, "retention_in_mb", null)

            }
          }

        }
      }

    }
  }
  #storage_account = var.storage_account

  dynamic "sticky_settings" {
    for_each = var.sticky_settings != null ? [var.sticky_settings] : []
    content {

    }
  }
  virtual_network_subnet_id = var.virtual_network_subnet_id
  zip_deploy_file           = var.zip_deploy_file
  tags                      = var.tags

}
