-- Cross-Domain Foreign Keys for Business: Telecommunication | Version: v1_mvm
-- Generated on: 2026-05-08 08:31:47
-- Total cross-domain FK constraints: 1398
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: assurance, billing, compliance, customer, enterprise, interconnect, inventory, network, order, partner, product, sales, service, usage, workforce

-- ========= assurance --> billing (4 constraint(s)) =========
-- Requires: assurance schema, billing schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= assurance --> compliance (20 constraint(s)) =========
-- Requires: assurance schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `telecommunication_ecm`.`compliance`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `telecommunication_ecm`.`compliance`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_mnp_compliance_id` FOREIGN KEY (`mnp_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`mnp_compliance`(`mnp_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ADD CONSTRAINT `fk_assurance_kpi_threshold_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` ADD CONSTRAINT `fk_assurance_fraud_pattern_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= assurance --> customer (8 constraint(s)) =========
-- Requires: assurance schema, customer schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_address_id` FOREIGN KEY (`address_id`) REFERENCES `telecommunication_ecm`.`customer`.`address`(`address_id`);

-- ========= assurance --> enterprise (14 constraint(s)) =========
-- Requires: assurance schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);

-- ========= assurance --> interconnect (17 constraint(s)) =========
-- Requires: assurance schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_poi_id` FOREIGN KEY (`poi_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`poi`(`poi_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_mnp_transaction_id` FOREIGN KEY (`mnp_transaction_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`mnp_transaction`(`mnp_transaction_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_peering_arrangement_id` FOREIGN KEY (`peering_arrangement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`peering_arrangement`(`peering_arrangement_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_poi_id` FOREIGN KEY (`poi_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`poi`(`poi_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_settlement_invoice_id` FOREIGN KEY (`settlement_invoice_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`settlement_invoice`(`settlement_invoice_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_mnp_transaction_id` FOREIGN KEY (`mnp_transaction_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`mnp_transaction`(`mnp_transaction_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_tap_file_id` FOREIGN KEY (`tap_file_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_file`(`tap_file_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_nrtrde_record_id` FOREIGN KEY (`nrtrde_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`nrtrde_record`(`nrtrde_record_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_tap_record_id` FOREIGN KEY (`tap_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_record`(`tap_record_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_peering_arrangement_id` FOREIGN KEY (`peering_arrangement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`peering_arrangement`(`peering_arrangement_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_poi_id` FOREIGN KEY (`poi_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`poi`(`poi_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` ADD CONSTRAINT `fk_assurance_fraud_pattern_iot_tariff_id` FOREIGN KEY (`iot_tariff_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`iot_tariff`(`iot_tariff_id`);

-- ========= assurance --> inventory (37 constraint(s)) =========
-- Requires: assurance schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);

-- ========= assurance --> network (8 constraint(s)) =========
-- Requires: assurance schema, network schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);

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

-- ========= assurance --> product (29 constraint(s)) =========
-- Requires: assurance schema, product schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ADD CONSTRAINT `fk_assurance_kpi_threshold_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ADD CONSTRAINT `fk_assurance_kpi_threshold_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);

-- ========= assurance --> service (6 constraint(s)) =========
-- Requires: assurance schema, service schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= assurance --> workforce (4 constraint(s)) =========
-- Requires: assurance schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ADD CONSTRAINT `fk_assurance_problem_record_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);

-- ========= billing --> assurance (7 constraint(s)) =========
-- Requires: billing schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);

-- ========= billing --> compliance (7 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ADD CONSTRAINT `fk_billing_rate_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= billing --> customer (17 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscription`(`subscription_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscription`(`subscription_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscription`(`subscription_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscription`(`subscription_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= billing --> enterprise (19 constraint(s)) =========
-- Requires: billing schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_discount_scheme_id` FOREIGN KEY (`discount_scheme_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`discount_scheme`(`discount_scheme_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ADD CONSTRAINT `fk_billing_rate_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_sla_breach_id` FOREIGN KEY (`sla_breach_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`sla_breach`(`sla_breach_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);

-- ========= billing --> interconnect (8 constraint(s)) =========
-- Requires: billing schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_tap_record_id` FOREIGN KEY (`tap_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_record`(`tap_record_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`rate`(`rate_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_tap_record_id` FOREIGN KEY (`tap_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_record`(`tap_record_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_settlement_dispute_id` FOREIGN KEY (`settlement_dispute_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`settlement_dispute`(`settlement_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_settlement_dispute_id` FOREIGN KEY (`settlement_dispute_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`settlement_dispute`(`settlement_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ADD CONSTRAINT `fk_billing_rate_plan_iot_tariff_id` FOREIGN KEY (`iot_tariff_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`iot_tariff`(`iot_tariff_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_settlement_dispute_id` FOREIGN KEY (`settlement_dispute_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`settlement_dispute`(`settlement_dispute_id`);

-- ========= billing --> inventory (24 constraint(s)) =========
-- Requires: billing schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);

-- ========= billing --> network (6 constraint(s)) =========
-- Requires: billing schema, network schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_planned_outage_id` FOREIGN KEY (`planned_outage_id`) REFERENCES `telecommunication_ecm`.`network`.`planned_outage`(`planned_outage_id`);

-- ========= billing --> order (10 constraint(s)) =========
-- Requires: billing schema, order schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `telecommunication_ecm`.`order`.`amendment`(`amendment_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_line_id` FOREIGN KEY (`line_id`) REFERENCES `telecommunication_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_task_id` FOREIGN KEY (`task_id`) REFERENCES `telecommunication_ecm`.`order`.`task`(`task_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `telecommunication_ecm`.`order`.`amendment`(`amendment_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_line_id` FOREIGN KEY (`line_id`) REFERENCES `telecommunication_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `telecommunication_ecm`.`order`.`amendment`(`amendment_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_line_id` FOREIGN KEY (`line_id`) REFERENCES `telecommunication_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `telecommunication_ecm`.`order`.`sla`(`sla_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= billing --> partner (10 constraint(s)) =========
-- Requires: billing schema, partner schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= billing --> product (18 constraint(s)) =========
-- Requires: billing schema, product schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ADD CONSTRAINT `fk_billing_rate_plan_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= billing --> sales (6 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ADD CONSTRAINT `fk_billing_rate_plan_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);

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

-- ========= billing --> workforce (3 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);

-- ========= compliance --> customer (9 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ADD CONSTRAINT `fk_compliance_mnp_compliance_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ADD CONSTRAINT `fk_compliance_mnp_compliance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= compliance --> enterprise (12 constraint(s)) =========
-- Requires: compliance schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ADD CONSTRAINT `fk_compliance_spectrum_license_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ADD CONSTRAINT `fk_compliance_mnp_compliance_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ADD CONSTRAINT `fk_compliance_mnp_compliance_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);

-- ========= compliance --> interconnect (1 constraint(s)) =========
-- Requires: compliance schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);

-- ========= compliance --> workforce (1 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);

-- ========= customer --> assurance (5 constraint(s)) =========
-- Requires: customer schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);

-- ========= customer --> billing (3 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= customer --> compliance (3 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `telecommunication_ecm`.`compliance`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);

-- ========= customer --> enterprise (4 constraint(s)) =========
-- Requires: customer schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);

-- ========= customer --> inventory (6 constraint(s)) =========
-- Requires: customer schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);

-- ========= customer --> order (3 constraint(s)) =========
-- Requires: customer schema, order schema
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= customer --> partner (5 constraint(s)) =========
-- Requires: customer schema, partner schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);

-- ========= customer --> product (29 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);

-- ========= customer --> sales (7 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_retention_offer_id` FOREIGN KEY (`retention_offer_id`) REFERENCES `telecommunication_ecm`.`sales`.`retention_offer`(`retention_offer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_retention_offer_id` FOREIGN KEY (`retention_offer_id`) REFERENCES `telecommunication_ecm`.`sales`.`retention_offer`(`retention_offer_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `telecommunication_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= customer --> service (7 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_svc_configuration_id` FOREIGN KEY (`svc_configuration_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_configuration`(`svc_configuration_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= enterprise --> assurance (5 constraint(s)) =========
-- Requires: enterprise schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_measurement` ADD CONSTRAINT `fk_enterprise_sla_measurement_performance_measurement_id` FOREIGN KEY (`performance_measurement_id`) REFERENCES `telecommunication_ecm`.`assurance`.`performance_measurement`(`performance_measurement_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_measurement` ADD CONSTRAINT `fk_enterprise_sla_measurement_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_breach` ADD CONSTRAINT `fk_enterprise_sla_breach_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);

-- ========= enterprise --> billing (8 constraint(s)) =========
-- Requires: enterprise schema, billing schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`account_hierarchy` ADD CONSTRAINT `fk_enterprise_account_hierarchy_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`site` ADD CONSTRAINT `fk_enterprise_site_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sdwan_topology` ADD CONSTRAINT `fk_enterprise_sdwan_topology_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= enterprise --> customer (2 constraint(s)) =========
-- Requires: enterprise schema, customer schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_breach` ADD CONSTRAINT `fk_enterprise_sla_breach_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= enterprise --> interconnect (4 constraint(s)) =========
-- Requires: enterprise schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_poi_id` FOREIGN KEY (`poi_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`poi`(`poi_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_iot_tariff_id` FOREIGN KEY (`iot_tariff_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`iot_tariff`(`iot_tariff_id`);

-- ========= enterprise --> inventory (13 constraint(s)) =========
-- Requires: enterprise schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`site` ADD CONSTRAINT `fk_enterprise_site_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sdwan_topology` ADD CONSTRAINT `fk_enterprise_sdwan_topology_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sdwan_topology` ADD CONSTRAINT `fk_enterprise_sdwan_topology_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);

-- ========= enterprise --> product (26 constraint(s)) =========
-- Requires: enterprise schema, product schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`enterprise_contract` ADD CONSTRAINT `fk_enterprise_enterprise_contract_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sdwan_topology` ADD CONSTRAINT `fk_enterprise_sdwan_topology_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`discount_scheme` ADD CONSTRAINT `fk_enterprise_discount_scheme_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`discount_scheme` ADD CONSTRAINT `fk_enterprise_discount_scheme_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`discount_scheme` ADD CONSTRAINT `fk_enterprise_discount_scheme_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`discount_scheme` ADD CONSTRAINT `fk_enterprise_discount_scheme_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);

-- ========= enterprise --> service (7 constraint(s)) =========
-- Requires: enterprise schema, service schema
ALTER TABLE `telecommunication_ecm`.`enterprise`.`site` ADD CONSTRAINT `fk_enterprise_site_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`managed_service` ADD CONSTRAINT `fk_enterprise_managed_service_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_measurement` ADD CONSTRAINT `fk_enterprise_sla_measurement_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sla_breach` ADD CONSTRAINT `fk_enterprise_sla_breach_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`iot_deployment` ADD CONSTRAINT `fk_enterprise_iot_deployment_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`uc_subscription` ADD CONSTRAINT `fk_enterprise_uc_subscription_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`enterprise`.`sdwan_topology` ADD CONSTRAINT `fk_enterprise_sdwan_topology_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);

-- ========= interconnect --> assurance (4 constraint(s)) =========
-- Requires: interconnect schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`peering_arrangement` ADD CONSTRAINT `fk_interconnect_peering_arrangement_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_dispute` ADD CONSTRAINT `fk_interconnect_settlement_dispute_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);

-- ========= interconnect --> compliance (7 constraint(s)) =========
-- Requires: interconnect schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`nrtrde_record` ADD CONSTRAINT `fk_interconnect_nrtrde_record_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_dispute` ADD CONSTRAINT `fk_interconnect_settlement_dispute_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`rate` ADD CONSTRAINT `fk_interconnect_rate_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_mnp_compliance_id` FOREIGN KEY (`mnp_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`mnp_compliance`(`mnp_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= interconnect --> customer (3 constraint(s)) =========
-- Requires: interconnect schema, customer schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_record` ADD CONSTRAINT `fk_interconnect_tap_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`nrtrde_record` ADD CONSTRAINT `fk_interconnect_nrtrde_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= interconnect --> enterprise (7 constraint(s)) =========
-- Requires: interconnect schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_file` ADD CONSTRAINT `fk_interconnect_tap_file_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice` ADD CONSTRAINT `fk_interconnect_settlement_invoice_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice` ADD CONSTRAINT `fk_interconnect_settlement_invoice_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);

-- ========= interconnect --> inventory (4 constraint(s)) =========
-- Requires: interconnect schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`peering_arrangement` ADD CONSTRAINT `fk_interconnect_peering_arrangement_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`peering_arrangement` ADD CONSTRAINT `fk_interconnect_peering_arrangement_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);

-- ========= interconnect --> network (10 constraint(s)) =========
-- Requires: interconnect schema, network schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_qos_profile_id` FOREIGN KEY (`qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`qos_profile`(`qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_record` ADD CONSTRAINT `fk_interconnect_tap_record_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`nrtrde_record` ADD CONSTRAINT `fk_interconnect_nrtrde_record_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`peering_arrangement` ADD CONSTRAINT `fk_interconnect_peering_arrangement_topology_id` FOREIGN KEY (`topology_id`) REFERENCES `telecommunication_ecm`.`network`.`topology`(`topology_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice` ADD CONSTRAINT `fk_interconnect_settlement_invoice_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`rate` ADD CONSTRAINT `fk_interconnect_rate_qos_profile_id` FOREIGN KEY (`qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`qos_profile`(`qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_topology_id` FOREIGN KEY (`topology_id`) REFERENCES `telecommunication_ecm`.`network`.`topology`(`topology_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);

-- ========= interconnect --> order (2 constraint(s)) =========
-- Requires: interconnect schema, order schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_line_id` FOREIGN KEY (`line_id`) REFERENCES `telecommunication_ecm`.`order`.`line`(`line_id`);

-- ========= interconnect --> partner (21 constraint(s)) =========
-- Requires: interconnect schema, partner schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier_agreement` ADD CONSTRAINT `fk_interconnect_carrier_agreement_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`carrier` ADD CONSTRAINT `fk_interconnect_carrier_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`iot_tariff` ADD CONSTRAINT `fk_interconnect_iot_tariff_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_file` ADD CONSTRAINT `fk_interconnect_tap_file_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_record` ADD CONSTRAINT `fk_interconnect_tap_record_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`tap_record` ADD CONSTRAINT `fk_interconnect_tap_record_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`nrtrde_record` ADD CONSTRAINT `fk_interconnect_nrtrde_record_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`nrtrde_record` ADD CONSTRAINT `fk_interconnect_nrtrde_record_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`peering_arrangement` ADD CONSTRAINT `fk_interconnect_peering_arrangement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`peering_arrangement` ADD CONSTRAINT `fk_interconnect_peering_arrangement_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice` ADD CONSTRAINT `fk_interconnect_settlement_invoice_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice` ADD CONSTRAINT `fk_interconnect_settlement_invoice_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_invoice_line` ADD CONSTRAINT `fk_interconnect_settlement_invoice_line_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_dispute` ADD CONSTRAINT `fk_interconnect_settlement_dispute_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`settlement_dispute` ADD CONSTRAINT `fk_interconnect_settlement_dispute_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`rate` ADD CONSTRAINT `fk_interconnect_rate_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= interconnect --> sales (2 constraint(s)) =========
-- Requires: interconnect schema, sales schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`mnp_transaction` ADD CONSTRAINT `fk_interconnect_mnp_transaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= interconnect --> workforce (2 constraint(s)) =========
-- Requires: interconnect schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`interconnect`.`poi` ADD CONSTRAINT `fk_interconnect_poi_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);

-- ========= inventory --> assurance (7 constraint(s)) =========
-- Requires: inventory schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`alarm_event`(`alarm_event_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);

-- ========= inventory --> compliance (7 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ADD CONSTRAINT `fk_inventory_ip_address_pool_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ADD CONSTRAINT `fk_inventory_msisdn_range_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);

-- ========= inventory --> customer (4 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_address_id` FOREIGN KEY (`address_id`) REFERENCES `telecommunication_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= inventory --> interconnect (1 constraint(s)) =========
-- Requires: inventory schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ADD CONSTRAINT `fk_inventory_msisdn_range_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);

-- ========= inventory --> network (3 constraint(s)) =========
-- Requires: inventory schema, network schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ADD CONSTRAINT `fk_inventory_ip_address_pool_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);

-- ========= inventory --> order (1 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= inventory --> partner (15 constraint(s)) =========
-- Requires: inventory schema, partner schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ADD CONSTRAINT `fk_inventory_ip_address_pool_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ADD CONSTRAINT `fk_inventory_msisdn_range_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= inventory --> product (9 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);

-- ========= inventory --> workforce (14 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);

-- ========= network --> assurance (11 constraint(s)) =========
-- Requires: network schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ADD CONSTRAINT `fk_network_topology_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_kpi_threshold_id` FOREIGN KEY (`kpi_threshold_id`) REFERENCES `telecommunication_ecm`.`assurance`.`kpi_threshold`(`kpi_threshold_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ADD CONSTRAINT `fk_network_qos_profile_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);

-- ========= network --> billing (2 constraint(s)) =========
-- Requires: network schema, billing schema
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ADD CONSTRAINT `fk_network_capacity_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= network --> compliance (14 constraint(s)) =========
-- Requires: network schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ADD CONSTRAINT `fk_network_qos_profile_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= network --> customer (4 constraint(s)) =========
-- Requires: network schema, customer schema
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ADD CONSTRAINT `fk_network_topology_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= network --> enterprise (10 constraint(s)) =========
-- Requires: network schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ADD CONSTRAINT `fk_network_capacity_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);

-- ========= network --> interconnect (4 constraint(s)) =========
-- Requires: network schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_poi_id` FOREIGN KEY (`poi_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`poi`(`poi_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_poi_id` FOREIGN KEY (`poi_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`poi`(`poi_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);

-- ========= network --> inventory (9 constraint(s)) =========
-- Requires: network schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ADD CONSTRAINT `fk_network_topology_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);

-- ========= network --> partner (10 constraint(s)) =========
-- Requires: network schema, partner schema
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);

-- ========= network --> product (6 constraint(s)) =========
-- Requires: network schema, product schema
ALTER TABLE `telecommunication_ecm`.`network`.`element` ADD CONSTRAINT `fk_network_element_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ADD CONSTRAINT `fk_network_qos_profile_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ADD CONSTRAINT `fk_network_qos_profile_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= network --> service (4 constraint(s)) =========
-- Requires: network schema, service schema
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);

-- ========= network --> workforce (7 constraint(s)) =========
-- Requires: network schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);

-- ========= order --> assurance (13 constraint(s)) =========
-- Requires: order schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);

-- ========= order --> billing (7 constraint(s)) =========
-- Requires: order schema, billing schema
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `telecommunication_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_payment_arrangement_id` FOREIGN KEY (`payment_arrangement_id`) REFERENCES `telecommunication_ecm`.`billing`.`payment_arrangement`(`payment_arrangement_id`);

-- ========= order --> compliance (13 constraint(s)) =========
-- Requires: order schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_mnp_compliance_id` FOREIGN KEY (`mnp_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`mnp_compliance`(`mnp_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_mnp_compliance_id` FOREIGN KEY (`mnp_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`mnp_compliance`(`mnp_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= order --> customer (19 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `telecommunication_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_address_id` FOREIGN KEY (`address_id`) REFERENCES `telecommunication_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_address_id` FOREIGN KEY (`address_id`) REFERENCES `telecommunication_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscription`(`subscription_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_address_id` FOREIGN KEY (`address_id`) REFERENCES `telecommunication_ecm`.`customer`.`address`(`address_id`);

-- ========= order --> enterprise (38 constraint(s)) =========
-- Requires: order schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_discount_scheme_id` FOREIGN KEY (`discount_scheme_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`discount_scheme`(`discount_scheme_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_sdwan_topology_id` FOREIGN KEY (`sdwan_topology_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`sdwan_topology`(`sdwan_topology_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_sdwan_topology_id` FOREIGN KEY (`sdwan_topology_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`sdwan_topology`(`sdwan_topology_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_uc_subscription_id` FOREIGN KEY (`uc_subscription_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`uc_subscription`(`uc_subscription_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_sdwan_topology_id` FOREIGN KEY (`sdwan_topology_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`sdwan_topology`(`sdwan_topology_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_discount_scheme_id` FOREIGN KEY (`discount_scheme_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`discount_scheme`(`discount_scheme_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_discount_scheme_id` FOREIGN KEY (`discount_scheme_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`discount_scheme`(`discount_scheme_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);

-- ========= order --> interconnect (7 constraint(s)) =========
-- Requires: order schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_mnp_transaction_id` FOREIGN KEY (`mnp_transaction_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`mnp_transaction`(`mnp_transaction_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_mnp_transaction_id` FOREIGN KEY (`mnp_transaction_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`mnp_transaction`(`mnp_transaction_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_mnp_transaction_id` FOREIGN KEY (`mnp_transaction_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`mnp_transaction`(`mnp_transaction_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_mnp_transaction_id` FOREIGN KEY (`mnp_transaction_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`mnp_transaction`(`mnp_transaction_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`rate`(`rate_id`);

-- ========= order --> inventory (19 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);

-- ========= order --> network (25 constraint(s)) =========
-- Requires: order schema, network schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_qos_profile_id` FOREIGN KEY (`qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`qos_profile`(`qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_qos_profile_id` FOREIGN KEY (`qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`qos_profile`(`qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);

-- ========= order --> partner (8 constraint(s)) =========
-- Requires: order schema, partner schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_revenue_share_plan_id` FOREIGN KEY (`revenue_share_plan_id`) REFERENCES `telecommunication_ecm`.`partner`.`revenue_share_plan`(`revenue_share_plan_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_revenue_share_plan_id` FOREIGN KEY (`revenue_share_plan_id`) REFERENCES `telecommunication_ecm`.`partner`.`revenue_share_plan`(`revenue_share_plan_id`);

-- ========= order --> product (23 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);

-- ========= order --> sales (3 constraint(s)) =========
-- Requires: order schema, sales schema
ALTER TABLE `telecommunication_ecm`.`order`.`fulfillment_order` ADD CONSTRAINT `fk_order_fulfillment_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `telecommunication_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `telecommunication_ecm`.`sales`.`quote_line`(`quote_line_id`);

-- ========= order --> service (12 constraint(s)) =========
-- Requires: order schema, service schema
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_svc_configuration_id` FOREIGN KEY (`svc_configuration_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_configuration`(`svc_configuration_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_svc_configuration_id` FOREIGN KEY (`svc_configuration_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_configuration`(`svc_configuration_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`provisioning_request` ADD CONSTRAINT `fk_order_provisioning_request_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= order --> workforce (15 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_task_technician_id` FOREIGN KEY (`task_technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`task` ADD CONSTRAINT `fk_order_task_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`fallout` ADD CONSTRAINT `fk_order_fallout_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`service_qualification` ADD CONSTRAINT `fk_order_service_qualification_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`appointment` ADD CONSTRAINT `fk_order_appointment_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`sla` ADD CONSTRAINT `fk_order_sla_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`notification` ADD CONSTRAINT `fk_order_notification_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`amendment` ADD CONSTRAINT `fk_order_amendment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`order`.`order_charge` ADD CONSTRAINT `fk_order_order_charge_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);

-- ========= partner --> assurance (5 constraint(s)) =========
-- Requires: partner schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ADD CONSTRAINT `fk_partner_settlement_run_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);

-- ========= partner --> billing (13 constraint(s)) =========
-- Requires: partner schema, billing schema
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ADD CONSTRAINT `fk_partner_revenue_share_plan_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ADD CONSTRAINT `fk_partner_settlement_run_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ADD CONSTRAINT `fk_partner_settlement_run_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ADD CONSTRAINT `fk_partner_settlement_run_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_billing_charge_id` FOREIGN KEY (`billing_charge_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_charge`(`billing_charge_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_rated_event_id` FOREIGN KEY (`rated_event_id`) REFERENCES `telecommunication_ecm`.`billing`.`rated_event`(`rated_event_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_billing_charge_id` FOREIGN KEY (`billing_charge_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_charge`(`billing_charge_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= partner --> compliance (10 constraint(s)) =========
-- Requires: partner schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ADD CONSTRAINT `fk_partner_partner_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ADD CONSTRAINT `fk_partner_roaming_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ADD CONSTRAINT `fk_partner_sla_definition_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ADD CONSTRAINT `fk_partner_revenue_share_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ADD CONSTRAINT `fk_partner_settlement_run_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ADD CONSTRAINT `fk_partner_onboarding_request_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= partner --> enterprise (8 constraint(s)) =========
-- Requires: partner schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ADD CONSTRAINT `fk_partner_onboarding_request_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ADD CONSTRAINT `fk_partner_onboarding_request_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ADD CONSTRAINT `fk_partner_dealer_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ADD CONSTRAINT `fk_partner_dealer_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);

-- ========= partner --> interconnect (2 constraint(s)) =========
-- Requires: partner schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`rate`(`rate_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_nrtrde_record_id` FOREIGN KEY (`nrtrde_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`nrtrde_record`(`nrtrde_record_id`);

-- ========= partner --> inventory (1 constraint(s)) =========
-- Requires: partner schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);

-- ========= partner --> network (1 constraint(s)) =========
-- Requires: partner schema, network schema
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_qos_profile_id` FOREIGN KEY (`qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`qos_profile`(`qos_profile_id`);

-- ========= partner --> sales (3 constraint(s)) =========
-- Requires: partner schema, sales schema
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ADD CONSTRAINT `fk_partner_onboarding_request_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ADD CONSTRAINT `fk_partner_dealer_commission_plan_id` FOREIGN KEY (`commission_plan_id`) REFERENCES `telecommunication_ecm`.`sales`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= partner --> usage (3 constraint(s)) =========
-- Requires: partner schema, usage schema
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_aggregated_usage_id` FOREIGN KEY (`aggregated_usage_id`) REFERENCES `telecommunication_ecm`.`usage`.`aggregated_usage`(`aggregated_usage_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_anomaly_id` FOREIGN KEY (`anomaly_id`) REFERENCES `telecommunication_ecm`.`usage`.`anomaly`(`anomaly_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_roaming_file_id` FOREIGN KEY (`roaming_file_id`) REFERENCES `telecommunication_ecm`.`usage`.`roaming_file`(`roaming_file_id`);

-- ========= partner --> workforce (3 constraint(s)) =========
-- Requires: partner schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ADD CONSTRAINT `fk_partner_onboarding_request_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);

-- ========= product --> compliance (8 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ADD CONSTRAINT `fk_product_device_model_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= product --> enterprise (3 constraint(s)) =========
-- Requires: product schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);

-- ========= product --> interconnect (3 constraint(s)) =========
-- Requires: product schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_iot_tariff_id` FOREIGN KEY (`iot_tariff_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`iot_tariff`(`iot_tariff_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_iot_tariff_id` FOREIGN KEY (`iot_tariff_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`iot_tariff`(`iot_tariff_id`);

-- ========= product --> partner (17 constraint(s)) =========
-- Requires: product schema, partner schema
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_revenue_share_plan_id` FOREIGN KEY (`revenue_share_plan_id`) REFERENCES `telecommunication_ecm`.`partner`.`revenue_share_plan`(`revenue_share_plan_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_revenue_share_plan_id` FOREIGN KEY (`revenue_share_plan_id`) REFERENCES `telecommunication_ecm`.`partner`.`revenue_share_plan`(`revenue_share_plan_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_revenue_share_plan_id` FOREIGN KEY (`revenue_share_plan_id`) REFERENCES `telecommunication_ecm`.`partner`.`revenue_share_plan`(`revenue_share_plan_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ADD CONSTRAINT `fk_product_spec_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ADD CONSTRAINT `fk_product_device_model_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);

-- ========= sales --> assurance (7 constraint(s)) =========
-- Requires: sales schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);

-- ========= sales --> billing (5 constraint(s)) =========
-- Requires: sales schema, billing schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);

-- ========= sales --> compliance (10 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= sales --> customer (8 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_address_id` FOREIGN KEY (`address_id`) REFERENCES `telecommunication_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_address_id` FOREIGN KEY (`address_id`) REFERENCES `telecommunication_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= sales --> enterprise (21 constraint(s)) =========
-- Requires: sales schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ADD CONSTRAINT `fk_sales_commission_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);

-- ========= sales --> interconnect (1 constraint(s)) =========
-- Requires: sales schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`rate`(`rate_id`);

-- ========= sales --> inventory (10 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);

-- ========= sales --> network (5 constraint(s)) =========
-- Requires: sales schema, network schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_qos_profile_id` FOREIGN KEY (`qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`qos_profile`(`qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);

-- ========= sales --> partner (13 constraint(s)) =========
-- Requires: sales schema, partner schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_revenue_share_plan_id` FOREIGN KEY (`revenue_share_plan_id`) REFERENCES `telecommunication_ecm`.`partner`.`revenue_share_plan`(`revenue_share_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);

-- ========= sales --> product (22 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);

-- ========= sales --> service (3 constraint(s)) =========
-- Requires: sales schema, service schema
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_svc_location_id` FOREIGN KEY (`svc_location_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_location`(`svc_location_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= sales --> workforce (3 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);

-- ========= service --> assurance (5 constraint(s)) =========
-- Requires: service schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ADD CONSTRAINT `fk_service_sla_profile_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);

-- ========= service --> billing (6 constraint(s)) =========
-- Requires: service schema, billing schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= service --> compliance (12 constraint(s)) =========
-- Requires: service schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_mnp_compliance_id` FOREIGN KEY (`mnp_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`mnp_compliance`(`mnp_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_mnp_compliance_id` FOREIGN KEY (`mnp_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`mnp_compliance`(`mnp_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_mnp_compliance_id` FOREIGN KEY (`mnp_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`mnp_compliance`(`mnp_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ADD CONSTRAINT `fk_service_svc_location_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);

-- ========= service --> customer (9 constraint(s)) =========
-- Requires: service schema, customer schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_case_id` FOREIGN KEY (`case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= service --> enterprise (29 constraint(s)) =========
-- Requires: service schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_sdwan_topology_id` FOREIGN KEY (`sdwan_topology_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`sdwan_topology`(`sdwan_topology_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_sdwan_topology_id` FOREIGN KEY (`sdwan_topology_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`sdwan_topology`(`sdwan_topology_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_uc_subscription_id` FOREIGN KEY (`uc_subscription_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`uc_subscription`(`uc_subscription_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ADD CONSTRAINT `fk_service_sla_profile_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ADD CONSTRAINT `fk_service_sla_profile_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`segment`(`segment_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_uc_subscription_id` FOREIGN KEY (`uc_subscription_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`uc_subscription`(`uc_subscription_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ADD CONSTRAINT `fk_service_svc_location_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);

-- ========= service --> interconnect (7 constraint(s)) =========
-- Requires: service schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_mnp_transaction_id` FOREIGN KEY (`mnp_transaction_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`mnp_transaction`(`mnp_transaction_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_mnp_transaction_id` FOREIGN KEY (`mnp_transaction_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`mnp_transaction`(`mnp_transaction_id`);

-- ========= service --> inventory (14 constraint(s)) =========
-- Requires: service schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ADD CONSTRAINT `fk_service_svc_location_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ADD CONSTRAINT `fk_service_svc_location_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);

-- ========= service --> network (8 constraint(s)) =========
-- Requires: service schema, network schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_qos_profile_id` FOREIGN KEY (`qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`qos_profile`(`qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ADD CONSTRAINT `fk_service_svc_location_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ADD CONSTRAINT `fk_service_svc_location_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);

-- ========= service --> order (5 constraint(s)) =========
-- Requires: service schema, order schema
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `telecommunication_ecm`.`order`.`appointment`(`appointment_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `telecommunication_ecm`.`order`.`amendment`(`amendment_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= service --> partner (9 constraint(s)) =========
-- Requires: service schema, partner schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ADD CONSTRAINT `fk_service_sla_profile_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);

-- ========= service --> product (17 constraint(s)) =========
-- Requires: service schema, product schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);

-- ========= service --> sales (6 constraint(s)) =========
-- Requires: service schema, sales schema
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_retention_offer_id` FOREIGN KEY (`retention_offer_id`) REFERENCES `telecommunication_ecm`.`sales`.`retention_offer`(`retention_offer_id`);

-- ========= service --> workforce (7 constraint(s)) =========
-- Requires: service schema, workforce schema
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ADD CONSTRAINT `fk_service_svc_location_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);

-- ========= usage --> assurance (12 constraint(s)) =========
-- Requires: usage schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`alarm_event`(`alarm_event_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);

-- ========= usage --> billing (20 constraint(s)) =========
-- Requires: usage schema, billing schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_prepaid_balance_id` FOREIGN KEY (`prepaid_balance_id`) REFERENCES `telecommunication_ecm`.`billing`.`prepaid_balance`(`prepaid_balance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_billing_charge_id` FOREIGN KEY (`billing_charge_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_charge`(`billing_charge_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_rated_event_id` FOREIGN KEY (`rated_event_id`) REFERENCES `telecommunication_ecm`.`billing`.`rated_event`(`rated_event_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= usage --> compliance (6 constraint(s)) =========
-- Requires: usage schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `telecommunication_ecm`.`compliance`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= usage --> customer (7 constraint(s)) =========
-- Requires: usage schema, customer schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= usage --> enterprise (30 constraint(s)) =========
-- Requires: usage schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_uc_subscription_id` FOREIGN KEY (`uc_subscription_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`uc_subscription`(`uc_subscription_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_discount_scheme_id` FOREIGN KEY (`discount_scheme_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`discount_scheme`(`discount_scheme_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_sdwan_topology_id` FOREIGN KEY (`sdwan_topology_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`sdwan_topology`(`sdwan_topology_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_uc_subscription_id` FOREIGN KEY (`uc_subscription_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`uc_subscription`(`uc_subscription_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);

-- ========= usage --> interconnect (24 constraint(s)) =========
-- Requires: usage schema, interconnect schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_cdr_network_operator_carrier_id` FOREIGN KEY (`cdr_network_operator_carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_nrtrde_record_id` FOREIGN KEY (`nrtrde_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`nrtrde_record`(`nrtrde_record_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_poi_id` FOREIGN KEY (`poi_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`poi`(`poi_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`rate`(`rate_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_tap_file_id` FOREIGN KEY (`tap_file_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_file`(`tap_file_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_tap_record_id` FOREIGN KEY (`tap_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_record`(`tap_record_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`rate`(`rate_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_tap_record_id` FOREIGN KEY (`tap_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_record`(`tap_record_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`rate`(`rate_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_nrtrde_record_id` FOREIGN KEY (`nrtrde_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`nrtrde_record`(`nrtrde_record_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_tap_file_id` FOREIGN KEY (`tap_file_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_file`(`tap_file_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_tap_record_id` FOREIGN KEY (`tap_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_record`(`tap_record_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`rate`(`rate_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_settlement_dispute_id` FOREIGN KEY (`settlement_dispute_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`settlement_dispute`(`settlement_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_tap_record_id` FOREIGN KEY (`tap_record_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_record`(`tap_record_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`carrier`(`carrier_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_tap_file_id` FOREIGN KEY (`tap_file_id`) REFERENCES `telecommunication_ecm`.`interconnect`.`tap_file`(`tap_file_id`);

-- ========= usage --> inventory (9 constraint(s)) =========
-- Requires: usage schema, inventory schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);

-- ========= usage --> network (17 constraint(s)) =========
-- Requires: usage schema, network schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_qos_profile_id` FOREIGN KEY (`qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`qos_profile`(`qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_topology_id` FOREIGN KEY (`topology_id`) REFERENCES `telecommunication_ecm`.`network`.`topology`(`topology_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);

-- ========= usage --> order (5 constraint(s)) =========
-- Requires: usage schema, order schema
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_line_id` FOREIGN KEY (`line_id`) REFERENCES `telecommunication_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_line_id` FOREIGN KEY (`line_id`) REFERENCES `telecommunication_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `telecommunication_ecm`.`order`.`amendment`(`amendment_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_line_id` FOREIGN KEY (`line_id`) REFERENCES `telecommunication_ecm`.`order`.`line`(`line_id`);

-- ========= usage --> partner (12 constraint(s)) =========
-- Requires: usage schema, partner schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_mvno_profile_id` FOREIGN KEY (`mvno_profile_id`) REFERENCES `telecommunication_ecm`.`partner`.`mvno_profile`(`mvno_profile_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_settlement_run_id` FOREIGN KEY (`settlement_run_id`) REFERENCES `telecommunication_ecm`.`partner`.`settlement_run`(`settlement_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_settlement_run_id` FOREIGN KEY (`settlement_run_id`) REFERENCES `telecommunication_ecm`.`partner`.`settlement_run`(`settlement_run_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_roaming_agreement_id` FOREIGN KEY (`roaming_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`roaming_agreement`(`roaming_agreement_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ADD CONSTRAINT `fk_usage_roaming_file_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= usage --> product (11 constraint(s)) =========
-- Requires: usage schema, product schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);

-- ========= usage --> sales (2 constraint(s)) =========
-- Requires: usage schema, sales schema
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= usage --> service (8 constraint(s)) =========
-- Requires: usage schema, service schema
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ADD CONSTRAINT `fk_usage_balance_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ADD CONSTRAINT `fk_usage_aggregated_usage_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= workforce --> assurance (6 constraint(s)) =========
-- Requires: workforce schema, assurance schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`alarm_event`(`alarm_event_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`outage_record`(`outage_record_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_sla_breach_event_id` FOREIGN KEY (`sla_breach_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_breach_event`(`sla_breach_event_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);

-- ========= workforce --> compliance (6 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_lawful_intercept_order_id` FOREIGN KEY (`lawful_intercept_order_id`) REFERENCES `telecommunication_ecm`.`compliance`.`lawful_intercept_order`(`lawful_intercept_order_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ADD CONSTRAINT `fk_workforce_field_vehicle_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);

-- ========= workforce --> customer (7 constraint(s)) =========
-- Requires: workforce schema, customer schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_case_id` FOREIGN KEY (`case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `telecommunication_ecm`.`customer`.`interaction`(`interaction_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscription`(`subscription_id`);

-- ========= workforce --> enterprise (10 constraint(s)) =========
-- Requires: workforce schema, enterprise schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_iot_deployment_id` FOREIGN KEY (`iot_deployment_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`iot_deployment`(`iot_deployment_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_managed_service_id` FOREIGN KEY (`managed_service_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`managed_service`(`managed_service_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_sdwan_topology_id` FOREIGN KEY (`sdwan_topology_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`sdwan_topology`(`sdwan_topology_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_uc_subscription_id` FOREIGN KEY (`uc_subscription_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`uc_subscription`(`uc_subscription_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ADD CONSTRAINT `fk_workforce_team_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ADD CONSTRAINT `fk_workforce_team_enterprise_contract_id` FOREIGN KEY (`enterprise_contract_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`enterprise_contract`(`enterprise_contract_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ADD CONSTRAINT `fk_workforce_team_site_id` FOREIGN KEY (`site_id`) REFERENCES `telecommunication_ecm`.`enterprise`.`site`(`site_id`);

-- ========= workforce --> network (2 constraint(s)) =========
-- Requires: workforce schema, network schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ADD CONSTRAINT `fk_workforce_technician_schedule_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);

-- ========= workforce --> order (4 constraint(s)) =========
-- Requires: workforce schema, order schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `telecommunication_ecm`.`order`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `telecommunication_ecm`.`order`.`appointment`(`appointment_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_task_id` FOREIGN KEY (`task_id`) REFERENCES `telecommunication_ecm`.`order`.`task`(`task_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ADD CONSTRAINT `fk_workforce_route_plan_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `telecommunication_ecm`.`order`.`appointment`(`appointment_id`);

-- ========= workforce --> partner (4 constraint(s)) =========
-- Requires: workforce schema, partner schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ADD CONSTRAINT `fk_workforce_team_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);

-- ========= workforce --> product (6 constraint(s)) =========
-- Requires: workforce schema, product schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `telecommunication_ecm`.`product`.`promo_offer`(`promo_offer_id`);

-- ========= workforce --> sales (2 constraint(s)) =========
-- Requires: workforce schema, sales schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_retention_offer_id` FOREIGN KEY (`retention_offer_id`) REFERENCES `telecommunication_ecm`.`sales`.`retention_offer`(`retention_offer_id`);

-- ========= workforce --> service (3 constraint(s)) =========
-- Requires: workforce schema, service schema
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_svc_location_id` FOREIGN KEY (`svc_location_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_location`(`svc_location_id`);

