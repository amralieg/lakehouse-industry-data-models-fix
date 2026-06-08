-- Cross-Domain Foreign Keys for Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:51
-- Total cross-domain FK constraints: 1942
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: analytics, assurance, billing, compliance, content, customer, enterprise, finance, interconnect, inventory, location, network, order, partner, people, product, sales, service, usage, workforce

-- ========= analytics --> assurance (3 constraint(s)) =========
-- Requires: analytics schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ADD CONSTRAINT `fk_analytics_model_run_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ADD CONSTRAINT `fk_analytics_retention_model_output_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);

-- ========= analytics --> customer (6 constraint(s)) =========
-- Requires: analytics schema, customer schema
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ADD CONSTRAINT `fk_analytics_customer_analytics_kpi_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ADD CONSTRAINT `fk_analytics_customer_analytics_kpi_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ADD CONSTRAINT `fk_analytics_analytics_segment_membership_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ADD CONSTRAINT `fk_analytics_ab_test_assignment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ADD CONSTRAINT `fk_analytics_ab_test_assignment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ADD CONSTRAINT `fk_analytics_retention_model_output_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= analytics --> inventory (15 constraint(s)) =========
-- Requires: analytics schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ADD CONSTRAINT `fk_analytics_dq_issue_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `telecommunication_ecm`.`inventory`.`spare_part`(`spare_part_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_spectrum_allocation_id` FOREIGN KEY (`spectrum_allocation_id`) REFERENCES `telecommunication_ecm`.`inventory`.`spectrum_allocation`(`spectrum_allocation_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ADD CONSTRAINT `fk_analytics_customer_analytics_kpi_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ADD CONSTRAINT `fk_analytics_customer_analytics_kpi_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_spectrum_allocation_id` FOREIGN KEY (`spectrum_allocation_id`) REFERENCES `telecommunication_ecm`.`inventory`.`spectrum_allocation`(`spectrum_allocation_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `telecommunication_ecm`.`inventory`.`spare_part`(`spare_part_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ADD CONSTRAINT `fk_analytics_retention_model_output_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);

-- ========= analytics --> location (13 constraint(s)) =========
-- Requires: analytics schema, location schema
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ADD CONSTRAINT `fk_analytics_dq_issue_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ADD CONSTRAINT `fk_analytics_bi_report_definition_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ADD CONSTRAINT `fk_analytics_customer_analytics_kpi_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ADD CONSTRAINT `fk_analytics_revenue_analytics_kpi_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ADD CONSTRAINT `fk_analytics_revenue_analytics_kpi_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ADD CONSTRAINT `fk_analytics_segment_definition_geographic_zone_id` FOREIGN KEY (`geographic_zone_id`) REFERENCES `telecommunication_ecm`.`location`.`geographic_zone`(`geographic_zone_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ADD CONSTRAINT `fk_analytics_analytics_segment_membership_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ADD CONSTRAINT `fk_analytics_retention_model_output_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);

