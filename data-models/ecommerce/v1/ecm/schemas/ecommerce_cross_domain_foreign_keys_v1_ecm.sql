-- Cross-Domain Foreign Keys for Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:14
-- Total cross-domain FK constraints: 851
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: analytics, compliance, content, customer, finance, fulfillment, inventory, logistics, marketing, marketplace, order, payment, pricing, procurement, product, search, seller, service

-- ========= analytics --> compliance (4 constraint(s)) =========
-- Requires: analytics schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ADD CONSTRAINT `fk_analytics_report_definition_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_program_id` FOREIGN KEY (`program_id`) REFERENCES `ecommerce_ecm`.`compliance`.`program`(`program_id`);

-- ========= analytics --> content (3 constraint(s)) =========
-- Requires: analytics schema, content schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ADD CONSTRAINT `fk_analytics_funnel_event_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `ecommerce_ecm`.`content`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ADD CONSTRAINT `fk_analytics_ab_test_result_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `ecommerce_ecm`.`content`.`ab_test_variant`(`ab_test_variant_id`);

-- ========= analytics --> customer (6 constraint(s)) =========
-- Requires: analytics schema, customer schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ADD CONSTRAINT `fk_analytics_report_definition_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ADD CONSTRAINT `fk_analytics_customer_retention_fact_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ADD CONSTRAINT `fk_analytics_conversion_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ADD CONSTRAINT `fk_analytics_session_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);

