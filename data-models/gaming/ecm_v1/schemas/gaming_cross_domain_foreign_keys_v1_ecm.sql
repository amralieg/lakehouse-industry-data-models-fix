-- Cross-Domain Foreign Keys for Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:06
-- Total cross-domain FK constraints: 1817
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: analytics, billing, community, compliance, content, esports, finance, infrastructure, licensing, marketing, monetization, platform, player, quality, studio, title, workforce

-- ========= analytics --> billing (19 constraint(s)) =========
-- Requires: analytics schema, billing schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `gaming_ecm`.`billing`.`promo_code`(`promo_code_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `gaming_ecm`.`billing`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ADD CONSTRAINT `fk_analytics_behavior_segment_membership_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ADD CONSTRAINT `fk_analytics_player_prediction_record_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);

-- ========= analytics --> community (21 constraint(s)) =========
-- Requires: analytics schema, community schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_forum_thread_id` FOREIGN KEY (`forum_thread_id`) REFERENCES `gaming_ecm`.`community`.`forum_thread`(`forum_thread_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_moderation_action_id` FOREIGN KEY (`moderation_action_id`) REFERENCES `gaming_ecm`.`community`.`moderation_action`(`moderation_action_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_ugc_submission_id` FOREIGN KEY (`ugc_submission_id`) REFERENCES `gaming_ecm`.`community`.`ugc_submission`(`ugc_submission_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `gaming_ecm`.`community`.`forum`(`forum_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_forum_thread_id` FOREIGN KEY (`forum_thread_id`) REFERENCES `gaming_ecm`.`community`.`forum_thread`(`forum_thread_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_ugc_submission_id` FOREIGN KEY (`ugc_submission_id`) REFERENCES `gaming_ecm`.`community`.`ugc_submission`(`ugc_submission_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `gaming_ecm`.`community`.`forum`(`forum_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ADD CONSTRAINT `fk_analytics_behavior_segment_membership_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_ugc_submission_id` FOREIGN KEY (`ugc_submission_id`) REFERENCES `gaming_ecm`.`community`.`ugc_submission`(`ugc_submission_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_forum_thread_id` FOREIGN KEY (`forum_thread_id`) REFERENCES `gaming_ecm`.`community`.`forum_thread`(`forum_thread_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_forum_thread_id` FOREIGN KEY (`forum_thread_id`) REFERENCES `gaming_ecm`.`community`.`forum_thread`(`forum_thread_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);

-- ========= analytics --> compliance (15 constraint(s)) =========
-- Requires: analytics schema, compliance schema
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_privacy_impact_assessment_id` FOREIGN KEY (`privacy_impact_assessment_id`) REFERENCES `gaming_ecm`.`compliance`.`privacy_impact_assessment`(`privacy_impact_assessment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_privacy_impact_assessment_id` FOREIGN KEY (`privacy_impact_assessment_id`) REFERENCES `gaming_ecm`.`compliance`.`privacy_impact_assessment`(`privacy_impact_assessment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_privacy_impact_assessment_id` FOREIGN KEY (`privacy_impact_assessment_id`) REFERENCES `gaming_ecm`.`compliance`.`privacy_impact_assessment`(`privacy_impact_assessment_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`feature_store_definition` ADD CONSTRAINT `fk_analytics_feature_store_definition_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_jurisdiction_configuration` ADD CONSTRAINT `fk_analytics_experiment_jurisdiction_configuration_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= analytics --> content (16 constraint(s)) =========
-- Requires: analytics schema, content schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ADD CONSTRAINT `fk_analytics_game_balance_snapshot_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ADD CONSTRAINT `fk_analytics_game_balance_snapshot_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ADD CONSTRAINT `fk_analytics_retention_cohort_analysis_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ADD CONSTRAINT `fk_analytics_player_prediction_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);

-- ========= analytics --> esports (3 constraint(s)) =========
-- Requires: analytics schema, esports schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ADD CONSTRAINT `fk_analytics_game_balance_snapshot_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);

-- ========= analytics --> infrastructure (1 constraint(s)) =========
-- Requires: analytics schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);

-- ========= analytics --> licensing (13 constraint(s)) =========
-- Requires: analytics schema, licensing schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `gaming_ecm`.`licensing`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ADD CONSTRAINT `fk_analytics_game_balance_snapshot_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ADD CONSTRAINT `fk_analytics_retention_cohort_analysis_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ADD CONSTRAINT `fk_analytics_retention_cohort_analysis_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);

-- ========= analytics --> marketing (9 constraint(s)) =========
-- Requires: analytics schema, marketing schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_retention_cohort_id` FOREIGN KEY (`retention_cohort_id`) REFERENCES `gaming_ecm`.`marketing`.`retention_cohort`(`retention_cohort_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_retention_cohort_id` FOREIGN KEY (`retention_cohort_id`) REFERENCES `gaming_ecm`.`marketing`.`retention_cohort`(`retention_cohort_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_retention_cohort_id` FOREIGN KEY (`retention_cohort_id`) REFERENCES `gaming_ecm`.`marketing`.`retention_cohort`(`retention_cohort_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_retention_cohort_id` FOREIGN KEY (`retention_cohort_id`) REFERENCES `gaming_ecm`.`marketing`.`retention_cohort`(`retention_cohort_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_retention_cohort_id` FOREIGN KEY (`retention_cohort_id`) REFERENCES `gaming_ecm`.`marketing`.`retention_cohort`(`retention_cohort_id`);

-- ========= analytics --> platform (24 constraint(s)) =========
-- Requires: analytics schema, platform schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_crossplay_feature_id` FOREIGN KEY (`crossplay_feature_id`) REFERENCES `gaming_ecm`.`platform`.`crossplay_feature`(`crossplay_feature_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_platform_cert_submission_id` FOREIGN KEY (`platform_cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`platform_cert_submission`(`platform_cert_submission_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `gaming_ecm`.`platform`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_sdk_integration_id` FOREIGN KEY (`sdk_integration_id`) REFERENCES `gaming_ecm`.`platform`.`sdk_integration`(`sdk_integration_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_storefront_listing_id` FOREIGN KEY (`storefront_listing_id`) REFERENCES `gaming_ecm`.`platform`.`storefront_listing`(`storefront_listing_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `gaming_ecm`.`platform`.`pricing`(`pricing_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_platform_storefront_id` FOREIGN KEY (`platform_storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ADD CONSTRAINT `fk_analytics_behavior_segment_membership_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ADD CONSTRAINT `fk_analytics_game_balance_snapshot_compatibility_profile_id` FOREIGN KEY (`compatibility_profile_id`) REFERENCES `gaming_ecm`.`platform`.`compatibility_profile`(`compatibility_profile_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ADD CONSTRAINT `fk_analytics_game_balance_snapshot_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ADD CONSTRAINT `fk_analytics_retention_cohort_analysis_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= analytics --> player (16 constraint(s)) =========
-- Requires: analytics schema, player schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ADD CONSTRAINT `fk_analytics_behavior_segment_membership_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ADD CONSTRAINT `fk_analytics_player_prediction_record_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);

-- ========= analytics --> studio (9 constraint(s)) =========
-- Requires: analytics schema, studio schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ADD CONSTRAINT `fk_analytics_game_balance_snapshot_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);

-- ========= analytics --> title (27 constraint(s)) =========
-- Requires: analytics schema, title schema
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_event` ADD CONSTRAINT `fk_analytics_telemetry_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_step_event` ADD CONSTRAINT `fk_analytics_funnel_step_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`behavior_segment_membership` ADD CONSTRAINT `fk_analytics_behavior_segment_membership_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`model_serving_event` ADD CONSTRAINT `fk_analytics_model_serving_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ADD CONSTRAINT `fk_analytics_game_balance_snapshot_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`game_balance_snapshot` ADD CONSTRAINT `fk_analytics_game_balance_snapshot_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ADD CONSTRAINT `fk_analytics_retention_cohort_analysis_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`session_event_summary` ADD CONSTRAINT `fk_analytics_session_event_summary_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_prediction_record` ADD CONSTRAINT `fk_analytics_player_prediction_record_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`live_ops_signal` ADD CONSTRAINT `fk_analytics_live_ops_signal_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_instance` ADD CONSTRAINT `fk_analytics_funnel_instance_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= analytics --> workforce (20 constraint(s)) =========
-- Requires: analytics schema, workforce schema
ALTER TABLE `gaming_ecm`.`analytics`.`event_schema` ADD CONSTRAINT `fk_analytics_event_schema_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`telemetry_pipeline` ADD CONSTRAINT `fk_analytics_telemetry_pipeline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_experiment` ADD CONSTRAINT `fk_analytics_ab_experiment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_assignment` ADD CONSTRAINT `fk_analytics_experiment_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`experiment_result` ADD CONSTRAINT `fk_analytics_experiment_result_primary_experiment_employee_id` FOREIGN KEY (`primary_experiment_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_target_owner_employee_id` FOREIGN KEY (`target_owner_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`player_behavior_segment` ADD CONSTRAINT `fk_analytics_player_behavior_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_registry` ADD CONSTRAINT `fk_analytics_ml_model_registry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`retention_cohort_analysis` ADD CONSTRAINT `fk_analytics_retention_cohort_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`treatment_arm` ADD CONSTRAINT `fk_analytics_treatment_arm_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ADD CONSTRAINT `fk_analytics_ab_test_variant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ab_test_variant` ADD CONSTRAINT `fk_analytics_ab_test_variant_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_version` ADD CONSTRAINT `fk_analytics_ml_model_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` ADD CONSTRAINT `fk_analytics_ml_model_deployment_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`analytics`.`ml_model_deployment` ADD CONSTRAINT `fk_analytics_ml_model_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= billing --> community (2 constraint(s)) =========
-- Requires: billing schema, community schema
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);

-- ========= billing --> compliance (6 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ADD CONSTRAINT `fk_billing_payout_line_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ADD CONSTRAINT `fk_billing_promo_code_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ADD CONSTRAINT `fk_billing_payment_hold_sanctions_screening_result_id` FOREIGN KEY (`sanctions_screening_result_id`) REFERENCES `gaming_ecm`.`compliance`.`sanctions_screening_result`(`sanctions_screening_result_id`);

-- ========= billing --> content (3 constraint(s)) =========
-- Requires: billing schema, content schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ADD CONSTRAINT `fk_billing_promo_code_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);

-- ========= billing --> finance (14 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `gaming_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ADD CONSTRAINT `fk_billing_billing_tax_record_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `gaming_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ADD CONSTRAINT `fk_billing_promo_code_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `gaming_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= billing --> infrastructure (2 constraint(s)) =========
-- Requires: billing schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);

-- ========= billing --> licensing (19 constraint(s)) =========
-- Requires: billing schema, licensing schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_virtual_currency_account_id` FOREIGN KEY (`virtual_currency_account_id`) REFERENCES `gaming_ecm`.`licensing`.`virtual_currency_account`(`virtual_currency_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `gaming_ecm`.`licensing`.`entitlement`(`entitlement_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_catalog_offer_id` FOREIGN KEY (`catalog_offer_id`) REFERENCES `gaming_ecm`.`licensing`.`catalog_offer`(`catalog_offer_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ADD CONSTRAINT `fk_billing_promo_code_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ADD CONSTRAINT `fk_billing_promo_redemption_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_catalog_offer_id` FOREIGN KEY (`catalog_offer_id`) REFERENCES `gaming_ecm`.`licensing`.`catalog_offer`(`catalog_offer_id`);

-- ========= billing --> marketing (6 constraint(s)) =========
-- Requires: billing schema, marketing schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ADD CONSTRAINT `fk_billing_promo_code_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ADD CONSTRAINT `fk_billing_promo_redemption_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);

-- ========= billing --> monetization (1 constraint(s)) =========
-- Requires: billing schema, monetization schema
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `gaming_ecm`.`monetization`.`subscription_plan`(`subscription_plan_id`);

-- ========= billing --> platform (11 constraint(s)) =========
-- Requires: billing schema, platform schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ADD CONSTRAINT `fk_billing_payout_line_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ADD CONSTRAINT `fk_billing_promo_redemption_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_cycle` ADD CONSTRAINT `fk_billing_dunning_cycle_platform_holder_id` FOREIGN KEY (`platform_holder_id`) REFERENCES `gaming_ecm`.`platform`.`platform_holder`(`platform_holder_id`);
ALTER TABLE `gaming_ecm`.`billing`.`settlement_batch` ADD CONSTRAINT `fk_billing_settlement_batch_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_platform_holder_id` FOREIGN KEY (`platform_holder_id`) REFERENCES `gaming_ecm`.`platform`.`platform_holder`(`platform_holder_id`);
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= billing --> player (18 constraint(s)) =========
-- Requires: billing schema, player schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_subscription_player_account_id` FOREIGN KEY (`subscription_player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ADD CONSTRAINT `fk_billing_promo_redemption_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ADD CONSTRAINT `fk_billing_payment_hold_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ADD CONSTRAINT `fk_billing_bank_account_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= billing --> quality (3 constraint(s)) =========
-- Requires: billing schema, quality schema
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `gaming_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `gaming_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `gaming_ecm`.`quality`.`defect`(`defect_id`);

-- ========= billing --> studio (2 constraint(s)) =========
-- Requires: billing schema, studio schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ADD CONSTRAINT `fk_billing_payout_line_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);

-- ========= billing --> title (12 constraint(s)) =========
-- Requires: billing schema, title schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ADD CONSTRAINT `fk_billing_payout_line_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ADD CONSTRAINT `fk_billing_payout_line_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ADD CONSTRAINT `fk_billing_promo_redemption_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);

-- ========= billing --> workforce (14 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ADD CONSTRAINT `fk_billing_billing_tax_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ADD CONSTRAINT `fk_billing_promo_code_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_tertiary_credit_voided_by_agent_employee_id` FOREIGN KEY (`tertiary_credit_voided_by_agent_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ADD CONSTRAINT `fk_billing_payment_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_cycle` ADD CONSTRAINT `fk_billing_dunning_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_cycle` ADD CONSTRAINT `fk_billing_dunning_cycle_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= community --> billing (14 constraint(s)) =========
-- Requires: community schema, billing schema
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `gaming_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_storefront_order_line_id` FOREIGN KEY (`storefront_order_line_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order_line`(`storefront_order_line_id`);
ALTER TABLE `gaming_ecm`.`community`.`guild` ADD CONSTRAINT `fk_community_guild_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `gaming_ecm`.`billing`.`refund`(`refund_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `gaming_ecm`.`billing`.`refund`(`refund_id`);
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ADD CONSTRAINT `fk_community_survey_response_promo_redemption_id` FOREIGN KEY (`promo_redemption_id`) REFERENCES `gaming_ecm`.`billing`.`promo_redemption`(`promo_redemption_id`);
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ADD CONSTRAINT `fk_community_viral_referral_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `gaming_ecm`.`billing`.`promo_code`(`promo_code_id`);
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ADD CONSTRAINT `fk_community_viral_referral_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `gaming_ecm`.`billing`.`promo_code`(`promo_code_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `gaming_ecm`.`billing`.`refund`(`refund_id`);

-- ========= community --> compliance (13 constraint(s)) =========
-- Requires: community schema, compliance schema
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_privacy_impact_assessment_id` FOREIGN KEY (`privacy_impact_assessment_id`) REFERENCES `gaming_ecm`.`compliance`.`privacy_impact_assessment`(`privacy_impact_assessment_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ADD CONSTRAINT `fk_community_chat_session_age_verification_event_id` FOREIGN KEY (`age_verification_event_id`) REFERENCES `gaming_ecm`.`compliance`.`age_verification_event`(`age_verification_event_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_sanctions_screening_result_id` FOREIGN KEY (`sanctions_screening_result_id`) REFERENCES `gaming_ecm`.`compliance`.`sanctions_screening_result`(`sanctions_screening_result_id`);

-- ========= community --> content (13 constraint(s)) =========
-- Requires: community schema, content schema
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);

-- ========= community --> esports (1 constraint(s)) =========
-- Requires: community schema, esports schema
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);

-- ========= community --> finance (8 constraint(s)) =========
-- Requires: community schema, finance schema
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ADD CONSTRAINT `fk_community_chat_session_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);

-- ========= community --> licensing (18 constraint(s)) =========
-- Requires: community schema, licensing schema
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_gacha_pool_id` FOREIGN KEY (`gacha_pool_id`) REFERENCES `gaming_ecm`.`licensing`.`gacha_pool`(`gacha_pool_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_battle_pass_entitlement_id` FOREIGN KEY (`battle_pass_entitlement_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass_entitlement`(`battle_pass_entitlement_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_gacha_pull_id` FOREIGN KEY (`gacha_pull_id`) REFERENCES `gaming_ecm`.`licensing`.`gacha_pull`(`gacha_pull_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ADD CONSTRAINT `fk_community_chat_session_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_brand_partnership_id` FOREIGN KEY (`brand_partnership_id`) REFERENCES `gaming_ecm`.`licensing`.`brand_partnership`(`brand_partnership_id`);

-- ========= community --> marketing (16 constraint(s)) =========
-- Requires: community schema, marketing schema
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `gaming_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `gaming_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ADD CONSTRAINT `fk_community_survey_response_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ADD CONSTRAINT `fk_community_viral_referral_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ADD CONSTRAINT `fk_community_chat_session_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `gaming_ecm`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ADD CONSTRAINT `fk_community_social_connection_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);

-- ========= community --> monetization (4 constraint(s)) =========
-- Requires: community schema, monetization schema
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_dlc_entitlement_id` FOREIGN KEY (`dlc_entitlement_id`) REFERENCES `gaming_ecm`.`monetization`.`dlc_entitlement`(`dlc_entitlement_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `gaming_ecm`.`monetization`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ADD CONSTRAINT `fk_community_survey_response_player_ltv_segment_id` FOREIGN KEY (`player_ltv_segment_id`) REFERENCES `gaming_ecm`.`monetization`.`player_ltv_segment`(`player_ltv_segment_id`);
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ADD CONSTRAINT `fk_community_chat_session_player_subscription_id` FOREIGN KEY (`player_subscription_id`) REFERENCES `gaming_ecm`.`monetization`.`player_subscription`(`player_subscription_id`);

-- ========= community --> platform (17 constraint(s)) =========
-- Requires: community schema, platform schema
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ADD CONSTRAINT `fk_community_ugc_review_storefront_listing_id` FOREIGN KEY (`storefront_listing_id`) REFERENCES `gaming_ecm`.`platform`.`storefront_listing`(`storefront_listing_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_compatibility_profile_id` FOREIGN KEY (`compatibility_profile_id`) REFERENCES `gaming_ecm`.`platform`.`compatibility_profile`(`compatibility_profile_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `gaming_ecm`.`platform`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_platform_cert_submission_id` FOREIGN KEY (`platform_cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`platform_cert_submission`(`platform_cert_submission_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_crossplay_feature_id` FOREIGN KEY (`crossplay_feature_id`) REFERENCES `gaming_ecm`.`platform`.`crossplay_feature`(`crossplay_feature_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_release_schedule_id` FOREIGN KEY (`release_schedule_id`) REFERENCES `gaming_ecm`.`platform`.`release_schedule`(`release_schedule_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= community --> player (23 constraint(s)) =========
-- Requires: community schema, player schema
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ADD CONSTRAINT `fk_community_forum_post_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ADD CONSTRAINT `fk_community_ugc_review_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`guild` ADD CONSTRAINT `fk_community_guild_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ADD CONSTRAINT `fk_community_guild_membership_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ADD CONSTRAINT `fk_community_ticket_comment_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ADD CONSTRAINT `fk_community_survey_response_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ADD CONSTRAINT `fk_community_survey_response_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ADD CONSTRAINT `fk_community_viral_referral_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ADD CONSTRAINT `fk_community_chat_session_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ADD CONSTRAINT `fk_community_social_connection_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ADD CONSTRAINT `fk_community_social_connection_target_player_player_account_id` FOREIGN KEY (`target_player_player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ADD CONSTRAINT `fk_community_player_reputation_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_category` ADD CONSTRAINT `fk_community_forum_category_modified_by_user_player_account_id` FOREIGN KEY (`modified_by_user_player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_category` ADD CONSTRAINT `fk_community_forum_category_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= community --> quality (2 constraint(s)) =========
-- Requires: community schema, quality schema
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `gaming_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `gaming_ecm`.`quality`.`defect`(`defect_id`);

-- ========= community --> studio (10 constraint(s)) =========
-- Requires: community schema, studio schema
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_backlog_item_id` FOREIGN KEY (`backlog_item_id`) REFERENCES `gaming_ecm`.`studio`.`backlog_item`(`backlog_item_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ADD CONSTRAINT `fk_community_ugc_review_backlog_item_id` FOREIGN KEY (`backlog_item_id`) REFERENCES `gaming_ecm`.`studio`.`backlog_item`(`backlog_item_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_backlog_item_id` FOREIGN KEY (`backlog_item_id`) REFERENCES `gaming_ecm`.`studio`.`backlog_item`(`backlog_item_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_backlog_item_id` FOREIGN KEY (`backlog_item_id`) REFERENCES `gaming_ecm`.`studio`.`backlog_item`(`backlog_item_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_backlog_item_id` FOREIGN KEY (`backlog_item_id`) REFERENCES `gaming_ecm`.`studio`.`backlog_item`(`backlog_item_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);

-- ========= community --> title (26 constraint(s)) =========
-- Requires: community schema, title schema
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ADD CONSTRAINT `fk_community_forum_post_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ADD CONSTRAINT `fk_community_ugc_review_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`guild` ADD CONSTRAINT `fk_community_guild_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ADD CONSTRAINT `fk_community_guild_membership_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ADD CONSTRAINT `fk_community_ticket_comment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ADD CONSTRAINT `fk_community_survey_response_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ADD CONSTRAINT `fk_community_viral_referral_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ADD CONSTRAINT `fk_community_chat_session_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ADD CONSTRAINT `fk_community_social_connection_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ADD CONSTRAINT `fk_community_player_reputation_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_category` ADD CONSTRAINT `fk_community_forum_category_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_section` ADD CONSTRAINT `fk_community_kb_section_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= community --> workforce (19 constraint(s)) =========
-- Requires: community schema, workforce schema
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ADD CONSTRAINT `fk_community_ugc_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ADD CONSTRAINT `fk_community_ugc_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ADD CONSTRAINT `fk_community_support_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ADD CONSTRAINT `fk_community_ticket_comment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_reviewer_agent_employee_id` FOREIGN KEY (`reviewer_agent_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_report` ADD CONSTRAINT `fk_community_player_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ADD CONSTRAINT `fk_community_player_feedback_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ADD CONSTRAINT `fk_community_chat_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_ban_employee_id` FOREIGN KEY (`ban_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_category` ADD CONSTRAINT `fk_community_kb_category_archived_by_user_employee_id` FOREIGN KEY (`archived_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_category` ADD CONSTRAINT `fk_community_kb_category_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_category` ADD CONSTRAINT `fk_community_kb_category_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_category` ADD CONSTRAINT `fk_community_kb_category_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_section` ADD CONSTRAINT `fk_community_kb_section_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_section` ADD CONSTRAINT `fk_community_kb_section_reviewer_user_employee_id` FOREIGN KEY (`reviewer_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> billing (1 constraint(s)) =========
-- Requires: compliance schema, billing schema
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ADD CONSTRAINT `fk_compliance_sanctions_screening_result_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `gaming_ecm`.`billing`.`payment_instrument`(`payment_instrument_id`);

-- ========= compliance --> esports (1 constraint(s)) =========
-- Requires: compliance schema, esports schema
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);

-- ========= compliance --> finance (8 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= compliance --> licensing (14 constraint(s)) =========
-- Requires: compliance schema, licensing schema
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_gacha_pool_id` FOREIGN KEY (`gacha_pool_id`) REFERENCES `gaming_ecm`.`licensing`.`gacha_pool`(`gacha_pool_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ADD CONSTRAINT `fk_compliance_privacy_impact_assessment_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`third_party_processor` ADD CONSTRAINT `fk_compliance_third_party_processor_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ADD CONSTRAINT `fk_compliance_age_verification_event_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ADD CONSTRAINT `fk_compliance_sanctions_screening_result_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);

-- ========= compliance --> platform (5 constraint(s)) =========
-- Requires: compliance schema, platform schema
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ADD CONSTRAINT `fk_compliance_age_verification_event_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= compliance --> player (8 constraint(s)) =========
-- Requires: compliance schema, player schema
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ADD CONSTRAINT `fk_compliance_age_verification_event_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ADD CONSTRAINT `fk_compliance_age_verification_event_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ADD CONSTRAINT `fk_compliance_age_verification_event_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ADD CONSTRAINT `fk_compliance_sanctions_screening_result_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= compliance --> studio (1 constraint(s)) =========
-- Requires: compliance schema, studio schema
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);

-- ========= compliance --> title (12 constraint(s)) =========
-- Requires: compliance schema, title schema
ALTER TABLE `gaming_ecm`.`compliance`.`age_rating_cert` ADD CONSTRAINT `fk_compliance_age_rating_cert_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`loot_box_disclosure` ADD CONSTRAINT `fk_compliance_loot_box_disclosure_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`privacy_impact_assessment` ADD CONSTRAINT `fk_compliance_privacy_impact_assessment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`processing_activity` ADD CONSTRAINT `fk_compliance_processing_activity_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`age_verification_event` ADD CONSTRAINT `fk_compliance_age_verification_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`spend_limit_control` ADD CONSTRAINT `fk_compliance_spend_limit_control_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= compliance --> workforce (11 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_primary_audit_employee_id` FOREIGN KEY (`primary_audit_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`compliance_incident` ADD CONSTRAINT `fk_compliance_compliance_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_quaternary_remediation_last_modified_by_employee_id` FOREIGN KEY (`quaternary_remediation_last_modified_by_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_tertiary_remediation_created_by_employee_id` FOREIGN KEY (`tertiary_remediation_created_by_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`sanctions_screening_result` ADD CONSTRAINT `fk_compliance_sanctions_screening_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= content --> compliance (15 constraint(s)) =========
-- Requires: content schema, compliance schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ADD CONSTRAINT `fk_content_localization_string_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ADD CONSTRAINT `fk_content_localization_translation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`content`.`level_map` ADD CONSTRAINT `fk_content_level_map_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_loot_box_disclosure_id` FOREIGN KEY (`loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_review` ADD CONSTRAINT `fk_content_asset_review_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= content --> esports (1 constraint(s)) =========
-- Requires: content schema, esports schema
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);

-- ========= content --> finance (8 constraint(s)) =========
-- Requires: content schema, finance schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);

-- ========= content --> infrastructure (10 constraint(s)) =========
-- Requires: content schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_cicd_pipeline_id` FOREIGN KEY (`cicd_pipeline_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cicd_pipeline`(`cicd_pipeline_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);

-- ========= content --> licensing (12 constraint(s)) =========
-- Requires: content schema, licensing schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ADD CONSTRAINT `fk_content_localization_string_music_sync_license_id` FOREIGN KEY (`music_sync_license_id`) REFERENCES `gaming_ecm`.`licensing`.`music_sync_license`(`music_sync_license_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ADD CONSTRAINT `fk_content_localization_translation_music_sync_license_id` FOREIGN KEY (`music_sync_license_id`) REFERENCES `gaming_ecm`.`licensing`.`music_sync_license`(`music_sync_license_id`);
ALTER TABLE `gaming_ecm`.`content`.`level_map` ADD CONSTRAINT `fk_content_level_map_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ADD CONSTRAINT `fk_content_npc_definition_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_brand_partnership_id` FOREIGN KEY (`brand_partnership_id`) REFERENCES `gaming_ecm`.`licensing`.`brand_partnership`(`brand_partnership_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_review` ADD CONSTRAINT `fk_content_asset_review_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `gaming_ecm`.`licensing`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `gaming_ecm`.`licensing`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_dependency` ADD CONSTRAINT `fk_content_asset_dependency_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);

-- ========= content --> marketing (2 constraint(s)) =========
-- Requires: content schema, marketing schema
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);

-- ========= content --> platform (2 constraint(s)) =========
-- Requires: content schema, platform schema
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_review` ADD CONSTRAINT `fk_content_asset_review_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);

-- ========= content --> quality (4 constraint(s)) =========
-- Requires: content schema, quality schema
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_cert_finding_id` FOREIGN KEY (`cert_finding_id`) REFERENCES `gaming_ecm`.`quality`.`cert_finding`(`cert_finding_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_release_gate_id` FOREIGN KEY (`release_gate_id`) REFERENCES `gaming_ecm`.`quality`.`release_gate`(`release_gate_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_test_plan_id` FOREIGN KEY (`test_plan_id`) REFERENCES `gaming_ecm`.`quality`.`test_plan`(`test_plan_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_test_suite_id` FOREIGN KEY (`test_suite_id`) REFERENCES `gaming_ecm`.`quality`.`test_suite`(`test_suite_id`);

-- ========= content --> studio (11 constraint(s)) =========
-- Requires: content schema, studio schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_changelist_id` FOREIGN KEY (`changelist_id`) REFERENCES `gaming_ecm`.`studio`.`changelist`(`changelist_id`);
ALTER TABLE `gaming_ecm`.`content`.`lod_variant` ADD CONSTRAINT `fk_content_lod_variant_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`level_map` ADD CONSTRAINT `fk_content_level_map_changelist_id` FOREIGN KEY (`changelist_id`) REFERENCES `gaming_ecm`.`studio`.`changelist`(`changelist_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ADD CONSTRAINT `fk_content_npc_definition_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_changelist_id` FOREIGN KEY (`changelist_id`) REFERENCES `gaming_ecm`.`studio`.`changelist`(`changelist_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_dependency` ADD CONSTRAINT `fk_content_asset_dependency_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_dependency` ADD CONSTRAINT `fk_content_asset_dependency_changelist_id` FOREIGN KEY (`changelist_id`) REFERENCES `gaming_ecm`.`studio`.`changelist`(`changelist_id`);

-- ========= content --> title (13 constraint(s)) =========
-- Requires: content schema, title schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`lod_variant` ADD CONSTRAINT `fk_content_lod_variant_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ADD CONSTRAINT `fk_content_localization_string_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ADD CONSTRAINT `fk_content_npc_definition_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_dependency` ADD CONSTRAINT `fk_content_asset_dependency_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_pack` ADD CONSTRAINT `fk_content_content_pack_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= content --> workforce (16 constraint(s)) =========
-- Requires: content schema, workforce schema
ALTER TABLE `gaming_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_bundle` ADD CONSTRAINT `fk_content_asset_bundle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_string` ADD CONSTRAINT `fk_content_localization_string_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`localization_translation` ADD CONSTRAINT `fk_content_localization_translation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`level_map` ADD CONSTRAINT `fk_content_level_map_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`npc_definition` ADD CONSTRAINT `fk_content_npc_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_release` ADD CONSTRAINT `fk_content_content_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`patch` ADD CONSTRAINT `fk_content_patch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`seasonal_event` ADD CONSTRAINT `fk_content_seasonal_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_review` ADD CONSTRAINT `fk_content_asset_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_deployment` ADD CONSTRAINT `fk_content_content_deployment_primary_content_deployer_employee_id` FOREIGN KEY (`primary_content_deployer_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`asset_dependency` ADD CONSTRAINT `fk_content_asset_dependency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_pack` ADD CONSTRAINT `fk_content_content_pack_approval_user_employee_id` FOREIGN KEY (`approval_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`content`.`content_pack` ADD CONSTRAINT `fk_content_content_pack_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= esports --> billing (2 constraint(s)) =========
-- Requires: esports schema, billing schema
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ADD CONSTRAINT `fk_esports_tournament_registration_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= esports --> community (8 constraint(s)) =========
-- Requires: esports schema, community schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `gaming_ecm`.`community`.`forum`(`forum_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `gaming_ecm`.`community`.`forum`(`forum_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `gaming_ecm`.`community`.`forum`(`forum_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_player_feedback_id` FOREIGN KEY (`player_feedback_id`) REFERENCES `gaming_ecm`.`community`.`player_feedback`(`player_feedback_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ADD CONSTRAINT `fk_esports_tournament_registration_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ADD CONSTRAINT `fk_esports_team_event_participation_community_event_id` FOREIGN KEY (`community_event_id`) REFERENCES `gaming_ecm`.`community`.`community_event`(`community_event_id`);

-- ========= esports --> compliance (11 constraint(s)) =========
-- Requires: esports schema, compliance schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ADD CONSTRAINT `fk_esports_broadcast_viewership_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ADD CONSTRAINT `fk_esports_tournament_registration_age_verification_event_id` FOREIGN KEY (`age_verification_event_id`) REFERENCES `gaming_ecm`.`compliance`.`age_verification_event`(`age_verification_event_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ADD CONSTRAINT `fk_esports_match_incident_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);

-- ========= esports --> content (9 constraint(s)) =========
-- Requires: esports schema, content schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ADD CONSTRAINT `fk_esports_broadcast_viewership_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ADD CONSTRAINT `fk_esports_team_asset_license_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ADD CONSTRAINT `fk_esports_tournament_asset_usage_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);

-- ========= esports --> finance (49 constraint(s)) =========
-- Requires: esports schema, finance schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `gaming_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_intercompany_transaction_id` FOREIGN KEY (`intercompany_transaction_id`) REFERENCES `gaming_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_period_close_id` FOREIGN KEY (`period_close_id`) REFERENCES `gaming_ecm`.`finance`.`period_close`(`period_close_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_title_pl_id` FOREIGN KEY (`title_pl_id`) REFERENCES `gaming_ecm`.`finance`.`title_pl`(`title_pl_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `gaming_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_intercompany_transaction_id` FOREIGN KEY (`intercompany_transaction_id`) REFERENCES `gaming_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_period_close_id` FOREIGN KEY (`period_close_id`) REFERENCES `gaming_ecm`.`finance`.`period_close`(`period_close_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_title_pl_id` FOREIGN KEY (`title_pl_id`) REFERENCES `gaming_ecm`.`finance`.`title_pl`(`title_pl_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_intercompany_transaction_id` FOREIGN KEY (`intercompany_transaction_id`) REFERENCES `gaming_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_studio_pl_id` FOREIGN KEY (`studio_pl_id`) REFERENCES `gaming_ecm`.`finance`.`studio_pl`(`studio_pl_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_finance_tax_record_id` FOREIGN KEY (`finance_tax_record_id`) REFERENCES `gaming_ecm`.`finance`.`finance_tax_record`(`finance_tax_record_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_title_pl_id` FOREIGN KEY (`title_pl_id`) REFERENCES `gaming_ecm`.`finance`.`title_pl`(`title_pl_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_period_close_id` FOREIGN KEY (`period_close_id`) REFERENCES `gaming_ecm`.`finance`.`period_close`(`period_close_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_finance_tax_record_id` FOREIGN KEY (`finance_tax_record_id`) REFERENCES `gaming_ecm`.`finance`.`finance_tax_record`(`finance_tax_record_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_royalty_accrual_id` FOREIGN KEY (`royalty_accrual_id`) REFERENCES `gaming_ecm`.`finance`.`royalty_accrual`(`royalty_accrual_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_deferred_revenue_id` FOREIGN KEY (`deferred_revenue_id`) REFERENCES `gaming_ecm`.`finance`.`deferred_revenue`(`deferred_revenue_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_period_close_id` FOREIGN KEY (`period_close_id`) REFERENCES `gaming_ecm`.`finance`.`period_close`(`period_close_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_deferred_revenue_id` FOREIGN KEY (`deferred_revenue_id`) REFERENCES `gaming_ecm`.`finance`.`deferred_revenue`(`deferred_revenue_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_period_close_id` FOREIGN KEY (`period_close_id`) REFERENCES `gaming_ecm`.`finance`.`period_close`(`period_close_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= esports --> infrastructure (6 constraint(s)) =========
-- Requires: esports schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ADD CONSTRAINT `fk_esports_broadcast_viewership_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);

-- ========= esports --> licensing (6 constraint(s)) =========
-- Requires: esports schema, licensing schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_royalty_report_id` FOREIGN KEY (`royalty_report_id`) REFERENCES `gaming_ecm`.`licensing`.`royalty_report`(`royalty_report_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_brand_partnership_id` FOREIGN KEY (`brand_partnership_id`) REFERENCES `gaming_ecm`.`licensing`.`brand_partnership`(`brand_partnership_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ADD CONSTRAINT `fk_esports_tournament_promotion_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);

-- ========= esports --> marketing (1 constraint(s)) =========
-- Requires: esports schema, marketing schema
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ADD CONSTRAINT `fk_esports_league_influencer_partnership_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `gaming_ecm`.`marketing`.`influencer`(`influencer_id`);

-- ========= esports --> platform (9 constraint(s)) =========
-- Requires: esports schema, platform schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_compatibility_profile_id` FOREIGN KEY (`compatibility_profile_id`) REFERENCES `gaming_ecm`.`platform`.`compatibility_profile`(`compatibility_profile_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);

-- ========= esports --> player (9 constraint(s)) =========
-- Requires: esports schema, player schema
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ADD CONSTRAINT `fk_esports_broadcast_viewership_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ADD CONSTRAINT `fk_esports_tournament_registration_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ADD CONSTRAINT `fk_esports_match_incident_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ADD CONSTRAINT `fk_esports_match_stat_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ADD CONSTRAINT `fk_esports_transfer_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= esports --> studio (1 constraint(s)) =========
-- Requires: esports schema, studio schema
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);

-- ========= esports --> title (18 constraint(s)) =========
-- Requires: esports schema, title schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team` ADD CONSTRAINT `fk_esports_team_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ADD CONSTRAINT `fk_esports_match_stat_playable_character_id` FOREIGN KEY (`playable_character_id`) REFERENCES `gaming_ecm`.`title`.`playable_character`(`playable_character_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ADD CONSTRAINT `fk_esports_match_stat_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`round` ADD CONSTRAINT `fk_esports_round_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`division` ADD CONSTRAINT `fk_esports_division_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`esports`.`transfer_window` ADD CONSTRAINT `fk_esports_transfer_window_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= esports --> workforce (14 constraint(s)) =========
-- Requires: esports schema, workforce schema
ALTER TABLE `gaming_ecm`.`esports`.`league` ADD CONSTRAINT `fk_esports_league_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_bracket_employee_id` FOREIGN KEY (`bracket_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ADD CONSTRAINT `fk_esports_match_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ADD CONSTRAINT `fk_esports_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ADD CONSTRAINT `fk_esports_team_asset_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> analytics (2 constraint(s)) =========
-- Requires: finance schema, analytics schema
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ADD CONSTRAINT `fk_finance_intangible_asset_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);

-- ========= finance --> compliance (5 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ADD CONSTRAINT `fk_finance_finance_tax_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ADD CONSTRAINT `fk_finance_regulatory_disclosure_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ADD CONSTRAINT `fk_finance_regulatory_disclosure_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ADD CONSTRAINT `fk_finance_compliance_allocation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ADD CONSTRAINT `fk_finance_entity_registration_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= finance --> licensing (7 constraint(s)) =========
-- Requires: finance schema, licensing schema
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ADD CONSTRAINT `fk_finance_royalty_statement_contract_ip_agreement_id` FOREIGN KEY (`contract_ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ADD CONSTRAINT `fk_finance_royalty_statement_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ADD CONSTRAINT `fk_finance_royalty_statement_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ADD CONSTRAINT `fk_finance_intangible_asset_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);

-- ========= finance --> platform (2 constraint(s)) =========
-- Requires: finance schema, platform schema
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= finance --> player (1 constraint(s)) =========
-- Requires: finance schema, player schema
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= finance --> studio (11 constraint(s)) =========
-- Requires: finance schema, studio schema
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ADD CONSTRAINT `fk_finance_title_pl_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ADD CONSTRAINT `fk_finance_studio_pl_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ADD CONSTRAINT `fk_finance_intangible_asset_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);

-- ========= finance --> title (14 constraint(s)) =========
-- Requires: finance schema, title schema
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ADD CONSTRAINT `fk_finance_title_pl_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ADD CONSTRAINT `fk_finance_royalty_statement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ADD CONSTRAINT `fk_finance_intangible_asset_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= finance --> workforce (13 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_tertiary_journal_approved_by_user_employee_id` FOREIGN KEY (`tertiary_journal_approved_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_quaternary_budget_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_budget_last_modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_tertiary_budget_created_by_user_employee_id` FOREIGN KEY (`tertiary_budget_created_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ADD CONSTRAINT `fk_finance_royalty_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_quaternary_period_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_period_last_modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_tertiary_period_created_by_user_employee_id` FOREIGN KEY (`tertiary_period_created_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_assigned_by_employee_id` FOREIGN KEY (`assigned_by_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_revoked_by_employee_id` FOREIGN KEY (`revoked_by_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= infrastructure --> analytics (4 constraint(s)) =========
-- Requires: infrastructure schema, analytics schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ADD CONSTRAINT `fk_infrastructure_capacity_plan_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_session_event_summary_id` FOREIGN KEY (`session_event_summary_id`) REFERENCES `gaming_ecm`.`analytics`.`session_event_summary`(`session_event_summary_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);

-- ========= infrastructure --> community (1 constraint(s)) =========
-- Requires: infrastructure schema, community schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);

-- ========= infrastructure --> compliance (14 constraint(s)) =========
-- Requires: infrastructure schema, compliance schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ADD CONSTRAINT `fk_infrastructure_game_server_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ADD CONSTRAINT `fk_infrastructure_server_fleet_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ADD CONSTRAINT `fk_infrastructure_cdn_node_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ADD CONSTRAINT `fk_infrastructure_matchmaking_pool_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ADD CONSTRAINT `fk_infrastructure_network_region_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ADD CONSTRAINT `fk_infrastructure_capacity_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `gaming_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ADD CONSTRAINT `fk_infrastructure_cicd_pipeline_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ADD CONSTRAINT `fk_infrastructure_maintenance_window_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);

-- ========= infrastructure --> esports (2 constraint(s)) =========
-- Requires: infrastructure schema, esports schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ADD CONSTRAINT `fk_infrastructure_maintenance_window_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);

-- ========= infrastructure --> finance (19 constraint(s)) =========
-- Requires: infrastructure schema, finance schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ADD CONSTRAINT `fk_infrastructure_game_server_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ADD CONSTRAINT `fk_infrastructure_server_fleet_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ADD CONSTRAINT `fk_infrastructure_server_fleet_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ADD CONSTRAINT `fk_infrastructure_cdn_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ADD CONSTRAINT `fk_infrastructure_cdn_node_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ADD CONSTRAINT `fk_infrastructure_matchmaking_pool_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ADD CONSTRAINT `fk_infrastructure_network_region_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ADD CONSTRAINT `fk_infrastructure_capacity_plan_budget_version_id` FOREIGN KEY (`budget_version_id`) REFERENCES `gaming_ecm`.`finance`.`budget_version`(`budget_version_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ADD CONSTRAINT `fk_infrastructure_capacity_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_title_pl_id` FOREIGN KEY (`title_pl_id`) REFERENCES `gaming_ecm`.`finance`.`title_pl`(`title_pl_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_deferred_revenue_id` FOREIGN KEY (`deferred_revenue_id`) REFERENCES `gaming_ecm`.`finance`.`deferred_revenue`(`deferred_revenue_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_intangible_asset_id` FOREIGN KEY (`intangible_asset_id`) REFERENCES `gaming_ecm`.`finance`.`intangible_asset`(`intangible_asset_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ADD CONSTRAINT `fk_infrastructure_cicd_pipeline_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ADD CONSTRAINT `fk_infrastructure_cloud_resource_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ADD CONSTRAINT `fk_infrastructure_cloud_resource_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_title_pl_id` FOREIGN KEY (`title_pl_id`) REFERENCES `gaming_ecm`.`finance`.`title_pl`(`title_pl_id`);

-- ========= infrastructure --> platform (1 constraint(s)) =========
-- Requires: infrastructure schema, platform schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= infrastructure --> player (1 constraint(s)) =========
-- Requires: infrastructure schema, player schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ADD CONSTRAINT `fk_infrastructure_matchmaking_ticket_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= infrastructure --> quality (4 constraint(s)) =========
-- Requires: infrastructure schema, quality schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `gaming_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `gaming_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ADD CONSTRAINT `fk_infrastructure_infrastructure_test_execution_test_case_id` FOREIGN KEY (`test_case_id`) REFERENCES `gaming_ecm`.`quality`.`test_case`(`test_case_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ADD CONSTRAINT `fk_infrastructure_infrastructure_test_execution_quality_test_execution_id` FOREIGN KEY (`quality_test_execution_id`) REFERENCES `gaming_ecm`.`quality`.`quality_test_execution`(`quality_test_execution_id`);

-- ========= infrastructure --> studio (1 constraint(s)) =========
-- Requires: infrastructure schema, studio schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ADD CONSTRAINT `fk_infrastructure_cicd_pipeline_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);

-- ========= infrastructure --> title (13 constraint(s)) =========
-- Requires: infrastructure schema, title schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ADD CONSTRAINT `fk_infrastructure_game_server_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ADD CONSTRAINT `fk_infrastructure_server_fleet_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ADD CONSTRAINT `fk_infrastructure_matchmaking_pool_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ADD CONSTRAINT `fk_infrastructure_matchmaking_pool_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ADD CONSTRAINT `fk_infrastructure_capacity_plan_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ADD CONSTRAINT `fk_infrastructure_cicd_pipeline_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ADD CONSTRAINT `fk_infrastructure_matchmaking_ticket_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= infrastructure --> workforce (12 constraint(s)) =========
-- Requires: infrastructure schema, workforce schema
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ADD CONSTRAINT `fk_infrastructure_capacity_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ADD CONSTRAINT `fk_infrastructure_capacity_plan_primary_capacity_employee_id` FOREIGN KEY (`primary_capacity_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ADD CONSTRAINT `fk_infrastructure_cicd_pipeline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ADD CONSTRAINT `fk_infrastructure_cloud_resource_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ADD CONSTRAINT `fk_infrastructure_maintenance_window_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` ADD CONSTRAINT `fk_infrastructure_change_request_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` ADD CONSTRAINT `fk_infrastructure_change_request_assigned_to_user_employee_id` FOREIGN KEY (`assigned_to_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` ADD CONSTRAINT `fk_infrastructure_change_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` ADD CONSTRAINT `fk_infrastructure_change_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= licensing --> analytics (6 constraint(s)) =========
-- Requires: licensing schema, analytics schema
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);

-- ========= licensing --> billing (6 constraint(s)) =========
-- Requires: licensing schema, billing schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ADD CONSTRAINT `fk_licensing_virtual_currency_account_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= licensing --> compliance (13 constraint(s)) =========
-- Requires: licensing schema, compliance schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ADD CONSTRAINT `fk_licensing_ip_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ADD CONSTRAINT `fk_licensing_ip_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ADD CONSTRAINT `fk_licensing_licensed_ip_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ADD CONSTRAINT `fk_licensing_music_sync_license_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ADD CONSTRAINT `fk_licensing_brand_partnership_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ADD CONSTRAINT `fk_licensing_audit_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ADD CONSTRAINT `fk_licensing_ip_compliance_obligation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= licensing --> content (17 constraint(s)) =========
-- Requires: licensing schema, content schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);

-- ========= licensing --> esports (6 constraint(s)) =========
-- Requires: licensing schema, esports schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ADD CONSTRAINT `fk_licensing_team_brand_license_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);

-- ========= licensing --> finance (30 constraint(s)) =========
-- Requires: licensing schema, finance schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_finance_tax_record_id` FOREIGN KEY (`finance_tax_record_id`) REFERENCES `gaming_ecm`.`finance`.`finance_tax_record`(`finance_tax_record_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `gaming_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `gaming_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_royalty_accrual_id` FOREIGN KEY (`royalty_accrual_id`) REFERENCES `gaming_ecm`.`finance`.`royalty_accrual`(`royalty_accrual_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `gaming_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `gaming_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_royalty_accrual_id` FOREIGN KEY (`royalty_accrual_id`) REFERENCES `gaming_ecm`.`finance`.`royalty_accrual`(`royalty_accrual_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_deferred_revenue_id` FOREIGN KEY (`deferred_revenue_id`) REFERENCES `gaming_ecm`.`finance`.`deferred_revenue`(`deferred_revenue_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `gaming_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_royalty_accrual_id` FOREIGN KEY (`royalty_accrual_id`) REFERENCES `gaming_ecm`.`finance`.`royalty_accrual`(`royalty_accrual_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ADD CONSTRAINT `fk_licensing_ip_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ADD CONSTRAINT `fk_licensing_ip_dispute_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);

-- ========= licensing --> infrastructure (16 constraint(s)) =========
-- Requires: licensing schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ADD CONSTRAINT `fk_licensing_ip_agreement_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ADD CONSTRAINT `fk_licensing_brand_partnership_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ADD CONSTRAINT `fk_licensing_audit_event_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ADD CONSTRAINT `fk_licensing_audit_event_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ADD CONSTRAINT `fk_licensing_audit_event_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ADD CONSTRAINT `fk_licensing_usage_report_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ADD CONSTRAINT `fk_licensing_usage_report_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ADD CONSTRAINT `fk_licensing_rating_submission_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);

-- ========= licensing --> marketing (4 constraint(s)) =========
-- Requires: licensing schema, marketing schema
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);

-- ========= licensing --> platform (5 constraint(s)) =========
-- Requires: licensing schema, platform schema
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ADD CONSTRAINT `fk_licensing_virtual_currency_account_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= licensing --> player (8 constraint(s)) =========
-- Requires: licensing schema, player schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ADD CONSTRAINT `fk_licensing_virtual_currency_account_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);

-- ========= licensing --> studio (22 constraint(s)) =========
-- Requires: licensing schema, studio schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ADD CONSTRAINT `fk_licensing_middleware_agreement_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ADD CONSTRAINT `fk_licensing_music_sync_license_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ADD CONSTRAINT `fk_licensing_rating_submission_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);

-- ========= licensing --> title (28 constraint(s)) =========
-- Requires: licensing schema, title schema
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ADD CONSTRAINT `fk_licensing_virtual_currency_account_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `gaming_ecm`.`title`.`achievement`(`achievement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ADD CONSTRAINT `fk_licensing_ip_agreement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ADD CONSTRAINT `fk_licensing_licensed_ip_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `gaming_ecm`.`title`.`franchise`(`franchise_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ADD CONSTRAINT `fk_licensing_middleware_agreement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ADD CONSTRAINT `fk_licensing_music_sync_license_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ADD CONSTRAINT `fk_licensing_brand_partnership_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ADD CONSTRAINT `fk_licensing_rating_submission_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);

-- ========= licensing --> workforce (14 constraint(s)) =========
-- Requires: licensing schema, workforce schema
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_tertiary_offer_approved_by_user_employee_id` FOREIGN KEY (`tertiary_offer_approved_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ADD CONSTRAINT `fk_licensing_middleware_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_primary_compliance_employee_id` FOREIGN KEY (`primary_compliance_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ADD CONSTRAINT `fk_licensing_ip_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ADD CONSTRAINT `fk_licensing_sublicense_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_promotion_employee_id` FOREIGN KEY (`promotion_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_promotion_modified_by_user_employee_id` FOREIGN KEY (`promotion_modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ADD CONSTRAINT `fk_licensing_catalog_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= marketing --> analytics (8 constraint(s)) =========
-- Requires: marketing schema, analytics schema
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ADD CONSTRAINT `fk_marketing_player_segment_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`creative_test_assignment` ADD CONSTRAINT `fk_marketing_creative_test_assignment_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);

-- ========= marketing --> billing (2 constraint(s)) =========
-- Requires: marketing schema, billing schema
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ADD CONSTRAINT `fk_marketing_campaign_promo_distribution_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `gaming_ecm`.`billing`.`promo_code`(`promo_code_id`);

-- ========= marketing --> compliance (9 constraint(s)) =========
-- Requires: marketing schema, compliance schema
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ADD CONSTRAINT `fk_marketing_marketing_campaign_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ADD CONSTRAINT `fk_marketing_player_segment_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`player_segment` ADD CONSTRAINT `fk_marketing_player_segment_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ADD CONSTRAINT `fk_marketing_consent_record_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_processing_activity_id` FOREIGN KEY (`processing_activity_id`) REFERENCES `gaming_ecm`.`compliance`.`processing_activity`(`processing_activity_id`);

-- ========= marketing --> esports (8 constraint(s)) =========
-- Requires: marketing schema, esports schema
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ADD CONSTRAINT `fk_marketing_consent_record_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);

-- ========= marketing --> finance (3 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= marketing --> infrastructure (3 constraint(s)) =========
-- Requires: marketing schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ADD CONSTRAINT `fk_marketing_marketing_campaign_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);

-- ========= marketing --> licensing (10 constraint(s)) =========
-- Requires: marketing schema, licensing schema
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ADD CONSTRAINT `fk_marketing_marketing_campaign_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ADD CONSTRAINT `fk_marketing_aso_listing_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_brand_partnership_id` FOREIGN KEY (`brand_partnership_id`) REFERENCES `gaming_ecm`.`licensing`.`brand_partnership`(`brand_partnership_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer_campaign` ADD CONSTRAINT `fk_marketing_influencer_campaign_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);

-- ========= marketing --> monetization (3 constraint(s)) =========
-- Requires: marketing schema, monetization schema
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_player_ltv_segment_id` FOREIGN KEY (`player_ltv_segment_id`) REFERENCES `gaming_ecm`.`monetization`.`player_ltv_segment`(`player_ltv_segment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ADD CONSTRAINT `fk_marketing_campaign_exposure_ad_impression_id` FOREIGN KEY (`ad_impression_id`) REFERENCES `gaming_ecm`.`monetization`.`ad_impression`(`ad_impression_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ADD CONSTRAINT `fk_marketing_campaign_exposure_ad_placement_id` FOREIGN KEY (`ad_placement_id`) REFERENCES `gaming_ecm`.`monetization`.`ad_placement`(`ad_placement_id`);

-- ========= marketing --> platform (1 constraint(s)) =========
-- Requires: marketing schema, platform schema
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= marketing --> player (9 constraint(s)) =========
-- Requires: marketing schema, player schema
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`attribution_record` ADD CONSTRAINT `fk_marketing_attribution_record_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ADD CONSTRAINT `fk_marketing_consent_record_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ADD CONSTRAINT `fk_marketing_consent_record_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `gaming_ecm`.`player`.`segment`(`segment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_exposure` ADD CONSTRAINT `fk_marketing_campaign_exposure_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ADD CONSTRAINT `fk_marketing_campaign_promo_distribution_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `gaming_ecm`.`player`.`segment`(`segment_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ADD CONSTRAINT `fk_marketing_suppression_list_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ADD CONSTRAINT `fk_marketing_suppression_list_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= marketing --> quality (1 constraint(s)) =========
-- Requires: marketing schema, quality schema
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_release_gate_id` FOREIGN KEY (`release_gate_id`) REFERENCES `gaming_ecm`.`quality`.`release_gate`(`release_gate_id`);

-- ========= marketing --> title (16 constraint(s)) =========
-- Requires: marketing schema, title schema
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_campaign` ADD CONSTRAINT `fk_marketing_marketing_campaign_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_game_edition_id` FOREIGN KEY (`game_edition_id`) REFERENCES `gaming_ecm`.`title`.`game_edition`(`game_edition_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`retention_cohort` ADD CONSTRAINT `fk_marketing_retention_cohort_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ADD CONSTRAINT `fk_marketing_aso_listing_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_title_season_id` FOREIGN KEY (`title_season_id`) REFERENCES `gaming_ecm`.`title`.`title_season`(`title_season_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`consent_record` ADD CONSTRAINT `fk_marketing_consent_record_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`message_template` ADD CONSTRAINT `fk_marketing_message_template_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ADD CONSTRAINT `fk_marketing_suppression_list_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= marketing --> workforce (18 constraint(s)) =========
-- Requires: marketing schema, workforce schema
ALTER TABLE `gaming_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`aso_listing` ADD CONSTRAINT `fk_marketing_aso_listing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`influencer` ADD CONSTRAINT `fk_marketing_influencer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`crm_campaign` ADD CONSTRAINT `fk_marketing_crm_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`launch_event` ADD CONSTRAINT `fk_marketing_launch_event_tertiary_launch_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_launch_last_modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_quaternary_marketing_last_modified_by_employee_id` FOREIGN KEY (`quaternary_marketing_last_modified_by_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_tertiary_marketing_created_by_employee_id` FOREIGN KEY (`tertiary_marketing_created_by_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`audience` ADD CONSTRAINT `fk_marketing_audience_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`campaign_promo_distribution` ADD CONSTRAINT `fk_marketing_campaign_promo_distribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`message_template` ADD CONSTRAINT `fk_marketing_message_template_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`message_template` ADD CONSTRAINT `fk_marketing_message_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`message_template` ADD CONSTRAINT `fk_marketing_message_template_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ADD CONSTRAINT `fk_marketing_suppression_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`marketing`.`suppression_list` ADD CONSTRAINT `fk_marketing_suppression_list_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= monetization --> analytics (3 constraint(s)) =========
-- Requires: monetization schema, analytics schema
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);

-- ========= monetization --> billing (4 constraint(s)) =========
-- Requires: monetization schema, billing schema
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `gaming_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);

-- ========= monetization --> compliance (4 constraint(s)) =========
-- Requires: monetization schema, compliance schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= monetization --> content (5 constraint(s)) =========
-- Requires: monetization schema, content schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);

-- ========= monetization --> esports (3 constraint(s)) =========
-- Requires: monetization schema, esports schema
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);

-- ========= monetization --> finance (15 constraint(s)) =========
-- Requires: monetization schema, finance schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_deferred_revenue_id` FOREIGN KEY (`deferred_revenue_id`) REFERENCES `gaming_ecm`.`finance`.`deferred_revenue`(`deferred_revenue_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_finance_tax_record_id` FOREIGN KEY (`finance_tax_record_id`) REFERENCES `gaming_ecm`.`finance`.`finance_tax_record`(`finance_tax_record_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_deferred_revenue_id` FOREIGN KEY (`deferred_revenue_id`) REFERENCES `gaming_ecm`.`finance`.`deferred_revenue`(`deferred_revenue_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_finance_tax_record_id` FOREIGN KEY (`finance_tax_record_id`) REFERENCES `gaming_ecm`.`finance`.`finance_tax_record`(`finance_tax_record_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `gaming_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= monetization --> infrastructure (2 constraint(s)) =========
-- Requires: monetization schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);

-- ========= monetization --> licensing (3 constraint(s)) =========
-- Requires: monetization schema, licensing schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);

-- ========= monetization --> marketing (8 constraint(s)) =========
-- Requires: monetization schema, marketing schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_ad_network_id` FOREIGN KEY (`ad_network_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_network`(`ad_network_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);

-- ========= monetization --> platform (7 constraint(s)) =========
-- Requires: monetization schema, platform schema
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= monetization --> player (8 constraint(s)) =========
-- Requires: monetization schema, player schema
ALTER TABLE `gaming_ecm`.`monetization`.`player_subscription` ADD CONSTRAINT `fk_monetization_player_subscription_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);

-- ========= monetization --> studio (3 constraint(s)) =========
-- Requires: monetization schema, studio schema
ALTER TABLE `gaming_ecm`.`monetization`.`subscription_plan` ADD CONSTRAINT `fk_monetization_subscription_plan_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);

-- ========= monetization --> title (10 constraint(s)) =========
-- Requires: monetization schema, title schema
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`dlc_entitlement` ADD CONSTRAINT `fk_monetization_dlc_entitlement_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`player_ltv_segment` ADD CONSTRAINT `fk_monetization_player_ltv_segment_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_impression` ADD CONSTRAINT `fk_monetization_ad_impression_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`storefront_transaction` ADD CONSTRAINT `fk_monetization_storefront_transaction_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= monetization --> workforce (5 constraint(s)) =========
-- Requires: monetization schema, workforce schema
ALTER TABLE `gaming_ecm`.`monetization`.`ad_placement` ADD CONSTRAINT `fk_monetization_ad_placement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`price_point` ADD CONSTRAINT `fk_monetization_price_point_tertiary_price_updated_by_user_employee_id` FOREIGN KEY (`tertiary_price_updated_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`monetization`.`ad_unit` ADD CONSTRAINT `fk_monetization_ad_unit_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= platform --> billing (2 constraint(s)) =========
-- Requires: platform schema, billing schema
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `gaming_ecm`.`billing`.`promo_code`(`promo_code_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);

-- ========= platform --> compliance (27 constraint(s)) =========
-- Requires: platform schema, compliance schema
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_age_verification_event_id` FOREIGN KEY (`age_verification_event_id`) REFERENCES `gaming_ecm`.`compliance`.`age_verification_event`(`age_verification_event_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_age_verification_event_id` FOREIGN KEY (`age_verification_event_id`) REFERENCES `gaming_ecm`.`compliance`.`age_verification_event`(`age_verification_event_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_third_party_processor_id` FOREIGN KEY (`third_party_processor_id`) REFERENCES `gaming_ecm`.`compliance`.`third_party_processor`(`third_party_processor_id`);
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ADD CONSTRAINT `fk_platform_build_submission_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ADD CONSTRAINT `fk_platform_build_submission_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ADD CONSTRAINT `fk_platform_compliance_event_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ADD CONSTRAINT `fk_platform_compliance_event_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ADD CONSTRAINT `fk_platform_crossplay_feature_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_loot_box_disclosure_id` FOREIGN KEY (`loot_box_disclosure_id`) REFERENCES `gaming_ecm`.`compliance`.`loot_box_disclosure`(`loot_box_disclosure_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ADD CONSTRAINT `fk_platform_developer_account_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ADD CONSTRAINT `fk_platform_developer_account_third_party_processor_id` FOREIGN KEY (`third_party_processor_id`) REFERENCES `gaming_ecm`.`compliance`.`third_party_processor`(`third_party_processor_id`);
ALTER TABLE `gaming_ecm`.`platform`.`developer_compliance` ADD CONSTRAINT `fk_platform_developer_compliance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= platform --> content (3 constraint(s)) =========
-- Requires: platform schema, content schema
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);

-- ========= platform --> finance (8 constraint(s)) =========
-- Requires: platform schema, finance schema
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ADD CONSTRAINT `fk_platform_build_submission_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ADD CONSTRAINT `fk_platform_compliance_event_finance_tax_record_id` FOREIGN KEY (`finance_tax_record_id`) REFERENCES `gaming_ecm`.`finance`.`finance_tax_record`(`finance_tax_record_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_deferred_revenue_id` FOREIGN KEY (`deferred_revenue_id`) REFERENCES `gaming_ecm`.`finance`.`deferred_revenue`(`deferred_revenue_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ADD CONSTRAINT `fk_platform_developer_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= platform --> infrastructure (10 constraint(s)) =========
-- Requires: platform schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ADD CONSTRAINT `fk_platform_build_submission_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_capacity_plan_id` FOREIGN KEY (`capacity_plan_id`) REFERENCES `gaming_ecm`.`infrastructure`.`capacity_plan`(`capacity_plan_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ADD CONSTRAINT `fk_platform_crossplay_feature_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_infrastructure_deployment_id` FOREIGN KEY (`infrastructure_deployment_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_deployment`(`infrastructure_deployment_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);

-- ========= platform --> licensing (10 constraint(s)) =========
-- Requires: platform schema, licensing schema
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_middleware_agreement_id` FOREIGN KEY (`middleware_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`middleware_agreement`(`middleware_agreement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ADD CONSTRAINT `fk_platform_compliance_event_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ADD CONSTRAINT `fk_platform_crossplay_feature_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ADD CONSTRAINT `fk_platform_compatibility_profile_middleware_agreement_id` FOREIGN KEY (`middleware_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`middleware_agreement`(`middleware_agreement_id`);
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ADD CONSTRAINT `fk_platform_developer_account_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);

-- ========= platform --> marketing (8 constraint(s)) =========
-- Requires: platform schema, marketing schema
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_ad_network_id` FOREIGN KEY (`ad_network_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_network`(`ad_network_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_launch_event_id` FOREIGN KEY (`launch_event_id`) REFERENCES `gaming_ecm`.`marketing`.`launch_event`(`launch_event_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_aso_listing_id` FOREIGN KEY (`aso_listing_id`) REFERENCES `gaming_ecm`.`marketing`.`aso_listing`(`aso_listing_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_campaign` ADD CONSTRAINT `fk_platform_storefront_campaign_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`platform`.`creative_listing_assignment` ADD CONSTRAINT `fk_platform_creative_listing_assignment_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `gaming_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);

-- ========= platform --> player (5 constraint(s)) =========
-- Requires: platform schema, player schema
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_platform_identity_id` FOREIGN KEY (`platform_identity_id`) REFERENCES `gaming_ecm`.`player`.`platform_identity`(`platform_identity_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_device_id` FOREIGN KEY (`device_id`) REFERENCES `gaming_ecm`.`player`.`device`(`device_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_platform_identity_id` FOREIGN KEY (`platform_identity_id`) REFERENCES `gaming_ecm`.`player`.`platform_identity`(`platform_identity_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= platform --> studio (3 constraint(s)) =========
-- Requires: platform schema, studio schema
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ADD CONSTRAINT `fk_platform_build_submission_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_release` ADD CONSTRAINT `fk_platform_storefront_release_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);

-- ========= platform --> title (19 constraint(s)) =========
-- Requires: platform schema, title schema
ALTER TABLE `gaming_ecm`.`platform`.`platform_sku` ADD CONSTRAINT `fk_platform_platform_sku_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`sdk_integration` ADD CONSTRAINT `fk_platform_sdk_integration_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ADD CONSTRAINT `fk_platform_build_submission_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`release_schedule` ADD CONSTRAINT `fk_platform_release_schedule_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compliance_event` ADD CONSTRAINT `fk_platform_compliance_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`crossplay_feature` ADD CONSTRAINT `fk_platform_crossplay_feature_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`storefront_listing` ADD CONSTRAINT `fk_platform_storefront_listing_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`pricing` ADD CONSTRAINT `fk_platform_pricing_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`compatibility_profile` ADD CONSTRAINT `fk_platform_compatibility_profile_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`platform`.`certification_certificate` ADD CONSTRAINT `fk_platform_certification_certificate_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= platform --> workforce (9 constraint(s)) =========
-- Requires: platform schema, workforce schema
ALTER TABLE `gaming_ecm`.`platform`.`storefront` ADD CONSTRAINT `fk_platform_storefront_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `gaming_ecm`.`platform`.`platform_cert_submission` ADD CONSTRAINT `fk_platform_platform_cert_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`platform`.`certification_checklist` ADD CONSTRAINT `fk_platform_certification_checklist_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `gaming_ecm`.`platform`.`checklist_requirement` ADD CONSTRAINT `fk_platform_checklist_requirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`platform`.`drm_entitlement` ADD CONSTRAINT `fk_platform_drm_entitlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`platform`.`entitlement_grant` ADD CONSTRAINT `fk_platform_entitlement_grant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`platform`.`build_submission` ADD CONSTRAINT `fk_platform_build_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`platform`.`patch_release` ADD CONSTRAINT `fk_platform_patch_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`platform`.`developer_account` ADD CONSTRAINT `fk_platform_developer_account_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= player --> analytics (2 constraint(s)) =========
-- Requires: player schema, analytics schema
ALTER TABLE `gaming_ecm`.`player`.`segment` ADD CONSTRAINT `fk_player_segment_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ADD CONSTRAINT `fk_player_player_lifecycle_event_telemetry_pipeline_id` FOREIGN KEY (`telemetry_pipeline_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_pipeline`(`telemetry_pipeline_id`);

-- ========= player --> billing (1 constraint(s)) =========
-- Requires: player schema, billing schema
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ADD CONSTRAINT `fk_player_dlc_purchase_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);

-- ========= player --> community (1 constraint(s)) =========
-- Requires: player schema, community schema
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);

-- ========= player --> compliance (3 constraint(s)) =========
-- Requires: player schema, compliance schema
ALTER TABLE `gaming_ecm`.`player`.`consent_snapshot` ADD CONSTRAINT `fk_player_consent_snapshot_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `gaming_ecm`.`player`.`parental_control` ADD CONSTRAINT `fk_player_parental_control_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`player`.`preference` ADD CONSTRAINT `fk_player_preference_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `gaming_ecm`.`compliance`.`consent_policy`(`consent_policy_id`);

-- ========= player --> infrastructure (4 constraint(s)) =========
-- Requires: player schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`player`.`device` ADD CONSTRAINT `fk_player_device_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ADD CONSTRAINT `fk_player_authentication_log_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);

-- ========= player --> licensing (1 constraint(s)) =========
-- Requires: player schema, licensing schema
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);

-- ========= player --> marketing (3 constraint(s)) =========
-- Requires: player schema, marketing schema
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ADD CONSTRAINT `fk_player_segment_membership_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ADD CONSTRAINT `fk_player_segment_membership_player_segment_id` FOREIGN KEY (`player_segment_id`) REFERENCES `gaming_ecm`.`marketing`.`player_segment`(`player_segment_id`);
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ADD CONSTRAINT `fk_player_player_lifecycle_event_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);

-- ========= player --> platform (4 constraint(s)) =========
-- Requires: player schema, platform schema
ALTER TABLE `gaming_ecm`.`player`.`preference` ADD CONSTRAINT `fk_player_preference_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`player`.`authentication_log` ADD CONSTRAINT `fk_player_authentication_log_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= player --> title (9 constraint(s)) =========
-- Requires: player schema, title schema
ALTER TABLE `gaming_ecm`.`player`.`preference` ADD CONSTRAINT `fk_player_preference_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`player`.`segment_membership` ADD CONSTRAINT `fk_player_segment_membership_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`player`.`ltv_record` ADD CONSTRAINT `fk_player_ltv_record_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`player`.`player_lifecycle_event` ADD CONSTRAINT `fk_player_player_lifecycle_event_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_checkpoint_id` FOREIGN KEY (`checkpoint_id`) REFERENCES `gaming_ecm`.`title`.`checkpoint`(`checkpoint_id`);
ALTER TABLE `gaming_ecm`.`player`.`dlc_purchase` ADD CONSTRAINT `fk_player_dlc_purchase_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);

-- ========= player --> workforce (5 constraint(s)) =========
-- Requires: player schema, workforce schema
ALTER TABLE `gaming_ecm`.`player`.`player_account` ADD CONSTRAINT `fk_player_player_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`player`.`segment` ADD CONSTRAINT `fk_player_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`player`.`session` ADD CONSTRAINT `fk_player_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`player`.`ban_record` ADD CONSTRAINT `fk_player_ban_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`player`.`title_progress` ADD CONSTRAINT `fk_player_title_progress_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> analytics (23 constraint(s)) =========
-- Requires: quality schema, analytics schema
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_telemetry_event_id` FOREIGN KEY (`telemetry_event_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_event`(`telemetry_event_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_triage` ADD CONSTRAINT `fk_quality_defect_triage_experiment_assignment_id` FOREIGN KEY (`experiment_assignment_id`) REFERENCES `gaming_ecm`.`analytics`.`experiment_assignment`(`experiment_assignment_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_experiment_assignment_id` FOREIGN KEY (`experiment_assignment_id`) REFERENCES `gaming_ecm`.`analytics`.`experiment_assignment`(`experiment_assignment_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_telemetry_event_id` FOREIGN KEY (`telemetry_event_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_event`(`telemetry_event_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate` ADD CONSTRAINT `fk_quality_release_gate_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`quality`.`perf_test_run` ADD CONSTRAINT `fk_quality_perf_test_run_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`quality`.`stability_benchmark` ADD CONSTRAINT `fk_quality_stability_benchmark_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `gaming_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_live_ops_signal_id` FOREIGN KEY (`live_ops_signal_id`) REFERENCES `gaming_ecm`.`analytics`.`live_ops_signal`(`live_ops_signal_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_ml_model_registry_id` FOREIGN KEY (`ml_model_registry_id`) REFERENCES `gaming_ecm`.`analytics`.`ml_model_registry`(`ml_model_registry_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_player_behavior_segment_id` FOREIGN KEY (`player_behavior_segment_id`) REFERENCES `gaming_ecm`.`analytics`.`player_behavior_segment`(`player_behavior_segment_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_player_prediction_record_id` FOREIGN KEY (`player_prediction_record_id`) REFERENCES `gaming_ecm`.`analytics`.`player_prediction_record`(`player_prediction_record_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_telemetry_event_id` FOREIGN KEY (`telemetry_event_id`) REFERENCES `gaming_ecm`.`analytics`.`telemetry_event`(`telemetry_event_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_ab_experiment_id` FOREIGN KEY (`ab_experiment_id`) REFERENCES `gaming_ecm`.`analytics`.`ab_experiment`(`ab_experiment_id`);

-- ========= quality --> compliance (19 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_audit_schedule_id` FOREIGN KEY (`audit_schedule_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_schedule`(`audit_schedule_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_triage` ADD CONSTRAINT `fk_quality_defect_triage_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_age_verification_event_id` FOREIGN KEY (`age_verification_event_id`) REFERENCES `gaming_ecm`.`compliance`.`age_verification_event`(`age_verification_event_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `gaming_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate` ADD CONSTRAINT `fk_quality_release_gate_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate` ADD CONSTRAINT `fk_quality_release_gate_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate_review` ADD CONSTRAINT `fk_quality_release_gate_review_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `gaming_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_waiver` ADD CONSTRAINT `fk_quality_defect_waiver_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);

-- ========= quality --> content (36 constraint(s)) =========
-- Requires: quality schema, content schema
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `gaming_ecm`.`content`.`asset_version`(`asset_version_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_npc_definition_id` FOREIGN KEY (`npc_definition_id`) REFERENCES `gaming_ecm`.`content`.`npc_definition`(`npc_definition_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_npc_definition_id` FOREIGN KEY (`npc_definition_id`) REFERENCES `gaming_ecm`.`content`.`npc_definition`(`npc_definition_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `gaming_ecm`.`content`.`asset_version`(`asset_version_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_cycle` ADD CONSTRAINT `fk_quality_test_cycle_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_npc_definition_id` FOREIGN KEY (`npc_definition_id`) REFERENCES `gaming_ecm`.`content`.`npc_definition`(`npc_definition_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_patch_id` FOREIGN KEY (`patch_id`) REFERENCES `gaming_ecm`.`content`.`patch`(`patch_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_localization_string_id` FOREIGN KEY (`localization_string_id`) REFERENCES `gaming_ecm`.`content`.`localization_string`(`localization_string_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate` ADD CONSTRAINT `fk_quality_release_gate_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`quality`.`perf_test_run` ADD CONSTRAINT `fk_quality_perf_test_run_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);

-- ========= quality --> esports (7 constraint(s)) =========
-- Requires: quality schema, esports schema
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_cycle` ADD CONSTRAINT `fk_quality_test_cycle_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`quality`.`perf_test_run` ADD CONSTRAINT `fk_quality_perf_test_run_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);

-- ========= quality --> finance (7 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate` ADD CONSTRAINT `fk_quality_release_gate_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_regulatory_disclosure_id` FOREIGN KEY (`regulatory_disclosure_id`) REFERENCES `gaming_ecm`.`finance`.`regulatory_disclosure`(`regulatory_disclosure_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_waiver` ADD CONSTRAINT `fk_quality_defect_waiver_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);

-- ========= quality --> infrastructure (13 constraint(s)) =========
-- Requires: quality schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`quality`.`perf_test_run` ADD CONSTRAINT `fk_quality_perf_test_run_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`quality`.`perf_test_run` ADD CONSTRAINT `fk_quality_perf_test_run_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);

-- ========= quality --> licensing (17 constraint(s)) =========
-- Requires: quality schema, licensing schema
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_gacha_pool_id` FOREIGN KEY (`gacha_pool_id`) REFERENCES `gaming_ecm`.`licensing`.`gacha_pool`(`gacha_pool_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_waiver` ADD CONSTRAINT `fk_quality_defect_waiver_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);

-- ========= quality --> platform (38 constraint(s)) =========
-- Requires: quality schema, platform schema
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_platform_cert_submission_id` FOREIGN KEY (`platform_cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`platform_cert_submission`(`platform_cert_submission_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_platform_cert_submission_id` FOREIGN KEY (`platform_cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`platform_cert_submission`(`platform_cert_submission_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_cycle` ADD CONSTRAINT `fk_quality_test_cycle_platform_cert_submission_id` FOREIGN KEY (`platform_cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`platform_cert_submission`(`platform_cert_submission_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_cycle` ADD CONSTRAINT `fk_quality_test_cycle_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_platform_cert_submission_id` FOREIGN KEY (`platform_cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`platform_cert_submission`(`platform_cert_submission_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate` ADD CONSTRAINT `fk_quality_release_gate_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate` ADD CONSTRAINT `fk_quality_release_gate_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate_review` ADD CONSTRAINT `fk_quality_release_gate_review_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`perf_test_run` ADD CONSTRAINT `fk_quality_perf_test_run_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`quality`.`perf_test_run` ADD CONSTRAINT `fk_quality_perf_test_run_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`stability_benchmark` ADD CONSTRAINT `fk_quality_stability_benchmark_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_drm_entitlement_id` FOREIGN KEY (`drm_entitlement_id`) REFERENCES `gaming_ecm`.`platform`.`drm_entitlement`(`drm_entitlement_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_platform_cert_submission_id` FOREIGN KEY (`platform_cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`platform_cert_submission`(`platform_cert_submission_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_platform_sku_id` FOREIGN KEY (`platform_sku_id`) REFERENCES `gaming_ecm`.`platform`.`platform_sku`(`platform_sku_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_checklist_requirement_id` FOREIGN KEY (`checklist_requirement_id`) REFERENCES `gaming_ecm`.`platform`.`checklist_requirement`(`checklist_requirement_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);

-- ========= quality --> player (7 constraint(s)) =========
-- Requires: quality schema, player schema
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_session_id` FOREIGN KEY (`session_id`) REFERENCES `gaming_ecm`.`player`.`session`(`session_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= quality --> studio (27 constraint(s)) =========
-- Requires: quality schema, studio schema
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_sprint_id` FOREIGN KEY (`sprint_id`) REFERENCES `gaming_ecm`.`studio`.`sprint`(`sprint_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_sprint_id` FOREIGN KEY (`sprint_id`) REFERENCES `gaming_ecm`.`studio`.`sprint`(`sprint_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_sprint_id` FOREIGN KEY (`sprint_id`) REFERENCES `gaming_ecm`.`studio`.`sprint`(`sprint_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_cycle` ADD CONSTRAINT `fk_quality_test_cycle_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_cycle` ADD CONSTRAINT `fk_quality_test_cycle_sprint_id` FOREIGN KEY (`sprint_id`) REFERENCES `gaming_ecm`.`studio`.`sprint`(`sprint_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_triage` ADD CONSTRAINT `fk_quality_defect_triage_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate` ADD CONSTRAINT `fk_quality_release_gate_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate_review` ADD CONSTRAINT `fk_quality_release_gate_review_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate_review` ADD CONSTRAINT `fk_quality_release_gate_review_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`quality`.`perf_test_run` ADD CONSTRAINT `fk_quality_perf_test_run_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_changelist_id` FOREIGN KEY (`changelist_id`) REFERENCES `gaming_ecm`.`studio`.`changelist`(`changelist_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_waiver` ADD CONSTRAINT `fk_quality_defect_waiver_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);

-- ========= quality --> title (29 constraint(s)) =========
-- Requires: quality schema, title schema
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_build_artifact_id` FOREIGN KEY (`build_artifact_id`) REFERENCES `gaming_ecm`.`title`.`build_artifact`(`build_artifact_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_case` ADD CONSTRAINT `fk_quality_test_case_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_title_release_id` FOREIGN KEY (`title_release_id`) REFERENCES `gaming_ecm`.`title`.`title_release`(`title_release_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_cycle` ADD CONSTRAINT `fk_quality_test_cycle_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_triage` ADD CONSTRAINT `fk_quality_defect_triage_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_feedback` ADD CONSTRAINT `fk_quality_playtest_feedback_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_title_sku_id` FOREIGN KEY (`title_sku_id`) REFERENCES `gaming_ecm`.`title`.`title_sku`(`title_sku_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate` ADD CONSTRAINT `fk_quality_release_gate_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate_review` ADD CONSTRAINT `fk_quality_release_gate_review_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`perf_test_run` ADD CONSTRAINT `fk_quality_perf_test_run_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`quality`.`perf_test_run` ADD CONSTRAINT `fk_quality_perf_test_run_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`stability_benchmark` ADD CONSTRAINT `fk_quality_stability_benchmark_game_mode_id` FOREIGN KEY (`game_mode_id`) REFERENCES `gaming_ecm`.`title`.`game_mode`(`game_mode_id`);
ALTER TABLE `gaming_ecm`.`quality`.`stability_benchmark` ADD CONSTRAINT `fk_quality_stability_benchmark_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_dlc_bundle_id` FOREIGN KEY (`dlc_bundle_id`) REFERENCES `gaming_ecm`.`title`.`dlc_bundle`(`dlc_bundle_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_game_edition_id` FOREIGN KEY (`game_edition_id`) REFERENCES `gaming_ecm`.`title`.`game_edition`(`game_edition_id`);
ALTER TABLE `gaming_ecm`.`quality`.`uat_session` ADD CONSTRAINT `fk_quality_uat_session_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `gaming_ecm`.`title`.`content_rating`(`content_rating_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_waiver` ADD CONSTRAINT `fk_quality_defect_waiver_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_suite` ADD CONSTRAINT `fk_quality_test_suite_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= quality --> workforce (20 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_defect_employee_id` FOREIGN KEY (`defect_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`quality_test_execution` ADD CONSTRAINT `fk_quality_quality_test_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_cycle` ADD CONSTRAINT `fk_quality_test_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_triage` ADD CONSTRAINT `fk_quality_defect_triage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_triage` ADD CONSTRAINT `fk_quality_defect_triage_tertiary_defect_reporter_employee_id` FOREIGN KEY (`tertiary_defect_reporter_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`playtest_session` ADD CONSTRAINT `fk_quality_playtest_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`cert_finding` ADD CONSTRAINT `fk_quality_cert_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate` ADD CONSTRAINT `fk_quality_release_gate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate` ADD CONSTRAINT `fk_quality_release_gate_primary_release_employee_id` FOREIGN KEY (`primary_release_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`release_gate_review` ADD CONSTRAINT `fk_quality_release_gate_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`perf_test_run` ADD CONSTRAINT `fk_quality_perf_test_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`stability_benchmark` ADD CONSTRAINT `fk_quality_stability_benchmark_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`crash_report` ADD CONSTRAINT `fk_quality_crash_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`compliance_test_result` ADD CONSTRAINT `fk_quality_compliance_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`defect_waiver` ADD CONSTRAINT `fk_quality_defect_waiver_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_suite` ADD CONSTRAINT `fk_quality_test_suite_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_suite` ADD CONSTRAINT `fk_quality_test_suite_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`quality`.`test_suite` ADD CONSTRAINT `fk_quality_test_suite_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= studio --> billing (3 constraint(s)) =========
-- Requires: studio schema, billing schema
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ADD CONSTRAINT `fk_studio_partnership_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `gaming_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ADD CONSTRAINT `fk_studio_partnership_payout_line_id` FOREIGN KEY (`payout_line_id`) REFERENCES `gaming_ecm`.`billing`.`payout_line`(`payout_line_id`);
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ADD CONSTRAINT `fk_studio_project_budget_allocation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= studio --> community (1 constraint(s)) =========
-- Requires: studio schema, community schema
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `gaming_ecm`.`community`.`forum`(`forum_id`);

-- ========= studio --> compliance (12 constraint(s)) =========
-- Requires: studio schema, compliance schema
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ADD CONSTRAINT `fk_studio_game_studio_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_privacy_impact_assessment_id` FOREIGN KEY (`privacy_impact_assessment_id`) REFERENCES `gaming_ecm`.`compliance`.`privacy_impact_assessment`(`privacy_impact_assessment_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `gaming_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `gaming_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ADD CONSTRAINT `fk_studio_milestone_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_age_rating_cert_id` FOREIGN KEY (`age_rating_cert_id`) REFERENCES `gaming_ecm`.`compliance`.`age_rating_cert`(`age_rating_cert_id`);
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ADD CONSTRAINT `fk_studio_changelist_compliance_incident_id` FOREIGN KEY (`compliance_incident_id`) REFERENCES `gaming_ecm`.`compliance`.`compliance_incident`(`compliance_incident_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `gaming_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ADD CONSTRAINT `fk_studio_partnership_third_party_processor_id` FOREIGN KEY (`third_party_processor_id`) REFERENCES `gaming_ecm`.`compliance`.`third_party_processor`(`third_party_processor_id`);
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_third_party_processor_id` FOREIGN KEY (`third_party_processor_id`) REFERENCES `gaming_ecm`.`compliance`.`third_party_processor`(`third_party_processor_id`);

-- ========= studio --> content (3 constraint(s)) =========
-- Requires: studio schema, content schema
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ADD CONSTRAINT `fk_studio_sprint_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_content_release_id` FOREIGN KEY (`content_release_id`) REFERENCES `gaming_ecm`.`content`.`content_release`(`content_release_id`);

-- ========= studio --> esports (1 constraint(s)) =========
-- Requires: studio schema, esports schema
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);

-- ========= studio --> finance (12 constraint(s)) =========
-- Requires: studio schema, finance schema
ALTER TABLE `gaming_ecm`.`studio`.`game_studio` ADD CONSTRAINT `fk_studio_game_studio_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ADD CONSTRAINT `fk_studio_milestone_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ADD CONSTRAINT `fk_studio_resource_allocation_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ADD CONSTRAINT `fk_studio_partnership_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ADD CONSTRAINT `fk_studio_project_budget_allocation_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ADD CONSTRAINT `fk_studio_project_budget_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `gaming_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);

-- ========= studio --> infrastructure (9 constraint(s)) =========
-- Requires: studio schema, infrastructure schema
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ADD CONSTRAINT `fk_studio_sprint_cicd_pipeline_id` FOREIGN KEY (`cicd_pipeline_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cicd_pipeline`(`cicd_pipeline_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`studio`.`repo` ADD CONSTRAINT `fk_studio_repo_cicd_pipeline_id` FOREIGN KEY (`cicd_pipeline_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cicd_pipeline`(`cicd_pipeline_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_infrastructure_deployment_id` FOREIGN KEY (`infrastructure_deployment_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_deployment`(`infrastructure_deployment_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_infrastructure_deployment_id` FOREIGN KEY (`infrastructure_deployment_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_deployment`(`infrastructure_deployment_id`);

-- ========= studio --> licensing (9 constraint(s)) =========
-- Requires: studio schema, licensing schema
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ADD CONSTRAINT `fk_studio_milestone_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ADD CONSTRAINT `fk_studio_changelist_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ADD CONSTRAINT `fk_studio_partnership_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);

-- ========= studio --> marketing (3 constraint(s)) =========
-- Requires: studio schema, marketing schema
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ADD CONSTRAINT `fk_studio_milestone_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);

-- ========= studio --> platform (5 constraint(s)) =========
-- Requires: studio schema, platform schema
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_build_submission_id` FOREIGN KEY (`build_submission_id`) REFERENCES `gaming_ecm`.`platform`.`build_submission`(`build_submission_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_patch_release_id` FOREIGN KEY (`patch_release_id`) REFERENCES `gaming_ecm`.`platform`.`patch_release`(`patch_release_id`);
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ADD CONSTRAINT `fk_studio_partnership_developer_account_id` FOREIGN KEY (`developer_account_id`) REFERENCES `gaming_ecm`.`platform`.`developer_account`(`developer_account_id`);
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ADD CONSTRAINT `fk_studio_certification_test_run_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);

-- ========= studio --> quality (1 constraint(s)) =========
-- Requires: studio schema, quality schema
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_test_plan_id` FOREIGN KEY (`test_plan_id`) REFERENCES `gaming_ecm`.`quality`.`test_plan`(`test_plan_id`);

-- ========= studio --> title (3 constraint(s)) =========
-- Requires: studio schema, title schema
ALTER TABLE `gaming_ecm`.`studio`.`dev_project` ADD CONSTRAINT `fk_studio_dev_project_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ADD CONSTRAINT `fk_studio_milestone_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_game_title_id` FOREIGN KEY (`game_title_id`) REFERENCES `gaming_ecm`.`title`.`game_title`(`game_title_id`);

-- ========= studio --> workforce (13 constraint(s)) =========
-- Requires: studio schema, workforce schema
ALTER TABLE `gaming_ecm`.`studio`.`sprint` ADD CONSTRAINT `fk_studio_sprint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`backlog_item` ADD CONSTRAINT `fk_studio_backlog_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`milestone` ADD CONSTRAINT `fk_studio_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`build` ADD CONSTRAINT `fk_studio_build_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`changelist` ADD CONSTRAINT `fk_studio_changelist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ADD CONSTRAINT `fk_studio_resource_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`resource_allocation` ADD CONSTRAINT `fk_studio_resource_allocation_tertiary_resource_replacement_employee_id` FOREIGN KEY (`tertiary_resource_replacement_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`live_ops_cycle` ADD CONSTRAINT `fk_studio_live_ops_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`partnership` ADD CONSTRAINT `fk_studio_partnership_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`project_budget_allocation` ADD CONSTRAINT `fk_studio_project_budget_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`engine_config` ADD CONSTRAINT `fk_studio_engine_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`vendor_work_package` ADD CONSTRAINT `fk_studio_vendor_work_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`studio`.`certification_test_run` ADD CONSTRAINT `fk_studio_certification_test_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= title --> compliance (3 constraint(s)) =========
-- Requires: title schema, compliance schema
ALTER TABLE `gaming_ecm`.`title`.`content_rating` ADD CONSTRAINT `fk_title_content_rating_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ADD CONSTRAINT `fk_title_localization_version_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ADD CONSTRAINT `fk_title_territory_rights_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= title --> content (6 constraint(s)) =========
-- Requires: title schema, content schema
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_asset_bundle_id` FOREIGN KEY (`asset_bundle_id`) REFERENCES `gaming_ecm`.`content`.`asset_bundle`(`asset_bundle_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `gaming_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_seasonal_event_id` FOREIGN KEY (`seasonal_event_id`) REFERENCES `gaming_ecm`.`content`.`seasonal_event`(`seasonal_event_id`);
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ADD CONSTRAINT `fk_title_mode_map_availability_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);
ALTER TABLE `gaming_ecm`.`title`.`checkpoint` ADD CONSTRAINT `fk_title_checkpoint_level_map_id` FOREIGN KEY (`level_map_id`) REFERENCES `gaming_ecm`.`content`.`level_map`(`level_map_id`);

-- ========= title --> finance (2 constraint(s)) =========
-- Requires: title schema, finance schema
ALTER TABLE `gaming_ecm`.`title`.`franchise` ADD CONSTRAINT `fk_title_franchise_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`title`.`publishing_agreement` ADD CONSTRAINT `fk_title_publishing_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= title --> licensing (8 constraint(s)) =========
-- Requires: title schema, licensing schema
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_middleware_agreement_id` FOREIGN KEY (`middleware_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`middleware_agreement`(`middleware_agreement_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ADD CONSTRAINT `fk_title_localization_version_music_sync_license_id` FOREIGN KEY (`music_sync_license_id`) REFERENCES `gaming_ecm`.`licensing`.`music_sync_license`(`music_sync_license_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_season` ADD CONSTRAINT `fk_title_title_season_brand_partnership_id` FOREIGN KEY (`brand_partnership_id`) REFERENCES `gaming_ecm`.`licensing`.`brand_partnership`(`brand_partnership_id`);
ALTER TABLE `gaming_ecm`.`title`.`territory_rights` ADD CONSTRAINT `fk_title_territory_rights_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`title`.`game_mode` ADD CONSTRAINT `fk_title_game_mode_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`title`.`ip_usage` ADD CONSTRAINT `fk_title_ip_usage_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);

-- ========= title --> marketing (4 constraint(s)) =========
-- Requires: title schema, marketing schema
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ADD CONSTRAINT `fk_title_title_campaign_marketing_campaign_id` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `gaming_ecm`.`marketing`.`marketing_campaign`(`marketing_campaign_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_campaign` ADD CONSTRAINT `fk_title_title_campaign_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `gaming_ecm`.`marketing`.`influencer`(`influencer_id`);

-- ========= title --> platform (4 constraint(s)) =========
-- Requires: title schema, platform schema
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_platform_storefront_id` FOREIGN KEY (`platform_storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `gaming_ecm`.`platform`.`storefront`(`storefront_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ADD CONSTRAINT `fk_title_title_cert_submission_platform_cert_submission_id` FOREIGN KEY (`platform_cert_submission_id`) REFERENCES `gaming_ecm`.`platform`.`platform_cert_submission`(`platform_cert_submission_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_cert_submission` ADD CONSTRAINT `fk_title_title_cert_submission_certification_checklist_id` FOREIGN KEY (`certification_checklist_id`) REFERENCES `gaming_ecm`.`platform`.`certification_checklist`(`certification_checklist_id`);

-- ========= title --> player (1 constraint(s)) =========
-- Requires: title schema, player schema
ALTER TABLE `gaming_ecm`.`title`.`leaderboard_entry` ADD CONSTRAINT `fk_title_leaderboard_entry_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= title --> quality (1 constraint(s)) =========
-- Requires: title schema, quality schema
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_release_gate_id` FOREIGN KEY (`release_gate_id`) REFERENCES `gaming_ecm`.`quality`.`release_gate`(`release_gate_id`);

-- ========= title --> studio (23 constraint(s)) =========
-- Requires: title schema, studio schema
ALTER TABLE `gaming_ecm`.`title`.`game_edition` ADD CONSTRAINT `fk_title_game_edition_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_repo_id` FOREIGN KEY (`repo_id`) REFERENCES `gaming_ecm`.`studio`.`repo`(`repo_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`dlc_bundle` ADD CONSTRAINT `fk_title_dlc_bundle_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ADD CONSTRAINT `fk_title_title_lifecycle_event_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ADD CONSTRAINT `fk_title_title_lifecycle_event_changelist_id` FOREIGN KEY (`changelist_id`) REFERENCES `gaming_ecm`.`studio`.`changelist`(`changelist_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ADD CONSTRAINT `fk_title_title_lifecycle_event_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_lifecycle_event` ADD CONSTRAINT `fk_title_title_lifecycle_event_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`title`.`franchise` ADD CONSTRAINT `fk_title_franchise_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ADD CONSTRAINT `fk_title_localization_version_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ADD CONSTRAINT `fk_title_localization_version_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ADD CONSTRAINT `fk_title_localization_version_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`title`.`localization_version` ADD CONSTRAINT `fk_title_localization_version_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_season` ADD CONSTRAINT `fk_title_title_season_build_id` FOREIGN KEY (`build_id`) REFERENCES `gaming_ecm`.`studio`.`build`(`build_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_season` ADD CONSTRAINT `fk_title_title_season_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`achievement` ADD CONSTRAINT `fk_title_achievement_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`title`.`leaderboard` ADD CONSTRAINT `fk_title_leaderboard_live_ops_cycle_id` FOREIGN KEY (`live_ops_cycle_id`) REFERENCES `gaming_ecm`.`studio`.`live_ops_cycle`(`live_ops_cycle_id`);
ALTER TABLE `gaming_ecm`.`title`.`studio_contribution` ADD CONSTRAINT `fk_title_studio_contribution_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);

-- ========= title --> workforce (5 constraint(s)) =========
-- Requires: title schema, workforce schema
ALTER TABLE `gaming_ecm`.`title`.`title_sku` ADD CONSTRAINT `fk_title_title_sku_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`title`.`build_artifact` ADD CONSTRAINT `fk_title_build_artifact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`title`.`title_release` ADD CONSTRAINT `fk_title_title_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`title`.`sku_deployment` ADD CONSTRAINT `fk_title_sku_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`title`.`mode_map_availability` ADD CONSTRAINT `fk_title_mode_map_availability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> compliance (3 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `gaming_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ADD CONSTRAINT `fk_workforce_disciplinary_case_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ADD CONSTRAINT `fk_workforce_job_policy_training_requirement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `gaming_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= workforce --> finance (14 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ADD CONSTRAINT `fk_workforce_studio_capacity_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ADD CONSTRAINT `fk_workforce_studio_capacity_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ADD CONSTRAINT `fk_workforce_project_allocation_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `gaming_ecm`.`finance`.`capex_project`(`capex_project_id`);

-- ========= workforce --> player (1 constraint(s)) =========
-- Requires: workforce schema, player schema
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_player_account_id` FOREIGN KEY (`player_account_id`) REFERENCES `gaming_ecm`.`player`.`player_account`(`player_account_id`);

-- ========= workforce --> studio (26 constraint(s)) =========
-- Requires: workforce schema, studio schema
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ADD CONSTRAINT `fk_workforce_contractor_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ADD CONSTRAINT `fk_workforce_skill_matrix_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ADD CONSTRAINT `fk_workforce_skill_matrix_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_sprint_id` FOREIGN KEY (`sprint_id`) REFERENCES `gaming_ecm`.`studio`.`sprint`(`sprint_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ADD CONSTRAINT `fk_workforce_studio_capacity_plan_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ADD CONSTRAINT `fk_workforce_studio_capacity_plan_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ADD CONSTRAINT `fk_workforce_studio_capacity_plan_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `gaming_ecm`.`studio`.`milestone`(`milestone_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ADD CONSTRAINT `fk_workforce_workforce_event_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `gaming_ecm`.`studio`.`dev_project`(`dev_project_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ADD CONSTRAINT `fk_workforce_disciplinary_case_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`application` ADD CONSTRAINT `fk_workforce_application_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_calendar` ADD CONSTRAINT `fk_workforce_payroll_calendar_game_studio_id` FOREIGN KEY (`game_studio_id`) REFERENCES `gaming_ecm`.`studio`.`game_studio`(`game_studio_id`);