-- ========= analytics --> network (10 constraint(s)) =========
-- Requires: analytics schema, network schema
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ADD CONSTRAINT `fk_analytics_dq_issue_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ADD CONSTRAINT `fk_analytics_bi_report_definition_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_ims_node_id` FOREIGN KEY (`ims_node_id`) REFERENCES `telecommunication_ecm`.`network`.`ims_node`(`ims_node_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_mpls_tunnel_id` FOREIGN KEY (`mpls_tunnel_id`) REFERENCES `telecommunication_ecm`.`network`.`mpls_tunnel`(`mpls_tunnel_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_topology_id` FOREIGN KEY (`topology_id`) REFERENCES `telecommunication_ecm`.`network`.`topology`(`topology_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ADD CONSTRAINT `fk_analytics_retention_model_output_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);

-- ========= analytics --> order (1 constraint(s)) =========
-- Requires: analytics schema, order schema
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ADD CONSTRAINT `fk_analytics_revenue_analytics_kpi_line_id` FOREIGN KEY (`line_id`) REFERENCES `telecommunication_ecm`.`order`.`line`(`line_id`);

-- ========= analytics --> people (13 constraint(s)) =========
-- Requires: analytics schema, people schema
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ADD CONSTRAINT `fk_analytics_analytical_subject_area_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ADD CONSTRAINT `fk_analytics_dq_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ADD CONSTRAINT `fk_analytics_dq_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ADD CONSTRAINT `fk_analytics_analytical_model_registry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ADD CONSTRAINT `fk_analytics_model_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ADD CONSTRAINT `fk_analytics_feature_store_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ADD CONSTRAINT `fk_analytics_bi_report_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ADD CONSTRAINT `fk_analytics_analytics_segment_membership_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ADD CONSTRAINT `fk_analytics_glossary_term_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_target_owner_employee_id` FOREIGN KEY (`target_owner_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ADD CONSTRAINT `fk_analytics_ab_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= analytics --> sales (2 constraint(s)) =========
-- Requires: analytics schema, sales schema
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ADD CONSTRAINT `fk_analytics_revenue_analytics_kpi_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ADD CONSTRAINT `fk_analytics_analytics_segment_membership_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);

-- ========= assurance --> analytics (10 constraint(s)) =========
-- Requires: assurance schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_dq_issue_id` FOREIGN KEY (`dq_issue_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`revenue_leakage_case` ADD CONSTRAINT `fk_assurance_revenue_leakage_case_dq_issue_id` FOREIGN KEY (`dq_issue_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`reconciliation_run` ADD CONSTRAINT `fk_assurance_reconciliation_run_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_analytical_model_registry_id` FOREIGN KEY (`analytical_model_registry_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_model_registry`(`analytical_model_registry_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_analytical_model_registry_id` FOREIGN KEY (`analytical_model_registry_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_model_registry`(`analytical_model_registry_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`qos_measurement` ADD CONSTRAINT `fk_assurance_qos_measurement_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ADD CONSTRAINT `fk_assurance_kpi_threshold_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);

-- ========= assurance --> billing (6 constraint(s)) =========
-- Requires: assurance schema, billing schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`revenue_leakage_case` ADD CONSTRAINT `fk_assurance_revenue_leakage_case_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= assurance --> compliance (17 constraint(s)) =========
-- Requires: assurance schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_e911_compliance_id` FOREIGN KEY (`e911_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`e911_compliance`(`e911_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `telecommunication_ecm`.`compliance`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `telecommunication_ecm`.`compliance`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`revenue_leakage_case` ADD CONSTRAINT `fk_assurance_revenue_leakage_case_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `telecommunication_ecm`.`compliance`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`change_record` ADD CONSTRAINT `fk_assurance_change_record_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`qos_measurement` ADD CONSTRAINT `fk_assurance_qos_measurement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= assurance --> content (12 constraint(s)) =========
-- Requires: assurance schema, content schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`revenue_leakage_case` ADD CONSTRAINT `fk_assurance_revenue_leakage_case_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`qos_measurement` ADD CONSTRAINT `fk_assurance_qos_measurement_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`qos_measurement` ADD CONSTRAINT `fk_assurance_qos_measurement_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);

-- ========= assurance --> customer (15 constraint(s)) =========
-- Requires: assurance schema, customer schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_case_id` FOREIGN KEY (`case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_corporate_hierarchy_id` FOREIGN KEY (`corporate_hierarchy_id`) REFERENCES `telecommunication_ecm`.`customer`.`corporate_hierarchy`(`corporate_hierarchy_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`revenue_leakage_case` ADD CONSTRAINT `fk_assurance_revenue_leakage_case_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`revenue_leakage_case` ADD CONSTRAINT `fk_assurance_revenue_leakage_case_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`qos_measurement` ADD CONSTRAINT `fk_assurance_qos_measurement_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= assurance --> finance (12 constraint(s)) =========
-- Requires: assurance schema, finance schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`revenue_leakage_case` ADD CONSTRAINT `fk_assurance_revenue_leakage_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`reconciliation_run` ADD CONSTRAINT `fk_assurance_reconciliation_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`change_record` ADD CONSTRAINT `fk_assurance_change_record_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`change_record` ADD CONSTRAINT `fk_assurance_change_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= assurance --> inventory (17 constraint(s)) =========
-- Requires: assurance schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`revenue_leakage_case` ADD CONSTRAINT `fk_assurance_revenue_leakage_case_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`reconciliation_run` ADD CONSTRAINT `fk_assurance_reconciliation_run_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`reconciliation_run` ADD CONSTRAINT `fk_assurance_reconciliation_run_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`change_record` ADD CONSTRAINT `fk_assurance_change_record_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`qos_measurement` ADD CONSTRAINT `fk_assurance_qos_measurement_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);

-- ========= assurance --> location (2 constraint(s)) =========
-- Requires: assurance schema, location schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_exchange_id` FOREIGN KEY (`exchange_id`) REFERENCES `telecommunication_ecm`.`location`.`exchange`(`exchange_id`);

-- ========= assurance --> network (11 constraint(s)) =========
-- Requires: assurance schema, network schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_alarm_id` FOREIGN KEY (`alarm_id`) REFERENCES `telecommunication_ecm`.`network`.`alarm`(`alarm_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_planned_outage_id` FOREIGN KEY (`planned_outage_id`) REFERENCES `telecommunication_ecm`.`network`.`planned_outage`(`planned_outage_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`qos_measurement` ADD CONSTRAINT `fk_assurance_qos_measurement_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);

-- ========= assurance --> partner (8 constraint(s)) =========
-- Requires: assurance schema, partner schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);

-- ========= assurance --> people (8 constraint(s)) =========
-- Requires: assurance schema, people schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`revenue_leakage_case` ADD CONSTRAINT `fk_assurance_revenue_leakage_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`reconciliation_run` ADD CONSTRAINT `fk_assurance_reconciliation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= assurance --> product (12 constraint(s)) =========
-- Requires: assurance schema, product schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`revenue_leakage_case` ADD CONSTRAINT `fk_assurance_revenue_leakage_case_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`revenue_leakage_case` ADD CONSTRAINT `fk_assurance_revenue_leakage_case_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`qos_measurement` ADD CONSTRAINT `fk_assurance_qos_measurement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= assurance --> service (8 constraint(s)) =========
-- Requires: assurance schema, service schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`qos_measurement` ADD CONSTRAINT `fk_assurance_qos_measurement_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`qos_measurement` ADD CONSTRAINT `fk_assurance_qos_measurement_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= assurance --> workforce (1 constraint(s)) =========
-- Requires: assurance schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);

-- ========= billing --> analytics (8 constraint(s)) =========
-- Requires: billing schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);

-- ========= billing --> assurance (1 constraint(s)) =========
-- Requires: billing schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);

-- ========= billing --> compliance (6 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= billing --> content (15 constraint(s)) =========
-- Requires: billing schema, content schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ADD CONSTRAINT `fk_billing_billing_subscription_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ADD CONSTRAINT `fk_billing_rate_plan_content_package_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);

-- ========= billing --> customer (19 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_customer_subscription_id` FOREIGN KEY (`customer_subscription_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_subscription`(`customer_subscription_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_case_id` FOREIGN KEY (`case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_customer_subscription_id` FOREIGN KEY (`customer_subscription_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_subscription`(`customer_subscription_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_case_id` FOREIGN KEY (`case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= billing --> enterprise (9 constraint(s)) =========
-- Requires: billing schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ADD CONSTRAINT `fk_billing_corporate_rate_plan_agreement_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);

-- ========= billing --> finance (5 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`voucher_batch` ADD CONSTRAINT `fk_billing_voucher_batch_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `telecommunication_ecm`.`finance`.`vendor`(`vendor_id`);

-- ========= billing --> interconnect (5 constraint(s)) =========
-- Requires: billing schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_tap_record_id` FOREIGN KEY (`tap_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_record`(`tap_record_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_tap_record_id` FOREIGN KEY (`tap_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_record`(`tap_record_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_settlement_dispute_id` FOREIGN KEY (`settlement_dispute_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`settlement_dispute`(`settlement_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_settlement_dispute_id` FOREIGN KEY (`settlement_dispute_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`settlement_dispute`(`settlement_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_settlement_dispute_id` FOREIGN KEY (`settlement_dispute_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`settlement_dispute`(`settlement_dispute_id`);

-- ========= billing --> inventory (14 constraint(s)) =========
-- Requires: billing schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_spectrum_allocation_id` FOREIGN KEY (`spectrum_allocation_id`) REFERENCES `telecommunication_ecm`.`inventory`.`spectrum_allocation`(`spectrum_allocation_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_spectrum_allocation_id` FOREIGN KEY (`spectrum_allocation_id`) REFERENCES `telecommunication_ecm`.`inventory`.`spectrum_allocation`(`spectrum_allocation_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);

-- ========= billing --> location (7 constraint(s)) =========
-- Requires: billing schema, location schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);

-- ========= billing --> network (1 constraint(s)) =========
-- Requires: billing schema, network schema
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);

-- ========= billing --> order (1 constraint(s)) =========
-- Requires: billing schema, order schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= billing --> partner (9 constraint(s)) =========
-- Requires: billing schema, partner schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= billing --> people (16 constraint(s)) =========
-- Requires: billing schema, people schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_billing_employee_id` FOREIGN KEY (`billing_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ADD CONSTRAINT `fk_billing_rate_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ADD CONSTRAINT `fk_billing_contract_billing_arrangement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`voucher_batch` ADD CONSTRAINT `fk_billing_voucher_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`voucher_batch` ADD CONSTRAINT `fk_billing_voucher_batch_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= billing --> product (14 constraint(s)) =========
-- Requires: billing schema, product schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ADD CONSTRAINT `fk_billing_rate_plan_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);

-- ========= billing --> sales (9 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ADD CONSTRAINT `fk_billing_rate_plan_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ADD CONSTRAINT `fk_billing_contract_billing_arrangement_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`voucher_batch` ADD CONSTRAINT `fk_billing_voucher_batch_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);

-- ========= billing --> service (5 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= billing --> usage (2 constraint(s)) =========
-- Requires: billing schema, usage schema
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_cdr_id` FOREIGN KEY (`cdr_id`) REFERENCES `telecommunication_ecm`.`usage`.`cdr`(`cdr_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_balance_id` FOREIGN KEY (`balance_id`) REFERENCES `telecommunication_ecm`.`usage`.`balance`(`balance_id`);

-- ========= billing --> workforce (2 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);

-- ========= compliance --> analytics (15 constraint(s)) =========
-- Requires: compliance schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_bi_report_definition_id` FOREIGN KEY (`bi_report_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`bi_report_definition`(`bi_report_definition_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_dq_issue_id` FOREIGN KEY (`dq_issue_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_dq_issue_id` FOREIGN KEY (`dq_issue_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_analytical_subject_area_id` FOREIGN KEY (`analytical_subject_area_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_subject_area`(`analytical_subject_area_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_dq_execution_result_id` FOREIGN KEY (`dq_execution_result_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_execution_result`(`dq_execution_result_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_analytical_model_registry_id` FOREIGN KEY (`analytical_model_registry_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_model_registry`(`analytical_model_registry_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_dq_issue_id` FOREIGN KEY (`dq_issue_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_bi_report_definition_id` FOREIGN KEY (`bi_report_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`bi_report_definition`(`bi_report_definition_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ADD CONSTRAINT `fk_compliance_audit_rule_test_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);

-- ========= compliance --> customer (8 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ADD CONSTRAINT `fk_compliance_mnp_compliance_customer_mnp_request_id` FOREIGN KEY (`customer_mnp_request_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_mnp_request`(`customer_mnp_request_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ADD CONSTRAINT `fk_compliance_mnp_compliance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ADD CONSTRAINT `fk_compliance_cpni_authorization_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ADD CONSTRAINT `fk_compliance_cpni_authorization_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= compliance --> enterprise (12 constraint(s)) =========
-- Requires: compliance schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ADD CONSTRAINT `fk_compliance_spectrum_license_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ADD CONSTRAINT `fk_compliance_mnp_compliance_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ADD CONSTRAINT `fk_compliance_e911_compliance_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ADD CONSTRAINT `fk_compliance_account_obligation_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);

-- ========= compliance --> finance (19 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ADD CONSTRAINT `fk_compliance_spectrum_license_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ADD CONSTRAINT `fk_compliance_e911_compliance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= compliance --> interconnect (1 constraint(s)) =========
-- Requires: compliance schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);

-- ========= compliance --> location (11 constraint(s)) =========
-- Requires: compliance schema, location schema
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ADD CONSTRAINT `fk_compliance_spectrum_license_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ADD CONSTRAINT `fk_compliance_e911_compliance_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ADD CONSTRAINT `fk_compliance_e911_compliance_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ADD CONSTRAINT `fk_compliance_coverage_obligation_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);

-- ========= compliance --> people (15 constraint(s)) =========
-- Requires: compliance schema, people schema
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ADD CONSTRAINT `fk_compliance_spectrum_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ADD CONSTRAINT `fk_compliance_mnp_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ADD CONSTRAINT `fk_compliance_cpni_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ADD CONSTRAINT `fk_compliance_e911_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= content --> analytics (16 constraint(s)) =========
-- Requires: content schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ADD CONSTRAINT `fk_content_vod_asset_bi_report_definition_id` FOREIGN KEY (`bi_report_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`bi_report_definition`(`bi_report_definition_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_asset` ADD CONSTRAINT `fk_content_vod_asset_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ADD CONSTRAINT `fk_content_iptv_channel_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ADD CONSTRAINT `fk_content_ott_platform_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`license` ADD CONSTRAINT `fk_content_license_bi_report_definition_id` FOREIGN KEY (`bi_report_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`bi_report_definition`(`bi_report_definition_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`license` ADD CONSTRAINT `fk_content_license_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_ab_test_assignment_id` FOREIGN KEY (`ab_test_assignment_id`) REFERENCES `telecommunication_ecm`.`analytics`.`ab_test_assignment`(`ab_test_assignment_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_analytics_segment_membership_id` FOREIGN KEY (`analytics_segment_membership_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytics_segment_membership`(`analytics_segment_membership_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ADD CONSTRAINT `fk_content_vod_rental_revenue_analytics_kpi_id` FOREIGN KEY (`revenue_analytics_kpi_id`) REFERENCES `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi`(`revenue_analytics_kpi_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ADD CONSTRAINT `fk_content_geo_restriction_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ADD CONSTRAINT `fk_content_network_recording_customer_analytics_kpi_id` FOREIGN KEY (`customer_analytics_kpi_id`) REFERENCES `telecommunication_ecm`.`analytics`.`customer_analytics_kpi`(`customer_analytics_kpi_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ADD CONSTRAINT `fk_content_ingestion_job_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ADD CONSTRAINT `fk_content_rights_window_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ADD CONSTRAINT `fk_content_ad_insertion_policy_ab_test_id` FOREIGN KEY (`ab_test_id`) REFERENCES `telecommunication_ecm`.`analytics`.`ab_test`(`ab_test_id`);

-- ========= content --> billing (2 constraint(s)) =========
-- Requires: content schema, billing schema
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ADD CONSTRAINT `fk_content_vod_rental_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `telecommunication_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ADD CONSTRAINT `fk_content_ott_entitlement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= content --> compliance (10 constraint(s)) =========
-- Requires: content schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`content`.`license` ADD CONSTRAINT `fk_content_license_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`drm_policy` ADD CONSTRAINT `fk_content_drm_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ADD CONSTRAINT `fk_content_vod_rental_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ADD CONSTRAINT `fk_content_epg_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ADD CONSTRAINT `fk_content_ott_entitlement_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ADD CONSTRAINT `fk_content_network_recording_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ADD CONSTRAINT `fk_content_ingestion_job_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ADD CONSTRAINT `fk_content_rights_window_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ADD CONSTRAINT `fk_content_ad_insertion_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= content --> customer (5 constraint(s)) =========
-- Requires: content schema, customer schema
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ADD CONSTRAINT `fk_content_vod_rental_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ADD CONSTRAINT `fk_content_vod_rental_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ADD CONSTRAINT `fk_content_ott_entitlement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ADD CONSTRAINT `fk_content_network_recording_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= content --> enterprise (7 constraint(s)) =========
-- Requires: content schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`content`.`content_channel_lineup` ADD CONSTRAINT `fk_content_content_channel_lineup_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`license` ADD CONSTRAINT `fk_content_license_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ADD CONSTRAINT `fk_content_vod_catalog_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ADD CONSTRAINT `fk_content_ott_entitlement_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ADD CONSTRAINT `fk_content_ott_subscription_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);

-- ========= content --> finance (7 constraint(s)) =========
-- Requires: content schema, finance schema
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ADD CONSTRAINT `fk_content_ott_platform_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`license` ADD CONSTRAINT `fk_content_license_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`license` ADD CONSTRAINT `fk_content_license_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ADD CONSTRAINT `fk_content_vod_rental_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ADD CONSTRAINT `fk_content_ingestion_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ADD CONSTRAINT `fk_content_ad_insertion_policy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= content --> inventory (7 constraint(s)) =========
-- Requires: content schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`entitlement` ADD CONSTRAINT `fk_content_entitlement_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ADD CONSTRAINT `fk_content_vod_rental_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ADD CONSTRAINT `fk_content_ott_entitlement_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ADD CONSTRAINT `fk_content_network_recording_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ADD CONSTRAINT `fk_content_network_recording_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ADD CONSTRAINT `fk_content_ingestion_job_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);

-- ========= content --> location (7 constraint(s)) =========
-- Requires: content schema, location schema
ALTER TABLE `telecommunication_ecm`.`content`.`iptv_channel` ADD CONSTRAINT `fk_content_iptv_channel_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`license` ADD CONSTRAINT `fk_content_license_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ADD CONSTRAINT `fk_content_epg_schedule_geo_boundary_id` FOREIGN KEY (`geo_boundary_id`) REFERENCES `telecommunication_ecm`.`location`.`geo_boundary`(`geo_boundary_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ADD CONSTRAINT `fk_content_geo_restriction_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ADD CONSTRAINT `fk_content_geo_restriction_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`network_recording` ADD CONSTRAINT `fk_content_network_recording_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ADD CONSTRAINT `fk_content_package_territory_availability_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);

-- ========= content --> order (1 constraint(s)) =========
-- Requires: content schema, order schema
ALTER TABLE `telecommunication_ecm`.`content`.`vod_rental` ADD CONSTRAINT `fk_content_vod_rental_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= content --> partner (7 constraint(s)) =========
-- Requires: content schema, partner schema
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ADD CONSTRAINT `fk_content_ott_platform_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`license` ADD CONSTRAINT `fk_content_license_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ADD CONSTRAINT `fk_content_epg_schedule_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ADD CONSTRAINT `fk_content_ott_entitlement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`geo_restriction` ADD CONSTRAINT `fk_content_geo_restriction_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ADD CONSTRAINT `fk_content_ingestion_job_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`rights_window` ADD CONSTRAINT `fk_content_rights_window_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= content --> people (8 constraint(s)) =========
-- Requires: content schema, people schema
ALTER TABLE `telecommunication_ecm`.`content`.`ott_platform` ADD CONSTRAINT `fk_content_ott_platform_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`license` ADD CONSTRAINT `fk_content_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`epg_schedule` ADD CONSTRAINT `fk_content_epg_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`vod_catalog` ADD CONSTRAINT `fk_content_vod_catalog_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ingestion_job` ADD CONSTRAINT `fk_content_ingestion_job_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ad_insertion_policy` ADD CONSTRAINT `fk_content_ad_insertion_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`ott_subscription` ADD CONSTRAINT `fk_content_ott_subscription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`content`.`package_territory_availability` ADD CONSTRAINT `fk_content_package_territory_availability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= content --> product (1 constraint(s)) =========
-- Requires: content schema, product schema
ALTER TABLE `telecommunication_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= content --> service (1 constraint(s)) =========
-- Requires: content schema, service schema
ALTER TABLE `telecommunication_ecm`.`content`.`ott_entitlement` ADD CONSTRAINT `fk_content_ott_entitlement_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);

-- ========= customer --> analytics (8 constraint(s)) =========
-- Requires: customer schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ADD CONSTRAINT `fk_customer_loyalty_account_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ADD CONSTRAINT `fk_customer_kyc_verification_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ADD CONSTRAINT `fk_customer_customer_segment_membership_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);

-- ========= customer --> assurance (6 constraint(s)) =========
-- Requires: customer schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);

-- ========= customer --> billing (8 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ADD CONSTRAINT `fk_customer_customer_mnp_request_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ADD CONSTRAINT `fk_customer_loyalty_account_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ADD CONSTRAINT `fk_customer_promo_redemption_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ADD CONSTRAINT `fk_customer_customer_subscription_billing_subscription_id` FOREIGN KEY (`billing_subscription_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_subscription`(`billing_subscription_id`);

-- ========= customer --> compliance (3 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ADD CONSTRAINT `fk_customer_kyc_verification_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);

-- ========= customer --> content (5 constraint(s)) =========
-- Requires: customer schema, content schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);

-- ========= customer --> enterprise (1 constraint(s)) =========
-- Requires: customer schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);

-- ========= customer --> finance (3 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ADD CONSTRAINT `fk_customer_loyalty_account_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= customer --> interconnect (1 constraint(s)) =========
-- Requires: customer schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ADD CONSTRAINT `fk_customer_customer_mnp_request_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);

-- ========= customer --> inventory (5 constraint(s)) =========
-- Requires: customer schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ADD CONSTRAINT `fk_customer_customer_mnp_request_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);

-- ========= customer --> location (9 constraint(s)) =========
-- Requires: customer schema, location schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ADD CONSTRAINT `fk_customer_customer_address_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ADD CONSTRAINT `fk_customer_customer_mnp_request_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);

-- ========= customer --> order (3 constraint(s)) =========
-- Requires: customer schema, order schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= customer --> partner (6 constraint(s)) =========
-- Requires: customer schema, partner schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ADD CONSTRAINT `fk_customer_customer_address_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ADD CONSTRAINT `fk_customer_account_dealer_transaction_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ADD CONSTRAINT `fk_customer_customer_roaming_session_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);

-- ========= customer --> people (8 constraint(s)) =========
-- Requires: customer schema, people schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ADD CONSTRAINT `fk_customer_kyc_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ADD CONSTRAINT `fk_customer_customer_account_coverage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ADD CONSTRAINT `fk_customer_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= customer --> product (24 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ADD CONSTRAINT `fk_customer_loyalty_account_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_device_offering_id` FOREIGN KEY (`device_offering_id`) REFERENCES `telecommunication_ecm`.`product`.`device_offering`(`device_offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ADD CONSTRAINT `fk_customer_promo_redemption_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ADD CONSTRAINT `fk_customer_customer_subscription_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);

-- ========= customer --> sales (1 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ADD CONSTRAINT `fk_customer_redemption_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);

-- ========= customer --> service (4 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_esim_profile_id` FOREIGN KEY (`esim_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`esim_profile`(`esim_profile_id`);

-- ========= customer --> workforce (2 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);

-- ========= enterprise --> analytics (8 constraint(s)) =========
-- Requires: enterprise schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`corporate_account` ADD CONSTRAINT `fk_enterprise_corporate_account_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_sla_measurement` ADD CONSTRAINT `fk_enterprise_enterprise_sla_measurement_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_breach` ADD CONSTRAINT `fk_enterprise_sla_breach_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_customer_analytics_kpi_id` FOREIGN KEY (`customer_analytics_kpi_id`) REFERENCES `telecommunication_ecm`.`analytics`.`customer_analytics_kpi`(`customer_analytics_kpi_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`government_contract` ADD CONSTRAINT `fk_enterprise_government_contract_revenue_analytics_kpi_id` FOREIGN KEY (`revenue_analytics_kpi_id`) REFERENCES `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi`(`revenue_analytics_kpi_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`segment` ADD CONSTRAINT `fk_enterprise_segment_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_dq_issue_id` FOREIGN KEY (`dq_issue_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);

-- ========= enterprise --> assurance (10 constraint(s)) =========
-- Requires: enterprise schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_sla_measurement` ADD CONSTRAINT `fk_enterprise_enterprise_sla_measurement_performance_measurement_id` FOREIGN KEY (`performance_measurement_id`) REFERENCES `telecommunication_ecm`.`assurance`.`performance_measurement`(`performance_measurement_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_sla_measurement` ADD CONSTRAINT `fk_enterprise_enterprise_sla_measurement_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_breach` ADD CONSTRAINT `fk_enterprise_sla_breach_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_change_record_id` FOREIGN KEY (`change_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`change_record`(`change_record_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);

-- ========= enterprise --> billing (3 constraint(s)) =========
-- Requires: enterprise schema, billing schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_site` ADD CONSTRAINT `fk_enterprise_enterprise_site_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);

-- ========= enterprise --> compliance (1 constraint(s)) =========
-- Requires: enterprise schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_breach` ADD CONSTRAINT `fk_enterprise_sla_breach_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);

-- ========= enterprise --> customer (2 constraint(s)) =========
-- Requires: enterprise schema, customer schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_breach` ADD CONSTRAINT `fk_enterprise_sla_breach_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= enterprise --> finance (15 constraint(s)) =========
-- Requires: enterprise schema, finance schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`corporate_account` ADD CONSTRAINT `fk_enterprise_corporate_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`corporate_account` ADD CONSTRAINT `fk_enterprise_corporate_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_site` ADD CONSTRAINT `fk_enterprise_enterprise_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sdwan_topology` ADD CONSTRAINT `fk_enterprise_sdwan_topology_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sdwan_topology` ADD CONSTRAINT `fk_enterprise_sdwan_topology_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`government_contract` ADD CONSTRAINT `fk_enterprise_government_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= enterprise --> interconnect (2 constraint(s)) =========
-- Requires: enterprise schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);

-- ========= enterprise --> inventory (9 constraint(s)) =========
-- Requires: enterprise schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_site` ADD CONSTRAINT `fk_enterprise_enterprise_site_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_rack_slot_port_id` FOREIGN KEY (`rack_slot_port_id`) REFERENCES `telecommunication_ecm`.`inventory`.`rack_slot_port`(`rack_slot_port_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sdwan_topology` ADD CONSTRAINT `fk_enterprise_sdwan_topology_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);

-- ========= enterprise --> location (12 constraint(s)) =========
-- Requires: enterprise schema, location schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`corporate_account` ADD CONSTRAINT `fk_enterprise_corporate_account_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_site` ADD CONSTRAINT `fk_enterprise_enterprise_site_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_site` ADD CONSTRAINT `fk_enterprise_enterprise_site_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_site` ADD CONSTRAINT `fk_enterprise_enterprise_site_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_breach` ADD CONSTRAINT `fk_enterprise_sla_breach_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_breach` ADD CONSTRAINT `fk_enterprise_sla_breach_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);

-- ========= enterprise --> network (1 constraint(s)) =========
-- Requires: enterprise schema, network schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_circuit_id` FOREIGN KEY (`circuit_id`) REFERENCES `telecommunication_ecm`.`network`.`circuit`(`circuit_id`);

-- ========= enterprise --> people (14 constraint(s)) =========
-- Requires: enterprise schema, people schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`account_hierarchy` ADD CONSTRAINT `fk_enterprise_account_hierarchy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_site` ADD CONSTRAINT `fk_enterprise_enterprise_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_breach` ADD CONSTRAINT `fk_enterprise_sla_breach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sdwan_topology` ADD CONSTRAINT `fk_enterprise_sdwan_topology_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`discount_scheme` ADD CONSTRAINT `fk_enterprise_discount_scheme_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`government_contract` ADD CONSTRAINT `fk_enterprise_government_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_ticket_technical_account_manager_employee_id` FOREIGN KEY (`ticket_technical_account_manager_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`site_access` ADD CONSTRAINT `fk_enterprise_site_access_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_account_coverage` ADD CONSTRAINT `fk_enterprise_enterprise_account_coverage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= enterprise --> product (9 constraint(s)) =========
-- Requires: enterprise schema, product schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_device_offering_id` FOREIGN KEY (`device_offering_id`) REFERENCES `telecommunication_ecm`.`product`.`device_offering`(`device_offering_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`discount_scheme` ADD CONSTRAINT `fk_enterprise_discount_scheme_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= enterprise --> service (2 constraint(s)) =========
-- Requires: enterprise schema, service schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_sla_measurement` ADD CONSTRAINT `fk_enterprise_enterprise_sla_measurement_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`ticket` ADD CONSTRAINT `fk_enterprise_ticket_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= enterprise --> workforce (1 constraint(s)) =========
-- Requires: enterprise schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`site_access` ADD CONSTRAINT `fk_enterprise_site_access_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);

-- ========= finance --> analytics (5 constraint(s)) =========
-- Requires: finance schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ADD CONSTRAINT `fk_finance_financial_consolidation_analytical_subject_area_id` FOREIGN KEY (`analytical_subject_area_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_subject_area`(`analytical_subject_area_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);

-- ========= finance --> billing (5 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `telecommunication_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= finance --> customer (4 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `telecommunication_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= finance --> enterprise (7 constraint(s)) =========
-- Requires: finance schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);

-- ========= finance --> location (12 constraint(s)) =========
-- Requires: finance schema, location schema
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_network_rollout_zone_id` FOREIGN KEY (`network_rollout_zone_id`) REFERENCES `telecommunication_ecm`.`location`.`network_rollout_zone`(`network_rollout_zone_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_allocation` ADD CONSTRAINT `fk_finance_budget_allocation_network_rollout_zone_id` FOREIGN KEY (`network_rollout_zone_id`) REFERENCES `telecommunication_ecm`.`location`.`network_rollout_zone`(`network_rollout_zone_id`);

-- ========= finance --> network (1 constraint(s)) =========
-- Requires: finance schema, network schema
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);

-- ========= finance --> partner (1 constraint(s)) =========
-- Requires: finance schema, partner schema
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= finance --> people (20 constraint(s)) =========
-- Requires: finance schema, people schema
ALTER TABLE `telecommunication_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ADD CONSTRAINT `fk_finance_vendor_payment_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ADD CONSTRAINT `fk_finance_vendor_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`vendor_payment` ADD CONSTRAINT `fk_finance_vendor_payment_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_user_employee_id` FOREIGN KEY (`user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`financial_consolidation` ADD CONSTRAINT `fk_finance_financial_consolidation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_primary_capital_approved_by_employee_id` FOREIGN KEY (`primary_capital_approved_by_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ADD CONSTRAINT `fk_finance_finance_project_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`finance_project_assignment` ADD CONSTRAINT `fk_finance_finance_project_assignment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `telecommunication_ecm`.`people`.`assignment`(`assignment_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_delegated_by_employee_id` FOREIGN KEY (`delegated_by_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`allocation_rule` ADD CONSTRAINT `fk_finance_allocation_rule_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= finance --> product (2 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);

-- ========= finance --> sales (2 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `telecommunication_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= finance --> service (1 constraint(s)) =========
-- Requires: finance schema, service schema
ALTER TABLE `telecommunication_ecm`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= interconnect --> analytics (10 constraint(s)) =========
-- Requires: interconnect schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_record` ADD CONSTRAINT `fk_interconnect_tap_record_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`nrtrde_record` ADD CONSTRAINT `fk_interconnect_nrtrde_record_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`transit_traffic_record` ADD CONSTRAINT `fk_interconnect_transit_traffic_record_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice` ADD CONSTRAINT `fk_interconnect_settlement_invoice_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice_line` ADD CONSTRAINT `fk_interconnect_settlement_invoice_line_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_dispute` ADD CONSTRAINT `fk_interconnect_settlement_dispute_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`rate` ADD CONSTRAINT `fk_interconnect_rate_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`rap_file` ADD CONSTRAINT `fk_interconnect_rap_file_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);

-- ========= interconnect --> assurance (2 constraint(s)) =========
-- Requires: interconnect schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_dispute` ADD CONSTRAINT `fk_interconnect_settlement_dispute_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);

-- ========= interconnect --> billing (1 constraint(s)) =========
-- Requires: interconnect schema, billing schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`transit_traffic_record` ADD CONSTRAINT `fk_interconnect_transit_traffic_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= interconnect --> compliance (7 constraint(s)) =========
-- Requires: interconnect schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier` ADD CONSTRAINT `fk_interconnect_carrier_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_record` ADD CONSTRAINT `fk_interconnect_tap_record_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`nrtrde_record` ADD CONSTRAINT `fk_interconnect_nrtrde_record_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_dispute` ADD CONSTRAINT `fk_interconnect_settlement_dispute_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_mnp_compliance_id` FOREIGN KEY (`mnp_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`mnp_compliance`(`mnp_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);

-- ========= interconnect --> enterprise (6 constraint(s)) =========
-- Requires: interconnect schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier` ADD CONSTRAINT `fk_interconnect_carrier_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_file` ADD CONSTRAINT `fk_interconnect_tap_file_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice` ADD CONSTRAINT `fk_interconnect_settlement_invoice_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);

-- ========= interconnect --> finance (8 constraint(s)) =========
-- Requires: interconnect schema, finance schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_file` ADD CONSTRAINT `fk_interconnect_tap_file_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`transit_traffic_record` ADD CONSTRAINT `fk_interconnect_transit_traffic_record_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice` ADD CONSTRAINT `fk_interconnect_settlement_invoice_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice_line` ADD CONSTRAINT `fk_interconnect_settlement_invoice_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_dispute` ADD CONSTRAINT `fk_interconnect_settlement_dispute_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= interconnect --> inventory (3 constraint(s)) =========
-- Requires: interconnect schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_record` ADD CONSTRAINT `fk_interconnect_tap_record_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`nrtrde_record` ADD CONSTRAINT `fk_interconnect_nrtrde_record_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`transit_traffic_record` ADD CONSTRAINT `fk_interconnect_transit_traffic_record_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);

-- ========= interconnect --> location (5 constraint(s)) =========
-- Requires: interconnect schema, location schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier` ADD CONSTRAINT `fk_interconnect_carrier_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`peering_arrangement` ADD CONSTRAINT `fk_interconnect_peering_arrangement_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice` ADD CONSTRAINT `fk_interconnect_settlement_invoice_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);

-- ========= interconnect --> network (9 constraint(s)) =========
-- Requires: interconnect schema, network schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_record` ADD CONSTRAINT `fk_interconnect_tap_record_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`nrtrde_record` ADD CONSTRAINT `fk_interconnect_nrtrde_record_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`transit_traffic_record` ADD CONSTRAINT `fk_interconnect_transit_traffic_record_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`rate` ADD CONSTRAINT `fk_interconnect_rate_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_mpls_tunnel_id` FOREIGN KEY (`mpls_tunnel_id`) REFERENCES `telecommunication_ecm`.`network`.`mpls_tunnel`(`mpls_tunnel_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);

-- ========= interconnect --> partner (6 constraint(s)) =========
-- Requires: interconnect schema, partner schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier` ADD CONSTRAINT `fk_interconnect_carrier_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice` ADD CONSTRAINT `fk_interconnect_settlement_invoice_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_dispute` ADD CONSTRAINT `fk_interconnect_settlement_dispute_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= interconnect --> people (5 constraint(s)) =========
-- Requires: interconnect schema, people schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`peering_arrangement` ADD CONSTRAINT `fk_interconnect_peering_arrangement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice` ADD CONSTRAINT `fk_interconnect_settlement_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_dispute` ADD CONSTRAINT `fk_interconnect_settlement_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= interconnect --> workforce (1 constraint(s)) =========
-- Requires: interconnect schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);

-- ========= inventory --> assurance (1 constraint(s)) =========
-- Requires: inventory schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);

-- ========= inventory --> compliance (7 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_cpni_authorization_id` FOREIGN KEY (`cpni_authorization_id`) REFERENCES `telecommunication_ecm`.`compliance`.`cpni_authorization`(`cpni_authorization_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ADD CONSTRAINT `fk_inventory_msisdn_range_mnp_compliance_id` FOREIGN KEY (`mnp_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`mnp_compliance`(`mnp_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ADD CONSTRAINT `fk_inventory_spectrum_allocation_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);

-- ========= inventory --> customer (4 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= inventory --> enterprise (2 constraint(s)) =========
-- Requires: inventory schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ADD CONSTRAINT `fk_inventory_service_equipment_assignment_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`circuit` ADD CONSTRAINT `fk_inventory_circuit_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);

-- ========= inventory --> finance (20 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `telecommunication_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ADD CONSTRAINT `fk_inventory_spectrum_allocation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ADD CONSTRAINT `fk_inventory_spare_part_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ADD CONSTRAINT `fk_inventory_pop_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= inventory --> interconnect (1 constraint(s)) =========
-- Requires: inventory schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ADD CONSTRAINT `fk_inventory_fiber_lease_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);

-- ========= inventory --> location (20 constraint(s)) =========
-- Requires: inventory schema, location schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_duct_route_id` FOREIGN KEY (`duct_route_id`) REFERENCES `telecommunication_ecm`.`location`.`duct_route`(`duct_route_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ADD CONSTRAINT `fk_inventory_fiber_splice_geo_point_id` FOREIGN KEY (`geo_point_id`) REFERENCES `telecommunication_ecm`.`location`.`geo_point`(`geo_point_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ADD CONSTRAINT `fk_inventory_ip_address_pool_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ADD CONSTRAINT `fk_inventory_msisdn_range_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ADD CONSTRAINT `fk_inventory_spectrum_allocation_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ADD CONSTRAINT `fk_inventory_spare_part_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_exchange_id` FOREIGN KEY (`exchange_id`) REFERENCES `telecommunication_ecm`.`location`.`exchange`(`exchange_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`circuit` ADD CONSTRAINT `fk_inventory_circuit_end_location_id` FOREIGN KEY (`end_location_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`circuit` ADD CONSTRAINT `fk_inventory_circuit_end_location_location_site_id` FOREIGN KEY (`end_location_location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`circuit` ADD CONSTRAINT `fk_inventory_circuit_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`circuit` ADD CONSTRAINT `fk_inventory_circuit_start_location_location_site_id` FOREIGN KEY (`start_location_location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);

-- ========= inventory --> network (2 constraint(s)) =========
-- Requires: inventory schema, network schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ADD CONSTRAINT `fk_inventory_ip_address_pool_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);

-- ========= inventory --> order (2 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= inventory --> partner (11 constraint(s)) =========
-- Requires: inventory schema, partner schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ADD CONSTRAINT `fk_inventory_msisdn_range_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ADD CONSTRAINT `fk_inventory_spectrum_allocation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ADD CONSTRAINT `fk_inventory_spare_part_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ADD CONSTRAINT `fk_inventory_colocation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= inventory --> people (12 constraint(s)) =========
-- Requires: inventory schema, people schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ADD CONSTRAINT `fk_inventory_spectrum_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ADD CONSTRAINT `fk_inventory_spare_part_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ADD CONSTRAINT `fk_inventory_pop_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `telecommunication_ecm`.`people`.`assignment`(`assignment_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` ADD CONSTRAINT `fk_inventory_maintenance_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= inventory --> product (8 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ADD CONSTRAINT `fk_inventory_spare_part_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ADD CONSTRAINT `fk_inventory_spare_part_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);

-- ========= inventory --> service (3 constraint(s)) =========
-- Requires: inventory schema, service schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= inventory --> workforce (12 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ADD CONSTRAINT `fk_inventory_fiber_splice_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ADD CONSTRAINT `fk_inventory_fiber_splice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ADD CONSTRAINT `fk_inventory_spare_part_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ADD CONSTRAINT `fk_inventory_pop_facility_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);

-- ========= location --> enterprise (1 constraint(s)) =========
-- Requires: location schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ADD CONSTRAINT `fk_location_geo_point_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);

-- ========= location --> network (8 constraint(s)) =========
-- Requires: location schema, network schema
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ADD CONSTRAINT `fk_location_exchange_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ADD CONSTRAINT `fk_location_premise_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ADD CONSTRAINT `fk_location_coverage_qualification_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ADD CONSTRAINT `fk_location_premises_passed_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ADD CONSTRAINT `fk_location_cell_coverage_footprint_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ADD CONSTRAINT `fk_location_black_spot_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ADD CONSTRAINT `fk_location_mdu_building_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ADD CONSTRAINT `fk_location_drive_test_record_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);

-- ========= location --> people (16 constraint(s)) =========
-- Requires: location schema, people schema
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ADD CONSTRAINT `fk_location_coverage_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ADD CONSTRAINT `fk_location_address_validation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ADD CONSTRAINT `fk_location_coverage_area_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ADD CONSTRAINT `fk_location_network_rollout_zone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ADD CONSTRAINT `fk_location_network_rollout_zone_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ADD CONSTRAINT `fk_location_premises_passed_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ADD CONSTRAINT `fk_location_duct_route_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ADD CONSTRAINT `fk_location_address_alias_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ADD CONSTRAINT `fk_location_change_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ADD CONSTRAINT `fk_location_change_event_primary_change_employee_id` FOREIGN KEY (`primary_change_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ADD CONSTRAINT `fk_location_black_spot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ADD CONSTRAINT `fk_location_address_geocode_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ADD CONSTRAINT `fk_location_infrastructure_corridor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ADD CONSTRAINT `fk_location_coverage_gap_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ADD CONSTRAINT `fk_location_reference_code_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ADD CONSTRAINT `fk_location_drive_test_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= location --> workforce (4 constraint(s)) =========
-- Requires: location schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ADD CONSTRAINT `fk_location_network_rollout_zone_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `telecommunication_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ADD CONSTRAINT `fk_location_premises_passed_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `telecommunication_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ADD CONSTRAINT `fk_location_coverage_gap_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`field_survey` ADD CONSTRAINT `fk_location_field_survey_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);

-- ========= network --> assurance (8 constraint(s)) =========
-- Requires: network schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ADD CONSTRAINT `fk_network_mpls_tunnel_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_change_record_id` FOREIGN KEY (`change_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`change_record`(`change_record_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_change_record_id` FOREIGN KEY (`change_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`change_record`(`change_record_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_change_record_id` FOREIGN KEY (`change_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`change_record`(`change_record_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);

-- ========= network --> billing (5 constraint(s)) =========
-- Requires: network schema, billing schema
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ADD CONSTRAINT `fk_network_capacity_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ADD CONSTRAINT `fk_network_peering_agreement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);

-- ========= network --> compliance (8 constraint(s)) =========
-- Requires: network schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_e911_compliance_id` FOREIGN KEY (`e911_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`e911_compliance`(`e911_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ADD CONSTRAINT `fk_network_network_capacity_plan_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);

-- ========= network --> customer (5 constraint(s)) =========
-- Requires: network schema, customer schema
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ADD CONSTRAINT `fk_network_sdwan_policy_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= network --> enterprise (17 constraint(s)) =========
-- Requires: network schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ADD CONSTRAINT `fk_network_mpls_tunnel_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ADD CONSTRAINT `fk_network_network_capacity_plan_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ADD CONSTRAINT `fk_network_sdwan_policy_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ADD CONSTRAINT `fk_network_sdwan_policy_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ADD CONSTRAINT `fk_network_sdwan_policy_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ADD CONSTRAINT `fk_network_peering_agreement_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ADD CONSTRAINT `fk_network_ims_node_uc_subscription_id` FOREIGN KEY (`uc_subscription_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`uc_subscription`(`uc_subscription_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` ADD CONSTRAINT `fk_network_circuit_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);

-- ========= network --> finance (14 constraint(s)) =========
-- Requires: network schema, finance schema
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ADD CONSTRAINT `fk_network_mpls_tunnel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ADD CONSTRAINT `fk_network_nfv_vnf_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ADD CONSTRAINT `fk_network_capacity_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ADD CONSTRAINT `fk_network_network_capacity_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ADD CONSTRAINT `fk_network_network_capacity_plan_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ADD CONSTRAINT `fk_network_ims_node_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` ADD CONSTRAINT `fk_network_circuit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `telecommunication_ecm`.`finance`.`vendor`(`vendor_id`);

-- ========= network --> interconnect (1 constraint(s)) =========
-- Requires: network schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` ADD CONSTRAINT `fk_network_circuit_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);

-- ========= network --> inventory (18 constraint(s)) =========
-- Requires: network schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ADD CONSTRAINT `fk_network_topology_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_spectrum_allocation_id` FOREIGN KEY (`spectrum_allocation_id`) REFERENCES `telecommunication_ecm`.`inventory`.`spectrum_allocation`(`spectrum_allocation_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_fiber_lease_id` FOREIGN KEY (`fiber_lease_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_lease`(`fiber_lease_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ADD CONSTRAINT `fk_network_mpls_tunnel_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ADD CONSTRAINT `fk_network_nfv_vnf_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ADD CONSTRAINT `fk_network_ip_address_plan_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ADD CONSTRAINT `fk_network_capacity_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ADD CONSTRAINT `fk_network_peering_agreement_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ADD CONSTRAINT `fk_network_peering_agreement_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ADD CONSTRAINT `fk_network_ims_node_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ADD CONSTRAINT `fk_network_ims_node_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);

-- ========= network --> location (8 constraint(s)) =========
-- Requires: network schema, location schema
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ADD CONSTRAINT `fk_network_network_capacity_plan_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` ADD CONSTRAINT `fk_network_circuit_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);

-- ========= network --> partner (3 constraint(s)) =========
-- Requires: network schema, partner schema
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ADD CONSTRAINT `fk_network_peering_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= network --> people (16 constraint(s)) =========
-- Requires: network schema, people schema
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ADD CONSTRAINT `fk_network_mpls_tunnel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ADD CONSTRAINT `fk_network_nfv_vnf_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_primary_element_employee_id` FOREIGN KEY (`primary_element_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_tertiary_planned_last_updated_by_user_employee_id` FOREIGN KEY (`tertiary_planned_last_updated_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ADD CONSTRAINT `fk_network_network_capacity_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ADD CONSTRAINT `fk_network_sdwan_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ADD CONSTRAINT `fk_network_peering_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ADD CONSTRAINT `fk_network_ims_node_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ADD CONSTRAINT `fk_network_cell_slice_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= network --> product (5 constraint(s)) =========
-- Requires: network schema, product schema
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ADD CONSTRAINT `fk_network_network_capacity_plan_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ADD CONSTRAINT `fk_network_sdwan_policy_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ADD CONSTRAINT `fk_network_network_qos_profile_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= network --> service (4 constraint(s)) =========
-- Requires: network schema, service schema
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ADD CONSTRAINT `fk_network_sdwan_policy_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ADD CONSTRAINT `fk_network_slice_vnf_assignment_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);

-- ========= network --> workforce (6 constraint(s)) =========
-- Requires: network schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ADD CONSTRAINT `fk_network_nfv_vnf_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ADD CONSTRAINT `fk_network_network_capacity_plan_workforce_capacity_plan_id` FOREIGN KEY (`workforce_capacity_plan_id`) REFERENCES `telecommunication_ecm`.`workforce`.`workforce_capacity_plan`(`workforce_capacity_plan_id`);

-- ========= order --> analytics (6 constraint(s)) =========
-- Requires: order schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`jeopardy` ADD CONSTRAINT `fk_order_jeopardy_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`bulk_order` ADD CONSTRAINT `fk_order_bulk_order_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`decomposition` ADD CONSTRAINT `fk_order_decomposition_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);

-- ========= order --> assurance (15 constraint(s)) =========
-- Requires: order schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_change_record_id` FOREIGN KEY (`change_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`change_record`(`change_record_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`jeopardy` ADD CONSTRAINT `fk_order_jeopardy_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`jeopardy` ADD CONSTRAINT `fk_order_jeopardy_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_mnp_request` ADD CONSTRAINT `fk_order_order_mnp_request_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_change_record_id` FOREIGN KEY (`change_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`change_record`(`change_record_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_revenue_leakage_case_id` FOREIGN KEY (`revenue_leakage_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`revenue_leakage_case`(`revenue_leakage_case_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`bulk_order` ADD CONSTRAINT `fk_order_bulk_order_reconciliation_run_id` FOREIGN KEY (`reconciliation_run_id`) REFERENCES `telecommunication_ecm`.`assurance`.`reconciliation_run`(`reconciliation_run_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`inventory_reservation` ADD CONSTRAINT `fk_order_inventory_reservation_reconciliation_run_id` FOREIGN KEY (`reconciliation_run_id`) REFERENCES `telecommunication_ecm`.`assurance`.`reconciliation_run`(`reconciliation_run_id`);

-- ========= order --> billing (5 constraint(s)) =========
-- Requires: order schema, billing schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= order --> compliance (8 constraint(s)) =========
-- Requires: order schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`jeopardy` ADD CONSTRAINT `fk_order_jeopardy_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_interaction` ADD CONSTRAINT `fk_order_order_interaction_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_mnp_request` ADD CONSTRAINT `fk_order_order_mnp_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`validation_result` ADD CONSTRAINT `fk_order_validation_result_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= order --> content (6 constraint(s)) =========
-- Requires: order schema, content schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_content_channel_lineup_id` FOREIGN KEY (`content_channel_lineup_id`) REFERENCES `telecommunication_ecm`.`content`.`content_channel_lineup`(`content_channel_lineup_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);

-- ========= order --> customer (20 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_customer_subscription_id` FOREIGN KEY (`customer_subscription_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_subscription`(`customer_subscription_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`jeopardy` ADD CONSTRAINT `fk_order_jeopardy_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_interaction` ADD CONSTRAINT `fk_order_order_interaction_case_id` FOREIGN KEY (`case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_interaction` ADD CONSTRAINT `fk_order_order_interaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_interaction` ADD CONSTRAINT `fk_order_order_interaction_customer_interaction_id` FOREIGN KEY (`customer_interaction_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_interaction`(`customer_interaction_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_mnp_request` ADD CONSTRAINT `fk_order_order_mnp_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`bulk_order` ADD CONSTRAINT `fk_order_bulk_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`inventory_reservation` ADD CONSTRAINT `fk_order_inventory_reservation_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= order --> enterprise (19 constraint(s)) =========
-- Requires: order schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`jeopardy` ADD CONSTRAINT `fk_order_jeopardy_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_interaction` ADD CONSTRAINT `fk_order_order_interaction_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_mnp_request` ADD CONSTRAINT `fk_order_order_mnp_request_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`bulk_order` ADD CONSTRAINT `fk_order_bulk_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`validation_result` ADD CONSTRAINT `fk_order_validation_result_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);

-- ========= order --> finance (10 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`jeopardy` ADD CONSTRAINT `fk_order_jeopardy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`bulk_order` ADD CONSTRAINT `fk_order_bulk_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= order --> interconnect (1 constraint(s)) =========
-- Requires: order schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`order`.`order_mnp_request` ADD CONSTRAINT `fk_order_order_mnp_request_mnp_transaction_id` FOREIGN KEY (`mnp_transaction_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`mnp_transaction`(`mnp_transaction_id`);

-- ========= order --> inventory (8 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_mnp_request` ADD CONSTRAINT `fk_order_order_mnp_request_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`inventory_reservation` ADD CONSTRAINT `fk_order_inventory_reservation_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);

-- ========= order --> location (4 constraint(s)) =========
-- Requires: order schema, location schema
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_exchange_id` FOREIGN KEY (`exchange_id`) REFERENCES `telecommunication_ecm`.`location`.`exchange`(`exchange_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`inventory_reservation` ADD CONSTRAINT `fk_order_inventory_reservation_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);

-- ========= order --> network (6 constraint(s)) =========
-- Requires: order schema, network schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`jeopardy` ADD CONSTRAINT `fk_order_jeopardy_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);

-- ========= order --> partner (6 constraint(s)) =========
-- Requires: order schema, partner schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`bulk_order` ADD CONSTRAINT `fk_order_bulk_order_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`bulk_order` ADD CONSTRAINT `fk_order_bulk_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= order --> people (13 constraint(s)) =========
-- Requires: order schema, people schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_actor_employee_id` FOREIGN KEY (`actor_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`jeopardy` ADD CONSTRAINT `fk_order_jeopardy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_interaction` ADD CONSTRAINT `fk_order_order_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`bulk_order` ADD CONSTRAINT `fk_order_bulk_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`inventory_reservation` ADD CONSTRAINT `fk_order_inventory_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`validation_result` ADD CONSTRAINT `fk_order_validation_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= order --> product (19 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_device_offering_id` FOREIGN KEY (`device_offering_id`) REFERENCES `telecommunication_ecm`.`product`.`device_offering`(`device_offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`jeopardy` ADD CONSTRAINT `fk_order_jeopardy_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `telecommunication_ecm`.`product`.`sla_template`(`sla_template_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_price_alteration_id` FOREIGN KEY (`price_alteration_id`) REFERENCES `telecommunication_ecm`.`product`.`price_alteration`(`price_alteration_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`bulk_order` ADD CONSTRAINT `fk_order_bulk_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`inventory_reservation` ADD CONSTRAINT `fk_order_inventory_reservation_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`validation_result` ADD CONSTRAINT `fk_order_validation_result_compatibility_rule_id` FOREIGN KEY (`compatibility_rule_id`) REFERENCES `telecommunication_ecm`.`product`.`compatibility_rule`(`compatibility_rule_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`validation_result` ADD CONSTRAINT `fk_order_validation_result_eligibility_rule_id` FOREIGN KEY (`eligibility_rule_id`) REFERENCES `telecommunication_ecm`.`product`.`eligibility_rule`(`eligibility_rule_id`);

-- ========= order --> service (6 constraint(s)) =========
-- Requires: order schema, service schema
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`inventory_reservation` ADD CONSTRAINT `fk_order_inventory_reservation_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= order --> workforce (10 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_assigned_technician_id` FOREIGN KEY (`assigned_technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`jeopardy` ADD CONSTRAINT `fk_order_jeopardy_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);

-- ========= partner --> analytics (8 constraint(s)) =========
-- Requires: partner schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ADD CONSTRAINT `fk_partner_settlement_run_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_revenue_analytics_kpi_id` FOREIGN KEY (`revenue_analytics_kpi_id`) REFERENCES `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi`(`revenue_analytics_kpi_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ADD CONSTRAINT `fk_partner_partner_sla_measurement_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_dq_issue_id` FOREIGN KEY (`dq_issue_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ADD CONSTRAINT `fk_partner_scorecard_analytical_subject_area_id` FOREIGN KEY (`analytical_subject_area_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_subject_area`(`analytical_subject_area_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ADD CONSTRAINT `fk_partner_scorecard_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);

-- ========= partner --> assurance (4 constraint(s)) =========
-- Requires: partner schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ADD CONSTRAINT `fk_partner_partner_sla_measurement_performance_measurement_id` FOREIGN KEY (`performance_measurement_id`) REFERENCES `telecommunication_ecm`.`assurance`.`performance_measurement`(`performance_measurement_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);

-- ========= partner --> billing (8 constraint(s)) =========
-- Requires: partner schema, billing schema
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ADD CONSTRAINT `fk_partner_settlement_run_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_rated_event_id` FOREIGN KEY (`rated_event_id`) REFERENCES `telecommunication_ecm`.`billing`.`rated_event`(`rated_event_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ADD CONSTRAINT `fk_partner_partner_sla_measurement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_billing_charge_id` FOREIGN KEY (`billing_charge_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_charge`(`billing_charge_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= partner --> compliance (11 constraint(s)) =========
-- Requires: partner schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ADD CONSTRAINT `fk_partner_partner_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ADD CONSTRAINT `fk_partner_roaming_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ADD CONSTRAINT `fk_partner_sla_definition_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ADD CONSTRAINT `fk_partner_onboarding_request_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ADD CONSTRAINT `fk_partner_partner_sla_measurement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ADD CONSTRAINT `fk_partner_partner_certification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ADD CONSTRAINT `fk_partner_scorecard_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);

-- ========= partner --> content (2 constraint(s)) =========
-- Requires: partner schema, content schema
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);

-- ========= partner --> enterprise (6 constraint(s)) =========
-- Requires: partner schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ADD CONSTRAINT `fk_partner_partner_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ADD CONSTRAINT `fk_partner_roaming_agreement_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ADD CONSTRAINT `fk_partner_onboarding_request_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ADD CONSTRAINT `fk_partner_dealer_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);

-- ========= partner --> finance (12 constraint(s)) =========
-- Requires: partner schema, finance schema
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ADD CONSTRAINT `fk_partner_partner_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ADD CONSTRAINT `fk_partner_revenue_share_plan_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ADD CONSTRAINT `fk_partner_settlement_run_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ADD CONSTRAINT `fk_partner_onboarding_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ADD CONSTRAINT `fk_partner_dealer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ADD CONSTRAINT `fk_partner_dealer_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ADD CONSTRAINT `fk_partner_partner_sla_measurement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= partner --> interconnect (2 constraint(s)) =========
-- Requires: partner schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`rate`(`rate_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_nrtrde_record_id` FOREIGN KEY (`nrtrde_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`nrtrde_record`(`nrtrde_record_id`);

-- ========= partner --> location (5 constraint(s)) =========
-- Requires: partner schema, location schema
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ADD CONSTRAINT `fk_partner_partner_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ADD CONSTRAINT `fk_partner_roaming_agreement_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ADD CONSTRAINT `fk_partner_dealer_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);

-- ========= partner --> order (1 constraint(s)) =========
-- Requires: partner schema, order schema
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `telecommunication_ecm`.`order`.`line`(`line_id`);

-- ========= partner --> people (9 constraint(s)) =========
-- Requires: partner schema, people schema
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ADD CONSTRAINT `fk_partner_partner_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ADD CONSTRAINT `fk_partner_roaming_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ADD CONSTRAINT `fk_partner_sla_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ADD CONSTRAINT `fk_partner_settlement_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ADD CONSTRAINT `fk_partner_dealer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= people --> finance (7 constraint(s)) =========
-- Requires: people schema, finance schema
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ADD CONSTRAINT `fk_people_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ADD CONSTRAINT `fk_people_org_unit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `telecommunication_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ADD CONSTRAINT `fk_people_org_unit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ADD CONSTRAINT `fk_people_assignment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ADD CONSTRAINT `fk_people_payroll_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `telecommunication_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ADD CONSTRAINT `fk_people_headcount_plan_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ADD CONSTRAINT `fk_people_workforce_policy_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= people --> location (4 constraint(s)) =========
-- Requires: people schema, location schema
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ADD CONSTRAINT `fk_people_employee_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`position` ADD CONSTRAINT `fk_people_position_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ADD CONSTRAINT `fk_people_assignment_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ADD CONSTRAINT `fk_people_recruitment_requisition_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);

-- ========= people --> order (1 constraint(s)) =========
-- Requires: people schema, order schema
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ADD CONSTRAINT `fk_people_disciplinary_case_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= product --> analytics (10 constraint(s)) =========
-- Requires: product schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_analytical_subject_area_id` FOREIGN KEY (`analytical_subject_area_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_subject_area`(`analytical_subject_area_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_analytical_subject_area_id` FOREIGN KEY (`analytical_subject_area_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_subject_area`(`analytical_subject_area_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_bi_report_definition_id` FOREIGN KEY (`bi_report_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`bi_report_definition`(`bi_report_definition_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_bi_report_definition_id` FOREIGN KEY (`bi_report_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`bi_report_definition`(`bi_report_definition_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_ab_test_id` FOREIGN KEY (`ab_test_id`) REFERENCES `telecommunication_ecm`.`analytics`.`ab_test`(`ab_test_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ADD CONSTRAINT `fk_product_device_model_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ADD CONSTRAINT `fk_product_lifecycle_status_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_analytical_subject_area_id` FOREIGN KEY (`analytical_subject_area_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_subject_area`(`analytical_subject_area_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ADD CONSTRAINT `fk_product_segment_eligibility_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);

-- ========= product --> compliance (5 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ADD CONSTRAINT `fk_product_device_model_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ADD CONSTRAINT `fk_product_sla_template_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ADD CONSTRAINT `fk_product_offering_filing_metric_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= product --> content (13 constraint(s)) =========
-- Requires: product schema, content schema
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ADD CONSTRAINT `fk_product_spec_content_channel_lineup_id` FOREIGN KEY (`content_channel_lineup_id`) REFERENCES `telecommunication_ecm`.`content`.`content_channel_lineup`(`content_channel_lineup_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ADD CONSTRAINT `fk_product_device_offering_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_vod_catalog_id` FOREIGN KEY (`vod_catalog_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_catalog`(`vod_catalog_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ADD CONSTRAINT `fk_product_bundle_channel_inclusion_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ADD CONSTRAINT `fk_product_product_channel_lineup_content_channel_lineup_id` FOREIGN KEY (`content_channel_lineup_id`) REFERENCES `telecommunication_ecm`.`content`.`content_channel_lineup`(`content_channel_lineup_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ADD CONSTRAINT `fk_product_product_channel_lineup_iptv_channel_id` FOREIGN KEY (`iptv_channel_id`) REFERENCES `telecommunication_ecm`.`content`.`iptv_channel`(`iptv_channel_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ADD CONSTRAINT `fk_product_offering_platform_bundle_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);

-- ========= product --> enterprise (3 constraint(s)) =========
-- Requires: product schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ADD CONSTRAINT `fk_product_service_addon_subscription_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ADD CONSTRAINT `fk_product_bundle_subscription_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ADD CONSTRAINT `fk_product_bundle_subscription_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);

-- ========= product --> finance (11 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `telecommunication_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ADD CONSTRAINT `fk_product_device_offering_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ADD CONSTRAINT `fk_product_device_offering_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ADD CONSTRAINT `fk_product_sla_template_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= product --> interconnect (4 constraint(s)) =========
-- Requires: product schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_iot_tariff_id` FOREIGN KEY (`iot_tariff_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`iot_tariff`(`iot_tariff_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ADD CONSTRAINT `fk_product_device_offering_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_iot_tariff_id` FOREIGN KEY (`iot_tariff_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`iot_tariff`(`iot_tariff_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ADD CONSTRAINT `fk_product_catalog_roaming_enablement_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);

-- ========= product --> location (13 constraint(s)) =========
-- Requires: product schema, location schema
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ADD CONSTRAINT `fk_product_device_offering_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ADD CONSTRAINT `fk_product_sla_template_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);

-- ========= product --> partner (9 constraint(s)) =========
-- Requires: product schema, partner schema
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ADD CONSTRAINT `fk_product_device_offering_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ADD CONSTRAINT `fk_product_sla_template_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ADD CONSTRAINT `fk_product_device_supply_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= product --> people (17 constraint(s)) =========
-- Requires: product schema, people schema
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_offering_employee_id` FOREIGN KEY (`offering_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ADD CONSTRAINT `fk_product_price_alteration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ADD CONSTRAINT `fk_product_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ADD CONSTRAINT `fk_product_compatibility_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ADD CONSTRAINT `fk_product_device_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ADD CONSTRAINT `fk_product_sla_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ADD CONSTRAINT `fk_product_relationship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ADD CONSTRAINT `fk_product_service_addon_subscription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ADD CONSTRAINT `fk_product_bundle_promotion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= product --> sales (1 constraint(s)) =========
-- Requires: product schema, sales schema
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ADD CONSTRAINT `fk_product_bundle_promotion_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);

-- ========= product --> workforce (1 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ADD CONSTRAINT `fk_product_skill_requirement_skill_id` FOREIGN KEY (`skill_id`) REFERENCES `telecommunication_ecm`.`workforce`.`skill`(`skill_id`);

-- ========= sales --> analytics (10 constraint(s)) =========
-- Requires: sales schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ADD CONSTRAINT `fk_sales_commission_plan_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ADD CONSTRAINT `fk_sales_b2b_account_plan_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_retention_model_output_id` FOREIGN KEY (`retention_model_output_id`) REFERENCES `telecommunication_ecm`.`analytics`.`retention_model_output`(`retention_model_output_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ADD CONSTRAINT `fk_sales_retention_interaction_retention_model_output_id` FOREIGN KEY (`retention_model_output_id`) REFERENCES `telecommunication_ecm`.`analytics`.`retention_model_output`(`retention_model_output_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);

-- ========= sales --> assurance (4 constraint(s)) =========
-- Requires: sales schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ADD CONSTRAINT `fk_sales_b2b_account_plan_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ADD CONSTRAINT `fk_sales_retention_interaction_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);

-- ========= sales --> billing (3 constraint(s)) =========
-- Requires: sales schema, billing schema
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ADD CONSTRAINT `fk_sales_commission_txn_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= sales --> compliance (4 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);

-- ========= sales --> content (9 constraint(s)) =========
-- Requires: sales schema, content schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ADD CONSTRAINT `fk_sales_b2b_account_plan_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);

-- ========= sales --> customer (19 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ADD CONSTRAINT `fk_sales_commission_txn_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ADD CONSTRAINT `fk_sales_b2b_account_plan_corporate_hierarchy_id` FOREIGN KEY (`corporate_hierarchy_id`) REFERENCES `telecommunication_ecm`.`customer`.`corporate_hierarchy`(`corporate_hierarchy_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ADD CONSTRAINT `fk_sales_b2b_account_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ADD CONSTRAINT `fk_sales_retention_interaction_case_id` FOREIGN KEY (`case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ADD CONSTRAINT `fk_sales_retention_interaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ADD CONSTRAINT `fk_sales_retention_interaction_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= sales --> enterprise (9 constraint(s)) =========
-- Requires: sales schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ADD CONSTRAINT `fk_sales_b2b_account_plan_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);

-- ========= sales --> finance (9 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ADD CONSTRAINT `fk_sales_contract_amendment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ADD CONSTRAINT `fk_sales_commission_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ADD CONSTRAINT `fk_sales_commission_txn_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `telecommunication_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ADD CONSTRAINT `fk_sales_b2b_account_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`budget_plan`(`budget_plan_id`);

-- ========= sales --> inventory (10 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_spectrum_allocation_id` FOREIGN KEY (`spectrum_allocation_id`) REFERENCES `telecommunication_ecm`.`inventory`.`spectrum_allocation`(`spectrum_allocation_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_spectrum_allocation_id` FOREIGN KEY (`spectrum_allocation_id`) REFERENCES `telecommunication_ecm`.`inventory`.`spectrum_allocation`(`spectrum_allocation_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);

-- ========= sales --> location (8 constraint(s)) =========
-- Requires: sales schema, location schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ADD CONSTRAINT `fk_sales_b2b_account_plan_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ADD CONSTRAINT `fk_sales_retention_interaction_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);

-- ========= sales --> network (5 constraint(s)) =========
-- Requires: sales schema, network schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_network_capacity_plan_id` FOREIGN KEY (`network_capacity_plan_id`) REFERENCES `telecommunication_ecm`.`network`.`network_capacity_plan`(`network_capacity_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sdwan_policy_id` FOREIGN KEY (`sdwan_policy_id`) REFERENCES `telecommunication_ecm`.`network`.`sdwan_policy`(`sdwan_policy_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_peering_agreement_id` FOREIGN KEY (`peering_agreement_id`) REFERENCES `telecommunication_ecm`.`network`.`peering_agreement`(`peering_agreement_id`);

-- ========= sales --> order (2 constraint(s)) =========
-- Requires: sales schema, order schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= sales --> partner (8 constraint(s)) =========
-- Requires: sales schema, partner schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= sales --> people (40 constraint(s)) =========
-- Requires: sales schema, people schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_tertiary_sales_modified_by_user_employee_id` FOREIGN KEY (`tertiary_sales_modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ADD CONSTRAINT `fk_sales_contract_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ADD CONSTRAINT `fk_sales_commission_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ADD CONSTRAINT `fk_sales_commission_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ADD CONSTRAINT `fk_sales_commission_txn_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_target_created_by_user_employee_id` FOREIGN KEY (`target_created_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_target_employee_id` FOREIGN KEY (`target_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_target_last_modified_by_user_employee_id` FOREIGN KEY (`target_last_modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_promotion_last_modified_by_user_employee_id` FOREIGN KEY (`promotion_last_modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_tertiary_promotion_approved_by_user_employee_id` FOREIGN KEY (`tertiary_promotion_approved_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ADD CONSTRAINT `fk_sales_b2b_account_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `telecommunication_ecm`.`people`.`position`(`position_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ADD CONSTRAINT `fk_sales_b2b_account_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ADD CONSTRAINT `fk_sales_b2b_account_plan_tertiary_b2b_approved_by_user_employee_id` FOREIGN KEY (`tertiary_b2b_approved_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ADD CONSTRAINT `fk_sales_retention_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_forecast_employee_id` FOREIGN KEY (`forecast_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_forecast_submitted_by_user_employee_id` FOREIGN KEY (`forecast_submitted_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ADD CONSTRAINT `fk_sales_channel_offering_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ADD CONSTRAINT `fk_sales_channel_promotion_eligibility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ADD CONSTRAINT `fk_sales_channel_promotion_eligibility_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ADD CONSTRAINT `fk_sales_account_team_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= sales --> product (19 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_device_offering_id` FOREIGN KEY (`device_offering_id`) REFERENCES `telecommunication_ecm`.`product`.`device_offering`(`device_offering_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `telecommunication_ecm`.`product`.`sla_template`(`sla_template_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ADD CONSTRAINT `fk_sales_commission_plan_category_id` FOREIGN KEY (`category_id`) REFERENCES `telecommunication_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_category_id` FOREIGN KEY (`category_id`) REFERENCES `telecommunication_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ADD CONSTRAINT `fk_sales_channel_offering_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);

-- ========= sales --> workforce (4 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);

-- ========= service --> analytics (8 constraint(s)) =========
-- Requires: service schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ADD CONSTRAINT `fk_service_volte_ims_state_network_analytics_kpi_id` FOREIGN KEY (`network_analytics_kpi_id`) REFERENCES `telecommunication_ecm`.`analytics`.`network_analytics_kpi`(`network_analytics_kpi_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ADD CONSTRAINT `fk_service_esim_profile_network_analytics_kpi_id` FOREIGN KEY (`network_analytics_kpi_id`) REFERENCES `telecommunication_ecm`.`analytics`.`network_analytics_kpi`(`network_analytics_kpi_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_customer_analytics_kpi_id` FOREIGN KEY (`customer_analytics_kpi_id`) REFERENCES `telecommunication_ecm`.`analytics`.`customer_analytics_kpi`(`customer_analytics_kpi_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ADD CONSTRAINT `fk_service_provisioning_fallout_dq_issue_id` FOREIGN KEY (`dq_issue_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);

-- ========= service --> assurance (7 constraint(s)) =========
-- Requires: service schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ADD CONSTRAINT `fk_service_provisioning_fallout_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ADD CONSTRAINT `fk_service_provisioning_fallout_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);

-- ========= service --> billing (8 constraint(s)) =========
-- Requires: service schema, billing schema
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_dunning_event_id` FOREIGN KEY (`dunning_event_id`) REFERENCES `telecommunication_ecm`.`billing`.`dunning_event`(`dunning_event_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ADD CONSTRAINT `fk_service_service_mnp_request_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= service --> compliance (8 constraint(s)) =========
-- Requires: service schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_cpni_authorization_id` FOREIGN KEY (`cpni_authorization_id`) REFERENCES `telecommunication_ecm`.`compliance`.`cpni_authorization`(`cpni_authorization_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_e911_compliance_id` FOREIGN KEY (`e911_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`e911_compliance`(`e911_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ADD CONSTRAINT `fk_service_sla_profile_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ADD CONSTRAINT `fk_service_volte_ims_state_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ADD CONSTRAINT `fk_service_esim_profile_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);

-- ========= service --> customer (13 constraint(s)) =========
-- Requires: service schema, customer schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ADD CONSTRAINT `fk_service_volte_ims_state_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ADD CONSTRAINT `fk_service_esim_profile_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_case_id` FOREIGN KEY (`case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ADD CONSTRAINT `fk_service_service_mnp_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ADD CONSTRAINT `fk_service_service_roaming_session_customer_roaming_session_id` FOREIGN KEY (`customer_roaming_session_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_roaming_session`(`customer_roaming_session_id`);

-- ========= service --> enterprise (12 constraint(s)) =========
-- Requires: service schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ADD CONSTRAINT `fk_service_service_mnp_request_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ADD CONSTRAINT `fk_service_provisioning_fallout_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);

-- ========= service --> finance (8 constraint(s)) =========
-- Requires: service schema, finance schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ADD CONSTRAINT `fk_service_svc_location_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `telecommunication_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);

-- ========= service --> interconnect (7 constraint(s)) =========
-- Requires: service schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ADD CONSTRAINT `fk_service_volte_ims_state_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ADD CONSTRAINT `fk_service_esim_profile_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_mnp_transaction_id` FOREIGN KEY (`mnp_transaction_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`mnp_transaction`(`mnp_transaction_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ADD CONSTRAINT `fk_service_service_mnp_request_mnp_transaction_id` FOREIGN KEY (`mnp_transaction_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`mnp_transaction`(`mnp_transaction_id`);

-- ========= service --> inventory (7 constraint(s)) =========
-- Requires: service schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ADD CONSTRAINT `fk_service_esim_profile_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_ont_ont_asset_id` FOREIGN KEY (`ont_ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ADD CONSTRAINT `fk_service_ont_service_binding_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);

-- ========= service --> location (6 constraint(s)) =========
-- Requires: service schema, location schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ADD CONSTRAINT `fk_service_provisioning_fallout_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);

-- ========= service --> network (11 constraint(s)) =========
-- Requires: service schema, network schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ADD CONSTRAINT `fk_service_service_qos_profile_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ADD CONSTRAINT `fk_service_volte_ims_state_ims_node_id` FOREIGN KEY (`ims_node_id`) REFERENCES `telecommunication_ecm`.`network`.`ims_node`(`ims_node_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ADD CONSTRAINT `fk_service_volte_ims_state_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ADD CONSTRAINT `fk_service_esim_profile_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ADD CONSTRAINT `fk_service_provisioning_fallout_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);

-- ========= service --> order (3 constraint(s)) =========
-- Requires: service schema, order schema
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ADD CONSTRAINT `fk_service_contract_service_line_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `telecommunication_ecm`.`order`.`amendment`(`amendment_id`);

-- ========= service --> partner (7 constraint(s)) =========
-- Requires: service schema, partner schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ADD CONSTRAINT `fk_service_service_mnp_request_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ADD CONSTRAINT `fk_service_service_roaming_session_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);

-- ========= service --> people (7 constraint(s)) =========
-- Requires: service schema, people schema
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ADD CONSTRAINT `fk_service_sla_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ADD CONSTRAINT `fk_service_service_mnp_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ADD CONSTRAINT `fk_service_provisioning_fallout_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= service --> product (7 constraint(s)) =========
-- Requires: service schema, product schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ADD CONSTRAINT `fk_service_sla_profile_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `telecommunication_ecm`.`product`.`sla_template`(`sla_template_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ADD CONSTRAINT `fk_service_esim_profile_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);

-- ========= service --> sales (1 constraint(s)) =========
-- Requires: service schema, sales schema
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ADD CONSTRAINT `fk_service_contract_service_line_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= service --> workforce (5 constraint(s)) =========
-- Requires: service schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ADD CONSTRAINT `fk_service_visit_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ADD CONSTRAINT `fk_service_visit_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);

-- ========= usage --> analytics (18 constraint(s)) =========
-- Requires: usage schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_dq_execution_result_id` FOREIGN KEY (`dq_execution_result_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_execution_result`(`dq_execution_result_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_dq_execution_result_id` FOREIGN KEY (`dq_execution_result_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_execution_result`(`dq_execution_result_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_dq_execution_result_id` FOREIGN KEY (`dq_execution_result_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_execution_result`(`dq_execution_result_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_analytics_segment_membership_id` FOREIGN KEY (`analytics_segment_membership_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytics_segment_membership`(`analytics_segment_membership_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_analytics_segment_membership_id` FOREIGN KEY (`analytics_segment_membership_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytics_segment_membership`(`analytics_segment_membership_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_retention_model_output_id` FOREIGN KEY (`retention_model_output_id`) REFERENCES `telecommunication_ecm`.`analytics`.`retention_model_output`(`retention_model_output_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_dq_issue_id` FOREIGN KEY (`dq_issue_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_retention_model_output_id` FOREIGN KEY (`retention_model_output_id`) REFERENCES `telecommunication_ecm`.`analytics`.`retention_model_output`(`retention_model_output_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_dq_issue_id` FOREIGN KEY (`dq_issue_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);

-- ========= usage --> assurance (8 constraint(s)) =========
-- Requires: usage schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_qos_measurement_id` FOREIGN KEY (`qos_measurement_id`) REFERENCES `telecommunication_ecm`.`assurance`.`qos_measurement`(`qos_measurement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_revenue_leakage_case_id` FOREIGN KEY (`revenue_leakage_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`revenue_leakage_case`(`revenue_leakage_case_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_reconciliation_run_id` FOREIGN KEY (`reconciliation_run_id`) REFERENCES `telecommunication_ecm`.`assurance`.`reconciliation_run`(`reconciliation_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_qos_measurement_id` FOREIGN KEY (`qos_measurement_id`) REFERENCES `telecommunication_ecm`.`assurance`.`qos_measurement`(`qos_measurement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);

-- ========= usage --> billing (28 constraint(s)) =========
-- Requires: usage schema, billing schema
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_rated_event_id` FOREIGN KEY (`rated_event_id`) REFERENCES `telecommunication_ecm`.`billing`.`rated_event`(`rated_event_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_prepaid_balance_id` FOREIGN KEY (`prepaid_balance_id`) REFERENCES `telecommunication_ecm`.`billing`.`prepaid_balance`(`prepaid_balance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `telecommunication_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_rated_event_id` FOREIGN KEY (`rated_event_id`) REFERENCES `telecommunication_ecm`.`billing`.`rated_event`(`rated_event_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `telecommunication_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_billing_charge_id` FOREIGN KEY (`billing_charge_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_charge`(`billing_charge_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `telecommunication_ecm`.`billing`.`credit_note`(`credit_note_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_rated_event_id` FOREIGN KEY (`rated_event_id`) REFERENCES `telecommunication_ecm`.`billing`.`rated_event`(`rated_event_id`);

-- ========= usage --> compliance (9 constraint(s)) =========
-- Requires: usage schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);

-- ========= usage --> content (6 constraint(s)) =========
-- Requires: usage schema, content schema
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `telecommunication_ecm`.`content`.`entitlement`(`entitlement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_license_id` FOREIGN KEY (`license_id`) REFERENCES `telecommunication_ecm`.`content`.`license`(`license_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `telecommunication_ecm`.`content`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_package_id` FOREIGN KEY (`package_id`) REFERENCES `telecommunication_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_vod_asset_id` FOREIGN KEY (`vod_asset_id`) REFERENCES `telecommunication_ecm`.`content`.`vod_asset`(`vod_asset_id`);

-- ========= usage --> customer (14 constraint(s)) =========
-- Requires: usage schema, customer schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_correction_original_subscriber_id` FOREIGN KEY (`correction_original_subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_correction_subscriber_id` FOREIGN KEY (`correction_subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= usage --> enterprise (23 constraint(s)) =========
-- Requires: usage schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_sdwan_topology_id` FOREIGN KEY (`sdwan_topology_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`sdwan_topology`(`sdwan_topology_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_sdwan_topology_id` FOREIGN KEY (`sdwan_topology_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`sdwan_topology`(`sdwan_topology_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_uc_subscription_id` FOREIGN KEY (`uc_subscription_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`uc_subscription`(`uc_subscription_id`);

-- ========= usage --> finance (4 constraint(s)) =========
-- Requires: usage schema, finance schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `telecommunication_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= usage --> interconnect (13 constraint(s)) =========
-- Requires: usage schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_network_operator_carrier_id` FOREIGN KEY (`network_operator_carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_rap_file_id` FOREIGN KEY (`rap_file_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`rap_file`(`rap_file_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_rap_file_id` FOREIGN KEY (`rap_file_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`rap_file`(`rap_file_id`);

-- ========= usage --> inventory (4 constraint(s)) =========
-- Requires: usage schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);

-- ========= usage --> network (14 constraint(s)) =========
-- Requires: usage schema, network schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_sdwan_policy_id` FOREIGN KEY (`sdwan_policy_id`) REFERENCES `telecommunication_ecm`.`network`.`sdwan_policy`(`sdwan_policy_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_ims_node_id` FOREIGN KEY (`ims_node_id`) REFERENCES `telecommunication_ecm`.`network`.`ims_node`(`ims_node_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);

-- ========= usage --> order (6 constraint(s)) =========
-- Requires: usage schema, order schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= usage --> partner (4 constraint(s)) =========
-- Requires: usage schema, partner schema
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_roaming_partner_id` FOREIGN KEY (`roaming_partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= usage --> people (5 constraint(s)) =========
-- Requires: usage schema, people schema
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_correction_employee_id` FOREIGN KEY (`correction_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= usage --> product (5 constraint(s)) =========
-- Requires: usage schema, product schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_zero_rating_program_id` FOREIGN KEY (`zero_rating_program_id`) REFERENCES `telecommunication_ecm`.`product`.`zero_rating_program`(`zero_rating_program_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_bundle_subscription_id` FOREIGN KEY (`bundle_subscription_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle_subscription`(`bundle_subscription_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);

-- ========= usage --> sales (1 constraint(s)) =========
-- Requires: usage schema, sales schema
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_mvno_agreement_id` FOREIGN KEY (`mvno_agreement_id`) REFERENCES `telecommunication_ecm`.`sales`.`mvno_agreement`(`mvno_agreement_id`);

-- ========= usage --> service (8 constraint(s)) =========
-- Requires: usage schema, service schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ADD CONSTRAINT `fk_usage_volte_session_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= workforce --> analytics (10 constraint(s)) =========
-- Requires: workforce schema, analytics schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_analytical_model_registry_id` FOREIGN KEY (`analytical_model_registry_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_model_registry`(`analytical_model_registry_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ADD CONSTRAINT `fk_workforce_depot_reporting_dimension_id` FOREIGN KEY (`reporting_dimension_id`) REFERENCES `telecommunication_ecm`.`analytics`.`reporting_dimension`(`reporting_dimension_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ADD CONSTRAINT `fk_workforce_technician_schedule_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`contractor` ADD CONSTRAINT `fk_workforce_contractor_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_kpi_target` ADD CONSTRAINT `fk_workforce_technician_kpi_target_kpi_target_id` FOREIGN KEY (`kpi_target_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_target`(`kpi_target_id`);

-- ========= workforce --> assurance (2 constraint(s)) =========
-- Requires: workforce schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`alarm_event`(`alarm_event_id`);

-- ========= workforce --> compliance (4 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= workforce --> customer (5 constraint(s)) =========
-- Requires: workforce schema, customer schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_case_id` FOREIGN KEY (`case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= workforce --> enterprise (6 constraint(s)) =========
-- Requires: workforce schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ADD CONSTRAINT `fk_workforce_depot_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_enterprise_site_id` FOREIGN KEY (`enterprise_site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_site`(`enterprise_site_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_capacity_plan` ADD CONSTRAINT `fk_workforce_workforce_capacity_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);

-- ========= workforce --> finance (10 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ADD CONSTRAINT `fk_workforce_depot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ADD CONSTRAINT `fk_workforce_field_vehicle_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `telecommunication_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`contractor` ADD CONSTRAINT `fk_workforce_contractor_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `telecommunication_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`contractor` ADD CONSTRAINT `fk_workforce_contractor_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `telecommunication_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_capacity_plan` ADD CONSTRAINT `fk_workforce_workforce_capacity_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `telecommunication_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_project_assignment` ADD CONSTRAINT `fk_workforce_workforce_project_assignment_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `telecommunication_ecm`.`finance`.`capital_project`(`capital_project_id`);

-- ========= workforce --> interconnect (2 constraint(s)) =========
-- Requires: workforce schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_poi_id` FOREIGN KEY (`poi_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`poi`(`poi_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_poi_id` FOREIGN KEY (`poi_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`poi`(`poi_id`);

-- ========= workforce --> location (12 constraint(s)) =========
-- Requires: workforce schema, location schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ADD CONSTRAINT `fk_workforce_depot_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ADD CONSTRAINT `fk_workforce_technician_schedule_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_exchange_id` FOREIGN KEY (`exchange_id`) REFERENCES `telecommunication_ecm`.`location`.`exchange`(`exchange_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_capacity_plan` ADD CONSTRAINT `fk_workforce_workforce_capacity_plan_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_capacity_plan` ADD CONSTRAINT `fk_workforce_workforce_capacity_plan_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`tool_checkout` ADD CONSTRAINT `fk_workforce_tool_checkout_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);

-- ========= workforce --> network (3 constraint(s)) =========
-- Requires: workforce schema, network schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ADD CONSTRAINT `fk_workforce_technician_schedule_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);

-- ========= workforce --> order (5 constraint(s)) =========
-- Requires: workforce schema, order schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `telecommunication_ecm`.`order`.`appointment`(`appointment_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `telecommunication_ecm`.`order`.`appointment`(`appointment_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_task_id` FOREIGN KEY (`task_id`) REFERENCES `telecommunication_ecm`.`order`.`task`(`task_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ADD CONSTRAINT `fk_workforce_route_plan_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `telecommunication_ecm`.`order`.`appointment`(`appointment_id`);

-- ========= workforce --> people (18 constraint(s)) =========
-- Requires: workforce schema, people schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_learning_enrollment_id` FOREIGN KEY (`learning_enrollment_id`) REFERENCES `telecommunication_ecm`.`people`.`learning_enrollment`(`learning_enrollment_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ADD CONSTRAINT `fk_workforce_technician_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ADD CONSTRAINT `fk_workforce_technician_schedule_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ADD CONSTRAINT `fk_workforce_technician_schedule_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `telecommunication_ecm`.`people`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ADD CONSTRAINT `fk_workforce_route_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ADD CONSTRAINT `fk_workforce_route_plan_tertiary_route_employee_id` FOREIGN KEY (`tertiary_route_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_tertiary_safety_investigator_employee_id` FOREIGN KEY (`tertiary_safety_investigator_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ADD CONSTRAINT `fk_workforce_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_capacity_plan` ADD CONSTRAINT `fk_workforce_workforce_capacity_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_capacity_plan` ADD CONSTRAINT `fk_workforce_workforce_capacity_plan_quaternary_workforce_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_workforce_last_modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_capacity_plan` ADD CONSTRAINT `fk_workforce_workforce_capacity_plan_tertiary_workforce_created_by_user_employee_id` FOREIGN KEY (`tertiary_workforce_created_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`tool_checkout` ADD CONSTRAINT `fk_workforce_tool_checkout_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_skill_proficiency` ADD CONSTRAINT `fk_workforce_technician_skill_proficiency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_project_assignment` ADD CONSTRAINT `fk_workforce_workforce_project_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);

-- ========= workforce --> product (5 constraint(s)) =========
-- Requires: workforce schema, product schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_device_offering_id` FOREIGN KEY (`device_offering_id`) REFERENCES `telecommunication_ecm`.`product`.`device_offering`(`device_offering_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `telecommunication_ecm`.`product`.`sla_template`(`sla_template_id`);

-- ========= workforce --> sales (1 constraint(s)) =========
-- Requires: workforce schema, sales schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`workforce_capacity_plan` ADD CONSTRAINT `fk_workforce_workforce_capacity_plan_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `telecommunication_ecm`.`sales`.`forecast`(`forecast_id`);

-- ========= workforce --> service (1 constraint(s)) =========
-- Requires: workforce schema, service schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