-- ========= analytics --> fulfillment (3 constraint(s)) =========
-- Requires: analytics schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ADD CONSTRAINT `fk_analytics_operational_alert_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);

-- ========= analytics --> inventory (4 constraint(s)) =========
-- Requires: analytics schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_snapshot_id` FOREIGN KEY (`snapshot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`snapshot`(`snapshot_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ADD CONSTRAINT `fk_analytics_reporting_dimension_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ADD CONSTRAINT `fk_analytics_forecast_model_snapshot_id` FOREIGN KEY (`snapshot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`snapshot`(`snapshot_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ADD CONSTRAINT `fk_analytics_forecast_run_snapshot_id` FOREIGN KEY (`snapshot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`snapshot`(`snapshot_id`);

-- ========= analytics --> logistics (3 constraint(s)) =========
-- Requires: analytics schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `ecommerce_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ADD CONSTRAINT `fk_analytics_operational_alert_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= analytics --> marketing (11 constraint(s)) =========
-- Requires: analytics schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ADD CONSTRAINT `fk_analytics_dashboard_widget_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ADD CONSTRAINT `fk_analytics_report_definition_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ADD CONSTRAINT `fk_analytics_funnel_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ADD CONSTRAINT `fk_analytics_gmv_daily_snapshot_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ADD CONSTRAINT `fk_analytics_operational_alert_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ADD CONSTRAINT `fk_analytics_conversion_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ADD CONSTRAINT `fk_analytics_session_ad_group_id` FOREIGN KEY (`ad_group_id`) REFERENCES `ecommerce_ecm`.`marketing`.`ad_group`(`ad_group_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ADD CONSTRAINT `fk_analytics_session_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= analytics --> marketplace (2 constraint(s)) =========
-- Requires: analytics schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ADD CONSTRAINT `fk_analytics_gmv_daily_snapshot_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ADD CONSTRAINT `fk_analytics_category_performance_listing_category_id` FOREIGN KEY (`listing_category_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_category`(`listing_category_id`);

-- ========= analytics --> order (3 constraint(s)) =========
-- Requires: analytics schema, order schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ADD CONSTRAINT `fk_analytics_funnel_event_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ADD CONSTRAINT `fk_analytics_conversion_event_order_address_id` FOREIGN KEY (`order_address_id`) REFERENCES `ecommerce_ecm`.`order`.`order_address`(`order_address_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ADD CONSTRAINT `fk_analytics_conversion_event_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `ecommerce_ecm`.`order`.`order_address`(`order_address_id`);

-- ========= analytics --> payment (3 constraint(s)) =========
-- Requires: analytics schema, payment schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ADD CONSTRAINT `fk_analytics_funnel_event_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ADD CONSTRAINT `fk_analytics_operational_alert_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= analytics --> pricing (2 constraint(s)) =========
-- Requires: analytics schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= analytics --> procurement (4 constraint(s)) =========
-- Requires: analytics schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `ecommerce_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ADD CONSTRAINT `fk_analytics_conversion_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= analytics --> product (8 constraint(s)) =========
-- Requires: analytics schema, product schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ADD CONSTRAINT `fk_analytics_reporting_dimension_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ADD CONSTRAINT `fk_analytics_category_performance_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ADD CONSTRAINT `fk_analytics_conversion_event_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= analytics --> search (5 constraint(s)) =========
-- Requires: analytics schema, search schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_indexed_document_id` FOREIGN KEY (`indexed_document_id`) REFERENCES `ecommerce_ecm`.`search`.`indexed_document`(`indexed_document_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_result_id` FOREIGN KEY (`result_id`) REFERENCES `ecommerce_ecm`.`search`.`result`(`result_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ADD CONSTRAINT `fk_analytics_funnel_event_click_event_id` FOREIGN KEY (`click_event_id`) REFERENCES `ecommerce_ecm`.`search`.`click_event`(`click_event_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ADD CONSTRAINT `fk_analytics_funnel_event_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ADD CONSTRAINT `fk_analytics_ab_test_result_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);

-- ========= analytics --> seller (5 constraint(s)) =========
-- Requires: analytics schema, seller schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ADD CONSTRAINT `fk_analytics_cohort_membership_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ADD CONSTRAINT `fk_analytics_funnel_event_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ADD CONSTRAINT `fk_analytics_gmv_daily_snapshot_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ADD CONSTRAINT `fk_analytics_seller_performance_snapshot_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= analytics --> service (9 constraint(s)) =========
-- Requires: analytics schema, service schema
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ADD CONSTRAINT `fk_analytics_dashboard_definition_team_id` FOREIGN KEY (`team_id`) REFERENCES `ecommerce_ecm`.`service`.`team`(`team_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ADD CONSTRAINT `fk_analytics_dashboard_widget_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ADD CONSTRAINT `fk_analytics_report_definition_team_id` FOREIGN KEY (`team_id`) REFERENCES `ecommerce_ecm`.`service`.`team`(`team_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ADD CONSTRAINT `fk_analytics_report_execution_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_team_id` FOREIGN KEY (`team_id`) REFERENCES `ecommerce_ecm`.`service`.`team`(`team_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ADD CONSTRAINT `fk_analytics_operational_alert_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`incident` ADD CONSTRAINT `fk_analytics_incident_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`incident` ADD CONSTRAINT `fk_analytics_incident_reporter_agent_id` FOREIGN KEY (`reporter_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= compliance --> procurement (2 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`compliance`.`vendor_compliance_assessment` ADD CONSTRAINT `fk_compliance_vendor_compliance_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= compliance --> seller (1 constraint(s)) =========
-- Requires: compliance schema, seller schema
ALTER TABLE `ecommerce_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= content --> analytics (1 constraint(s)) =========
-- Requires: content schema, analytics schema
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ADD CONSTRAINT `fk_content_kpi_assignment_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);

-- ========= content --> compliance (5 constraint(s)) =========
-- Requires: content schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`content`.`item` ADD CONSTRAINT `fk_content_item_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ADD CONSTRAINT `fk_content_workflow_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ADD CONSTRAINT `fk_content_moderation_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);

-- ========= content --> customer (5 constraint(s)) =========
-- Requires: content schema, customer schema
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`item` ADD CONSTRAINT `fk_content_item_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`item` ADD CONSTRAINT `fk_content_item_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= content --> finance (3 constraint(s)) =========
-- Requires: content schema, finance schema
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ADD CONSTRAINT `fk_content_content_digital_asset_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`item` ADD CONSTRAINT `fk_content_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`item` ADD CONSTRAINT `fk_content_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= content --> marketing (5 constraint(s)) =========
-- Requires: content schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`content`.`item` ADD CONSTRAINT `fk_content_item_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`item` ADD CONSTRAINT `fk_content_item_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ADD CONSTRAINT `fk_content_publication_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ADD CONSTRAINT `fk_content_performance_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`personalization_rule` ADD CONSTRAINT `fk_content_personalization_rule_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);

-- ========= content --> procurement (3 constraint(s)) =========
-- Requires: content schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ADD CONSTRAINT `fk_content_content_digital_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`item` ADD CONSTRAINT `fk_content_item_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `ecommerce_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= content --> search (1 constraint(s)) =========
-- Requires: content schema, search schema
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ADD CONSTRAINT `fk_content_performance_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);

-- ========= content --> seller (2 constraint(s)) =========
-- Requires: content schema, seller schema
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ADD CONSTRAINT `fk_content_content_digital_asset_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`item` ADD CONSTRAINT `fk_content_item_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= content --> service (7 constraint(s)) =========
-- Requires: content schema, service schema
ALTER TABLE `ecommerce_ecm`.`content`.`item` ADD CONSTRAINT `fk_content_item_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ADD CONSTRAINT `fk_content_publication_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ADD CONSTRAINT `fk_content_workflow_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ADD CONSTRAINT `fk_content_workflow_workflow_assigned_by_user_agent_id` FOREIGN KEY (`workflow_assigned_by_user_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ADD CONSTRAINT `fk_content_moderation_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= customer --> compliance (4 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ADD CONSTRAINT `fk_customer_customer_profile_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ADD CONSTRAINT `fk_customer_customer_profile_privacy_notice_id` FOREIGN KEY (`privacy_notice_id`) REFERENCES `ecommerce_ecm`.`compliance`.`privacy_notice`(`privacy_notice_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ADD CONSTRAINT `fk_customer_customer_profile_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `ecommerce_ecm`.`compliance`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ADD CONSTRAINT `fk_customer_customer_profile_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `ecommerce_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);

-- ========= customer --> finance (1 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `ecommerce_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= customer --> marketing (2 constraint(s)) =========
-- Requires: customer schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= customer --> payment (1 constraint(s)) =========
-- Requires: customer schema, payment schema
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);

-- ========= customer --> pricing (2 constraint(s)) =========
-- Requires: customer schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ADD CONSTRAINT `fk_customer_customer_profile_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= customer --> product (5 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ADD CONSTRAINT `fk_customer_wishlist_item_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= customer --> search (1 constraint(s)) =========
-- Requires: customer schema, search schema
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_relevance_config_id` FOREIGN KEY (`relevance_config_id`) REFERENCES `ecommerce_ecm`.`search`.`relevance_config`(`relevance_config_id`);

-- ========= customer --> seller (2 constraint(s)) =========
-- Requires: customer schema, seller schema
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= customer --> service (4 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ADD CONSTRAINT `fk_customer_merge_event_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`merge_event` ADD CONSTRAINT `fk_customer_merge_event_created_by_user_agent_id` FOREIGN KEY (`created_by_user_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= finance --> analytics (2 constraint(s)) =========
-- Requires: finance schema, analytics schema
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ADD CONSTRAINT `fk_finance_gmv_reconciliation_gmv_daily_snapshot_id` FOREIGN KEY (`gmv_daily_snapshot_id`) REFERENCES `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot`(`gmv_daily_snapshot_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ADD CONSTRAINT `fk_finance_seller_disbursement_seller_performance_snapshot_id` FOREIGN KEY (`seller_performance_snapshot_id`) REFERENCES `ecommerce_ecm`.`analytics`.`seller_performance_snapshot`(`seller_performance_snapshot_id`);

-- ========= finance --> compliance (4 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ADD CONSTRAINT `fk_finance_seller_disbursement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_program_id` FOREIGN KEY (`program_id`) REFERENCES `ecommerce_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= finance --> customer (3 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`finance_bank_account` ADD CONSTRAINT `fk_finance_finance_bank_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_party_id` FOREIGN KEY (`party_id`) REFERENCES `ecommerce_ecm`.`customer`.`party`(`party_id`);

-- ========= finance --> order (4 constraint(s)) =========
-- Requires: finance schema, order schema
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= finance --> payment (2 constraint(s)) =========
-- Requires: finance schema, payment schema
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ADD CONSTRAINT `fk_finance_seller_disbursement_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= finance --> procurement (8 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `ecommerce_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `ecommerce_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);

-- ========= finance --> search (4 constraint(s)) =========
-- Requires: finance schema, search schema
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_relevance_config_id` FOREIGN KEY (`relevance_config_id`) REFERENCES `ecommerce_ecm`.`search`.`relevance_config`(`relevance_config_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_relevance_config_id` FOREIGN KEY (`relevance_config_id`) REFERENCES `ecommerce_ecm`.`search`.`relevance_config`(`relevance_config_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ADD CONSTRAINT `fk_finance_gmv_reconciliation_indexed_document_id` FOREIGN KEY (`indexed_document_id`) REFERENCES `ecommerce_ecm`.`search`.`indexed_document`(`indexed_document_id`);

-- ========= finance --> seller (5 constraint(s)) =========
-- Requires: finance schema, seller schema
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`gmv_reconciliation` ADD CONSTRAINT `fk_finance_gmv_reconciliation_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`seller_disbursement` ADD CONSTRAINT `fk_finance_seller_disbursement_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= finance --> service (11 constraint(s)) =========
-- Requires: finance schema, service schema
ALTER TABLE `ecommerce_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_approved_by_agent_id` FOREIGN KEY (`approved_by_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_approved_by_agent_id` FOREIGN KEY (`approved_by_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_primary_financial_agent_id` FOREIGN KEY (`primary_financial_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ADD CONSTRAINT `fk_finance_regulatory_filing_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`regulatory_filing` ADD CONSTRAINT `fk_finance_regulatory_filing_reviewer_agent_id` FOREIGN KEY (`reviewer_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= fulfillment --> compliance (7 constraint(s)) =========
-- Requires: fulfillment schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_program_id` FOREIGN KEY (`program_id`) REFERENCES `ecommerce_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ADD CONSTRAINT `fk_fulfillment_shipment_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment` ADD CONSTRAINT `fk_fulfillment_third_party_fulfillment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_compliance_exception_id` FOREIGN KEY (`compliance_exception_id`) REFERENCES `ecommerce_ecm`.`compliance`.`compliance_exception`(`compliance_exception_id`);

-- ========= fulfillment --> content (3 constraint(s)) =========
-- Requires: fulfillment schema, content schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ADD CONSTRAINT `fk_fulfillment_shipping_label_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ADD CONSTRAINT `fk_fulfillment_bopis_order_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);

-- ========= fulfillment --> customer (5 constraint(s)) =========
-- Requires: fulfillment schema, customer schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ADD CONSTRAINT `fk_fulfillment_proof_of_delivery_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ADD CONSTRAINT `fk_fulfillment_bopis_order_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ADD CONSTRAINT `fk_fulfillment_return_receipt_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= fulfillment --> finance (4 constraint(s)) =========
-- Requires: fulfillment schema, finance schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= fulfillment --> inventory (12 constraint(s)) =========
-- Requires: fulfillment schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ADD CONSTRAINT `fk_fulfillment_receiving_record_inventory_goods_receipt_id` FOREIGN KEY (`inventory_goods_receipt_id`) REFERENCES `ecommerce_ecm`.`inventory`.`inventory_goods_receipt`(`inventory_goods_receipt_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ADD CONSTRAINT `fk_fulfillment_bin_location_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ADD CONSTRAINT `fk_fulfillment_return_receipt_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`carton` ADD CONSTRAINT `fk_fulfillment_carton_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pick_wave` ADD CONSTRAINT `fk_fulfillment_pick_wave_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= fulfillment --> logistics (8 constraint(s)) =========
-- Requires: fulfillment schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_route_id` FOREIGN KEY (`route_id`) REFERENCES `ecommerce_ecm`.`logistics`.`route`(`route_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ADD CONSTRAINT `fk_fulfillment_shipping_label_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ADD CONSTRAINT `fk_fulfillment_shipment_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= fulfillment --> marketing (2 constraint(s)) =========
-- Requires: fulfillment schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ADD CONSTRAINT `fk_fulfillment_bopis_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= fulfillment --> marketplace (2 constraint(s)) =========
-- Requires: fulfillment schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_listing_offer_id` FOREIGN KEY (`listing_offer_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_offer`(`listing_offer_id`);

-- ========= fulfillment --> order (9 constraint(s)) =========
-- Requires: fulfillment schema, order schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ADD CONSTRAINT `fk_fulfillment_shipping_label_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ADD CONSTRAINT `fk_fulfillment_shipment_event_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ADD CONSTRAINT `fk_fulfillment_proof_of_delivery_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bopis_order` ADD CONSTRAINT `fk_fulfillment_bopis_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ADD CONSTRAINT `fk_fulfillment_return_receipt_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= fulfillment --> payment (3 constraint(s)) =========
-- Requires: fulfillment schema, payment schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ADD CONSTRAINT `fk_fulfillment_return_receipt_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `ecommerce_ecm`.`payment`.`authorization`(`authorization_id`);

-- ========= fulfillment --> pricing (4 constraint(s)) =========
-- Requires: fulfillment schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ADD CONSTRAINT `fk_fulfillment_shipping_label_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= fulfillment --> procurement (8 constraint(s)) =========
-- Requires: fulfillment schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `ecommerce_ecm`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ADD CONSTRAINT `fk_fulfillment_receiving_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ADD CONSTRAINT `fk_fulfillment_receiving_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ADD CONSTRAINT `fk_fulfillment_return_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`carton` ADD CONSTRAINT `fk_fulfillment_carton_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`carton` ADD CONSTRAINT `fk_fulfillment_carton_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= fulfillment --> product (5 constraint(s)) =========
-- Requires: fulfillment schema, product schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ADD CONSTRAINT `fk_fulfillment_receiving_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ADD CONSTRAINT `fk_fulfillment_return_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= fulfillment --> service (8 constraint(s)) =========
-- Requires: fulfillment schema, service schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ADD CONSTRAINT `fk_fulfillment_shipment_event_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ADD CONSTRAINT `fk_fulfillment_receiving_record_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`receiving_record` ADD CONSTRAINT `fk_fulfillment_receiving_record_receiving_putaway_associate_agent_id` FOREIGN KEY (`receiving_putaway_associate_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`return_receipt` ADD CONSTRAINT `fk_fulfillment_return_receipt_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_team_id` FOREIGN KEY (`team_id`) REFERENCES `ecommerce_ecm`.`service`.`team`(`team_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`pick_wave` ADD CONSTRAINT `fk_fulfillment_pick_wave_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= inventory --> compliance (5 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ADD CONSTRAINT `fk_inventory_quarantine_record_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_legal_hold_id` FOREIGN KEY (`legal_hold_id`) REFERENCES `ecommerce_ecm`.`compliance`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ADD CONSTRAINT `fk_inventory_inbound_shipment_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);

-- ========= inventory --> content (3 constraint(s)) =========
-- Requires: inventory schema, content schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);

-- ========= inventory --> customer (1 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= inventory --> finance (10 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ADD CONSTRAINT `fk_inventory_safety_stock_rule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_financial_period_close_id` FOREIGN KEY (`financial_period_close_id`) REFERENCES `ecommerce_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ADD CONSTRAINT `fk_inventory_inbound_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= inventory --> fulfillment (4 constraint(s)) =========
-- Requires: inventory schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_pick_wave_id` FOREIGN KEY (`pick_wave_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`pick_wave`(`pick_wave_id`);

-- ========= inventory --> logistics (6 constraint(s)) =========
-- Requires: inventory schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_route_id` FOREIGN KEY (`route_id`) REFERENCES `ecommerce_ecm`.`logistics`.`route`(`route_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_route_id` FOREIGN KEY (`route_id`) REFERENCES `ecommerce_ecm`.`logistics`.`route`(`route_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ADD CONSTRAINT `fk_inventory_inbound_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= inventory --> order (1 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);

-- ========= inventory --> procurement (14 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ADD CONSTRAINT `fk_inventory_replenishment_rule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ADD CONSTRAINT `fk_inventory_quarantine_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ADD CONSTRAINT `fk_inventory_inbound_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= inventory --> product (14 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ADD CONSTRAINT `fk_inventory_replenishment_rule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ADD CONSTRAINT `fk_inventory_snapshot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ADD CONSTRAINT `fk_inventory_sku_velocity_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ADD CONSTRAINT `fk_inventory_quarantine_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= inventory --> seller (11 constraint(s)) =========
-- Requires: inventory schema, seller schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ADD CONSTRAINT `fk_inventory_sku_velocity_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ADD CONSTRAINT `fk_inventory_quarantine_record_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ADD CONSTRAINT `fk_inventory_inbound_shipment_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= inventory --> service (3 constraint(s)) =========
-- Requires: inventory schema, service schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ADD CONSTRAINT `fk_inventory_quarantine_record_service_support_case_id` FOREIGN KEY (`service_support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`service_support_case`(`service_support_case_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_service_support_case_id` FOREIGN KEY (`service_support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`service_support_case`(`service_support_case_id`);

-- ========= logistics --> compliance (3 constraint(s)) =========
-- Requires: logistics schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_program_id` FOREIGN KEY (`program_id`) REFERENCES `ecommerce_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);

-- ========= logistics --> content (4 constraint(s)) =========
-- Requires: logistics schema, content schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ADD CONSTRAINT `fk_logistics_shipment_exception_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_tag_assignment` ADD CONSTRAINT `fk_logistics_carrier_tag_assignment_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `ecommerce_ecm`.`content`.`tag`(`tag_id`);

-- ========= logistics --> customer (2 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= logistics --> finance (16 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ADD CONSTRAINT `fk_logistics_carrier_service_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ADD CONSTRAINT `fk_logistics_transport_cost_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ADD CONSTRAINT `fk_logistics_carrier_rate_card_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ADD CONSTRAINT `fk_logistics_delivery_zone_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ADD CONSTRAINT `fk_logistics_shipment_exception_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ADD CONSTRAINT `fk_logistics_transport_lane_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ADD CONSTRAINT `fk_logistics_transport_lane_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_cost_center_contract` ADD CONSTRAINT `fk_logistics_carrier_cost_center_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= logistics --> fulfillment (11 constraint(s)) =========
-- Requires: logistics schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ADD CONSTRAINT `fk_logistics_shipment_package_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_primary_freight_center_id` FOREIGN KEY (`primary_freight_center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ADD CONSTRAINT `fk_logistics_transport_cost_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_exception` ADD CONSTRAINT `fk_logistics_shipment_exception_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ADD CONSTRAINT `fk_logistics_transport_lane_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_lane` ADD CONSTRAINT `fk_logistics_transport_lane_primary_transport_center_id` FOREIGN KEY (`primary_transport_center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);

-- ========= logistics --> marketing (1 constraint(s)) =========
-- Requires: logistics schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= logistics --> order (2 constraint(s)) =========
-- Requires: logistics schema, order schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_broker` ADD CONSTRAINT `fk_logistics_customs_broker_tax_id` FOREIGN KEY (`tax_id`) REFERENCES `ecommerce_ecm`.`order`.`tax`(`tax_id`);

-- ========= logistics --> procurement (4 constraint(s)) =========
-- Requires: logistics schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `ecommerce_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `ecommerce_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`transport_cost` ADD CONSTRAINT `fk_logistics_transport_cost_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);

-- ========= logistics --> product (1 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ADD CONSTRAINT `fk_logistics_shipment_package_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= logistics --> seller (6 constraint(s)) =========
-- Requires: logistics schema, seller schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_document_id` FOREIGN KEY (`document_id`) REFERENCES `ecommerce_ecm`.`seller`.`document`(`document_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_pod_document_id` FOREIGN KEY (`pod_document_id`) REFERENCES `ecommerce_ecm`.`seller`.`document`(`document_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ADD CONSTRAINT `fk_logistics_carrier_rate_card_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ADD CONSTRAINT `fk_logistics_delivery_zone_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= logistics --> service (1 constraint(s)) =========
-- Requires: logistics schema, service schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `ecommerce_ecm`.`service`.`rma`(`rma_id`);

-- ========= marketing --> analytics (2 constraint(s)) =========
-- Requires: marketing schema, analytics schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_session_id` FOREIGN KEY (`session_id`) REFERENCES `ecommerce_ecm`.`analytics`.`session`(`session_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_kpi_assignment` ADD CONSTRAINT `fk_marketing_campaign_kpi_assignment_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);

-- ========= marketing --> compliance (4 constraint(s)) =========
-- Requires: marketing schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ADD CONSTRAINT `fk_marketing_consent_record_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`regulatory_compliance` ADD CONSTRAINT `fk_marketing_regulatory_compliance_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);

-- ========= marketing --> content (1 constraint(s)) =========
-- Requires: marketing schema, content schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ADD CONSTRAINT `fk_marketing_email_event_template_id` FOREIGN KEY (`template_id`) REFERENCES `ecommerce_ecm`.`content`.`template`(`template_id`);

-- ========= marketing --> customer (6 constraint(s)) =========
-- Requires: marketing schema, customer schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ADD CONSTRAINT `fk_marketing_email_event_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ADD CONSTRAINT `fk_marketing_referral_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ADD CONSTRAINT `fk_marketing_referral_referral_referee_customer_profile_id` FOREIGN KEY (`referral_referee_customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`consent_record` ADD CONSTRAINT `fk_marketing_consent_record_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= marketing --> finance (5 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= marketing --> inventory (1 constraint(s)) =========
-- Requires: marketing schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= marketing --> logistics (1 constraint(s)) =========
-- Requires: marketing schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= marketing --> marketplace (1 constraint(s)) =========
-- Requires: marketing schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);

-- ========= marketing --> order (1 constraint(s)) =========
-- Requires: marketing schema, order schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ADD CONSTRAINT `fk_marketing_referral_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= marketing --> procurement (3 constraint(s)) =========
-- Requires: marketing schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= marketing --> product (3 constraint(s)) =========
-- Requires: marketing schema, product schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_sku_allocation` ADD CONSTRAINT `fk_marketing_campaign_sku_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= marketing --> search (4 constraint(s)) =========
-- Requires: marketing schema, search schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`marketing_ab_test` ADD CONSTRAINT `fk_marketing_marketing_ab_test_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`seo_page` ADD CONSTRAINT `fk_marketing_seo_page_indexed_document_id` FOREIGN KEY (`indexed_document_id`) REFERENCES `ecommerce_ecm`.`search`.`indexed_document`(`indexed_document_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_query_log_id` FOREIGN KEY (`query_log_id`) REFERENCES `ecommerce_ecm`.`search`.`query_log`(`query_log_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ADD CONSTRAINT `fk_marketing_ad_group_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);

-- ========= marketing --> service (2 constraint(s)) =========
-- Requires: marketing schema, service schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_owner_agent_id` FOREIGN KEY (`owner_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= marketplace --> compliance (5 constraint(s)) =========
-- Requires: marketplace schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ADD CONSTRAINT `fk_marketplace_buyer_protection_claim_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_compliance` ADD CONSTRAINT `fk_marketplace_listing_compliance_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= marketplace --> content (3 constraint(s)) =========
-- Requires: marketplace schema, content schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_seo_metadata_id` FOREIGN KEY (`seo_metadata_id`) REFERENCES `ecommerce_ecm`.`content`.`seo_metadata`(`seo_metadata_id`);

-- ========= marketplace --> customer (4 constraint(s)) =========
-- Requires: marketplace schema, customer schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ADD CONSTRAINT `fk_marketplace_listing_review_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= marketplace --> finance (7 constraint(s)) =========
-- Requires: marketplace schema, finance schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ADD CONSTRAINT `fk_marketplace_seller_settlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ADD CONSTRAINT `fk_marketplace_seller_settlement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ecommerce_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ADD CONSTRAINT `fk_marketplace_marketplace_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= marketplace --> fulfillment (1 constraint(s)) =========
-- Requires: marketplace schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);

-- ========= marketplace --> inventory (4 constraint(s)) =========
-- Requires: marketplace schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= marketplace --> logistics (5 constraint(s)) =========
-- Requires: marketplace schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_delivery_zone_id` FOREIGN KEY (`delivery_zone_id`) REFERENCES `ecommerce_ecm`.`logistics`.`delivery_zone`(`delivery_zone_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_route_id` FOREIGN KEY (`route_id`) REFERENCES `ecommerce_ecm`.`logistics`.`route`(`route_id`);

-- ========= marketplace --> marketing (6 constraint(s)) =========
-- Requires: marketplace schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ADD CONSTRAINT `fk_marketplace_sponsored_listing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ADD CONSTRAINT `fk_marketplace_ad_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_group` ADD CONSTRAINT `fk_marketplace_ad_group_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= marketplace --> order (2 constraint(s)) =========
-- Requires: marketplace schema, order schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ADD CONSTRAINT `fk_marketplace_ad_event_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= marketplace --> payment (2 constraint(s)) =========
-- Requires: marketplace schema, payment schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= marketplace --> pricing (4 constraint(s)) =========
-- Requires: marketplace schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);

-- ========= marketplace --> product (10 constraint(s)) =========
-- Requires: marketplace schema, product schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ADD CONSTRAINT `fk_marketplace_buy_box_rule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ADD CONSTRAINT `fk_marketplace_commission_schedule_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ADD CONSTRAINT `fk_marketplace_listing_review_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= marketplace --> seller (6 constraint(s)) =========
-- Requires: marketplace schema, seller schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ADD CONSTRAINT `fk_marketplace_buy_box_rule_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ADD CONSTRAINT `fk_marketplace_seller_settlement_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ADD CONSTRAINT `fk_marketplace_sponsored_listing_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ADD CONSTRAINT `fk_marketplace_buyer_protection_claim_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= marketplace --> service (3 constraint(s)) =========
-- Requires: marketplace schema, service schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_service_support_case_id` FOREIGN KEY (`service_support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`service_support_case`(`service_support_case_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ADD CONSTRAINT `fk_marketplace_buyer_protection_claim_service_support_case_id` FOREIGN KEY (`service_support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`service_support_case`(`service_support_case_id`);

-- ========= order --> compliance (5 constraint(s)) =========
-- Requires: order schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ADD CONSTRAINT `fk_order_order_address_privacy_notice_id` FOREIGN KEY (`privacy_notice_id`) REFERENCES `ecommerce_ecm`.`compliance`.`privacy_notice`(`privacy_notice_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= order --> content (2 constraint(s)) =========
-- Requires: order schema, content schema
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ADD CONSTRAINT `fk_order_delivery_confirmation_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);

-- ========= order --> customer (14 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ADD CONSTRAINT `fk_order_cart_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `ecommerce_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_household_id` FOREIGN KEY (`household_id`) REFERENCES `ecommerce_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ADD CONSTRAINT `fk_order_order_address_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `ecommerce_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ADD CONSTRAINT `fk_order_b2b_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ADD CONSTRAINT `fk_order_b2b_order_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `ecommerce_ecm`.`customer`.`organization`(`organization_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`subscription_order` ADD CONSTRAINT `fk_order_subscription_order_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`session` ADD CONSTRAINT `fk_order_session_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);

-- ========= order --> finance (6 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= order --> fulfillment (2 constraint(s)) =========
-- Requires: order schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);

-- ========= order --> inventory (4 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= order --> logistics (2 constraint(s)) =========
-- Requires: order schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_sla` ADD CONSTRAINT `fk_order_order_sla_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= order --> marketing (5 constraint(s)) =========
-- Requires: order schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`session` ADD CONSTRAINT `fk_order_session_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= order --> marketplace (2 constraint(s)) =========
-- Requires: order schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);

-- ========= order --> payment (5 constraint(s)) =========
-- Requires: order schema, payment schema
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `ecommerce_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= order --> pricing (7 constraint(s)) =========
-- Requires: order schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ADD CONSTRAINT `fk_order_cart_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_price_approval_id` FOREIGN KEY (`price_approval_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_approval`(`price_approval_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_dynamic_price_rule_id` FOREIGN KEY (`dynamic_price_rule_id`) REFERENCES `ecommerce_ecm`.`pricing`.`dynamic_price_rule`(`dynamic_price_rule_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_markdown_schedule_id` FOREIGN KEY (`markdown_schedule_id`) REFERENCES `ecommerce_ecm`.`pricing`.`markdown_schedule`(`markdown_schedule_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);

-- ========= order --> procurement (4 constraint(s)) =========
-- Requires: order schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `ecommerce_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`b2b_order` ADD CONSTRAINT `fk_order_b2b_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `ecommerce_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `ecommerce_ecm`.`procurement`.`po_line_item`(`po_line_item_id`);

-- ========= order --> product (5 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_variant_sku_id` FOREIGN KEY (`variant_sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= order --> search (4 constraint(s)) =========
-- Requires: order schema, search schema
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_query_log_id` FOREIGN KEY (`query_log_id`) REFERENCES `ecommerce_ecm`.`search`.`query_log`(`query_log_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_indexed_document_id` FOREIGN KEY (`indexed_document_id`) REFERENCES `ecommerce_ecm`.`search`.`indexed_document`(`indexed_document_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_result_id` FOREIGN KEY (`result_id`) REFERENCES `ecommerce_ecm`.`search`.`result`(`result_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_merchandising_rule_id` FOREIGN KEY (`merchandising_rule_id`) REFERENCES `ecommerce_ecm`.`search`.`merchandising_rule`(`merchandising_rule_id`);

-- ========= order --> seller (6 constraint(s)) =========
-- Requires: order schema, seller schema
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= order --> service (1 constraint(s)) =========
-- Requires: order schema, service schema
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `ecommerce_ecm`.`service`.`entitlement`(`entitlement_id`);

-- ========= payment --> compliance (4 constraint(s)) =========
-- Requires: payment schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ADD CONSTRAINT `fk_payment_merchant_account_program_id` FOREIGN KEY (`program_id`) REFERENCES `ecommerce_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`routing_rule` ADD CONSTRAINT `fk_payment_routing_rule_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);

-- ========= payment --> content (4 constraint(s)) =========
-- Requires: payment schema, content schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payout` ADD CONSTRAINT `fk_payment_payout_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);

-- ========= payment --> customer (9 constraint(s)) =========
-- Requires: payment schema, customer schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ADD CONSTRAINT `fk_payment_method_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`installment_plan` ADD CONSTRAINT `fk_payment_installment_plan_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ADD CONSTRAINT `fk_payment_wallet_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= payment --> finance (4 constraint(s)) =========
-- Requires: payment schema, finance schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= payment --> fulfillment (1 constraint(s)) =========
-- Requires: payment schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= payment --> logistics (2 constraint(s)) =========
-- Requires: payment schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_return_shipment_id` FOREIGN KEY (`return_shipment_id`) REFERENCES `ecommerce_ecm`.`logistics`.`return_shipment`(`return_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payout` ADD CONSTRAINT `fk_payment_payout_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `ecommerce_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= payment --> marketing (2 constraint(s)) =========
-- Requires: payment schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= payment --> marketplace (2 constraint(s)) =========
-- Requires: payment schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`dispute`(`dispute_id`);

-- ========= payment --> order (4 constraint(s)) =========
-- Requires: payment schema, order schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`installment_plan` ADD CONSTRAINT `fk_payment_installment_plan_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= payment --> pricing (5 constraint(s)) =========
-- Requires: payment schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_promotion_rule_id` FOREIGN KEY (`promotion_rule_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotion_rule`(`promotion_rule_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);

-- ========= payment --> product (2 constraint(s)) =========
-- Requires: payment schema, product schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= payment --> seller (4 constraint(s)) =========
-- Requires: payment schema, seller schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payout` ADD CONSTRAINT `fk_payment_payout_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payout` ADD CONSTRAINT `fk_payment_payout_document_id` FOREIGN KEY (`document_id`) REFERENCES `ecommerce_ecm`.`seller`.`document`(`document_id`);

-- ========= payment --> service (3 constraint(s)) =========
-- Requires: payment schema, service schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `ecommerce_ecm`.`service`.`rma`(`rma_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_service_refund_id` FOREIGN KEY (`service_refund_id`) REFERENCES `ecommerce_ecm`.`service`.`service_refund`(`service_refund_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= pricing --> compliance (3 constraint(s)) =========
-- Requires: pricing schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);

-- ========= pricing --> content (3 constraint(s)) =========
-- Requires: pricing schema, content schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_content_ab_test_id` FOREIGN KEY (`content_ab_test_id`) REFERENCES `ecommerce_ecm`.`content`.`content_ab_test`(`content_ab_test_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_content_ab_test_id` FOREIGN KEY (`content_ab_test_id`) REFERENCES `ecommerce_ecm`.`content`.`content_ab_test`(`content_ab_test_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ADD CONSTRAINT `fk_pricing_coupon_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);

-- ========= pricing --> customer (8 constraint(s)) =========
-- Requires: pricing schema, customer schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ADD CONSTRAINT `fk_pricing_coupon_redemption_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_audit_user_account_id` FOREIGN KEY (`audit_user_account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ADD CONSTRAINT `fk_pricing_price_history_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_approval` ADD CONSTRAINT `fk_pricing_price_approval_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);

-- ========= pricing --> finance (5 constraint(s)) =========
-- Requires: pricing schema, finance schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ADD CONSTRAINT `fk_pricing_price_history_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= pricing --> fulfillment (1 constraint(s)) =========
-- Requires: pricing schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`pricing_price_list_assignment` ADD CONSTRAINT `fk_pricing_pricing_price_list_assignment_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);

-- ========= pricing --> inventory (6 constraint(s)) =========
-- Requires: pricing schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_oos_event_id` FOREIGN KEY (`oos_event_id`) REFERENCES `ecommerce_ecm`.`inventory`.`oos_event`(`oos_event_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ADD CONSTRAINT `fk_pricing_price_history_snapshot_id` FOREIGN KEY (`snapshot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`snapshot`(`snapshot_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= pricing --> logistics (2 constraint(s)) =========
-- Requires: pricing schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_delivery_zone_id` FOREIGN KEY (`delivery_zone_id`) REFERENCES `ecommerce_ecm`.`logistics`.`delivery_zone`(`delivery_zone_id`);

-- ========= pricing --> marketing (4 constraint(s)) =========
-- Requires: pricing schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ADD CONSTRAINT `fk_pricing_coupon_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);

-- ========= pricing --> marketplace (3 constraint(s)) =========
-- Requires: pricing schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ADD CONSTRAINT `fk_pricing_coupon_redemption_marketplace_promotion_id` FOREIGN KEY (`marketplace_promotion_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_promotion`(`marketplace_promotion_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ADD CONSTRAINT `fk_pricing_price_history_marketplace_promotion_id` FOREIGN KEY (`marketplace_promotion_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_promotion`(`marketplace_promotion_id`);

-- ========= pricing --> order (3 constraint(s)) =========
-- Requires: pricing schema, order schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ADD CONSTRAINT `fk_pricing_coupon_redemption_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);

-- ========= pricing --> procurement (1 constraint(s)) =========
-- Requires: pricing schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`pricing_agreement` ADD CONSTRAINT `fk_pricing_pricing_agreement_supplier_price_list_id` FOREIGN KEY (`supplier_price_list_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier_price_list`(`supplier_price_list_id`);

-- ========= pricing --> product (4 constraint(s)) =========
-- Requires: pricing schema, product schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_product_variant_sku_id` FOREIGN KEY (`product_variant_sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ADD CONSTRAINT `fk_pricing_price_history_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`competitor_price` ADD CONSTRAINT `fk_pricing_competitor_price_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= pricing --> search (1 constraint(s)) =========
-- Requires: pricing schema, search schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ADD CONSTRAINT `fk_pricing_price_history_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);

-- ========= pricing --> seller (5 constraint(s)) =========
-- Requires: pricing schema, seller schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone_assignment` ADD CONSTRAINT `fk_pricing_price_zone_assignment_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= procurement --> compliance (2 constraint(s)) =========
-- Requires: procurement schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `ecommerce_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_return` ADD CONSTRAINT `fk_procurement_goods_return_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `ecommerce_ecm`.`compliance`.`audit`(`audit_id`);

-- ========= procurement --> content (2 constraint(s)) =========
-- Requires: procurement schema, content schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);

-- ========= procurement --> customer (5 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);

-- ========= procurement --> finance (10 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_return` ADD CONSTRAINT `fk_procurement_goods_return_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_return` ADD CONSTRAINT `fk_procurement_goods_return_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= procurement --> fulfillment (1 constraint(s)) =========
-- Requires: procurement schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_center_contract` ADD CONSTRAINT `fk_procurement_supplier_center_contract_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);

-- ========= procurement --> inventory (4 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_return` ADD CONSTRAINT `fk_procurement_goods_return_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= procurement --> order (1 constraint(s)) =========
-- Requires: procurement schema, order schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_onboarding` ADD CONSTRAINT `fk_procurement_supplier_onboarding_tax_id` FOREIGN KEY (`tax_id`) REFERENCES `ecommerce_ecm`.`order`.`tax`(`tax_id`);

-- ========= procurement --> pricing (3 constraint(s)) =========
-- Requires: procurement schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= procurement --> product (6 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`rfq_response` ADD CONSTRAINT `fk_procurement_rfq_response_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_return` ADD CONSTRAINT `fk_procurement_goods_return_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= procurement --> seller (6 constraint(s)) =========
-- Requires: procurement schema, seller schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_performance` ADD CONSTRAINT `fk_procurement_supplier_performance_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= procurement --> service (11 constraint(s)) =========
-- Requires: procurement schema, service schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_primary_vendor_agent_id` FOREIGN KEY (`primary_vendor_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_performance` ADD CONSTRAINT `fk_procurement_supplier_performance_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_rfq_agent_id` FOREIGN KEY (`rfq_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_requisition_agent_id` FOREIGN KEY (`requisition_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_return` ADD CONSTRAINT `fk_procurement_goods_return_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_onboarding` ADD CONSTRAINT `fk_procurement_supplier_onboarding_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= product --> compliance (6 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ADD CONSTRAINT `fk_product_attribute_value_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ADD CONSTRAINT `fk_product_identifier_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`regulation_compliance` ADD CONSTRAINT `fk_product_regulation_compliance_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand_compliance_enrollment` ADD CONSTRAINT `fk_product_brand_compliance_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `ecommerce_ecm`.`compliance`.`program`(`program_id`);

-- ========= product --> content (5 constraint(s)) =========
-- Requires: product schema, content schema
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ADD CONSTRAINT `fk_product_product_digital_asset_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ADD CONSTRAINT `fk_product_sku_asset_assignment_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);

-- ========= product --> finance (5 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ADD CONSTRAINT `fk_product_compliance_certification_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= product --> logistics (2 constraint(s)) =========
-- Requires: product schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);

-- ========= product --> marketing (1 constraint(s)) =========
-- Requires: product schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= product --> marketplace (1 constraint(s)) =========
-- Requires: product schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ADD CONSTRAINT `fk_product_identifier_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);

-- ========= product --> procurement (2 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ADD CONSTRAINT `fk_product_bundle_component_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= product --> seller (8 constraint(s)) =========
-- Requires: product schema, seller schema
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ADD CONSTRAINT `fk_product_relation_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ADD CONSTRAINT `fk_product_identifier_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ADD CONSTRAINT `fk_product_seller_sku_mapping_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` ADD CONSTRAINT `fk_product_brand_seller_agreement_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= product --> service (1 constraint(s)) =========
-- Requires: product schema, service schema
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ADD CONSTRAINT `fk_product_seller_sku_mapping_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= search --> analytics (1 constraint(s)) =========
-- Requires: search schema, analytics schema
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ADD CONSTRAINT `fk_search_ranking_model_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `ecommerce_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);

-- ========= search --> compliance (5 constraint(s)) =========
-- Requires: search schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ADD CONSTRAINT `fk_search_query_log_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`result` ADD CONSTRAINT `fk_search_result_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ADD CONSTRAINT `fk_search_recommendation_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ADD CONSTRAINT `fk_search_personalization_profile_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);

-- ========= search --> content (10 constraint(s)) =========
-- Requires: search schema, content schema
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ADD CONSTRAINT `fk_search_query_log_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `ecommerce_ecm`.`content`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ADD CONSTRAINT `fk_search_relevance_config_content_ab_test_id` FOREIGN KEY (`content_ab_test_id`) REFERENCES `ecommerce_ecm`.`content`.`content_ab_test`(`content_ab_test_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ADD CONSTRAINT `fk_search_recommendation_event_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `ecommerce_ecm`.`content`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ADD CONSTRAINT `fk_search_personalization_profile_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `ecommerce_ecm`.`content`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ADD CONSTRAINT `fk_search_zero_result_query_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `ecommerce_ecm`.`content`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ADD CONSTRAINT `fk_search_autocomplete_suggestion_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `ecommerce_ecm`.`content`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ADD CONSTRAINT `fk_search_quality_eval_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `ecommerce_ecm`.`content`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ADD CONSTRAINT `fk_search_trending_query_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `ecommerce_ecm`.`content`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ADD CONSTRAINT `fk_search_filter_usage_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `ecommerce_ecm`.`content`.`ab_test_variant`(`ab_test_variant_id`);

-- ========= search --> customer (10 constraint(s)) =========
-- Requires: search schema, customer schema
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ADD CONSTRAINT `fk_search_query_log_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`result` ADD CONSTRAINT `fk_search_result_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ADD CONSTRAINT `fk_search_click_event_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ADD CONSTRAINT `fk_search_experiment_assignment_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ADD CONSTRAINT `fk_search_recommendation_event_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ADD CONSTRAINT `fk_search_personalization_profile_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ADD CONSTRAINT `fk_search_behavioral_signal_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ADD CONSTRAINT `fk_search_zero_result_query_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ADD CONSTRAINT `fk_search_filter_usage_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` ADD CONSTRAINT `fk_search_search_session_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= search --> inventory (3 constraint(s)) =========
-- Requires: search schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ADD CONSTRAINT `fk_search_recommendation_model_snapshot_id` FOREIGN KEY (`snapshot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`snapshot`(`snapshot_id`);

-- ========= search --> logistics (2 constraint(s)) =========
-- Requires: search schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_delivery_zone_id` FOREIGN KEY (`delivery_zone_id`) REFERENCES `ecommerce_ecm`.`logistics`.`delivery_zone`(`delivery_zone_id`);

-- ========= search --> marketplace (1 constraint(s)) =========
-- Requires: search schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_marketplace_promotion_id` FOREIGN KEY (`marketplace_promotion_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_promotion`(`marketplace_promotion_id`);

-- ========= search --> payment (1 constraint(s)) =========
-- Requires: search schema, payment schema
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ADD CONSTRAINT `fk_search_click_event_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= search --> pricing (4 constraint(s)) =========
-- Requires: search schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`search`.`index` ADD CONSTRAINT `fk_search_index_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ADD CONSTRAINT `fk_search_query_log_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ADD CONSTRAINT `fk_search_experiment_price_experiment_id` FOREIGN KEY (`price_experiment_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_experiment`(`price_experiment_id`);

-- ========= search --> procurement (1 constraint(s)) =========
-- Requires: search schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= search --> product (4 constraint(s)) =========
-- Requires: search schema, product schema
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ADD CONSTRAINT `fk_search_recommendation_event_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ADD CONSTRAINT `fk_search_trending_query_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= search --> seller (1 constraint(s)) =========
-- Requires: search schema, seller schema
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= search --> service (3 constraint(s)) =========
-- Requires: search schema, service schema
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ADD CONSTRAINT `fk_search_ranking_model_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ADD CONSTRAINT `fk_search_experiment_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ADD CONSTRAINT `fk_search_quality_eval_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= seller --> compliance (4 constraint(s)) =========
-- Requires: seller schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`violation` ADD CONSTRAINT `fk_seller_violation_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`tax_reporting` ADD CONSTRAINT `fk_seller_tax_reporting_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`compliance_assignment` ADD CONSTRAINT `fk_seller_compliance_assignment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= seller --> customer (2 constraint(s)) =========
-- Requires: seller schema, customer schema
ALTER TABLE `ecommerce_ecm`.`seller`.`rating` ADD CONSTRAINT `fk_seller_rating_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`fraud_investigation` ADD CONSTRAINT `fk_seller_fraud_investigation_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= seller --> finance (4 constraint(s)) =========
-- Requires: seller schema, finance schema
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ecommerce_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= seller --> fulfillment (1 constraint(s)) =========
-- Requires: seller schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_third_party_fulfillment_id` FOREIGN KEY (`third_party_fulfillment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`third_party_fulfillment`(`third_party_fulfillment_id`);

-- ========= seller --> order (1 constraint(s)) =========
-- Requires: seller schema, order schema
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_support_case` ADD CONSTRAINT `fk_seller_seller_support_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= seller --> payment (1 constraint(s)) =========
-- Requires: seller schema, payment schema
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);

-- ========= seller --> pricing (1 constraint(s)) =========
-- Requires: seller schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_price_list_assignment` ADD CONSTRAINT `fk_seller_seller_price_list_assignment_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= seller --> product (1 constraint(s)) =========
-- Requires: seller schema, product schema
ALTER TABLE `ecommerce_ecm`.`seller`.`category_approval` ADD CONSTRAINT `fk_seller_category_approval_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);

-- ========= seller --> service (7 constraint(s)) =========
-- Requires: seller schema, service schema
ALTER TABLE `ecommerce_ecm`.`seller`.`onboarding` ADD CONSTRAINT `fk_seller_onboarding_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`violation` ADD CONSTRAINT `fk_seller_violation_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`tier` ADD CONSTRAINT `fk_seller_tier_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`tier_change` ADD CONSTRAINT `fk_seller_tier_change_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`category_approval` ADD CONSTRAINT `fk_seller_category_approval_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_support_case` ADD CONSTRAINT `fk_seller_seller_support_case_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`fraud_investigation` ADD CONSTRAINT `fk_seller_fraud_investigation_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= service --> compliance (7 constraint(s)) =========
-- Requires: service schema, compliance schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ADD CONSTRAINT `fk_service_sla_policy_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_regulation_id` FOREIGN KEY (`regulation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`regulation`(`regulation_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ADD CONSTRAINT `fk_service_case_status_history_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ecommerce_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= service --> content (2 constraint(s)) =========
-- Requires: service schema, content schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);

-- ========= service --> customer (10 constraint(s)) =========
-- Requires: service schema, customer schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ADD CONSTRAINT `fk_service_case_interaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ADD CONSTRAINT `fk_service_case_interaction_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ADD CONSTRAINT `fk_service_case_status_history_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= service --> finance (6 constraint(s)) =========
-- Requires: service schema, finance schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`team` ADD CONSTRAINT `fk_service_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= service --> fulfillment (3 constraint(s)) =========
-- Requires: service schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= service --> inventory (3 constraint(s)) =========
-- Requires: service schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= service --> logistics (4 constraint(s)) =========
-- Requires: service schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);

-- ========= service --> marketing (2 constraint(s)) =========
-- Requires: service schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `ecommerce_ecm`.`marketing`.`lead`(`lead_id`);

-- ========= service --> marketplace (5 constraint(s)) =========
-- Requires: service schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ADD CONSTRAINT `fk_service_case_interaction_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ADD CONSTRAINT `fk_service_case_queue_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`policy`(`policy_id`);

-- ========= service --> order (6 constraint(s)) =========
-- Requires: service schema, order schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ADD CONSTRAINT `fk_service_case_status_history_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= service --> payment (2 constraint(s)) =========
-- Requires: service schema, payment schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= service --> pricing (2 constraint(s)) =========
-- Requires: service schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= service --> product (4 constraint(s)) =========
-- Requires: service schema, product schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);

-- ========= service --> search (1 constraint(s)) =========
-- Requires: service schema, search schema
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);

-- ========= service --> seller (1 constraint(s)) =========
-- Requires: service schema, seller schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

