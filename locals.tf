resource "random_string" "prefix" {
  count   = try(var.global_settings.prefix, null) == null ? 1 : 0
  length  = 4
  special = false
  upper   = false
  number  = false
}

locals {
  azuread = {
    azuread_api_permissions             = try(var.azuread.azuread_api_permissions, {})
    azuread_applications                = try(var.azuread.azuread_applications, {})
    azuread_apps                        = try(var.azuread.azuread_apps, {})
    azuread_credential_policies         = try(var.azuread.azuread_credential_policies, {})
    azuread_credentials                 = try(var.azuread.azuread_credentials, {})
    azuread_groups                      = try(var.azuread.azuread_groups, {})
    azuread_groups_membership           = try(var.azuread.azuread_groups_membership, {})
    azuread_roles                       = try(var.azuread.azuread_roles, {})
    azuread_service_principal_passwords = try(var.azuread.azuread_service_principal_passwords, {})
    azuread_service_principals          = try(var.azuread.azuread_service_principals, {})
    azuread_users                       = try(var.azuread.azuread_users, {})
  }

  client_config = var.client_config == {} ? {
    client_id               = data.azurerm_client_config.current.client_id
    landingzone_key         = var.current_landingzone_key
    logged_aad_app_objectId = local.object_id
    logged_user_objectId    = local.object_id
    object_id               = local.object_id
    subscription_id         = data.azurerm_client_config.current.subscription_id
    tenant_id               = data.azurerm_client_config.current.tenant_id
  } : map(var.client_config)

  cloud = merge({
    acrLoginServerEndpoint                      = try(var.cloud.acrLoginServerEndpoint, {})
    attestationEndpoint                         = try(var.cloud.attestationEndpoint, {})
    azureDatalakeAnalyticsCatalogAndJobEndpoint = try(var.cloud.azureDatalakeAnalyticsCatalogAndJobEndpoint, {})
    azureDatalakeStoreFileSystemEndpoint        = try(var.cloud.azureDatalakeStoreFileSystemEndpoint, {})
    keyvaultDns                                 = try(var.cloud.keyvaultDns, {})
    mariadbServerEndpoint                       = try(var.cloud.mariadbServerEndpoint, {})
    mhsmDns                                     = try(var.cloud.mhsmDns, {})
    mysqlServerEndpoint                         = try(var.cloud.mysqlServerEndpoint, {})
    postgresqlServerEndpoint                    = try(var.cloud.postgresqlServerEndpoint, {})
    sqlServerHostname                           = try(var.cloud.sqlServerHostname, {})
    storageEndpoint                             = try(var.cloud.storageEndpoint, {})
    storageSyncEndpoint                         = try(var.cloud.storageSyncEndpoint, {})
    synapseAnalyticsEndpoint                    = try(var.cloud.synapseAnalyticsEndpoint, {})
    activeDirectory                             = try(var.cloud.activeDirectory, {})
    activeDirectoryDataLakeResourceId           = try(var.cloud.activeDirectoryDataLakeResourceId, {})
    activeDirectoryGraphResourceId              = try(var.cloud.activeDirectoryGraphResourceId, {})
    activeDirectoryResourceId                   = try(var.cloud.activeDirectoryResourceId, {})
    appInsightsResourceId                       = try(var.cloud.appInsightsResourceId, {})
    appInsightsTelemetryChannelResourceId       = try(var.cloud.appInsightsTelemetryChannelResourceId, {})
    attestationResourceId                       = try(var.cloud.attestationResourceId, {})
    azmirrorStorageAccountResourceId            = try(var.cloud.azmirrorStorageAccountResourceId, {})
    batchResourceId                             = try(var.cloud.batchResourceId, {})
    gallery                                     = try(var.cloud.gallery, {})
    logAnalyticsResourceId                      = try(var.cloud.logAnalyticsResourceId, {})
    management                                  = try(var.cloud.management, {})
    mediaResourceId                             = try(var.cloud.mediaResourceId, {})
    microsoftGraphResourceId                    = try(var.cloud.microsoftGraphResourceId, {})
    ossrdbmsResourceId                          = try(var.cloud.ossrdbmsResourceId, {})
    portal                                      = try(var.cloud.portal, {})
    resourceManager                             = try(var.cloud.resourceManager, {})
    sqlManagement                               = try(var.cloud.sqlManagement, {})
    synapseAnalyticsResourceId                  = try(var.cloud.synapseAnalyticsResourceId, {})
    vmImageAliasDoc                             = try(var.cloud.vmImageAliasDoc, {})
  }, var.cloud)

  compute = {
    aks_clusters                        = try(var.compute.aks_clusters, {})
    availability_sets                   = try(var.compute.availability_sets, {})
    azure_container_registries          = try(var.compute.azure_container_registries, {})
    bastion_hosts                       = try(var.compute.bastion_hosts, {})
    container_groups                    = try(var.compute.container_groups, {})
    dedicated_hosts                     = try(var.compute.dedicated_hosts, {})
    dedicated_host_groups               = try(var.compute.dedicated_host_groups, {})
    machine_learning_compute_instance   = try(var.compute.machine_learning_compute_instance, {})
    proximity_placement_groups          = try(var.compute.proximity_placement_groups, {})
    vmware_clusters                     = try(var.compute.vmware_clusters, {})
    vmware_private_clouds               = try(var.compute.vmware_private_clouds, {})
    vmware_express_route_authorizations = try(var.compute.vmware_express_route_authorizations, {})
    wvd_applications                    = try(var.compute.wvd_applications, {})
    wvd_application_groups              = try(var.compute.wvd_application_groups, {})
    wvd_host_pools                      = try(var.compute.wvd_host_pools, {})
    wvd_workspaces                      = try(var.compute.wvd_workspaces, {})
    virtual_machines                    = try(var.compute.virtual_machines, {})
    virtual_machine_scale_sets          = try(var.compute.virtual_machine_scale_sets, {})
  }

  communication = {
    communication_services = try(var.communication.communication_services, {})
  }

  database = {
    app_config                         = try(var.database.app_config, {})
    azurerm_redis_caches               = try(var.database.azurerm_redis_caches, {})
    cosmos_dbs                         = try(var.database.cosmos_dbs, {})
    database_migration_services        = try(var.database.database_migration_services, {})
    database_migration_projects        = try(var.database.database_migration_projects, {})
    databricks_workspaces              = try(var.database.databricks_workspaces, {})
    machine_learning_workspaces        = try(var.database.machine_learning_workspaces, {})
    mariadb_databases                  = try(var.database.mariadb_databases, {})
    mariadb_servers                    = try(var.database.mariadb_servers, {})
    mssql_databases                    = try(var.database.mssql_databases, {})
    mssql_elastic_pools                = try(var.database.mssql_elastic_pools, {})
    mssql_failover_groups              = try(var.database.mssql_failover_groups, {})
    mssql_managed_databases            = try(var.database.mssql_managed_databases, {})
    mssql_managed_databases_backup_ltr = try(var.database.mssql_managed_databases_backup_ltr, {})
    mssql_managed_databases_restore    = try(var.database.mssql_managed_databases_restore, {})
    mssql_managed_instances            = try(var.database.mssql_managed_instances, {})
    mssql_managed_instances_secondary  = try(var.database.mssql_managed_instances_secondary, {})
    mssql_mi_administrators            = try(var.database.mssql_mi_administrators, {})
    mssql_mi_failover_groups           = try(var.database.mssql_mi_failover_groups, {})
    mssql_mi_secondary_tdes            = try(var.database.mssql_mi_secondary_tdes, {})
    mssql_mi_tdes                      = try(var.database.mssql_mi_tdes, {})
    mssql_servers                      = try(var.database.mssql_servers, {})
    mysql_databases                    = try(var.database.mysql_databases, {})
    mysql_servers                      = try(var.database.mysql_servers, {})
    postgresql_flexible_servers        = try(var.database.postgresql_flexible_servers, {})
    postgresql_servers                 = try(var.database.postgresql_servers, {})
    synapse_workspaces                 = try(var.database.synapse_workspaces, {})
    data_explorer = {
      kusto_clusters                         = try(var.database.data_explorer.kusto_clusters, {})
      kusto_databases                        = try(var.database.data_explorer.kusto_databases, {})
      kusto_attached_database_configurations = try(var.database.data_explorer.kusto_attached_database_configurations, {})
      kusto_cluster_customer_managed_keys    = try(var.database.data_explorer.kusto_cluster_customer_managed_keys, {})
      kusto_cluster_principal_assignments    = try(var.database.data_explorer.kusto_cluster_principal_assignments, {})
      kusto_database_principal_assignments   = try(var.database.data_explorer.kusto_database_principal_assignments, {})
      kusto_eventgrid_data_connections       = try(var.database.data_explorer.kusto_eventgrid_data_connections, {})
      kusto_eventhub_data_connections        = try(var.database.data_explorer.kusto_eventhub_data_connections, {})
      kusto_iothub_data_connections          = try(var.database.data_explorer.kusto_iothub_data_connections, {})
    }
  }

  data_factory = {
    data_factory                                 = try(var.data_factory.data_factory, {})
    data_factory_pipeline                        = try(var.data_factory.data_factory_pipeline, {})
    data_factory_trigger_schedule                = try(var.data_factory.data_factory_trigger_schedule, {})
    data_factory_integration_runtime_azure_ssis  = try(var.data_factory.data_factory_integration_runtime_azure_ssis, {})
    data_factory_integration_runtime_self_hosted = try(var.data_factory.data_factory_integration_runtime_self_hosted, {})
    datasets = {
      azure_blob       = try(var.data_factory.datasets.azure_blob, {})
      cosmosdb_sqlapi  = try(var.data_factory.datasets.cosmosdb_sqlapi, {})
      delimited_text   = try(var.data_factory.datasets.delimited_text, {})
      http             = try(var.data_factory.datasets.http, {})
      json             = try(var.data_factory.datasets.json, {})
      mysql            = try(var.data_factory.datasets.mysql, {})
      postgresql       = try(var.data_factory.datasets.postgresql, {})
      sql_server_table = try(var.data_factory.datasets.sql_server_table, {})
    }
    linked_services = {
      azure_blob_storage = try(var.data_factory.linked_services.azure_blob_storage, {})
      azure_databricks   = try(var.data_factory.linked_services.azure_databricks, {})
      cosmosdb           = try(var.data_factory.linked_services.cosmosdb, {})
      key_vault          = try(var.data_factory.linked_services.key_vault, {})
      mysql              = try(var.data_factory.linked_services.mysql, {})
      postgresql         = try(var.data_factory.linked_services.postgresql, {})
      sql_server         = try(var.data_factory.linked_services.sql_server, {})
      web                = try(var.data_factory.linked_services.web, {})
    }
  }

  dynamic_app_settings_combined_objects = {
    app_config                  = local.combined_objects_app_config
    azure_container_registries  = local.combined_objects_azure_container_registries
    client_config               = tomap({ (local.client_config.landingzone_key) = { config = local.client_config } })
    keyvaults                   = local.combined_objects_keyvaults
    machine_learning_workspaces = local.combined_objects_machine_learning
    managed_identities          = local.combined_objects_managed_identities
    mssql_databases             = local.combined_objects_mssql_databases
    mssql_servers               = local.combined_objects_mssql_servers
    storage_accounts            = local.combined_objects_storage_accounts
  }

  dynamic_app_config_combined_objects = {
    azure_container_registries   = local.combined_objects_azure_container_registries
    azurerm_application_insights = tomap({ (local.client_config.landingzone_key) = module.azurerm_application_insights })
    client_config                = tomap({ (local.client_config.landingzone_key) = { config = local.client_config } })
    keyvaults                    = local.combined_objects_keyvaults
    logic_app_workflow           = local.combined_objects_logic_app_workflow
    machine_learning_workspaces  = local.combined_objects_machine_learning
    managed_identities           = local.combined_objects_managed_identities
    resource_groups              = local.combined_objects_resource_groups
    storage_accounts             = local.combined_objects_storage_accounts
  }

  global_settings = merge({
    default_region     = try(var.global_settings.default_region, "region1")
    environment        = try(var.global_settings.environment, var.environment)
    inherit_tags       = try(var.global_settings.inherit_tags, false)
    passthrough        = try(var.global_settings.passthrough, false)
    prefix             = try(var.global_settings.prefix, null)
    prefix_with_hyphen = try(var.global_settings.prefix_with_hyphen, format("%s-", try(var.global_settings.prefix, try(var.global_settings.prefixes[0], random_string.prefix.0.result))))
    prefixes           = try(var.global_settings.prefix, null) == "" ? null : try([var.global_settings.prefix], try(var.global_settings.prefixes, [random_string.prefix.0.result]))
    random_length      = try(var.global_settings.random_length, 0)
    regions            = try(var.global_settings.regions, null)
    tags               = try(var.global_settings.tags, null)
    use_slug           = try(var.global_settings.use_slug, true)
  }, var.global_settings)

  logic_app = {
    integration_service_environment = try(var.logic_app.integration_service_environment, {})
    logic_app_action_custom         = try(var.logic_app.logic_app_action_custom, {})
    logic_app_action_http           = try(var.logic_app.logic_app_action_http, {})
    logic_app_integration_account   = try(var.logic_app.logic_app_integration_account, {})
    logic_app_trigger_custom        = try(var.logic_app.logic_app_trigger_custom, {})
    logic_app_trigger_http_request  = try(var.logic_app.logic_app_trigger_http_request, {})
    logic_app_trigger_recurrence    = try(var.logic_app.logic_app_trigger_recurrence, {})
    logic_app_workflow              = try(var.logic_app.logic_app_workflow, {})
  }

  cognitive_services = {
    cognitive_services_account = try(var.cognitive_services.cognitive_services_account, {})
  }
  messaging = {
    signalr_services      = try(var.messaging.signalr_services, {})
    servicebus_namespaces = try(var.messaging.servicebus_namespaces, {})
    servicebus_queues     = try(var.messaging.servicebus_queues, {})
    servicebus_topics     = try(var.messaging.servicebus_topics, {})
  }

  networking = {
    application_gateway_applications                        = try(var.networking.application_gateway_applications, {})
    application_gateway_applications_v1                     = try(var.networking.application_gateway_applications_v1, {})
    application_gateway_platforms                           = try(var.networking.application_gateway_platforms, {})
    application_gateway_waf_policies                        = try(var.networking.application_gateway_waf_policies, {})
    application_gateways                                    = try(var.networking.application_gateways, {})
    application_security_groups                             = try(var.networking.application_security_groups, {})
    azurerm_firewall_application_rule_collection_definition = try(var.networking.azurerm_firewall_application_rule_collection_definition, {})
    azurerm_firewall_nat_rule_collection_definition         = try(var.networking.azurerm_firewall_nat_rule_collection_definition, {})
    azurerm_firewall_network_rule_collection_definition     = try(var.networking.azurerm_firewall_network_rule_collection_definition, {})
    azurerm_firewall_policies                               = try(var.networking.azurerm_firewall_policies, {})
    azurerm_firewall_policy_rule_collection_groups          = try(var.networking.azurerm_firewall_policy_rule_collection_groups, {})
    azurerm_firewalls                                       = try(var.networking.azurerm_firewalls, {})
    azurerm_routes                                          = try(var.networking.azurerm_routes, {})
    cdn_profile                                             = try(var.networking.cdn_profile, {})
    cdn_endpoint                                            = try(var.networking.cdn_endpoint, {})
    ddos_services                                           = try(var.networking.ddos_services, {})
    dns_zone_records                                        = try(var.networking.dns_zone_records, {})
    dns_zones                                               = try(var.networking.dns_zones, {})
    domain_name_registrations                               = try(var.networking.domain_name_registrations, {})
    express_route_circuit_authorizations                    = try(var.networking.express_route_circuit_authorizations, {})
    express_route_circuit_peerings                          = try(var.networking.express_route_circuit_peerings, {})
    express_route_circuits                                  = try(var.networking.express_route_circuits, {})
    express_route_connections                               = try(var.networking.express_route_connections, {})
    front_door_waf_policies                                 = try(var.networking.front_door_waf_policies, {})
    front_doors                                             = try(var.networking.front_doors, {})
    frontdoor_rules_engine                                  = try(var.networking.frontdoor_rules_engine, {})
    frontdoor_custom_https_configuration                    = try(var.networking.frontdoor_custom_https_configuration, {})
    ip_groups                                               = try(var.networking.ip_groups, {})
    lb                                                      = try(var.networking.lb, {})
    lb_backend_address_pool                                 = try(var.networking.lb_backend_address_pool, {})
    lb_backend_address_pool_address                         = try(var.networking.lb_backend_address_pool_address, {})
    lb_nat_pool                                             = try(var.networking.lb_nat_pool, {})
    lb_nat_rule                                             = try(var.networking.lb_nat_rule, {})
    lb_outbound_rule                                        = try(var.networking.lb_outbound_rule, {})
    lb_probe                                                = try(var.networking.lb_probe, {})
    lb_rule                                                 = try(var.networking.lb_rule, {})
    load_balancers                                          = try(var.networking.load_balancers, {})
    local_network_gateways                                  = try(var.networking.local_network_gateways, {})
    nat_gateways                                            = try(var.networking.nat_gateways, {})
    network_interface_backend_address_pool_association      = try(var.networking.network_interface_backend_address_pool_association, {})
    network_security_group_definition                       = try(var.networking.network_security_group_definition, {})
    network_watchers                                        = try(var.networking.network_watchers, {})
    private_dns                                             = try(var.networking.private_dns, {})
    private_dns_vnet_links                                  = try(var.networking.private_dns_vnet_links, {})
    public_ip_addresses                                     = try(var.networking.public_ip_addresses, {})
    route_tables                                            = try(var.networking.route_tables, {})
    vhub_peerings                                           = try(var.networking.vhub_peerings, {})
    virtual_hub_connections                                 = try(var.networking.virtual_hub_connections, {})
    virtual_hub_er_gateway_connections                      = try(var.networking.virtual_hub_er_gateway_connections, {})
    virtual_hub_route_tables                                = try(var.networking.virtual_hub_route_tables, {})
    virtual_hubs                                            = try(var.networking.virtual_hubs, {})
    virtual_network_gateway_connections                     = try(var.networking.virtual_network_gateway_connections, {})
    virtual_network_gateways                                = try(var.networking.virtual_network_gateways, {})
    virtual_wans                                            = try(var.networking.virtual_wans, {})
    vnet_peerings                                           = try(var.networking.vnet_peerings, {})
    vnets                                                   = try(var.networking.vnets, {})
    virtual_subnets                                         = try(var.networking.virtual_subnets, {})
    vpn_gateway_connections                                 = try(var.networking.vpn_gateway_connections, {})
    vpn_sites                                               = try(var.networking.vpn_sites, {})
  }

  object_id = coalesce(var.logged_user_objectId, var.logged_aad_app_objectId, try(data.azurerm_client_config.current.object_id, null), try(data.azuread_service_principal.logged_in_app.0.object_id, null))

  security = {
    disk_encryption_sets          = try(var.security.disk_encryption_sets, {})
    dynamic_keyvault_secrets      = try(var.security.dynamic_keyvault_secrets, {})
    keyvault_certificate_issuers  = try(var.security.keyvault_certificate_issuers, {})
    keyvault_certificate_requests = try(var.security.keyvault_certificate_requests, {})
    keyvault_certificates         = try(var.security.keyvault_certificates, {})
    keyvault_keys                 = try(var.security.keyvault_keys, {})
    lighthouse_definitions        = try(var.security.lighthouse_definitions, {})
  }

  shared_services = {
    automations                = try(var.shared_services.automations, {})
    consumption_budgets        = try(var.shared_services.consumption_budgets, {})
    image_definitions          = try(var.shared_services.image_definitions, {})
    monitor_autoscale_settings = try(var.shared_services.monitor_autoscale_settings, {})
    monitor_action_groups      = try(var.shared_services.monitor_action_groups, {})
    monitoring                 = try(var.shared_services.monitoring, {})
    monitor_metric_alert       = try(var.shared_services.monitor_metric_alert, {})
    monitor_activity_log_alert = try(var.shared_services.monitor_activity_log_alert, {})
    packer_managed_identity    = try(var.shared_services.packer_managed_identity, {})
    packer_service_principal   = try(var.shared_services.packer_service_principal, {})
    recovery_vaults            = try(var.shared_services.recovery_vaults, {})
    shared_image_galleries     = try(var.shared_services.shared_image_galleries, {})
  }

  storage = {
    netapp_accounts        = try(var.storage.netapp_accounts, {})
    storage_account_blobs  = try(var.storage.storage_account_blobs, {})
    storage_account_queues = try(var.storage.storage_account_queues, {})
    storage_containers     = try(var.storage.storage_containers, {})
  }

  webapp = {
    app_service_environments     = try(var.webapp.app_service_environments, {})
    app_service_plans            = try(var.webapp.app_service_plans, {})
    app_services                 = try(var.webapp.app_services, {})
    azurerm_application_insights = try(var.webapp.azurerm_application_insights, {})
    function_apps                = try(var.webapp.function_apps, {})
  }

  enable = {
    bastion_hosts    = try(var.enable.bastion_hosts, true)
    virtual_machines = try(var.enable.virtual_machines, true)
  }

  identity = {
    active_directory_domain_service             = try(var.identity.active_directory_domain_service, {})
    active_directory_domain_service_replica_set = try(var.identity.active_directory_domain_service_replica_set, {})
  }
  apim = {
    api_management                      = try(var.apim.api_management, {})
    api_management_api                  = try(var.apim.api_management_api, {})
    api_management_api_diagnostic       = try(var.apim.api_management_api_diagnostic, {})
    api_management_logger               = try(var.apim.api_management_logger, {})
    api_management_api_operation        = try(var.apim.api_management_api_operation, {})
    api_management_backend              = try(var.apim.api_management_backend, {})
    api_management_api_policy           = try(var.apim.api_management_api_policy, {})
    api_management_api_operation_tag    = try(var.apim.api_management_api_operation_tag, {})
    api_management_api_operation_policy = try(var.apim.api_management_api_operation_policy, {})
    api_management_user                 = try(var.apim.api_management_user, {})
    api_management_custom_domain        = try(var.apim.api_management_custom_domain, {})
    api_management_diagnostic           = try(var.apim.api_management_diagnostic, {})
    api_management_certificate          = try(var.apim.api_management_certificate, {})
    api_management_gateway              = try(var.apim.api_management_gateway, {})
    api_management_gateway_api          = try(var.apim.api_management_gateway_api, {})
    api_management_group                = try(var.apim.api_management_group, {})
  }
}
