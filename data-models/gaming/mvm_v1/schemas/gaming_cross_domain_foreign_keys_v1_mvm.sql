-- Cross-Domain Foreign Keys for Business: Gaming | Version: v1_mvm
-- Generated on: 2026-05-08 09:46:28
-- Total cross-domain FK constraints: 1399
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: analytics, billing, community, compliance, content, esports, infrastructure, licensing, marketing, monetization, platform, player, studio, title

-- ========= analytics --> billing (7 constraint(s)) =========
-- Requires: analytics schema, billing schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= analytics --> community (5 constraint(s)) =========
-- Requires: analytics schema, community schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_forum_thread_id` FOREIGN KEY (`forum_thread_id`) REFERENCES `gaming_ecm`.`community`.`forum_thread`(`forum_thread_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_ugc_submission_id` FOREIGN KEY (`ugc_submission_id`) REFERENCES `gaming_ecm`.`community`.`ugc_submission`(`ugc_submission_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `gaming_ecm`.`community`.`forum`(`forum_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);

-- ========= analytics --> compliance (21 constraint(s)) =========
-- Requires: analytics schema, compliance schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);

-- ========= analytics --> content (24 constraint(s)) =========
-- Requires: analytics schema, content schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_content_deployment_id` FOREIGN KEY (`content_deployment_id`) REFERENCES `gaming_ecm`.`content`.`content_deployment`(`content_deployment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_npc_definition_id` FOREIGN KEY (`npc_definition_id`) REFERENCES `gaming_ecm`.`content`.`npc_definition`(`npc_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_npc_definition_id` FOREIGN KEY (`npc_definition_id`) REFERENCES `gaming_ecm`.`content`.`npc_definition`(`npc_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_npc_definition_id` FOREIGN KEY (`npc_definition_id`) REFERENCES `gaming_ecm`.`content`.`npc_definition`(`npc_definition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);

-- ========= analytics --> esports (8 constraint(s)) =========
-- Requires: analytics schema, esports schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);

-- ========= analytics --> infrastructure (21 constraint(s)) =========
-- Requires: analytics schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_maintenance_window_id` FOREIGN KEY (`maintenance_window_id`) REFERENCES `gaming_ecm`.`infrastructure`.`maintenance_window`(`maintenance_window_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_server_session_id` FOREIGN KEY (`server_session_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_session`(`server_session_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);

-- ========= analytics --> licensing (6 constraint(s)) =========
-- Requires: analytics schema, licensing schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);

-- ========= analytics --> marketing (2 constraint(s)) =========
-- Requires: analytics schema, marketing schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_retention_cohort_id` FOREIGN KEY (`retention_cohort_id`) REFERENCES `gaming_ecm`.`marketing`.`retention_cohort`(`retention_cohort_id`);

-- ========= analytics --> platform (21 constraint(s)) =========
-- Requires: analytics schema, platform schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_cert_submission_id` FOREIGN KEY (`cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`cert_submission`(`cert_submission_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_release_schedule_id` FOREIGN KEY (`release_schedule_id`) REFERENCES `gaming_ecm`.`platform`.`release_schedule`(`release_schedule_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= analytics --> player (4 constraint(s)) =========
-- Requires: analytics schema, player schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= analytics --> studio (14 constraint(s)) =========
-- Requires: analytics schema, studio schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);

-- ========= analytics --> title (32 constraint(s)) =========
-- Requires: analytics schema, title schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_leaderboard_id` FOREIGN KEY (`leaderboard_id`) REFERENCES `gaming_ecm`.`title`.`leaderboard`(`leaderboard_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_playable_character_id` FOREIGN KEY (`playable_character_id`) REFERENCES `gaming_ecm`.`title`.`playable_character`(`playable_character_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_leaderboard_id` FOREIGN KEY (`leaderboard_id`) REFERENCES `gaming_ecm`.`title`.`leaderboard`(`leaderboard_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_playable_character_id` FOREIGN KEY (`playable_character_id`) REFERENCES `gaming_ecm`.`title`.`playable_character`(`playable_character_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_playable_character_id` FOREIGN KEY (`playable_character_id`) REFERENCES `gaming_ecm`.`title`.`playable_character`(`playable_character_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `gaming_ecm`.`title`.`franchise`(`franchise_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `gaming_ecm`.`title`.`franchise`(`franchise_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);

-- ========= billing --> analytics (2 constraint(s)) =========
-- Requires: billing schema, analytics schema
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);

-- ========= billing --> community (1 constraint(s)) =========
-- Requires: billing schema, community schema
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);

-- ========= billing --> compliance (41 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `gaming_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `gaming_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `gaming_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `gaming_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= billing --> content (5 constraint(s)) =========
-- Requires: billing schema, content schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);

-- ========= billing --> esports (3 constraint(s)) =========
-- Requires: billing schema, esports schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `gaming_ecm`.`esports`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);

-- ========= billing --> infrastructure (1 constraint(s)) =========
-- Requires: billing schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);

-- ========= billing --> licensing (16 constraint(s)) =========
-- Requires: billing schema, licensing schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_virtual_currency_account_id` FOREIGN KEY (`virtual_currency_account_id`) REFERENCES `gaming_ecm`.`licensing`.`virtual_currency_account`(`virtual_currency_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_virtual_currency_ledger_id` FOREIGN KEY (`virtual_currency_ledger_id`) REFERENCES `gaming_ecm`.`licensing`.`virtual_currency_ledger`(`virtual_currency_ledger_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_virtual_currency_ledger_id` FOREIGN KEY (`virtual_currency_ledger_id`) REFERENCES `gaming_ecm`.`licensing`.`virtual_currency_ledger`(`virtual_currency_ledger_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);

-- ========= billing --> marketing (2 constraint(s)) =========
-- Requires: billing schema, marketing schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= billing --> monetization (5 constraint(s)) =========
-- Requires: billing schema, monetization schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_storefront_item_id` FOREIGN KEY (`storefront_item_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_item`(`storefront_item_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `gaming_ecm`.`monetization`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_price_point_id` FOREIGN KEY (`price_point_id`) REFERENCES `gaming_ecm`.`monetization`.`price_point`(`price_point_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_price_point_id` FOREIGN KEY (`price_point_id`) REFERENCES `gaming_ecm`.`monetization`.`price_point`(`price_point_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_storefront_item_id` FOREIGN KEY (`storefront_item_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_item`(`storefront_item_id`);

-- ========= billing --> platform (14 constraint(s)) =========
-- Requires: billing schema, platform schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= billing --> player (5 constraint(s)) =========
-- Requires: billing schema, player schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= billing --> studio (13 constraint(s)) =========
-- Requires: billing schema, studio schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);

-- ========= billing --> title (8 constraint(s)) =========
-- Requires: billing schema, title schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_game_edition_id` FOREIGN KEY (`game_edition_id`) REFERENCES `gaming_ecm`.`title`.`game_edition`(`game_edition_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= community --> analytics (4 constraint(s)) =========
-- Requires: community schema, analytics schema
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);

-- ========= community --> billing (10 constraint(s)) =========
-- Requires: community schema, billing schema
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `gaming_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_storefront_order_line_id` FOREIGN KEY (`storefront_order_line_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order_line`(`storefront_order_line_id`);
ALTER TABLE `gaming_ecm`.`community`.`guild` ADD CONSTRAINT `fk_community_guild_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `gaming_ecm`.`billing`.`refund`(`refund_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `gaming_ecm`.`billing`.`chargeback`(`chargeback_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `gaming_ecm`.`billing`.`refund`(`refund_id`);

-- ========= community --> compliance (16 constraint(s)) =========
-- Requires: community schema, compliance schema
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ADD CONSTRAINT `fk_community_guild_membership_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `gaming_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ADD CONSTRAINT `fk_community_social_connection_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= community --> content (13 constraint(s)) =========
-- Requires: community schema, content schema
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);

-- ========= community --> esports (11 constraint(s)) =========
-- Requires: community schema, esports schema
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);

-- ========= community --> infrastructure (11 constraint(s)) =========
-- Requires: community schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_server_session_id` FOREIGN KEY (`server_session_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_session`(`server_session_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_server_session_id` FOREIGN KEY (`server_session_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_session`(`server_session_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_server_session_id` FOREIGN KEY (`server_session_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_session`(`server_session_id`);

-- ========= community --> licensing (37 constraint(s)) =========
-- Requires: community schema, licensing schema
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_battle_pass_entitlement_id` FOREIGN KEY (`battle_pass_entitlement_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass_entitlement`(`battle_pass_entitlement_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_gacha_pool_id` FOREIGN KEY (`gacha_pool_id`) REFERENCES `gaming_ecm`.`licensing`.`gacha_pool`(`gacha_pool_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_virtual_currency_account_id` FOREIGN KEY (`virtual_currency_account_id`) REFERENCES `gaming_ecm`.`licensing`.`virtual_currency_account`(`virtual_currency_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_gacha_pool_id` FOREIGN KEY (`gacha_pool_id`) REFERENCES `gaming_ecm`.`licensing`.`gacha_pool`(`gacha_pool_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_virtual_currency_ledger_id` FOREIGN KEY (`virtual_currency_ledger_id`) REFERENCES `gaming_ecm`.`licensing`.`virtual_currency_ledger`(`virtual_currency_ledger_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_gacha_pool_id` FOREIGN KEY (`gacha_pool_id`) REFERENCES `gaming_ecm`.`licensing`.`gacha_pool`(`gacha_pool_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_virtual_currency_ledger_id` FOREIGN KEY (`virtual_currency_ledger_id`) REFERENCES `gaming_ecm`.`licensing`.`virtual_currency_ledger`(`virtual_currency_ledger_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_gacha_pool_id` FOREIGN KEY (`gacha_pool_id`) REFERENCES `gaming_ecm`.`licensing`.`gacha_pool`(`gacha_pool_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_battle_pass_entitlement_id` FOREIGN KEY (`battle_pass_entitlement_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass_entitlement`(`battle_pass_entitlement_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);

-- ========= community --> marketing (16 constraint(s)) =========
-- Requires: community schema, marketing schema
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `gaming_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `gaming_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_launch_event_id` FOREIGN KEY (`launch_event_id`) REFERENCES `gaming_ecm`.`marketing`.`launch_event`(`launch_event_id`);
ALTER TABLE `gaming_ecm`.`community`.`guild` ADD CONSTRAINT `fk_community_guild_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_launch_event_id` FOREIGN KEY (`launch_event_id`) REFERENCES `gaming_ecm`.`marketing`.`launch_event`(`launch_event_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_launch_event_id` FOREIGN KEY (`launch_event_id`) REFERENCES `gaming_ecm`.`marketing`.`launch_event`(`launch_event_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `gaming_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ADD CONSTRAINT `fk_community_social_connection_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= community --> monetization (9 constraint(s)) =========
-- Requires: community schema, monetization schema
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `gaming_ecm`.`monetization`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_storefront_item_id` FOREIGN KEY (`storefront_item_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_item`(`storefront_item_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_dlc_entitlement_id` FOREIGN KEY (`dlc_entitlement_id`) REFERENCES `gaming_ecm`.`monetization`.`dlc_entitlement`(`dlc_entitlement_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_storefront_transaction_id` FOREIGN KEY (`storefront_transaction_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_transaction`(`storefront_transaction_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_storefront_item_id` FOREIGN KEY (`storefront_item_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_item`(`storefront_item_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `gaming_ecm`.`monetization`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_ad_placement_id` FOREIGN KEY (`ad_placement_id`) REFERENCES `gaming_ecm`.`monetization`.`ad_placement`(`ad_placement_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_ad_impression_id` FOREIGN KEY (`ad_impression_id`) REFERENCES `gaming_ecm`.`monetization`.`ad_impression`(`ad_impression_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_storefront_transaction_id` FOREIGN KEY (`storefront_transaction_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_transaction`(`storefront_transaction_id`);

-- ========= community --> platform (24 constraint(s)) =========
-- Requires: community schema, platform schema
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `gaming_ecm`.`platform`.`pricing`(`pricing_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_release_schedule_id` FOREIGN KEY (`release_schedule_id`) REFERENCES `gaming_ecm`.`platform`.`release_schedule`(`release_schedule_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= community --> player (15 constraint(s)) =========
-- Requires: community schema, player schema
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ADD CONSTRAINT `fk_community_guild_membership_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ADD CONSTRAINT `fk_community_social_connection_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ADD CONSTRAINT `fk_community_social_connection_target_player_player_account_id` FOREIGN KEY (`target_player_player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_ban_record_id` FOREIGN KEY (`ban_record_id`) REFERENCES `gaming_ecm`.`player`.`ban_record`(`ban_record_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= community --> studio (17 constraint(s)) =========
-- Requires: community schema, studio schema
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_backlog_item_id` FOREIGN KEY (`backlog_item_id`) REFERENCES `gaming_ecm`.`studio`.`backlog_item`(`backlog_item_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_backlog_item_id` FOREIGN KEY (`backlog_item_id`) REFERENCES `gaming_ecm`.`studio`.`backlog_item`(`backlog_item_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_backlog_item_id` FOREIGN KEY (`backlog_item_id`) REFERENCES `gaming_ecm`.`studio`.`backlog_item`(`backlog_item_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);

-- ========= community --> title (35 constraint(s)) =========
-- Requires: community schema, title schema
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_playable_character_id` FOREIGN KEY (`playable_character_id`) REFERENCES `gaming_ecm`.`title`.`playable_character`(`playable_character_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`community`.`guild` ADD CONSTRAINT `fk_community_guild_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_title_release_id` FOREIGN KEY (`title_release_id`) REFERENCES `gaming_ecm`.`title`.`title_release`(`title_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_leaderboard_id` FOREIGN KEY (`leaderboard_id`) REFERENCES `gaming_ecm`.`title`.`leaderboard`(`leaderboard_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_leaderboard_id` FOREIGN KEY (`leaderboard_id`) REFERENCES `gaming_ecm`.`title`.`leaderboard`(`leaderboard_id`);
ALTER TABLE `gaming_ecm`.`community`.`event` ADD CONSTRAINT `fk_community_event_playable_character_id` FOREIGN KEY (`playable_character_id`) REFERENCES `gaming_ecm`.`title`.`playable_character`(`playable_character_id`);
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ADD CONSTRAINT `fk_community_social_connection_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);

-- ========= compliance --> licensing (5 constraint(s)) =========
-- Requires: compliance schema, licensing schema
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);

-- ========= compliance --> platform (1 constraint(s)) =========
-- Requires: compliance schema, platform schema
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= compliance --> player (4 constraint(s)) =========
-- Requires: compliance schema, player schema
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= compliance --> studio (1 constraint(s)) =========
-- Requires: compliance schema, studio schema
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);

-- ========= compliance --> title (12 constraint(s)) =========
-- Requires: compliance schema, title schema
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ADD CONSTRAINT `fk_compliance_age_rating_cert_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_title_release_id` FOREIGN KEY (`title_release_id`) REFERENCES `gaming_ecm`.`title`.`title_release`(`title_release_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= content --> compliance (16 constraint(s)) =========
-- Requires: content schema, compliance schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ADD CONSTRAINT `fk_content_localization_string_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ADD CONSTRAINT `fk_content_localization_string_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ADD CONSTRAINT `fk_content_localization_translation_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ADD CONSTRAINT `fk_content_localization_translation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_loot_box_disclosure_id` FOREIGN KEY (`loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= content --> esports (1 constraint(s)) =========
-- Requires: content schema, esports schema
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);

-- ========= content --> infrastructure (11 constraint(s)) =========
-- Requires: content schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);

-- ========= content --> licensing (5 constraint(s)) =========
-- Requires: content schema, licensing schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`content`.`level_map` ADD CONSTRAINT `fk_content_level_map_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ADD CONSTRAINT `fk_content_npc_definition_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `gaming_ecm`.`licensing`.`compliance_obligation`(`compliance_obligation_id`);

-- ========= content --> marketing (1 constraint(s)) =========
-- Requires: content schema, marketing schema
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= content --> platform (5 constraint(s)) =========
-- Requires: content schema, platform schema
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= content --> studio (9 constraint(s)) =========
-- Requires: content schema, studio schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_repo_id` FOREIGN KEY (`repo_id`) REFERENCES `gaming_ecm`.`studio`.`repo`(`repo_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_repo_id` FOREIGN KEY (`repo_id`) REFERENCES `gaming_ecm`.`studio`.`repo`(`repo_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ADD CONSTRAINT `fk_content_npc_definition_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ADD CONSTRAINT `fk_content_npc_definition_repo_id` FOREIGN KEY (`repo_id`) REFERENCES `gaming_ecm`.`studio`.`repo`(`repo_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);

-- ========= content --> title (10 constraint(s)) =========
-- Requires: content schema, title schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ADD CONSTRAINT `fk_content_localization_string_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ADD CONSTRAINT `fk_content_npc_definition_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= esports --> billing (6 constraint(s)) =========
-- Requires: esports schema, billing schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);

-- ========= esports --> community (3 constraint(s)) =========
-- Requires: esports schema, community schema
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_event_id` FOREIGN KEY (`event_id`) REFERENCES `gaming_ecm`.`community`.`event`(`event_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `gaming_ecm`.`community`.`forum`(`forum_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `gaming_ecm`.`community`.`forum`(`forum_id`);

-- ========= esports --> compliance (23 constraint(s)) =========
-- Requires: esports schema, compliance schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`esports`.`venue` ADD CONSTRAINT `fk_esports_venue_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`venue` ADD CONSTRAINT `fk_esports_venue_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= esports --> content (10 constraint(s)) =========
-- Requires: esports schema, content schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);

-- ========= esports --> infrastructure (13 constraint(s)) =========
-- Requires: esports schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_server_session_id` FOREIGN KEY (`server_session_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_session`(`server_session_id`);
ALTER TABLE `gaming_ecm`.`esports`.`venue` ADD CONSTRAINT `fk_esports_venue_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);

-- ========= esports --> licensing (4 constraint(s)) =========
-- Requires: esports schema, licensing schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);

-- ========= esports --> marketing (2 constraint(s)) =========
-- Requires: esports schema, marketing schema
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= esports --> monetization (1 constraint(s)) =========
-- Requires: esports schema, monetization schema
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `gaming_ecm`.`monetization`.`subscription_plan`(`subscription_plan_id`);

-- ========= esports --> platform (11 constraint(s)) =========
-- Requires: esports schema, platform schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_cert_submission_id` FOREIGN KEY (`cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`cert_submission`(`cert_submission_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_storefront_listing_id` FOREIGN KEY (`storefront_listing_id`) REFERENCES `gaming_ecm`.`platform`.`storefront_listing`(`storefront_listing_id`);

-- ========= esports --> player (4 constraint(s)) =========
-- Requires: esports schema, player schema
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= esports --> studio (1 constraint(s)) =========
-- Requires: esports schema, studio schema
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);

-- ========= esports --> title (18 constraint(s)) =========
-- Requires: esports schema, title schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `gaming_ecm`.`title`.`franchise`(`franchise_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`standing` ADD CONSTRAINT `fk_esports_standing_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= infrastructure --> analytics (6 constraint(s)) =========
-- Requires: infrastructure schema, analytics schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ADD CONSTRAINT `fk_infrastructure_matchmaking_pool_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ADD CONSTRAINT `fk_infrastructure_maintenance_window_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);

-- ========= infrastructure --> billing (1 constraint(s)) =========
-- Requires: infrastructure schema, billing schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);

-- ========= infrastructure --> community (2 constraint(s)) =========
-- Requires: infrastructure schema, community schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_event_id` FOREIGN KEY (`event_id`) REFERENCES `gaming_ecm`.`community`.`event`(`event_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);

-- ========= infrastructure --> compliance (8 constraint(s)) =========
-- Requires: infrastructure schema, compliance schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ADD CONSTRAINT `fk_infrastructure_game_server_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ADD CONSTRAINT `fk_infrastructure_server_fleet_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ADD CONSTRAINT `fk_infrastructure_cdn_node_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ADD CONSTRAINT `fk_infrastructure_matchmaking_pool_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ADD CONSTRAINT `fk_infrastructure_network_region_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= infrastructure --> esports (3 constraint(s)) =========
-- Requires: infrastructure schema, esports schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ADD CONSTRAINT `fk_infrastructure_maintenance_window_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);

-- ========= infrastructure --> platform (1 constraint(s)) =========
-- Requires: infrastructure schema, platform schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= infrastructure --> player (1 constraint(s)) =========
-- Requires: infrastructure schema, player schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ADD CONSTRAINT `fk_infrastructure_matchmaking_ticket_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= infrastructure --> title (22 constraint(s)) =========
-- Requires: infrastructure schema, title schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ADD CONSTRAINT `fk_infrastructure_game_server_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ADD CONSTRAINT `fk_infrastructure_game_server_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ADD CONSTRAINT `fk_infrastructure_game_server_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ADD CONSTRAINT `fk_infrastructure_server_fleet_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ADD CONSTRAINT `fk_infrastructure_matchmaking_pool_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ADD CONSTRAINT `fk_infrastructure_matchmaking_pool_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ADD CONSTRAINT `fk_infrastructure_matchmaking_pool_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_title_release_id` FOREIGN KEY (`title_release_id`) REFERENCES `gaming_ecm`.`title`.`title_release`(`title_release_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_leaderboard_id` FOREIGN KEY (`leaderboard_id`) REFERENCES `gaming_ecm`.`title`.`leaderboard`(`leaderboard_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_title_release_id` FOREIGN KEY (`title_release_id`) REFERENCES `gaming_ecm`.`title`.`title_release`(`title_release_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ADD CONSTRAINT `fk_infrastructure_matchmaking_ticket_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ADD CONSTRAINT `fk_infrastructure_matchmaking_ticket_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ADD CONSTRAINT `fk_infrastructure_matchmaking_ticket_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);

-- ========= licensing --> analytics (9 constraint(s)) =========
-- Requires: licensing schema, analytics schema
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ADD CONSTRAINT `fk_licensing_virtual_currency_account_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_experiment_assignment_id` FOREIGN KEY (`experiment_assignment_id`) REFERENCES `gaming_ecm`.`analytics`.`experiment_assignment`(`experiment_assignment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_funnel_definition_id` FOREIGN KEY (`funnel_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_definition`(`funnel_definition_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);

-- ========= licensing --> billing (5 constraint(s)) =========
-- Requires: licensing schema, billing schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ADD CONSTRAINT `fk_licensing_virtual_currency_account_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= licensing --> compliance (13 constraint(s)) =========
-- Requires: licensing schema, compliance schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ADD CONSTRAINT `fk_licensing_virtual_currency_account_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ADD CONSTRAINT `fk_licensing_ip_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ADD CONSTRAINT `fk_licensing_ip_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ADD CONSTRAINT `fk_licensing_licensee_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);

-- ========= licensing --> content (27 constraint(s)) =========
-- Requires: licensing schema, content schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);

-- ========= licensing --> esports (8 constraint(s)) =========
-- Requires: licensing schema, esports schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);

-- ========= licensing --> infrastructure (10 constraint(s)) =========
-- Requires: licensing schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);

-- ========= licensing --> marketing (2 constraint(s)) =========
-- Requires: licensing schema, marketing schema
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= licensing --> platform (3 constraint(s)) =========
-- Requires: licensing schema, platform schema
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ADD CONSTRAINT `fk_licensing_virtual_currency_account_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= licensing --> player (5 constraint(s)) =========
-- Requires: licensing schema, player schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= licensing --> studio (16 constraint(s)) =========
-- Requires: licensing schema, studio schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);

-- ========= licensing --> title (31 constraint(s)) =========
-- Requires: licensing schema, title schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ADD CONSTRAINT `fk_licensing_virtual_currency_account_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ADD CONSTRAINT `fk_licensing_ip_agreement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ADD CONSTRAINT `fk_licensing_licensed_ip_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `gaming_ecm`.`title`.`franchise`(`franchise_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= marketing --> analytics (10 constraint(s)) =========
-- Requires: marketing schema, analytics schema
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_telemetry_event_id` FOREIGN KEY (`telemetry_event_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_event`(`telemetry_event_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_funnel_definition_id` FOREIGN KEY (`funnel_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_definition`(`funnel_definition_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);

-- ========= marketing --> billing (2 constraint(s)) =========
-- Requires: marketing schema, billing schema
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);

-- ========= marketing --> compliance (15 constraint(s)) =========
-- Requires: marketing schema, compliance schema
ALTER TABLE `gaming_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ADD CONSTRAINT `fk_marketing_influencer_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ADD CONSTRAINT `fk_marketing_player_segment_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ADD CONSTRAINT `fk_marketing_player_segment_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_network` ADD CONSTRAINT `fk_marketing_ad_network_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);

-- ========= marketing --> content (4 constraint(s)) =========
-- Requires: marketing schema, content schema
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);

-- ========= marketing --> esports (21 constraint(s)) =========
-- Requires: marketing schema, esports schema
ALTER TABLE `gaming_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `gaming_ecm`.`esports`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `gaming_ecm`.`esports`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ADD CONSTRAINT `fk_marketing_player_segment_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `gaming_ecm`.`esports`.`venue`(`venue_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `gaming_ecm`.`esports`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);

-- ========= marketing --> infrastructure (4 constraint(s)) =========
-- Requires: marketing schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);

-- ========= marketing --> licensing (15 constraint(s)) =========
-- Requires: marketing schema, licensing schema
ALTER TABLE `gaming_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);

-- ========= marketing --> monetization (6 constraint(s)) =========
-- Requires: marketing schema, monetization schema
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_storefront_transaction_id` FOREIGN KEY (`storefront_transaction_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_transaction`(`storefront_transaction_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_storefront_item_id` FOREIGN KEY (`storefront_item_id`) REFERENCES `gaming_ecm`.`monetization`.`storefront_item`(`storefront_item_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_player_ltv_segment_id` FOREIGN KEY (`player_ltv_segment_id`) REFERENCES `gaming_ecm`.`monetization`.`player_ltv_segment`(`player_ltv_segment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `gaming_ecm`.`monetization`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_player_ltv_segment_id` FOREIGN KEY (`player_ltv_segment_id`) REFERENCES `gaming_ecm`.`monetization`.`player_ltv_segment`(`player_ltv_segment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `gaming_ecm`.`monetization`.`subscription_plan`(`subscription_plan_id`);

-- ========= marketing --> platform (9 constraint(s)) =========
-- Requires: marketing schema, platform schema
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= marketing --> player (2 constraint(s)) =========
-- Requires: marketing schema, player schema
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= marketing --> studio (1 constraint(s)) =========
-- Requires: marketing schema, studio schema
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);

-- ========= marketing --> title (26 constraint(s)) =========
-- Requires: marketing schema, title schema
ALTER TABLE `gaming_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_game_edition_id` FOREIGN KEY (`game_edition_id`) REFERENCES `gaming_ecm`.`title`.`game_edition`(`game_edition_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_leaderboard_id` FOREIGN KEY (`leaderboard_id`) REFERENCES `gaming_ecm`.`title`.`leaderboard`(`leaderboard_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ADD CONSTRAINT `fk_marketing_player_segment_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`budget` ADD CONSTRAINT `fk_marketing_budget_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);

-- ========= monetization --> analytics (12 constraint(s)) =========
-- Requires: monetization schema, analytics schema
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_funnel_definition_id` FOREIGN KEY (`funnel_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_definition`(`funnel_definition_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_funnel_definition_id` FOREIGN KEY (`funnel_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`funnel_definition`(`funnel_definition_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);

-- ========= monetization --> billing (10 constraint(s)) =========
-- Requires: monetization schema, billing schema
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_storefront_order_line_id` FOREIGN KEY (`storefront_order_line_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order_line`(`storefront_order_line_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);

-- ========= monetization --> community (3 constraint(s)) =========
-- Requires: monetization schema, community schema
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_event_id` FOREIGN KEY (`event_id`) REFERENCES `gaming_ecm`.`community`.`event`(`event_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_event_id` FOREIGN KEY (`event_id`) REFERENCES `gaming_ecm`.`community`.`event`(`event_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_event_id` FOREIGN KEY (`event_id`) REFERENCES `gaming_ecm`.`community`.`event`(`event_id`);

-- ========= monetization --> compliance (21 constraint(s)) =========
-- Requires: monetization schema, compliance schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_loot_box_disclosure_id` FOREIGN KEY (`loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_loot_box_disclosure_id` FOREIGN KEY (`loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_loot_box_disclosure_id` FOREIGN KEY (`loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);

-- ========= monetization --> content (15 constraint(s)) =========
-- Requires: monetization schema, content schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);

-- ========= monetization --> esports (16 constraint(s)) =========
-- Requires: monetization schema, esports schema
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `gaming_ecm`.`esports`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `gaming_ecm`.`esports`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);

-- ========= monetization --> infrastructure (3 constraint(s)) =========
-- Requires: monetization schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_server_session_id` FOREIGN KEY (`server_session_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_session`(`server_session_id`);

-- ========= monetization --> licensing (13 constraint(s)) =========
-- Requires: monetization schema, licensing schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_economy_config_id` FOREIGN KEY (`economy_config_id`) REFERENCES `gaming_ecm`.`licensing`.`economy_config`(`economy_config_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `gaming_ecm`.`licensing`.`entitlement`(`entitlement_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_commercial_term_id` FOREIGN KEY (`commercial_term_id`) REFERENCES `gaming_ecm`.`licensing`.`commercial_term`(`commercial_term_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_gacha_pool_id` FOREIGN KEY (`gacha_pool_id`) REFERENCES `gaming_ecm`.`licensing`.`gacha_pool`(`gacha_pool_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);

-- ========= monetization --> marketing (10 constraint(s)) =========
-- Requires: monetization schema, marketing schema
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_ad_network_id` FOREIGN KEY (`ad_network_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_network`(`ad_network_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_ad_network_id` FOREIGN KEY (`ad_network_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_network`(`ad_network_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= monetization --> platform (15 constraint(s)) =========
-- Requires: monetization schema, platform schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `gaming_ecm`.`platform`.`pricing`(`pricing_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);

-- ========= monetization --> player (10 constraint(s)) =========
-- Requires: monetization schema, player schema
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);

-- ========= monetization --> studio (6 constraint(s)) =========
-- Requires: monetization schema, studio schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);

-- ========= monetization --> title (17 constraint(s)) =========
-- Requires: monetization schema, title schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_game_edition_id` FOREIGN KEY (`game_edition_id`) REFERENCES `gaming_ecm`.`title`.`game_edition`(`game_edition_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_item` ADD CONSTRAINT `fk_monetization_storefront_item_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= platform --> billing (3 constraint(s)) =========
-- Requires: platform schema, billing schema
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);

-- ========= platform --> compliance (36 constraint(s)) =========
-- Requires: platform schema, compliance schema
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_loot_box_disclosure_id` FOREIGN KEY (`loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_loot_box_disclosure_id` FOREIGN KEY (`loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_loot_box_disclosure_id` FOREIGN KEY (`loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_loot_box_disclosure_id` FOREIGN KEY (`loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ADD CONSTRAINT `fk_platform_developer_account_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ADD CONSTRAINT `fk_platform_developer_account_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ADD CONSTRAINT `fk_platform_developer_account_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= platform --> content (14 constraint(s)) =========
-- Requires: platform schema, content schema
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);

-- ========= platform --> esports (4 constraint(s)) =========
-- Requires: platform schema, esports schema
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);

-- ========= platform --> infrastructure (15 constraint(s)) =========
-- Requires: platform schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_infrastructure_deployment_id` FOREIGN KEY (`infrastructure_deployment_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_deployment`(`infrastructure_deployment_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_maintenance_window_id` FOREIGN KEY (`maintenance_window_id`) REFERENCES `gaming_ecm`.`infrastructure`.`maintenance_window`(`maintenance_window_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_maintenance_window_id` FOREIGN KEY (`maintenance_window_id`) REFERENCES `gaming_ecm`.`infrastructure`.`maintenance_window`(`maintenance_window_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_infrastructure_deployment_id` FOREIGN KEY (`infrastructure_deployment_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_deployment`(`infrastructure_deployment_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_maintenance_window_id` FOREIGN KEY (`maintenance_window_id`) REFERENCES `gaming_ecm`.`infrastructure`.`maintenance_window`(`maintenance_window_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);

-- ========= platform --> licensing (13 constraint(s)) =========
-- Requires: platform schema, licensing schema
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `gaming_ecm`.`licensing`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `gaming_ecm`.`licensing`.`entitlement`(`entitlement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `gaming_ecm`.`licensing`.`entitlement`(`entitlement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `gaming_ecm`.`licensing`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_commercial_term_id` FOREIGN KEY (`commercial_term_id`) REFERENCES `gaming_ecm`.`licensing`.`commercial_term`(`commercial_term_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_commercial_term_id` FOREIGN KEY (`commercial_term_id`) REFERENCES `gaming_ecm`.`licensing`.`commercial_term`(`commercial_term_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `gaming_ecm`.`licensing`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ADD CONSTRAINT `fk_platform_developer_account_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);

-- ========= platform --> marketing (7 constraint(s)) =========
-- Requires: platform schema, marketing schema
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_ad_network_id` FOREIGN KEY (`ad_network_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_network`(`ad_network_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_ad_network_id` FOREIGN KEY (`ad_network_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_network`(`ad_network_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_launch_event_id` FOREIGN KEY (`launch_event_id`) REFERENCES `gaming_ecm`.`marketing`.`launch_event`(`launch_event_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_launch_event_id` FOREIGN KEY (`launch_event_id`) REFERENCES `gaming_ecm`.`marketing`.`launch_event`(`launch_event_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= platform --> player (5 constraint(s)) =========
-- Requires: platform schema, player schema
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_platform_identity_id` FOREIGN KEY (`platform_identity_id`) REFERENCES `gaming_ecm`.`player`.`platform_identity`(`platform_identity_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_platform_identity_id` FOREIGN KEY (`platform_identity_id`) REFERENCES `gaming_ecm`.`player`.`platform_identity`(`platform_identity_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= platform --> studio (1 constraint(s)) =========
-- Requires: platform schema, studio schema
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);

-- ========= platform --> title (16 constraint(s)) =========
-- Requires: platform schema, title schema
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_game_edition_id` FOREIGN KEY (`game_edition_id`) REFERENCES `gaming_ecm`.`title`.`game_edition`(`game_edition_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`platform`.`cert_submission` ADD CONSTRAINT `fk_platform_cert_submission_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);

-- ========= player --> analytics (4 constraint(s)) =========
-- Requires: player schema, analytics schema
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);

-- ========= player --> billing (4 constraint(s)) =========
-- Requires: player schema, billing schema
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);

-- ========= player --> community (3 constraint(s)) =========
-- Requires: player schema, community schema
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_event_id` FOREIGN KEY (`event_id`) REFERENCES `gaming_ecm`.`community`.`event`(`event_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_moderation_action_id` FOREIGN KEY (`moderation_action_id`) REFERENCES `gaming_ecm`.`community`.`moderation_action`(`moderation_action_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);

-- ========= player --> compliance (9 constraint(s)) =========
-- Requires: player schema, compliance schema
ALTER TABLE `gaming_ecm`.`player`.`preference` ADD CONSTRAINT `fk_player_preference_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);

-- ========= player --> content (8 constraint(s)) =========
-- Requires: player schema, content schema
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_content_deployment_id` FOREIGN KEY (`content_deployment_id`) REFERENCES `gaming_ecm`.`content`.`content_deployment`(`content_deployment_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);

-- ========= player --> esports (3 constraint(s)) =========
-- Requires: player schema, esports schema
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);

-- ========= player --> infrastructure (9 constraint(s)) =========
-- Requires: player schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`player`.`device` ADD CONSTRAINT `fk_player_device_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_matchmaking_ticket_id` FOREIGN KEY (`matchmaking_ticket_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_ticket`(`matchmaking_ticket_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_server_session_id` FOREIGN KEY (`server_session_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_session`(`server_session_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_server_session_id` FOREIGN KEY (`server_session_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_session`(`server_session_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_server_session_id` FOREIGN KEY (`server_session_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_session`(`server_session_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);

-- ========= player --> licensing (6 constraint(s)) =========
-- Requires: player schema, licensing schema
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_battle_pass_entitlement_id` FOREIGN KEY (`battle_pass_entitlement_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass_entitlement`(`battle_pass_entitlement_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_economy_config_id` FOREIGN KEY (`economy_config_id`) REFERENCES `gaming_ecm`.`licensing`.`economy_config`(`economy_config_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_virtual_currency_account_id` FOREIGN KEY (`virtual_currency_account_id`) REFERENCES `gaming_ecm`.`licensing`.`virtual_currency_account`(`virtual_currency_account_id`);

-- ========= player --> marketing (4 constraint(s)) =========
-- Requires: player schema, marketing schema
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_crm_campaign_id` FOREIGN KEY (`crm_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`crm_campaign`(`crm_campaign_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);

-- ========= player --> platform (12 constraint(s)) =========
-- Requires: player schema, platform schema
ALTER TABLE `gaming_ecm`.`player`.`player_account` ADD CONSTRAINT `fk_player_player_account_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`player`.`profile` ADD CONSTRAINT `fk_player_profile_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`player`.`platform_identity` ADD CONSTRAINT `fk_player_platform_identity_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`player`.`preference` ADD CONSTRAINT `fk_player_preference_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`player`.`device` ADD CONSTRAINT `fk_player_device_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= player --> studio (2 constraint(s)) =========
-- Requires: player schema, studio schema
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);

-- ========= player --> title (6 constraint(s)) =========
-- Requires: player schema, title schema
ALTER TABLE `gaming_ecm`.`player`.`preference` ADD CONSTRAINT `fk_player_preference_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`player`.`lifecycle_event` ADD CONSTRAINT `fk_player_lifecycle_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= studio --> compliance (18 constraint(s)) =========
-- Requires: studio schema, compliance schema
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ADD CONSTRAINT `fk_studio_game_studio_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ADD CONSTRAINT `fk_studio_sprint_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `gaming_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ADD CONSTRAINT `fk_studio_milestone_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ADD CONSTRAINT `fk_studio_milestone_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`studio`.`repo` ADD CONSTRAINT `fk_studio_repo_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`studio`.`repo` ADD CONSTRAINT `fk_studio_repo_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_spend_limit_control_id` FOREIGN KEY (`spend_limit_control_id`) REFERENCES `gaming_ecm`.`compliance`.`spend_limit_control`(`spend_limit_control_id`);

-- ========= studio --> content (5 constraint(s)) =========
-- Requires: studio schema, content schema
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);

-- ========= studio --> esports (1 constraint(s)) =========
-- Requires: studio schema, esports schema
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);

-- ========= studio --> infrastructure (7 constraint(s)) =========
-- Requires: studio schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`studio`.`repo` ADD CONSTRAINT `fk_studio_repo_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_maintenance_window_id` FOREIGN KEY (`maintenance_window_id`) REFERENCES `gaming_ecm`.`infrastructure`.`maintenance_window`(`maintenance_window_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);

-- ========= studio --> licensing (9 constraint(s)) =========
-- Requires: studio schema, licensing schema
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ADD CONSTRAINT `fk_studio_game_studio_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`studio`.`repo` ADD CONSTRAINT `fk_studio_repo_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`studio`.`repo` ADD CONSTRAINT `fk_studio_repo_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_economy_config_id` FOREIGN KEY (`economy_config_id`) REFERENCES `gaming_ecm`.`licensing`.`economy_config`(`economy_config_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);

-- ========= studio --> marketing (2 constraint(s)) =========
-- Requires: studio schema, marketing schema
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);

-- ========= studio --> platform (6 constraint(s)) =========
-- Requires: studio schema, platform schema
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ADD CONSTRAINT `fk_studio_game_studio_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_release_schedule_id` FOREIGN KEY (`release_schedule_id`) REFERENCES `gaming_ecm`.`platform`.`release_schedule`(`release_schedule_id`);

-- ========= studio --> title (5 constraint(s)) =========
-- Requires: studio schema, title schema
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ADD CONSTRAINT `fk_studio_milestone_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= title --> compliance (6 constraint(s)) =========
-- Requires: title schema, compliance schema
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ADD CONSTRAINT `fk_title_title_sku_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ADD CONSTRAINT `fk_title_game_edition_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ADD CONSTRAINT `fk_title_content_rating_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= title --> content (14 constraint(s)) =========
-- Requires: title schema, content schema
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ADD CONSTRAINT `fk_title_title_sku_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ADD CONSTRAINT `fk_title_game_edition_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_season` ADD CONSTRAINT `fk_title_title_season_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ADD CONSTRAINT `fk_title_game_mode_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ADD CONSTRAINT `fk_title_playable_character_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);

-- ========= title --> licensing (3 constraint(s)) =========
-- Requires: title schema, licensing schema
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ADD CONSTRAINT `fk_title_game_mode_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);

-- ========= title --> marketing (2 constraint(s)) =========
-- Requires: title schema, marketing schema
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= title --> platform (4 constraint(s)) =========
-- Requires: title schema, platform schema
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ADD CONSTRAINT `fk_title_title_sku_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= title --> studio (18 constraint(s)) =========
-- Requires: title schema, studio schema
ALTER TABLE `gaming_ecm`.`title`.`game_title` ADD CONSTRAINT `fk_title_game_title_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ADD CONSTRAINT `fk_title_title_sku_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_repo_id` FOREIGN KEY (`repo_id`) REFERENCES `gaming_ecm`.`studio`.`repo`(`repo_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ADD CONSTRAINT `fk_title_content_rating_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`franchise` ADD CONSTRAINT `fk_title_franchise_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_season` ADD CONSTRAINT `fk_title_title_season_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ADD CONSTRAINT `fk_title_game_mode_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ADD CONSTRAINT `fk_title_playable_character_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`playable_character` ADD CONSTRAINT `fk_title_playable_character_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);

