-- Cross-Domain Foreign Keys for Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:17
-- Total cross-domain FK constraints: 2140
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, claim, contract, customer, customs, document, finance, fleet, freight, fulfillment, network, pricing, procurement, route, safety, shipment, sustainability, warehouse, workforce

-- ========= billing --> claim (2 constraint(s)) =========
-- Requires: billing schema, claim schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_surveyor_id` FOREIGN KEY (`surveyor_id`) REFERENCES `transport_shipping_ecm`.`claim`.`surveyor`(`surveyor_id`);

-- ========= billing --> contract (11 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_contract_surcharge_schedule_id` FOREIGN KEY (`contract_surcharge_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule`(`contract_surcharge_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_lane_commitment_id` FOREIGN KEY (`lane_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`lane_commitment`(`lane_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `transport_shipping_ecm`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ADD CONSTRAINT `fk_billing_advance_payment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= billing --> customer (15 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ADD CONSTRAINT `fk_billing_cod_collection_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ADD CONSTRAINT `fk_billing_dunning_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ADD CONSTRAINT `fk_billing_consolidated_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ADD CONSTRAINT `fk_billing_advance_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= billing --> customs (1 constraint(s)) =========
-- Requires: billing schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_tariff_rate_id` FOREIGN KEY (`tariff_rate_id`) REFERENCES `transport_shipping_ecm`.`customs`.`tariff_rate`(`tariff_rate_id`);

-- ========= billing --> document (5 constraint(s)) =========
-- Requires: billing schema, document schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);

-- ========= billing --> finance (10 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_bank_statement_line_id` FOREIGN KEY (`bank_statement_line_id`) REFERENCES `transport_shipping_ecm`.`finance`.`bank_statement_line`(`bank_statement_line_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ADD CONSTRAINT `fk_billing_cod_collection_bank_statement_line_id` FOREIGN KEY (`bank_statement_line_id`) REFERENCES `transport_shipping_ecm`.`finance`.`bank_statement_line`(`bank_statement_line_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ADD CONSTRAINT `fk_billing_tax_schedule_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ADD CONSTRAINT `fk_billing_intercompany_billing_intercompany_settlement_id` FOREIGN KEY (`intercompany_settlement_id`) REFERENCES `transport_shipping_ecm`.`finance`.`intercompany_settlement`(`intercompany_settlement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ADD CONSTRAINT `fk_billing_advance_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= billing --> network (19 constraint(s)) =========
-- Requires: billing schema, network schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_blocked_space_agreement_id` FOREIGN KEY (`blocked_space_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`blocked_space_agreement`(`blocked_space_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ADD CONSTRAINT `fk_billing_cod_collection_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);

-- ========= billing --> pricing (5 constraint(s)) =========
-- Requires: billing schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);

-- ========= billing --> procurement (4 constraint(s)) =========
-- Requires: billing schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= billing --> route (5 constraint(s)) =========
-- Requires: billing schema, route schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_route_exception_id` FOREIGN KEY (`route_exception_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_exception`(`route_exception_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_route_exception_id` FOREIGN KEY (`route_exception_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_exception`(`route_exception_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_lane_performance_id` FOREIGN KEY (`lane_performance_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane_performance`(`lane_performance_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ADD CONSTRAINT `fk_billing_dunning_record_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);

-- ========= billing --> safety (1 constraint(s)) =========
-- Requires: billing schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);

-- ========= billing --> shipment (7 constraint(s)) =========
-- Requires: billing schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ADD CONSTRAINT `fk_billing_cod_collection_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ADD CONSTRAINT `fk_billing_intercompany_billing_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= billing --> sustainability (4 constraint(s)) =========
-- Requires: billing schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_carbon_offset_transaction_id` FOREIGN KEY (`carbon_offset_transaction_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction`(`carbon_offset_transaction_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_supplier_emissions_disclosure_id` FOREIGN KEY (`supplier_emissions_disclosure_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure`(`supplier_emissions_disclosure_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);

-- ========= billing --> workforce (17 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ADD CONSTRAINT `fk_billing_cod_collection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ADD CONSTRAINT `fk_billing_dunning_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_cycle_modified_by_user_employee_id` FOREIGN KEY (`cycle_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ADD CONSTRAINT `fk_billing_intercompany_billing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ADD CONSTRAINT `fk_billing_advance_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= claim --> billing (1 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `transport_shipping_ecm`.`billing`.`credit_note`(`credit_note_id`);

-- ========= claim --> contract (11 constraint(s)) =========
-- Requires: claim schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ADD CONSTRAINT `fk_claim_claim_party_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_party`(`contract_party_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= claim --> customer (11 constraint(s)) =========
-- Requires: claim schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= claim --> customs (10 constraint(s)) =========
-- Requires: claim schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_declaration_line_id` FOREIGN KEY (`declaration_line_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration_line`(`declaration_line_id`);

-- ========= claim --> document (6 constraint(s)) =========
-- Requires: claim schema, document schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);

-- ========= claim --> finance (20 constraint(s)) =========
-- Requires: claim schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= claim --> fleet (10 constraint(s)) =========
-- Requires: claim schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);

-- ========= claim --> freight (38 constraint(s)) =========
-- Requires: claim schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= claim --> fulfillment (13 constraint(s)) =========
-- Requires: claim schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_delivery_attempt_id` FOREIGN KEY (`delivery_attempt_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`delivery_attempt`(`delivery_attempt_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_fulfillment_exception_id` FOREIGN KEY (`fulfillment_exception_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception`(`fulfillment_exception_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`order_line`(`order_line_id`);

-- ========= claim --> network (9 constraint(s)) =========
-- Requires: claim schema, network schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ADD CONSTRAINT `fk_claim_surveyor_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);

-- ========= claim --> pricing (1 constraint(s)) =========
-- Requires: claim schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);

-- ========= claim --> procurement (8 constraint(s)) =========
-- Requires: claim schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ADD CONSTRAINT `fk_claim_surveyor_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= claim --> route (8 constraint(s)) =========
-- Requires: claim schema, route schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);

-- ========= claim --> safety (11 constraint(s)) =========
-- Requires: claim schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_dg_incident_id` FOREIGN KEY (`dg_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_incident`(`dg_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_dg_incident_id` FOREIGN KEY (`dg_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_incident`(`dg_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_dg_incident_id` FOREIGN KEY (`dg_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_incident`(`dg_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `transport_shipping_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_dg_incident_id` FOREIGN KEY (`dg_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_incident`(`dg_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);

-- ========= claim --> shipment (7 constraint(s)) =========
-- Requires: claim schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= claim --> sustainability (1 constraint(s)) =========
-- Requires: claim schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_carbon_offset_transaction_id` FOREIGN KEY (`carbon_offset_transaction_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction`(`carbon_offset_transaction_id`);

-- ========= claim --> warehouse (6 constraint(s)) =========
-- Requires: claim schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= claim --> workforce (8 constraint(s)) =========
-- Requires: claim schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= contract --> billing (6 constraint(s)) =========
-- Requires: contract schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `transport_shipping_ecm`.`billing`.`credit_note`(`credit_note_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `transport_shipping_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_debit_note_id` FOREIGN KEY (`debit_note_id`) REFERENCES `transport_shipping_ecm`.`billing`.`debit_note`(`debit_note_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `transport_shipping_ecm`.`billing`.`credit_note`(`credit_note_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= contract --> claim (2 constraint(s)) =========
-- Requires: contract schema, claim schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);

-- ========= contract --> customer (3 constraint(s)) =========
-- Requires: contract schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);

-- ========= contract --> customs (2 constraint(s)) =========
-- Requires: contract schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ADD CONSTRAINT `fk_contract_agreement_compliance_qualification_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);

-- ========= contract --> document (9 constraint(s)) =========
-- Requires: contract schema, document schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ADD CONSTRAINT `fk_contract_contract_sla_commitment_compliance_check_id` FOREIGN KEY (`compliance_check_id`) REFERENCES `transport_shipping_ecm`.`document`.`compliance_check`(`compliance_check_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_compliance_check_id` FOREIGN KEY (`compliance_check_id`) REFERENCES `transport_shipping_ecm`.`document`.`compliance_check`(`compliance_check_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ADD CONSTRAINT `fk_contract_compliance_review_compliance_check_id` FOREIGN KEY (`compliance_check_id`) REFERENCES `transport_shipping_ecm`.`document`.`compliance_check`(`compliance_check_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `transport_shipping_ecm`.`document`.`workflow`(`workflow_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ADD CONSTRAINT `fk_contract_carrier_document_specification_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ADD CONSTRAINT `fk_contract_compliance_documentation_requirement_type_id` FOREIGN KEY (`type_id`) REFERENCES `transport_shipping_ecm`.`document`.`type`(`type_id`);

-- ========= contract --> finance (14 constraint(s)) =========
-- Requires: contract schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= contract --> freight (1 constraint(s)) =========
-- Requires: contract schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= contract --> network (15 constraint(s)) =========
-- Requires: contract schema, network schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ADD CONSTRAINT `fk_contract_contract_surcharge_schedule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ADD CONSTRAINT `fk_contract_partnership_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);

-- ========= contract --> pricing (2 constraint(s)) =========
-- Requires: contract schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_commodity_rate_class_id` FOREIGN KEY (`commodity_rate_class_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`commodity_rate_class`(`commodity_rate_class_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_dim_weight_rule_id` FOREIGN KEY (`dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);

-- ========= contract --> procurement (10 constraint(s)) =========
-- Requires: contract schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ADD CONSTRAINT `fk_contract_contract_surcharge_schedule_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ADD CONSTRAINT `fk_contract_compliance_review_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ADD CONSTRAINT `fk_contract_partnership_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ADD CONSTRAINT `fk_contract_agreement_supplier_service_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= contract --> route (7 constraint(s)) =========
-- Requires: contract schema, route schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ADD CONSTRAINT `fk_contract_contract_sla_commitment_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ADD CONSTRAINT `fk_contract_contract_volume_commitment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);

-- ========= contract --> safety (7 constraint(s)) =========
-- Requires: contract schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_driver_safety_program_id` FOREIGN KEY (`driver_safety_program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`driver_safety_program`(`driver_safety_program_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ADD CONSTRAINT `fk_contract_partnership_agreement_contractor_safety_prequal_id` FOREIGN KEY (`contractor_safety_prequal_id`) REFERENCES `transport_shipping_ecm`.`safety`.`contractor_safety_prequal`(`contractor_safety_prequal_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);

-- ========= contract --> shipment (2 constraint(s)) =========
-- Requires: contract schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= contract --> sustainability (12 constraint(s)) =========
-- Requires: contract schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ADD CONSTRAINT `fk_contract_contract_sla_commitment_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ADD CONSTRAINT `fk_contract_penalty_clause_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ADD CONSTRAINT `fk_contract_incentive_clause_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_corsia_compliance_record_id` FOREIGN KEY (`corsia_compliance_record_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record`(`corsia_compliance_record_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ADD CONSTRAINT `fk_contract_compliance_review_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);

-- ========= contract --> workforce (18 constraint(s)) =========
-- Requires: contract schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ADD CONSTRAINT `fk_contract_contract_surcharge_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ADD CONSTRAINT `fk_contract_contract_volume_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ADD CONSTRAINT `fk_contract_incentive_clause_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ADD CONSTRAINT `fk_contract_renewal_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ADD CONSTRAINT `fk_contract_renewal_schedule_quaternary_renewal_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_renewal_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ADD CONSTRAINT `fk_contract_renewal_schedule_tertiary_renewal_created_by_user_employee_id` FOREIGN KEY (`tertiary_renewal_created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ADD CONSTRAINT `fk_contract_compliance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ADD CONSTRAINT `fk_contract_partnership_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_primary_contract_employee_id` FOREIGN KEY (`primary_contract_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_tertiary_contract_authorized_signatory_employee_id` FOREIGN KEY (`tertiary_contract_authorized_signatory_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> contract (6 constraint(s)) =========
-- Requires: customer schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`opportunity` ADD CONSTRAINT `fk_customer_opportunity_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`ecommerce_seller` ADD CONSTRAINT `fk_customer_ecommerce_seller_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= customer --> customs (9 constraint(s)) =========
-- Requires: customer schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`kyc_verification` ADD CONSTRAINT `fk_customer_kyc_verification_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);

-- ========= customer --> document (4 constraint(s)) =========
-- Requires: customer schema, document schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`kyc_verification` ADD CONSTRAINT `fk_customer_kyc_verification_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);

-- ========= customer --> finance (8 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`opportunity` ADD CONSTRAINT `fk_customer_opportunity_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `transport_shipping_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `transport_shipping_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`ecommerce_seller` ADD CONSTRAINT `fk_customer_ecommerce_seller_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= customer --> fulfillment (3 constraint(s)) =========
-- Requires: customer schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`ecommerce_seller` ADD CONSTRAINT `fk_customer_ecommerce_seller_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_allocation` ADD CONSTRAINT `fk_customer_customer_allocation_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`zone_service_agreement` ADD CONSTRAINT `fk_customer_zone_service_agreement_fulfillment_delivery_zone_id` FOREIGN KEY (`fulfillment_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone`(`fulfillment_delivery_zone_id`);

-- ========= customer --> network (15 constraint(s)) =========
-- Requires: customer schema, network schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`opportunity` ADD CONSTRAINT `fk_customer_opportunity_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`opportunity` ADD CONSTRAINT `fk_customer_opportunity_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);

-- ========= customer --> pricing (6 constraint(s)) =========
-- Requires: customer schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`opportunity` ADD CONSTRAINT `fk_customer_opportunity_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`ecommerce_seller` ADD CONSTRAINT `fk_customer_ecommerce_seller_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);

-- ========= customer --> route (13 constraint(s)) =========
-- Requires: customer schema, route schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`address_book` ADD CONSTRAINT `fk_customer_address_book_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`opportunity` ADD CONSTRAINT `fk_customer_opportunity_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`ecommerce_seller` ADD CONSTRAINT `fk_customer_ecommerce_seller_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`zone_rate` ADD CONSTRAINT `fk_customer_zone_rate_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);

-- ========= customer --> safety (3 constraint(s)) =========
-- Requires: customer schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_dg_incident_id` FOREIGN KEY (`dg_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_incident`(`dg_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`environmental_incident`(`environmental_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_contractor_safety_prequal_id` FOREIGN KEY (`contractor_safety_prequal_id`) REFERENCES `transport_shipping_ecm`.`safety`.`contractor_safety_prequal`(`contractor_safety_prequal_id`);

-- ========= customer --> shipment (1 constraint(s)) =========
-- Requires: customer schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= customer --> sustainability (6 constraint(s)) =========
-- Requires: customer schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_supplier_emissions_disclosure_id` FOREIGN KEY (`supplier_emissions_disclosure_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure`(`supplier_emissions_disclosure_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`carbon_enrollment` ADD CONSTRAINT `fk_customer_carbon_enrollment_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sustainability_participation` ADD CONSTRAINT `fk_customer_sustainability_participation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`initiative`(`initiative_id`);

-- ========= customer --> warehouse (2 constraint(s)) =========
-- Requires: customer schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`address_book` ADD CONSTRAINT `fk_customer_address_book_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= customer --> workforce (16 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`kyc_verification` ADD CONSTRAINT `fk_customer_kyc_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`ecommerce_seller` ADD CONSTRAINT `fk_customer_ecommerce_seller_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_allocation` ADD CONSTRAINT `fk_customer_customer_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_allocation` ADD CONSTRAINT `fk_customer_customer_allocation_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`account_team_assignment` ADD CONSTRAINT `fk_customer_account_team_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`zone_service_agreement` ADD CONSTRAINT `fk_customer_zone_service_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`zone_rate` ADD CONSTRAINT `fk_customer_zone_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`opportunity_team_member` ADD CONSTRAINT `fk_customer_opportunity_team_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= customs --> billing (8 constraint(s)) =========
-- Requires: customs schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_billing_invoice_line_id` FOREIGN KEY (`billing_invoice_line_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_invoice_line`(`billing_invoice_line_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ADD CONSTRAINT `fk_customs_compliance_audit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ADD CONSTRAINT `fk_customs_ftz_admission_billing_invoice_line_id` FOREIGN KEY (`billing_invoice_line_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_invoice_line`(`billing_invoice_line_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ADD CONSTRAINT `fk_customs_ruling_request_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ADD CONSTRAINT `fk_customs_dg_declaration_billing_invoice_line_id` FOREIGN KEY (`billing_invoice_line_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_invoice_line`(`billing_invoice_line_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ADD CONSTRAINT `fk_customs_drawback_claim_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= customs --> contract (8 constraint(s)) =========
-- Requires: customs schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ADD CONSTRAINT `fk_customs_ftz_admission_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ADD CONSTRAINT `fk_customs_trade_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= customs --> customer (2 constraint(s)) =========
-- Requires: customs schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ADD CONSTRAINT `fk_customs_hs_classification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ADD CONSTRAINT `fk_customs_trade_agreement_utilization_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= customs --> document (1 constraint(s)) =========
-- Requires: customs schema, document schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ADD CONSTRAINT `fk_customs_dg_declaration_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);

-- ========= customs --> finance (11 constraint(s)) =========
-- Requires: customs schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ADD CONSTRAINT `fk_customs_compliance_audit_finance_audit_finding_id` FOREIGN KEY (`finance_audit_finding_id`) REFERENCES `transport_shipping_ecm`.`finance`.`finance_audit_finding`(`finance_audit_finding_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ADD CONSTRAINT `fk_customs_ftz_inventory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ADD CONSTRAINT `fk_customs_valuation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ADD CONSTRAINT `fk_customs_drawback_claim_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ADD CONSTRAINT `fk_customs_program_participation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= customs --> freight (1 constraint(s)) =========
-- Requires: customs schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= customs --> network (9 constraint(s)) =========
-- Requires: customs schema, network schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ADD CONSTRAINT `fk_customs_compliance_audit_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ADD CONSTRAINT `fk_customs_ftz_admission_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_transaction` ADD CONSTRAINT `fk_customs_trade_transaction_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);

-- ========= customs --> pricing (11 constraint(s)) =========
-- Requires: customs schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_commodity_rate_class_id` FOREIGN KEY (`commodity_rate_class_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`commodity_rate_class`(`commodity_rate_class_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ADD CONSTRAINT `fk_customs_hs_classification_commodity_rate_class_id` FOREIGN KEY (`commodity_rate_class_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`commodity_rate_class`(`commodity_rate_class_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ADD CONSTRAINT `fk_customs_tariff_rate_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ADD CONSTRAINT `fk_customs_ftz_admission_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_incoterms_charge_allocation_id` FOREIGN KEY (`incoterms_charge_allocation_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation`(`incoterms_charge_allocation_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ADD CONSTRAINT `fk_customs_dg_declaration_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);

-- ========= customs --> procurement (13 constraint(s)) =========
-- Requires: customs schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ADD CONSTRAINT `fk_customs_hs_classification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ADD CONSTRAINT `fk_customs_trade_party_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ADD CONSTRAINT `fk_customs_ftz_inventory_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ADD CONSTRAINT `fk_customs_ftz_admission_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ADD CONSTRAINT `fk_customs_ruling_request_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ADD CONSTRAINT `fk_customs_origin_determination_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= customs --> route (9 constraint(s)) =========
-- Requires: customs schema, route schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ADD CONSTRAINT `fk_customs_ftz_inventory_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ADD CONSTRAINT `fk_customs_ftz_admission_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);

-- ========= customs --> safety (2 constraint(s)) =========
-- Requires: customs schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ADD CONSTRAINT `fk_customs_dg_declaration_dg_certification_id` FOREIGN KEY (`dg_certification_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_certification`(`dg_certification_id`);

-- ========= customs --> shipment (14 constraint(s)) =========
-- Requires: customs schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_shipment_package_id` FOREIGN KEY (`shipment_package_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_package`(`shipment_package_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ADD CONSTRAINT `fk_customs_denied_party_screening_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ADD CONSTRAINT `fk_customs_ftz_admission_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ADD CONSTRAINT `fk_customs_dg_declaration_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ADD CONSTRAINT `fk_customs_drawback_claim_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ADD CONSTRAINT `fk_customs_customs_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= customs --> sustainability (6 constraint(s)) =========
-- Requires: customs schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_carbon_offset_transaction_id` FOREIGN KEY (`carbon_offset_transaction_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction`(`carbon_offset_transaction_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ADD CONSTRAINT `fk_customs_compliance_program_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ADD CONSTRAINT `fk_customs_compliance_audit_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ADD CONSTRAINT `fk_customs_ftz_inventory_packaging_sustainability_id` FOREIGN KEY (`packaging_sustainability_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`packaging_sustainability`(`packaging_sustainability_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_waste_record_id` FOREIGN KEY (`waste_record_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`waste_record`(`waste_record_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ADD CONSTRAINT `fk_customs_valuation_carbon_offset_transaction_id` FOREIGN KEY (`carbon_offset_transaction_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction`(`carbon_offset_transaction_id`);

-- ========= customs --> workforce (27 constraint(s)) =========
-- Requires: customs schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ADD CONSTRAINT `fk_customs_hs_classification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ADD CONSTRAINT `fk_customs_tariff_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ADD CONSTRAINT `fk_customs_denied_party_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ADD CONSTRAINT `fk_customs_trade_party_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ADD CONSTRAINT `fk_customs_compliance_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ADD CONSTRAINT `fk_customs_compliance_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ADD CONSTRAINT `fk_customs_ftz_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ADD CONSTRAINT `fk_customs_ftz_admission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ADD CONSTRAINT `fk_customs_ruling_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ADD CONSTRAINT `fk_customs_dg_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ADD CONSTRAINT `fk_customs_valuation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ADD CONSTRAINT `fk_customs_valuation_valuation_employee_id` FOREIGN KEY (`valuation_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ADD CONSTRAINT `fk_customs_valuation_valuation_last_modified_by_user_employee_id` FOREIGN KEY (`valuation_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ADD CONSTRAINT `fk_customs_drawback_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ADD CONSTRAINT `fk_customs_trade_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ADD CONSTRAINT `fk_customs_customs_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ADD CONSTRAINT `fk_customs_program_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ADD CONSTRAINT `fk_customs_trade_agreement_utilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= document --> contract (2 constraint(s)) =========
-- Requires: document schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ADD CONSTRAINT `fk_document_document_package_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ADD CONSTRAINT `fk_document_amendment_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_party`(`contract_party_id`);

-- ========= document --> customer (4 constraint(s)) =========
-- Requires: document schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ADD CONSTRAINT `fk_document_document_package_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ADD CONSTRAINT `fk_document_certificate_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= document --> customs (21 constraint(s)) =========
-- Requires: document schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ADD CONSTRAINT `fk_document_version_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ADD CONSTRAINT `fk_document_trade_document_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_broker_assignment_id` FOREIGN KEY (`broker_assignment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`broker_assignment`(`broker_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_issuing_entity_trade_party_id` FOREIGN KEY (`issuing_entity_trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ADD CONSTRAINT `fk_document_amendment_certificate_of_origin_id` FOREIGN KEY (`certificate_of_origin_id`) REFERENCES `transport_shipping_ecm`.`customs`.`certificate_of_origin`(`certificate_of_origin_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ADD CONSTRAINT `fk_document_certificate_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_certificate_of_origin_id` FOREIGN KEY (`certificate_of_origin_id`) REFERENCES `transport_shipping_ecm`.`customs`.`certificate_of_origin`(`certificate_of_origin_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ADD CONSTRAINT `fk_document_workflow_task_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_trade_transaction_id` FOREIGN KEY (`trade_transaction_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_transaction`(`trade_transaction_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ADD CONSTRAINT `fk_document_destruction_record_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ADD CONSTRAINT `fk_document_document_exception_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ADD CONSTRAINT `fk_document_document_exception_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ADD CONSTRAINT `fk_document_notarization_record_certificate_of_origin_id` FOREIGN KEY (`certificate_of_origin_id`) REFERENCES `transport_shipping_ecm`.`customs`.`certificate_of_origin`(`certificate_of_origin_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_ams_filing_id` FOREIGN KEY (`ams_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`ams_filing`(`ams_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_certificate_of_origin_id` FOREIGN KEY (`certificate_of_origin_id`) REFERENCES `transport_shipping_ecm`.`customs`.`certificate_of_origin`(`certificate_of_origin_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_isf_filing_id` FOREIGN KEY (`isf_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`isf_filing`(`isf_filing_id`);

-- ========= document --> freight (2 constraint(s)) =========
-- Requires: document schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ADD CONSTRAINT `fk_document_transport_document_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= document --> fulfillment (2 constraint(s)) =========
-- Requires: document schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ADD CONSTRAINT `fk_document_certificate_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);

-- ========= document --> network (24 constraint(s)) =========
-- Requires: document schema, network schema
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ADD CONSTRAINT `fk_document_transport_document_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ADD CONSTRAINT `fk_document_transport_document_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ADD CONSTRAINT `fk_document_transport_document_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ADD CONSTRAINT `fk_document_template_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ADD CONSTRAINT `fk_document_trade_document_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ADD CONSTRAINT `fk_document_document_package_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ADD CONSTRAINT `fk_document_document_package_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ADD CONSTRAINT `fk_document_amendment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ADD CONSTRAINT `fk_document_certificate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ADD CONSTRAINT `fk_document_certificate_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ADD CONSTRAINT `fk_document_workflow_task_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ADD CONSTRAINT `fk_document_document_exception_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ADD CONSTRAINT `fk_document_document_exception_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ADD CONSTRAINT `fk_document_notarization_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ADD CONSTRAINT `fk_document_notarization_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);

-- ========= document --> procurement (1 constraint(s)) =========
-- Requires: document schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ADD CONSTRAINT `fk_document_destruction_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= document --> shipment (10 constraint(s)) =========
-- Requires: document schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ADD CONSTRAINT `fk_document_transport_document_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ADD CONSTRAINT `fk_document_digital_signature_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ADD CONSTRAINT `fk_document_document_package_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ADD CONSTRAINT `fk_document_amendment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ADD CONSTRAINT `fk_document_document_exception_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ADD CONSTRAINT `fk_document_notarization_record_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= document --> workforce (28 constraint(s)) =========
-- Requires: document schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ADD CONSTRAINT `fk_document_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ADD CONSTRAINT `fk_document_version_version_employee_id` FOREIGN KEY (`version_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ADD CONSTRAINT `fk_document_version_version_modified_by_user_employee_id` FOREIGN KEY (`version_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ADD CONSTRAINT `fk_document_digital_signature_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ADD CONSTRAINT `fk_document_document_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ADD CONSTRAINT `fk_document_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ADD CONSTRAINT `fk_document_amendment_amendment_employee_id` FOREIGN KEY (`amendment_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ADD CONSTRAINT `fk_document_amendment_amendment_last_modified_by_user_employee_id` FOREIGN KEY (`amendment_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_workflow_employee_id` FOREIGN KEY (`workflow_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_workflow_last_modified_by_user_employee_id` FOREIGN KEY (`workflow_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ADD CONSTRAINT `fk_document_workflow_task_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ADD CONSTRAINT `fk_document_workflow_task_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ADD CONSTRAINT `fk_document_workflow_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ADD CONSTRAINT `fk_document_workflow_task_quaternary_workflow_delegated_from_user_employee_id` FOREIGN KEY (`quaternary_workflow_delegated_from_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ADD CONSTRAINT `fk_document_workflow_task_tertiary_workflow_escalated_to_user_employee_id` FOREIGN KEY (`tertiary_workflow_escalated_to_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ADD CONSTRAINT `fk_document_destruction_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ADD CONSTRAINT `fk_document_destruction_record_tertiary_destruction_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_destruction_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ADD CONSTRAINT `fk_document_document_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ADD CONSTRAINT `fk_document_notarization_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_primary_compliance_employee_id` FOREIGN KEY (`primary_compliance_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_tertiary_compliance_modified_by_user_employee_id` FOREIGN KEY (`tertiary_compliance_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> billing (2 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= finance --> contract (2 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= finance --> customer (2 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_lessee_id` FOREIGN KEY (`lessee_id`) REFERENCES `transport_shipping_ecm`.`customer`.`lessee`(`lessee_id`);

-- ========= finance --> customs (1 constraint(s)) =========
-- Requires: finance schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);

-- ========= finance --> document (11 constraint(s)) =========
-- Requires: finance schema, document schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `transport_shipping_ecm`.`document`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ADD CONSTRAINT `fk_finance_tax_account_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`trade_document`(`trade_document_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_version_id` FOREIGN KEY (`version_id`) REFERENCES `transport_shipping_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ADD CONSTRAINT `fk_finance_financial_control_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `transport_shipping_ecm`.`document`.`workflow`(`workflow_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);

-- ========= finance --> fleet (1 constraint(s)) =========
-- Requires: finance schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);

-- ========= finance --> network (7 constraint(s)) =========
-- Requires: finance schema, network schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);

-- ========= finance --> procurement (3 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= finance --> safety (3 constraint(s)) =========
-- Requires: finance schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_contractor_safety_prequal_id` FOREIGN KEY (`contractor_safety_prequal_id`) REFERENCES `transport_shipping_ecm`.`safety`.`contractor_safety_prequal`(`contractor_safety_prequal_id`);

-- ========= finance --> shipment (1 constraint(s)) =========
-- Requires: finance schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= finance --> sustainability (1 constraint(s)) =========
-- Requires: finance schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ADD CONSTRAINT `fk_finance_target_allocation_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);

-- ========= finance --> workforce (67 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_tertiary_fiscal_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_fiscal_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_budget_created_by_user_employee_id` FOREIGN KEY (`budget_created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_budget_employee_id` FOREIGN KEY (`budget_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_budget_last_modified_by_user_employee_id` FOREIGN KEY (`budget_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_quaternary_budget_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_budget_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_tertiary_budget_created_by_user_employee_id` FOREIGN KEY (`tertiary_budget_created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_quaternary_payment_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_payment_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_tertiary_payment_created_by_user_employee_id` FOREIGN KEY (`tertiary_payment_created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_tertiary_intercompany_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_intercompany_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ADD CONSTRAINT `fk_finance_tax_account_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ADD CONSTRAINT `fk_finance_tax_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_account` ADD CONSTRAINT `fk_finance_tax_account_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`tax_filing` ADD CONSTRAINT `fk_finance_tax_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_tertiary_fixed_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_fixed_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_tertiary_cost_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_cost_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_primary_financial_employee_id` FOREIGN KEY (`primary_financial_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_accrual_created_by_user_employee_id` FOREIGN KEY (`accrual_created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_accrual_employee_id` FOREIGN KEY (`accrual_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_accrual_last_modified_by_user_employee_id` FOREIGN KEY (`accrual_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ADD CONSTRAINT `fk_finance_currency_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`currency_rate` ADD CONSTRAINT `fk_finance_currency_rate_tertiary_currency_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_currency_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ADD CONSTRAINT `fk_finance_financial_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ADD CONSTRAINT `fk_finance_financial_statement_quaternary_financial_created_by_user_employee_id` FOREIGN KEY (`quaternary_financial_created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ADD CONSTRAINT `fk_finance_financial_statement_quinary_financial_last_modified_by_user_employee_id` FOREIGN KEY (`quinary_financial_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_statement` ADD CONSTRAINT `fk_finance_financial_statement_tertiary_financial_reviewed_by_user_employee_id` FOREIGN KEY (`tertiary_financial_reviewed_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_quaternary_finance_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_finance_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`finance_audit_finding` ADD CONSTRAINT `fk_finance_finance_audit_finding_tertiary_finance_created_by_user_employee_id` FOREIGN KEY (`tertiary_finance_created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_tertiary_internal_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_internal_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`bank_statement_line` ADD CONSTRAINT `fk_finance_bank_statement_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ADD CONSTRAINT `fk_finance_financial_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ADD CONSTRAINT `fk_finance_financial_control_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ADD CONSTRAINT `fk_finance_financial_control_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`financial_control` ADD CONSTRAINT `fk_finance_financial_control_primary_financial_employee_id` FOREIGN KEY (`primary_financial_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`target_allocation` ADD CONSTRAINT `fk_finance_target_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_project_owner_employee_id` FOREIGN KEY (`project_owner_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_sponsor_employee_id` FOREIGN KEY (`sponsor_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_proposal` ADD CONSTRAINT `fk_finance_payment_proposal_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`finance`.`payment_proposal` ADD CONSTRAINT `fk_finance_payment_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= fleet --> billing (8 constraint(s)) =========
-- Requires: fleet schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `transport_shipping_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `transport_shipping_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ADD CONSTRAINT `fk_fleet_asset_cost_record_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ADD CONSTRAINT `fk_fleet_toll_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= fleet --> claim (1 constraint(s)) =========
-- Requires: fleet schema, claim schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);

-- ========= fleet --> contract (8 constraint(s)) =========
-- Requires: fleet schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ADD CONSTRAINT `fk_fleet_asset_acquisition_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ADD CONSTRAINT `fk_fleet_asset_disposal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ADD CONSTRAINT `fk_fleet_toll_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ADD CONSTRAINT `fk_fleet_asset_insurance_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= fleet --> customer (1 constraint(s)) =========
-- Requires: fleet schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= fleet --> customs (12 constraint(s)) =========
-- Requires: fleet schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ADD CONSTRAINT `fk_fleet_driver_profile_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ADD CONSTRAINT `fk_fleet_asset_inspection_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ADD CONSTRAINT `fk_fleet_rfid_scan_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ADD CONSTRAINT `fk_fleet_reefer_monitoring_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ADD CONSTRAINT `fk_fleet_toll_record_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ADD CONSTRAINT `fk_fleet_asset_position_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ADD CONSTRAINT `fk_fleet_depot_certification_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ADD CONSTRAINT `fk_fleet_driver_certification_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);

-- ========= fleet --> document (17 constraint(s)) =========
-- Requires: fleet schema, document schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ADD CONSTRAINT `fk_fleet_driver_profile_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ADD CONSTRAINT `fk_fleet_asset_inspection_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ADD CONSTRAINT `fk_fleet_asset_licence_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ADD CONSTRAINT `fk_fleet_asset_acquisition_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ADD CONSTRAINT `fk_fleet_asset_disposal_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ADD CONSTRAINT `fk_fleet_rfid_scan_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ADD CONSTRAINT `fk_fleet_asset_cost_record_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ADD CONSTRAINT `fk_fleet_reefer_monitoring_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ADD CONSTRAINT `fk_fleet_toll_record_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ADD CONSTRAINT `fk_fleet_asset_insurance_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);

-- ========= fleet --> finance (12 constraint(s)) =========
-- Requires: fleet schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ADD CONSTRAINT `fk_fleet_transport_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ADD CONSTRAINT `fk_fleet_transport_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ADD CONSTRAINT `fk_fleet_container_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ADD CONSTRAINT `fk_fleet_container_unit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ADD CONSTRAINT `fk_fleet_asset_acquisition_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ADD CONSTRAINT `fk_fleet_asset_disposal_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ADD CONSTRAINT `fk_fleet_toll_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ADD CONSTRAINT `fk_fleet_asset_insurance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= fleet --> freight (5 constraint(s)) =========
-- Requires: fleet schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ADD CONSTRAINT `fk_fleet_rfid_scan_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ADD CONSTRAINT `fk_fleet_toll_record_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ADD CONSTRAINT `fk_fleet_asset_position_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_cargo_id` FOREIGN KEY (`cargo_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cargo`(`cargo_id`);

-- ========= fleet --> network (12 constraint(s)) =========
-- Requires: fleet schema, network schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ADD CONSTRAINT `fk_fleet_asset_acquisition_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ADD CONSTRAINT `fk_fleet_rfid_scan_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ADD CONSTRAINT `fk_fleet_toll_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ADD CONSTRAINT `fk_fleet_asset_insurance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ADD CONSTRAINT `fk_fleet_driver_performance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ADD CONSTRAINT `fk_fleet_asset_position_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ADD CONSTRAINT `fk_fleet_driver_engagement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);

-- ========= fleet --> pricing (1 constraint(s)) =========
-- Requires: fleet schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_fuel_index_id` FOREIGN KEY (`fuel_index_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`fuel_index`(`fuel_index_id`);

-- ========= fleet --> procurement (6 constraint(s)) =========
-- Requires: fleet schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ADD CONSTRAINT `fk_fleet_driver_profile_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ADD CONSTRAINT `fk_fleet_asset_acquisition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ADD CONSTRAINT `fk_fleet_asset_cost_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= fleet --> route (11 constraint(s)) =========
-- Requires: fleet schema, route schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ADD CONSTRAINT `fk_fleet_asset_utilisation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ADD CONSTRAINT `fk_fleet_toll_record_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ADD CONSTRAINT `fk_fleet_driver_performance_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ADD CONSTRAINT `fk_fleet_asset_position_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ADD CONSTRAINT `fk_fleet_asset_position_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);

-- ========= fleet --> safety (8 constraint(s)) =========
-- Requires: fleet schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `transport_shipping_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_fatigue_risk_assessment_id` FOREIGN KEY (`fatigue_risk_assessment_id`) REFERENCES `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment`(`fatigue_risk_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `transport_shipping_ecm`.`safety`.`permit`(`permit_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_fatigue_risk_assessment_id` FOREIGN KEY (`fatigue_risk_assessment_id`) REFERENCES `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment`(`fatigue_risk_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ADD CONSTRAINT `fk_fleet_geofence_zone_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ADD CONSTRAINT `fk_fleet_driver_performance_driver_safety_event_id` FOREIGN KEY (`driver_safety_event_id`) REFERENCES `transport_shipping_ecm`.`safety`.`driver_safety_event`(`driver_safety_event_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ADD CONSTRAINT `fk_fleet_fleet_training_completion_training_id` FOREIGN KEY (`training_id`) REFERENCES `transport_shipping_ecm`.`safety`.`training`(`training_id`);

-- ========= fleet --> shipment (5 constraint(s)) =========
-- Requires: fleet schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ADD CONSTRAINT `fk_fleet_rfid_scan_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ADD CONSTRAINT `fk_fleet_reefer_monitoring_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ADD CONSTRAINT `fk_fleet_asset_position_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= fleet --> sustainability (4 constraint(s)) =========
-- Requires: fleet schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_waste_record_id` FOREIGN KEY (`waste_record_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`waste_record`(`waste_record_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ADD CONSTRAINT `fk_fleet_asset_disposal_waste_record_id` FOREIGN KEY (`waste_record_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`waste_record`(`waste_record_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ADD CONSTRAINT `fk_fleet_tyre_record_waste_record_id` FOREIGN KEY (`waste_record_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`waste_record`(`waste_record_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ADD CONSTRAINT `fk_fleet_depot_initiative_implementation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`initiative`(`initiative_id`);

-- ========= fleet --> warehouse (2 constraint(s)) =========
-- Requires: fleet schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ADD CONSTRAINT `fk_fleet_geofence_zone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= fleet --> workforce (18 constraint(s)) =========
-- Requires: fleet schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ADD CONSTRAINT `fk_fleet_driver_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_tertiary_fleet_modified_by_user_employee_id` FOREIGN KEY (`tertiary_fleet_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_quaternary_maintenance_modified_by_user_employee_id` FOREIGN KEY (`quaternary_maintenance_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_tertiary_maintenance_created_by_user_employee_id` FOREIGN KEY (`tertiary_maintenance_created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ADD CONSTRAINT `fk_fleet_asset_acquisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ADD CONSTRAINT `fk_fleet_asset_disposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ADD CONSTRAINT `fk_fleet_rfid_scan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ADD CONSTRAINT `fk_fleet_depot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ADD CONSTRAINT `fk_fleet_asset_type_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ADD CONSTRAINT `fk_fleet_asset_cost_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ADD CONSTRAINT `fk_fleet_driver_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ADD CONSTRAINT `fk_fleet_depot_initiative_implementation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ADD CONSTRAINT `fk_fleet_fleet_training_completion_workforce_training_completion_id` FOREIGN KEY (`workforce_training_completion_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`workforce_training_completion`(`workforce_training_completion_id`);

-- ========= freight --> billing (12 constraint(s)) =========
-- Requires: freight schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_freight_audit_id` FOREIGN KEY (`freight_audit_id`) REFERENCES `transport_shipping_ecm`.`billing`.`freight_audit`(`freight_audit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_freight_audit_id` FOREIGN KEY (`freight_audit_id`) REFERENCES `transport_shipping_ecm`.`billing`.`freight_audit`(`freight_audit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `transport_shipping_ecm`.`billing`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_billing_invoice_line_id` FOREIGN KEY (`billing_invoice_line_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_invoice_line`(`billing_invoice_line_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_payment_allocation_id` FOREIGN KEY (`payment_allocation_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_allocation`(`payment_allocation_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `transport_shipping_ecm`.`billing`.`credit_note`(`credit_note_id`);

-- ========= freight --> claim (1 constraint(s)) =========
-- Requires: freight schema, claim schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);

-- ========= freight --> contract (8 constraint(s)) =========
-- Requires: freight schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= freight --> customer (13 constraint(s)) =========
-- Requires: freight schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `transport_shipping_ecm`.`customer`.`opportunity`(`opportunity_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);

-- ========= freight --> customs (12 constraint(s)) =========
-- Requires: freight schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_ams_filing_id` FOREIGN KEY (`ams_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`ams_filing`(`ams_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_isf_filing_id` FOREIGN KEY (`isf_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`isf_filing`(`isf_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_ams_filing_id` FOREIGN KEY (`ams_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`ams_filing`(`ams_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_isf_filing_id` FOREIGN KEY (`isf_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`isf_filing`(`isf_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ADD CONSTRAINT `fk_freight_cfs_operation_ftz_admission_id` FOREIGN KEY (`ftz_admission_id`) REFERENCES `transport_shipping_ecm`.`customs`.`ftz_admission`(`ftz_admission_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);

-- ========= freight --> document (10 constraint(s)) =========
-- Requires: freight schema, document schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_request_id` FOREIGN KEY (`request_id`) REFERENCES `transport_shipping_ecm`.`document`.`request`(`request_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`trade_document`(`trade_document_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_issuance_id` FOREIGN KEY (`issuance_id`) REFERENCES `transport_shipping_ecm`.`document`.`issuance`(`issuance_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_issuance_id` FOREIGN KEY (`issuance_id`) REFERENCES `transport_shipping_ecm`.`document`.`issuance`(`issuance_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_document_exception_id` FOREIGN KEY (`document_exception_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_exception`(`document_exception_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ADD CONSTRAINT `fk_freight_document_attachment_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`trade_document`(`trade_document_id`);

-- ========= freight --> finance (15 constraint(s)) =========
-- Requires: freight schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `transport_shipping_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ADD CONSTRAINT `fk_freight_cfs_operation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accrual`(`accrual_id`);

-- ========= freight --> fleet (16 constraint(s)) =========
-- Requires: freight schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ADD CONSTRAINT `fk_freight_cfs_operation_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);

-- ========= freight --> fulfillment (2 constraint(s)) =========
-- Requires: freight schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);

-- ========= freight --> network (16 constraint(s)) =========
-- Requires: freight schema, network schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_consolidation_nvocc_operator_carrier_id` FOREIGN KEY (`consolidation_nvocc_operator_carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ADD CONSTRAINT `fk_freight_shipment_agent_service_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);

-- ========= freight --> pricing (12 constraint(s)) =========
-- Requires: freight schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);

-- ========= freight --> route (11 constraint(s)) =========
-- Requires: freight schema, route schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_destination_node_network_node_id` FOREIGN KEY (`destination_node_network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_origin_node_network_node_id` FOREIGN KEY (`origin_node_network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_primary_freight_network_node_id` FOREIGN KEY (`primary_freight_network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);

-- ========= freight --> shipment (2 constraint(s)) =========
-- Requires: freight schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_freight_manifest_id` FOREIGN KEY (`freight_manifest_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`freight_manifest`(`freight_manifest_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= freight --> sustainability (16 constraint(s)) =========
-- Requires: freight schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_customer_carbon_report_id` FOREIGN KEY (`customer_carbon_report_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`customer_carbon_report`(`customer_carbon_report_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_green_shipment_certificate_id` FOREIGN KEY (`green_shipment_certificate_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate`(`green_shipment_certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_carbon_offset_transaction_id` FOREIGN KEY (`carbon_offset_transaction_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction`(`carbon_offset_transaction_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_green_shipment_certificate_id` FOREIGN KEY (`green_shipment_certificate_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate`(`green_shipment_certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_saf_procurement_id` FOREIGN KEY (`saf_procurement_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`saf_procurement`(`saf_procurement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_supplier_emissions_disclosure_id` FOREIGN KEY (`supplier_emissions_disclosure_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure`(`supplier_emissions_disclosure_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_carbon_offset_transaction_id` FOREIGN KEY (`carbon_offset_transaction_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction`(`carbon_offset_transaction_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_packaging_sustainability_id` FOREIGN KEY (`packaging_sustainability_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`packaging_sustainability`(`packaging_sustainability_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_carbon_offset_transaction_id` FOREIGN KEY (`carbon_offset_transaction_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction`(`carbon_offset_transaction_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ADD CONSTRAINT `fk_freight_carbon_allocation_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);

-- ========= freight --> warehouse (11 constraint(s)) =========
-- Requires: freight schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_origin_cfs_facility_id` FOREIGN KEY (`origin_cfs_facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ADD CONSTRAINT `fk_freight_cfs_operation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ADD CONSTRAINT `fk_freight_cfs_operation_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= freight --> workforce (12 constraint(s)) =========
-- Requires: freight schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_tertiary_load_planner_employee_id` FOREIGN KEY (`tertiary_load_planner_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ADD CONSTRAINT `fk_freight_cfs_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ADD CONSTRAINT `fk_freight_document_attachment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ADD CONSTRAINT `fk_freight_document_attachment_reviewed_by_user_employee_id` FOREIGN KEY (`reviewed_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ADD CONSTRAINT `fk_freight_carbon_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= fulfillment --> billing (9 constraint(s)) =========
-- Requires: fulfillment schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_cod_collection_id` FOREIGN KEY (`cod_collection_id`) REFERENCES `transport_shipping_ecm`.`billing`.`cod_collection`(`cod_collection_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_billing_invoice_line_id` FOREIGN KEY (`billing_invoice_line_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_invoice_line`(`billing_invoice_line_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_cod_collection_id` FOREIGN KEY (`cod_collection_id`) REFERENCES `transport_shipping_ecm`.`billing`.`cod_collection`(`cod_collection_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `transport_shipping_ecm`.`billing`.`credit_note`(`credit_note_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ADD CONSTRAINT `fk_fulfillment_delivery_confirmation_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `transport_shipping_ecm`.`billing`.`charge_event`(`charge_event_id`);

-- ========= fulfillment --> contract (9 constraint(s)) =========
-- Requires: fulfillment schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_contract_sla_commitment_id` FOREIGN KEY (`contract_sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_sla_commitment`(`contract_sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ADD CONSTRAINT `fk_fulfillment_merchant_carrier_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_allocation` ADD CONSTRAINT `fk_fulfillment_fulfillment_allocation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= fulfillment --> customer (9 constraint(s)) =========
-- Requires: fulfillment schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_ecommerce_seller_id` FOREIGN KEY (`ecommerce_seller_id`) REFERENCES `transport_shipping_ecm`.`customer`.`ecommerce_seller`(`ecommerce_seller_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_ecommerce_seller_id` FOREIGN KEY (`ecommerce_seller_id`) REFERENCES `transport_shipping_ecm`.`customer`.`ecommerce_seller`(`ecommerce_seller_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `transport_shipping_ecm`.`customer`.`service_case`(`service_case_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ADD CONSTRAINT `fk_fulfillment_consignee_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);

-- ========= fulfillment --> customs (9 constraint(s)) =========
-- Requires: fulfillment schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_dg_declaration_id` FOREIGN KEY (`dg_declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`dg_declaration`(`dg_declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_compliance_enrollment` ADD CONSTRAINT `fk_fulfillment_merchant_compliance_enrollment_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);

-- ========= fulfillment --> document (11 constraint(s)) =========
-- Requires: fulfillment schema, document schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_digital_signature_id` FOREIGN KEY (`digital_signature_id`) REFERENCES `transport_shipping_ecm`.`document`.`digital_signature`(`digital_signature_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_document_exception_id` FOREIGN KEY (`document_exception_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_exception`(`document_exception_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_document_exception_id` FOREIGN KEY (`document_exception_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_exception`(`document_exception_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ADD CONSTRAINT `fk_fulfillment_delivery_confirmation_digital_signature_id` FOREIGN KEY (`digital_signature_id`) REFERENCES `transport_shipping_ecm`.`document`.`digital_signature`(`digital_signature_id`);

-- ========= fulfillment --> finance (10 constraint(s)) =========
-- Requires: fulfillment schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_zone_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= fulfillment --> fleet (8 constraint(s)) =========
-- Requires: fulfillment schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ADD CONSTRAINT `fk_fulfillment_delivery_confirmation_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);

-- ========= fulfillment --> network (14 constraint(s)) =========
-- Requires: fulfillment schema, network schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_carrier_agreement` ADD CONSTRAINT `fk_fulfillment_merchant_carrier_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`service` ADD CONSTRAINT `fk_fulfillment_service_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);

-- ========= fulfillment --> pricing (6 constraint(s)) =========
-- Requires: fulfillment schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_service_level_rate_id` FOREIGN KEY (`service_level_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`service_level_rate`(`service_level_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_zone_lane_rate_zone_id` FOREIGN KEY (`lane_rate_zone_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`lane_rate_zone`(`lane_rate_zone_id`);

-- ========= fulfillment --> procurement (8 constraint(s)) =========
-- Requires: fulfillment schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= fulfillment --> route (11 constraint(s)) =========
-- Requires: fulfillment schema, route schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_zone_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);

-- ========= fulfillment --> safety (7 constraint(s)) =========
-- Requires: fulfillment schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_driver_safety_event_id` FOREIGN KEY (`driver_safety_event_id`) REFERENCES `transport_shipping_ecm`.`safety`.`driver_safety_event`(`driver_safety_event_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ADD CONSTRAINT `fk_fulfillment_fulfillment_program_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ADD CONSTRAINT `fk_fulfillment_merchant_safety_certification_safety_training_id` FOREIGN KEY (`safety_training_id`) REFERENCES `transport_shipping_ecm`.`safety`.`training`(`training_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ADD CONSTRAINT `fk_fulfillment_merchant_safety_certification_training_id` FOREIGN KEY (`training_id`) REFERENCES `transport_shipping_ecm`.`safety`.`training`(`training_id`);

-- ========= fulfillment --> shipment (6 constraint(s)) =========
-- Requires: fulfillment schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ADD CONSTRAINT `fk_fulfillment_delivery_confirmation_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= fulfillment --> warehouse (2 constraint(s)) =========
-- Requires: fulfillment schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_pick_task_id` FOREIGN KEY (`pick_task_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`pick_task`(`pick_task_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= fulfillment --> workforce (17 constraint(s)) =========
-- Requires: fulfillment schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_rma_received_by_employee_id` FOREIGN KEY (`rma_received_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`sla_breach` ADD CONSTRAINT `fk_fulfillment_sla_breach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_exception` ADD CONSTRAINT `fk_fulfillment_fulfillment_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_integration` ADD CONSTRAINT `fk_fulfillment_merchant_integration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_confirmation` ADD CONSTRAINT `fk_fulfillment_delivery_confirmation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_program_enrollment` ADD CONSTRAINT `fk_fulfillment_fulfillment_program_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant_safety_certification` ADD CONSTRAINT `fk_fulfillment_merchant_safety_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= network --> contract (4 constraint(s)) =========
-- Requires: network schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ADD CONSTRAINT `fk_network_partner_performance_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ADD CONSTRAINT `fk_network_capacity_allocation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ADD CONSTRAINT `fk_network_partner_onboarding_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ADD CONSTRAINT `fk_network_partner_tariff_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= network --> fleet (1 constraint(s)) =========
-- Requires: network schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ADD CONSTRAINT `fk_network_partner_incident_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`incident`(`incident_id`);

-- ========= network --> procurement (1 constraint(s)) =========
-- Requires: network schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ADD CONSTRAINT `fk_network_carrier_service_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= network --> route (2 constraint(s)) =========
-- Requires: network schema, route schema
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ADD CONSTRAINT `fk_network_capacity_allocation_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ADD CONSTRAINT `fk_network_blocked_space_agreement_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);

-- ========= network --> safety (3 constraint(s)) =========
-- Requires: network schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ADD CONSTRAINT `fk_network_network_event_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ADD CONSTRAINT `fk_network_partner_incident_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ADD CONSTRAINT `fk_network_partner_audit_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `transport_shipping_ecm`.`safety`.`audit`(`audit_id`);

-- ========= network --> shipment (1 constraint(s)) =========
-- Requires: network schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ADD CONSTRAINT `fk_network_interline_prorate_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= network --> sustainability (1 constraint(s)) =========
-- Requires: network schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ADD CONSTRAINT `fk_network_carrier_offset_participation_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);

-- ========= network --> warehouse (1 constraint(s)) =========
-- Requires: network schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ADD CONSTRAINT `fk_network_tpl_capability_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= network --> workforce (17 constraint(s)) =========
-- Requires: network schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ADD CONSTRAINT `fk_network_agent_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ADD CONSTRAINT `fk_network_interline_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ADD CONSTRAINT `fk_network_partner_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ADD CONSTRAINT `fk_network_capacity_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ADD CONSTRAINT `fk_network_network_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ADD CONSTRAINT `fk_network_partner_onboarding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ADD CONSTRAINT `fk_network_partner_onboarding_quaternary_partner_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_partner_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ADD CONSTRAINT `fk_network_partner_onboarding_tertiary_partner_approved_by_user_employee_id` FOREIGN KEY (`tertiary_partner_approved_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ADD CONSTRAINT `fk_network_partner_tariff_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ADD CONSTRAINT `fk_network_partner_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ADD CONSTRAINT `fk_network_partner_sla_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ADD CONSTRAINT `fk_network_partner_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ADD CONSTRAINT `fk_network_partner_incident_tertiary_partner_assigned_to_user_employee_id` FOREIGN KEY (`tertiary_partner_assigned_to_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ADD CONSTRAINT `fk_network_edi_connection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ADD CONSTRAINT `fk_network_partner_tier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ADD CONSTRAINT `fk_network_gsa_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ADD CONSTRAINT `fk_network_partner_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= pricing --> billing (2 constraint(s)) =========
-- Requires: pricing schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);

-- ========= pricing --> contract (13 constraint(s)) =========
-- Requires: pricing schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ADD CONSTRAINT `fk_pricing_dim_weight_rule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_agreement_version_id` FOREIGN KEY (`agreement_version_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement_version`(`agreement_version_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_compliance_review_id` FOREIGN KEY (`compliance_review_id`) REFERENCES `transport_shipping_ecm`.`contract`.`compliance_review`(`compliance_review_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ADD CONSTRAINT `fk_pricing_rate_request_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ADD CONSTRAINT `fk_pricing_rate_request_contract_dispute_id` FOREIGN KEY (`contract_dispute_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_dispute`(`contract_dispute_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ADD CONSTRAINT `fk_pricing_gri_announcement_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ADD CONSTRAINT `fk_pricing_pricing_volume_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ADD CONSTRAINT `fk_pricing_pricing_volume_commitment_contract_volume_commitment_id` FOREIGN KEY (`contract_volume_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_volume_commitment`(`contract_volume_commitment_id`);

-- ========= pricing --> customer (7 constraint(s)) =========
-- Requires: pricing schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ADD CONSTRAINT `fk_pricing_rate_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ADD CONSTRAINT `fk_pricing_pricing_volume_commitment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ADD CONSTRAINT `fk_pricing_rate_card_assignment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= pricing --> document (5 constraint(s)) =========
-- Requires: pricing schema, document schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`trade_document`(`trade_document_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ADD CONSTRAINT `fk_pricing_gri_announcement_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);

-- ========= pricing --> finance (10 constraint(s)) =========
-- Requires: pricing schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ADD CONSTRAINT `fk_pricing_gri_announcement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ADD CONSTRAINT `fk_pricing_pricing_volume_commitment_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `transport_shipping_ecm`.`finance`.`budget`(`budget_id`);

-- ========= pricing --> fulfillment (1 constraint(s)) =========
-- Requires: pricing schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);

-- ========= pricing --> network (26 constraint(s)) =========
-- Requires: pricing schema, network schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ADD CONSTRAINT `fk_pricing_rate_line_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ADD CONSTRAINT `fk_pricing_surcharge_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ADD CONSTRAINT `fk_pricing_fuel_index_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ADD CONSTRAINT `fk_pricing_accessorial_charge_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ADD CONSTRAINT `fk_pricing_dim_weight_rule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ADD CONSTRAINT `fk_pricing_spot_quote_line_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ADD CONSTRAINT `fk_pricing_rate_request_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ADD CONSTRAINT `fk_pricing_rate_request_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ADD CONSTRAINT `fk_pricing_gri_announcement_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ADD CONSTRAINT `fk_pricing_gri_announcement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ADD CONSTRAINT `fk_pricing_service_level_rate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ADD CONSTRAINT `fk_pricing_service_level_rate_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ADD CONSTRAINT `fk_pricing_pricing_volume_commitment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ADD CONSTRAINT `fk_pricing_pricing_volume_commitment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);

-- ========= pricing --> route (18 constraint(s)) =========
-- Requires: pricing schema, route schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ADD CONSTRAINT `fk_pricing_rate_line_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ADD CONSTRAINT `fk_pricing_rate_line_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ADD CONSTRAINT `fk_pricing_lane_rate_zone_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ADD CONSTRAINT `fk_pricing_rate_request_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ADD CONSTRAINT `fk_pricing_gri_announcement_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ADD CONSTRAINT `fk_pricing_service_level_rate_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ADD CONSTRAINT `fk_pricing_service_level_rate_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);

-- ========= pricing --> safety (3 constraint(s)) =========
-- Requires: pricing schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_dg_incident_id` FOREIGN KEY (`dg_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_incident`(`dg_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ADD CONSTRAINT `fk_pricing_gri_announcement_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`environmental_incident`(`environmental_incident_id`);

-- ========= pricing --> sustainability (14 constraint(s)) =========
-- Requires: pricing schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ADD CONSTRAINT `fk_pricing_rate_line_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ADD CONSTRAINT `fk_pricing_fuel_index_fuel_consumption_record_id` FOREIGN KEY (`fuel_consumption_record_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record`(`fuel_consumption_record_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ADD CONSTRAINT `fk_pricing_accessorial_charge_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ADD CONSTRAINT `fk_pricing_dim_weight_rule_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ADD CONSTRAINT `fk_pricing_spot_quote_line_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_carbon_offset_transaction_id` FOREIGN KEY (`carbon_offset_transaction_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction`(`carbon_offset_transaction_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ADD CONSTRAINT `fk_pricing_gri_announcement_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ADD CONSTRAINT `fk_pricing_service_level_rate_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ADD CONSTRAINT `fk_pricing_pricing_volume_commitment_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ADD CONSTRAINT `fk_pricing_rate_sustainability_contribution_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);

-- ========= pricing --> workforce (22 constraint(s)) =========
-- Requires: pricing schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ADD CONSTRAINT `fk_pricing_rate_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_tertiary_pricing_modified_by_user_employee_id` FOREIGN KEY (`tertiary_pricing_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ADD CONSTRAINT `fk_pricing_fuel_index_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ADD CONSTRAINT `fk_pricing_accessorial_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ADD CONSTRAINT `fk_pricing_dim_weight_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ADD CONSTRAINT `fk_pricing_spot_quote_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ADD CONSTRAINT `fk_pricing_rate_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ADD CONSTRAINT `fk_pricing_incoterms_charge_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ADD CONSTRAINT `fk_pricing_lane_rate_zone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ADD CONSTRAINT `fk_pricing_rate_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ADD CONSTRAINT `fk_pricing_gri_announcement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ADD CONSTRAINT `fk_pricing_commodity_rate_class_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ADD CONSTRAINT `fk_pricing_charge_code_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ADD CONSTRAINT `fk_pricing_service_level_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ADD CONSTRAINT `fk_pricing_pricing_volume_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ADD CONSTRAINT `fk_pricing_rate_card_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> billing (2 constraint(s)) =========
-- Requires: procurement schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ADD CONSTRAINT `fk_procurement_supplier_performance_freight_audit_id` FOREIGN KEY (`freight_audit_id`) REFERENCES `transport_shipping_ecm`.`billing`.`freight_audit`(`freight_audit_id`);

-- ========= procurement --> contract (2 constraint(s)) =========
-- Requires: procurement schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_contract_approval_workflow_id` FOREIGN KEY (`contract_approval_workflow_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_approval_workflow`(`contract_approval_workflow_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_contract_approval_workflow_id` FOREIGN KEY (`contract_approval_workflow_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_approval_workflow`(`contract_approval_workflow_id`);

-- ========= procurement --> customs (5 constraint(s)) =========
-- Requires: procurement schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_duty_assessment_id` FOREIGN KEY (`duty_assessment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`duty_assessment`(`duty_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);

-- ========= procurement --> document (6 constraint(s)) =========
-- Requires: procurement schema, document schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ADD CONSTRAINT `fk_procurement_rate_agreement_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_rule` ADD CONSTRAINT `fk_procurement_approval_rule_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ADD CONSTRAINT `fk_procurement_approval_session_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`trade_document`(`trade_document_id`);

-- ========= procurement --> finance (22 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ADD CONSTRAINT `fk_procurement_blanket_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ADD CONSTRAINT `fk_procurement_blanket_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ADD CONSTRAINT `fk_procurement_rate_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ADD CONSTRAINT `fk_procurement_rate_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ADD CONSTRAINT `fk_procurement_rate_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ADD CONSTRAINT `fk_procurement_supplier_performance_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= procurement --> freight (2 constraint(s)) =========
-- Requires: procurement schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= procurement --> network (11 constraint(s)) =========
-- Requires: procurement schema, network schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ADD CONSTRAINT `fk_procurement_blanket_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ADD CONSTRAINT `fk_procurement_rate_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ADD CONSTRAINT `fk_procurement_supplier_performance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ADD CONSTRAINT `fk_procurement_contracted_service_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);

-- ========= procurement --> safety (9 constraint(s)) =========
-- Requires: procurement schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `transport_shipping_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_dg_certification_id` FOREIGN KEY (`dg_certification_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_certification`(`dg_certification_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `transport_shipping_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_facility_inspection_id` FOREIGN KEY (`facility_inspection_id`) REFERENCES `transport_shipping_ecm`.`safety`.`facility_inspection`(`facility_inspection_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ADD CONSTRAINT `fk_procurement_rate_agreement_driver_safety_program_id` FOREIGN KEY (`driver_safety_program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`driver_safety_program`(`driver_safety_program_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ADD CONSTRAINT `fk_procurement_supplier_performance_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);

-- ========= procurement --> shipment (1 constraint(s)) =========
-- Requires: procurement schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= procurement --> sustainability (7 constraint(s)) =========
-- Requires: procurement schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_supplier_emissions_disclosure_id` FOREIGN KEY (`supplier_emissions_disclosure_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure`(`supplier_emissions_disclosure_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ADD CONSTRAINT `fk_procurement_rate_agreement_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ADD CONSTRAINT `fk_procurement_supplier_performance_supplier_emissions_disclosure_id` FOREIGN KEY (`supplier_emissions_disclosure_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure`(`supplier_emissions_disclosure_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ADD CONSTRAINT `fk_procurement_carbon_offset_procurement_agreement_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ADD CONSTRAINT `fk_procurement_contract_sustainability_contribution_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);

-- ========= procurement --> warehouse (7 constraint(s)) =========
-- Requires: procurement schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_material_id` FOREIGN KEY (`material_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`material`(`material_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ADD CONSTRAINT `fk_procurement_blanket_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= procurement --> workforce (42 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_primary_rfq_employee_id` FOREIGN KEY (`primary_rfq_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_rfq_buyer_employee_id` FOREIGN KEY (`rfq_buyer_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_rfq_employee_id` FOREIGN KEY (`rfq_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_primary_goods_receiver_employee_id` FOREIGN KEY (`primary_goods_receiver_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_location_id` FOREIGN KEY (`location_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_tertiary_supplier_modified_by_user_employee_id` FOREIGN KEY (`tertiary_supplier_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_location_id` FOREIGN KEY (`location_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_quaternary_purchase_last_modified_by_employee_id` FOREIGN KEY (`quaternary_purchase_last_modified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_requestor_employee_id` FOREIGN KEY (`requestor_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_tertiary_purchase_final_approver_employee_id` FOREIGN KEY (`tertiary_purchase_final_approver_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ADD CONSTRAINT `fk_procurement_blanket_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ADD CONSTRAINT `fk_procurement_rate_agreement_position_id` FOREIGN KEY (`position_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ADD CONSTRAINT `fk_procurement_rate_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ADD CONSTRAINT `fk_procurement_supplier_performance_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_position_id` FOREIGN KEY (`position_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_procurement_contract_employee_id` FOREIGN KEY (`procurement_contract_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ADD CONSTRAINT `fk_procurement_procurement_approval_workflow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ADD CONSTRAINT `fk_procurement_procurement_approval_workflow_primary_procurement_delegated_to_employee_id` FOREIGN KEY (`primary_procurement_delegated_to_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ADD CONSTRAINT `fk_procurement_procurement_approval_workflow_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ADD CONSTRAINT `fk_procurement_approval_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= route --> billing (1 constraint(s)) =========
-- Requires: route schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_billing_invoice_line_id` FOREIGN KEY (`billing_invoice_line_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_invoice_line`(`billing_invoice_line_id`);

-- ========= route --> contract (2 constraint(s)) =========
-- Requires: route schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`route`.`lane` ADD CONSTRAINT `fk_route_lane_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_schedule` ADD CONSTRAINT `fk_route_carrier_schedule_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);

-- ========= route --> customs (4 constraint(s)) =========
-- Requires: route schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_compliance_certification` ADD CONSTRAINT `fk_route_lane_compliance_certification_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);

-- ========= route --> document (6 constraint(s)) =========
-- Requires: route schema, document schema
ALTER TABLE `transport_shipping_ecm`.`route`.`lane` ADD CONSTRAINT `fk_route_lane_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`service_corridor` ADD CONSTRAINT `fk_route_service_corridor_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan` ADD CONSTRAINT `fk_route_plan_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);

-- ========= route --> finance (15 constraint(s)) =========
-- Requires: route schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`route`.`lane` ADD CONSTRAINT `fk_route_lane_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane` ADD CONSTRAINT `fk_route_lane_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`network_node` ADD CONSTRAINT `fk_route_network_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`network_node` ADD CONSTRAINT `fk_route_network_node_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`service_corridor` ADD CONSTRAINT `fk_route_service_corridor_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_lane_allocation` ADD CONSTRAINT `fk_route_carrier_lane_allocation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `transport_shipping_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan` ADD CONSTRAINT `fk_route_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan` ADD CONSTRAINT `fk_route_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`network_optimization_run` ADD CONSTRAINT `fk_route_network_optimization_run_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `transport_shipping_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`optimization_recommendation` ADD CONSTRAINT `fk_route_optimization_recommendation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `transport_shipping_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_performance` ADD CONSTRAINT `fk_route_lane_performance_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `transport_shipping_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_budget_allocation` ADD CONSTRAINT `fk_route_lane_budget_allocation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `transport_shipping_ecm`.`finance`.`budget`(`budget_id`);

-- ========= route --> fleet (13 constraint(s)) =========
-- Requires: route schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`route`.`route_delivery_zone` ADD CONSTRAINT `fk_route_route_delivery_zone_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_vehicle_transport_asset_id` FOREIGN KEY (`vehicle_transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_geofence_zone_id` FOREIGN KEY (`geofence_zone_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`geofence_zone`(`geofence_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`optimization_recommendation` ADD CONSTRAINT `fk_route_optimization_recommendation_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`hub_spoke_config` ADD CONSTRAINT `fk_route_hub_spoke_config_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_qualification` ADD CONSTRAINT `fk_route_lane_qualification_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);

-- ========= route --> freight (3 constraint(s)) =========
-- Requires: route schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`route`.`plan` ADD CONSTRAINT `fk_route_plan_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= route --> fulfillment (1 constraint(s)) =========
-- Requires: route schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_fulfillment_allocation` ADD CONSTRAINT `fk_route_lane_fulfillment_allocation_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);

-- ========= route --> network (26 constraint(s)) =========
-- Requires: route schema, network schema
ALTER TABLE `transport_shipping_ecm`.`route`.`lane` ADD CONSTRAINT `fk_route_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane` ADD CONSTRAINT `fk_route_lane_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane` ADD CONSTRAINT `fk_route_lane_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`network_node` ADD CONSTRAINT `fk_route_network_node_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`corridor_leg` ADD CONSTRAINT `fk_route_corridor_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_delivery_zone` ADD CONSTRAINT `fk_route_route_delivery_zone_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`transit_time_standard` ADD CONSTRAINT `fk_route_transit_time_standard_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`transit_time_standard` ADD CONSTRAINT `fk_route_transit_time_standard_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_lane_allocation` ADD CONSTRAINT `fk_route_carrier_lane_allocation_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_lane_allocation` ADD CONSTRAINT `fk_route_carrier_lane_allocation_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan` ADD CONSTRAINT `fk_route_plan_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`optimization_recommendation` ADD CONSTRAINT `fk_route_optimization_recommendation_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`optimization_recommendation` ADD CONSTRAINT `fk_route_optimization_recommendation_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`optimization_recommendation` ADD CONSTRAINT `fk_route_optimization_recommendation_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`hub_spoke_config` ADD CONSTRAINT `fk_route_hub_spoke_config_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`hub_spoke_config` ADD CONSTRAINT `fk_route_hub_spoke_config_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_performance` ADD CONSTRAINT `fk_route_lane_performance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_performance` ADD CONSTRAINT `fk_route_lane_performance_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_schedule` ADD CONSTRAINT `fk_route_carrier_schedule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_schedule` ADD CONSTRAINT `fk_route_carrier_schedule_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);

-- ========= route --> pricing (12 constraint(s)) =========
-- Requires: route schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`route`.`transit_time_standard` ADD CONSTRAINT `fk_route_transit_time_standard_service_level_rate_id` FOREIGN KEY (`service_level_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`service_level_rate`(`service_level_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_lane_allocation` ADD CONSTRAINT `fk_route_carrier_lane_allocation_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_lane_allocation` ADD CONSTRAINT `fk_route_carrier_lane_allocation_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan` ADD CONSTRAINT `fk_route_plan_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`optimization_recommendation` ADD CONSTRAINT `fk_route_optimization_recommendation_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`optimization_recommendation` ADD CONSTRAINT `fk_route_optimization_recommendation_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_performance` ADD CONSTRAINT `fk_route_lane_performance_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_schedule` ADD CONSTRAINT `fk_route_carrier_schedule_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_surcharge_application` ADD CONSTRAINT `fk_route_lane_surcharge_application_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`surcharge`(`surcharge_id`);

-- ========= route --> safety (7 constraint(s)) =========
-- Requires: route schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`route`.`optimization_recommendation` ADD CONSTRAINT `fk_route_optimization_recommendation_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `transport_shipping_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_driver_safety_event_id` FOREIGN KEY (`driver_safety_event_id`) REFERENCES `transport_shipping_ecm`.`safety`.`driver_safety_event`(`driver_safety_event_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`environmental_incident`(`environmental_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`schedule_dg_requirement` ADD CONSTRAINT `fk_route_schedule_dg_requirement_dg_certification_id` FOREIGN KEY (`dg_certification_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_certification`(`dg_certification_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_safety_program_requirement` ADD CONSTRAINT `fk_route_lane_safety_program_requirement_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_safety_program_requirement` ADD CONSTRAINT `fk_route_lane_safety_program_requirement_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);

-- ========= route --> shipment (5 constraint(s)) =========
-- Requires: route schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`route`.`plan` ADD CONSTRAINT `fk_route_plan_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= route --> sustainability (7 constraint(s)) =========
-- Requires: route schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`route`.`lane` ADD CONSTRAINT `fk_route_lane_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`service_corridor` ADD CONSTRAINT `fk_route_service_corridor_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`network_optimization_run` ADD CONSTRAINT `fk_route_network_optimization_run_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`optimization_recommendation` ADD CONSTRAINT `fk_route_optimization_recommendation_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_performance` ADD CONSTRAINT `fk_route_lane_performance_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_schedule` ADD CONSTRAINT `fk_route_carrier_schedule_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);

-- ========= route --> warehouse (1 constraint(s)) =========
-- Requires: route schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_facility_service` ADD CONSTRAINT `fk_route_lane_facility_service_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= route --> workforce (12 constraint(s)) =========
-- Requires: route schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`route`.`network_node` ADD CONSTRAINT `fk_route_network_node_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan` ADD CONSTRAINT `fk_route_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`network_optimization_run` ADD CONSTRAINT `fk_route_network_optimization_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`optimization_recommendation` ADD CONSTRAINT `fk_route_optimization_recommendation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`hub_spoke_config` ADD CONSTRAINT `fk_route_hub_spoke_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_performance` ADD CONSTRAINT `fk_route_lane_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`route_exception` ADD CONSTRAINT `fk_route_route_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_schedule` ADD CONSTRAINT `fk_route_carrier_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_assignment` ADD CONSTRAINT `fk_route_lane_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_budget_allocation` ADD CONSTRAINT `fk_route_lane_budget_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_safety_program_requirement` ADD CONSTRAINT `fk_route_lane_safety_program_requirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= safety --> document (13 constraint(s)) =========
-- Requires: safety schema, document schema
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ADD CONSTRAINT `fk_safety_facility_inspection_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ADD CONSTRAINT `fk_safety_dg_certification_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ADD CONSTRAINT `fk_safety_regulatory_notification_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ADD CONSTRAINT `fk_safety_permit_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ADD CONSTRAINT `fk_safety_occupational_health_case_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ADD CONSTRAINT `fk_safety_contractor_safety_prequal_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);

-- ========= safety --> fleet (11 constraint(s)) =========
-- Requires: safety schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_telematics_event_id` FOREIGN KEY (`telematics_event_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`telematics_event`(`telematics_event_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ADD CONSTRAINT `fk_safety_regulatory_notification_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`incident`(`incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ADD CONSTRAINT `fk_safety_regulatory_notification_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ADD CONSTRAINT `fk_safety_occupational_health_case_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`incident`(`incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ADD CONSTRAINT `fk_safety_fatigue_risk_assessment_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);

-- ========= safety --> freight (17 constraint(s)) =========
-- Requires: safety schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_cfs_operation_id` FOREIGN KEY (`cfs_operation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cfs_operation`(`cfs_operation_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_intermodal_transfer_id` FOREIGN KEY (`intermodal_transfer_id`) REFERENCES `transport_shipping_ecm`.`freight`.`intermodal_transfer`(`intermodal_transfer_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_cfs_operation_id` FOREIGN KEY (`cfs_operation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cfs_operation`(`cfs_operation_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_cfs_operation_id` FOREIGN KEY (`cfs_operation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cfs_operation`(`cfs_operation_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_intermodal_transfer_id` FOREIGN KEY (`intermodal_transfer_id`) REFERENCES `transport_shipping_ecm`.`freight`.`intermodal_transfer`(`intermodal_transfer_id`);

-- ========= safety --> network (12 constraint(s)) =========
-- Requires: safety schema, network schema
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ADD CONSTRAINT `fk_safety_safety_audit_finding_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ADD CONSTRAINT `fk_safety_safety_training_completion_training_provider_id` FOREIGN KEY (`training_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`training_provider`(`training_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ADD CONSTRAINT `fk_safety_contractor_safety_prequal_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `transport_shipping_ecm`.`network`.`contractor`(`contractor_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ADD CONSTRAINT `fk_safety_contractor_safety_prequal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ADD CONSTRAINT `fk_safety_hub_emergency_plan_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);

-- ========= safety --> route (10 constraint(s)) =========
-- Requires: safety schema, route schema
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_corridor_leg_id` FOREIGN KEY (`corridor_leg_id`) REFERENCES `transport_shipping_ecm`.`route`.`corridor_leg`(`corridor_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ADD CONSTRAINT `fk_safety_facility_inspection_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_plan_leg_id` FOREIGN KEY (`plan_leg_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan_leg`(`plan_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ADD CONSTRAINT `fk_safety_emergency_response_plan_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ADD CONSTRAINT `fk_safety_fatigue_risk_assessment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);

-- ========= safety --> shipment (17 constraint(s)) =========
-- Requires: safety schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ADD CONSTRAINT `fk_safety_regulatory_notification_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ADD CONSTRAINT `fk_safety_permit_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ADD CONSTRAINT `fk_safety_occupational_health_case_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ADD CONSTRAINT `fk_safety_fatigue_risk_assessment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ADD CONSTRAINT `fk_safety_fatigue_risk_assessment_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);

-- ========= safety --> sustainability (5 constraint(s)) =========
-- Requires: safety schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);

-- ========= safety --> warehouse (21 constraint(s)) =========
-- Requires: safety schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ADD CONSTRAINT `fk_safety_osha_recordable_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ADD CONSTRAINT `fk_safety_safety_audit_finding_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ADD CONSTRAINT `fk_safety_facility_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ADD CONSTRAINT `fk_safety_safety_training_completion_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ADD CONSTRAINT `fk_safety_emergency_response_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ADD CONSTRAINT `fk_safety_ppe_issuance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ADD CONSTRAINT `fk_safety_regulatory_notification_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ADD CONSTRAINT `fk_safety_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ADD CONSTRAINT `fk_safety_occupational_health_case_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ADD CONSTRAINT `fk_safety_fatigue_risk_assessment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ADD CONSTRAINT `fk_safety_hse_legal_register_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= safety --> workforce (51 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_quaternary_corrective_last_modified_by_employee_id` FOREIGN KEY (`quaternary_corrective_last_modified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_tertiary_corrective_created_by_employee_id` FOREIGN KEY (`tertiary_corrective_created_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ADD CONSTRAINT `fk_safety_osha_recordable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ADD CONSTRAINT `fk_safety_safety_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ADD CONSTRAINT `fk_safety_safety_audit_finding_quaternary_safety_modified_by_employee_id` FOREIGN KEY (`quaternary_safety_modified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ADD CONSTRAINT `fk_safety_safety_audit_finding_tertiary_safety_verified_by_employee_id` FOREIGN KEY (`tertiary_safety_verified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ADD CONSTRAINT `fk_safety_facility_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ADD CONSTRAINT `fk_safety_dg_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ADD CONSTRAINT `fk_safety_dg_certification_holder_employee_id` FOREIGN KEY (`holder_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ADD CONSTRAINT `fk_safety_dg_certification_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ADD CONSTRAINT `fk_safety_safety_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ADD CONSTRAINT `fk_safety_safety_training_completion_tertiary_safety_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_safety_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_tertiary_emergency_modified_by_user_employee_id` FOREIGN KEY (`tertiary_emergency_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_tertiary_hazard_modified_by_employee_id` FOREIGN KEY (`tertiary_hazard_modified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ADD CONSTRAINT `fk_safety_ppe_issuance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_observation_modified_by_employee_id` FOREIGN KEY (`observation_modified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_observation_observer_employee_id` FOREIGN KEY (`observation_observer_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_observation_verified_by_employee_id` FOREIGN KEY (`observation_verified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ADD CONSTRAINT `fk_safety_regulatory_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ADD CONSTRAINT `fk_safety_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ADD CONSTRAINT `fk_safety_permit_permit_closed_by_employee_id` FOREIGN KEY (`permit_closed_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ADD CONSTRAINT `fk_safety_permit_permit_employee_id` FOREIGN KEY (`permit_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ADD CONSTRAINT `fk_safety_permit_permit_holder_employee_id` FOREIGN KEY (`permit_holder_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ADD CONSTRAINT `fk_safety_occupational_health_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ADD CONSTRAINT `fk_safety_occupational_health_case_tertiary_occupational_modified_by_user_employee_id` FOREIGN KEY (`tertiary_occupational_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ADD CONSTRAINT `fk_safety_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ADD CONSTRAINT `fk_safety_program_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ADD CONSTRAINT `fk_safety_program_program_employee_id` FOREIGN KEY (`program_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ADD CONSTRAINT `fk_safety_program_program_modified_by_employee_id` FOREIGN KEY (`program_modified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ADD CONSTRAINT `fk_safety_contractor_safety_prequal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_alert_issuing_employee_id` FOREIGN KEY (`alert_issuing_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_alert_modified_by_employee_id` FOREIGN KEY (`alert_modified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ADD CONSTRAINT `fk_safety_fatigue_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ADD CONSTRAINT `fk_safety_fatigue_risk_assessment_tertiary_fatigue_assessor_employee_id` FOREIGN KEY (`tertiary_fatigue_assessor_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ADD CONSTRAINT `fk_safety_hse_legal_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ADD CONSTRAINT `fk_safety_hse_legal_register_quaternary_hse_responsible_owner_employee_id` FOREIGN KEY (`quaternary_hse_responsible_owner_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ADD CONSTRAINT `fk_safety_hse_legal_register_tertiary_hse_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_hse_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ADD CONSTRAINT `fk_safety_program_training_requirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ADD CONSTRAINT `fk_safety_program_training_requirement_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= shipment --> billing (3 constraint(s)) =========
-- Requires: shipment schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ADD CONSTRAINT `fk_shipment_consignment_accessorial_application_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ADD CONSTRAINT `fk_shipment_consignment_accessorial_application_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= shipment --> claim (2 constraint(s)) =========
-- Requires: shipment schema, claim schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);

-- ========= shipment --> contract (5 constraint(s)) =========
-- Requires: shipment schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_contract_sla_commitment_id` FOREIGN KEY (`contract_sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_sla_commitment`(`contract_sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ADD CONSTRAINT `fk_shipment_shipment_sla_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= shipment --> customer (7 constraint(s)) =========
-- Requires: shipment schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ADD CONSTRAINT `fk_shipment_delivery_instruction_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ADD CONSTRAINT `fk_shipment_return_shipment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ADD CONSTRAINT `fk_shipment_return_shipment_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ADD CONSTRAINT `fk_shipment_shipment_sla_commitment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= shipment --> customs (3 constraint(s)) =========
-- Requires: shipment schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_duty_assessment_id` FOREIGN KEY (`duty_assessment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`duty_assessment`(`duty_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ADD CONSTRAINT `fk_shipment_shipment_asn_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);

-- ========= shipment --> document (5 constraint(s)) =========
-- Requires: shipment schema, document schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ADD CONSTRAINT `fk_shipment_return_shipment_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ADD CONSTRAINT `fk_shipment_temperature_log_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);

-- ========= shipment --> finance (9 constraint(s)) =========
-- Requires: shipment schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ADD CONSTRAINT `fk_shipment_return_shipment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= shipment --> fleet (7 constraint(s)) =========
-- Requires: shipment schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ADD CONSTRAINT `fk_shipment_shipment_driver_assignment_fleet_driver_assignment_id` FOREIGN KEY (`fleet_driver_assignment_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment`(`fleet_driver_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ADD CONSTRAINT `fk_shipment_shipment_driver_assignment_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ADD CONSTRAINT `fk_shipment_shipment_driver_assignment_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);

-- ========= shipment --> freight (3 constraint(s)) =========
-- Requires: shipment schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_consolidation_entry` ADD CONSTRAINT `fk_shipment_consignment_consolidation_entry_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);

-- ========= shipment --> fulfillment (4 constraint(s)) =========
-- Requires: shipment schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ADD CONSTRAINT `fk_shipment_return_shipment_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ADD CONSTRAINT `fk_shipment_return_shipment_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ADD CONSTRAINT `fk_shipment_shipment_asn_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);

-- ========= shipment --> network (12 constraint(s)) =========
-- Requires: shipment schema, network schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ADD CONSTRAINT `fk_shipment_return_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ADD CONSTRAINT `fk_shipment_shipment_asn_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ADD CONSTRAINT `fk_shipment_transit_hub_event_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);

-- ========= shipment --> pricing (5 constraint(s)) =========
-- Requires: shipment schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ADD CONSTRAINT `fk_shipment_shipment_sla_commitment_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_sla_commitment` ADD CONSTRAINT `fk_shipment_shipment_sla_commitment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_accessorial_application` ADD CONSTRAINT `fk_shipment_consignment_accessorial_application_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);

-- ========= shipment --> procurement (4 constraint(s)) =========
-- Requires: shipment schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_rate_agreement_id` FOREIGN KEY (`rate_agreement_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rate_agreement`(`rate_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ADD CONSTRAINT `fk_shipment_shipment_asn_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`manifest_supplier_pickup` ADD CONSTRAINT `fk_shipment_manifest_supplier_pickup_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= shipment --> route (4 constraint(s)) =========
-- Requires: shipment schema, route schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ADD CONSTRAINT `fk_shipment_shipment_asn_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ADD CONSTRAINT `fk_shipment_transit_hub_event_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_driver_assignment` ADD CONSTRAINT `fk_shipment_shipment_driver_assignment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);

-- ========= shipment --> sustainability (1 constraint(s)) =========
-- Requires: shipment schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_offset_allocation` ADD CONSTRAINT `fk_shipment_consignment_offset_allocation_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);

-- ========= shipment --> warehouse (2 constraint(s)) =========
-- Requires: shipment schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ADD CONSTRAINT `fk_shipment_shipment_asn_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= shipment --> workforce (14 constraint(s)) =========
-- Requires: shipment schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_pod_verified_by_employee_id` FOREIGN KEY (`pod_verified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`return_shipment` ADD CONSTRAINT `fk_shipment_return_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_asn` ADD CONSTRAINT `fk_shipment_shipment_asn_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`transit_hub_event` ADD CONSTRAINT `fk_shipment_transit_hub_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`temperature_log` ADD CONSTRAINT `fk_shipment_temperature_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sustainability --> contract (1 constraint(s)) =========
-- Requires: sustainability schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ADD CONSTRAINT `fk_sustainability_saf_procurement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= sustainability --> customer (4 constraint(s)) =========
-- Requires: sustainability schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ADD CONSTRAINT `fk_sustainability_carbon_offset_transaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ADD CONSTRAINT `fk_sustainability_green_shipment_certificate_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ADD CONSTRAINT `fk_sustainability_packaging_sustainability_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ADD CONSTRAINT `fk_sustainability_customer_carbon_report_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= sustainability --> document (9 constraint(s)) =========
-- Requires: sustainability schema, document schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ADD CONSTRAINT `fk_sustainability_shipment_carbon_footprint_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ADD CONSTRAINT `fk_sustainability_carbon_offset_transaction_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ADD CONSTRAINT `fk_sustainability_fuel_consumption_record_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ADD CONSTRAINT `fk_sustainability_corsia_compliance_record_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ADD CONSTRAINT `fk_sustainability_green_shipment_certificate_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ADD CONSTRAINT `fk_sustainability_saf_procurement_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ADD CONSTRAINT `fk_sustainability_supplier_emissions_disclosure_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ADD CONSTRAINT `fk_sustainability_customer_carbon_report_document_package_id` FOREIGN KEY (`document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);

-- ========= sustainability --> finance (15 constraint(s)) =========
-- Requires: sustainability schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ADD CONSTRAINT `fk_sustainability_shipment_carbon_footprint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ADD CONSTRAINT `fk_sustainability_shipment_carbon_footprint_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ADD CONSTRAINT `fk_sustainability_carbon_offset_transaction_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ADD CONSTRAINT `fk_sustainability_carbon_offset_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ADD CONSTRAINT `fk_sustainability_carbon_offset_transaction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ADD CONSTRAINT `fk_sustainability_fuel_consumption_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ADD CONSTRAINT `fk_sustainability_ghg_inventory_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ADD CONSTRAINT `fk_sustainability_saf_procurement_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `transport_shipping_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ADD CONSTRAINT `fk_sustainability_saf_procurement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ADD CONSTRAINT `fk_sustainability_energy_consumption_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ADD CONSTRAINT `fk_sustainability_supplier_emissions_disclosure_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ADD CONSTRAINT `fk_sustainability_customer_carbon_report_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= sustainability --> fleet (3 constraint(s)) =========
-- Requires: sustainability schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ADD CONSTRAINT `fk_sustainability_fuel_consumption_record_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ADD CONSTRAINT `fk_sustainability_fuel_consumption_record_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ADD CONSTRAINT `fk_sustainability_energy_consumption_record_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);

-- ========= sustainability --> freight (1 constraint(s)) =========
-- Requires: sustainability schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ADD CONSTRAINT `fk_sustainability_fuel_consumption_record_freight_leg_id` FOREIGN KEY (`freight_leg_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_leg`(`freight_leg_id`);

-- ========= sustainability --> fulfillment (7 constraint(s)) =========
-- Requires: sustainability schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ADD CONSTRAINT `fk_sustainability_shipment_carbon_footprint_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ADD CONSTRAINT `fk_sustainability_shipment_carbon_footprint_parcel_manifest_id` FOREIGN KEY (`parcel_manifest_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel_manifest`(`parcel_manifest_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ADD CONSTRAINT `fk_sustainability_fuel_consumption_record_dispatch_run_id` FOREIGN KEY (`dispatch_run_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`dispatch_run`(`dispatch_run_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ADD CONSTRAINT `fk_sustainability_fuel_consumption_record_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ADD CONSTRAINT `fk_sustainability_green_shipment_certificate_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ADD CONSTRAINT `fk_sustainability_packaging_sustainability_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ADD CONSTRAINT `fk_sustainability_customer_carbon_report_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= sustainability --> network (7 constraint(s)) =========
-- Requires: sustainability schema, network schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ADD CONSTRAINT `fk_sustainability_shipment_carbon_footprint_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ADD CONSTRAINT `fk_sustainability_corsia_compliance_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ADD CONSTRAINT `fk_sustainability_saf_procurement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ADD CONSTRAINT `fk_sustainability_renewable_energy_certificate_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ADD CONSTRAINT `fk_sustainability_supplier_emissions_disclosure_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ADD CONSTRAINT `fk_sustainability_water_consumption_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);

-- ========= sustainability --> procurement (4 constraint(s)) =========
-- Requires: sustainability schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ADD CONSTRAINT `fk_sustainability_saf_procurement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ADD CONSTRAINT `fk_sustainability_supplier_emissions_disclosure_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ADD CONSTRAINT `fk_sustainability_packaging_sustainability_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= sustainability --> safety (3 constraint(s)) =========
-- Requires: sustainability schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ADD CONSTRAINT `fk_sustainability_renewable_energy_certificate_facility_inspection_id` FOREIGN KEY (`facility_inspection_id`) REFERENCES `transport_shipping_ecm`.`safety`.`facility_inspection`(`facility_inspection_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`environmental_incident`(`environmental_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ADD CONSTRAINT `fk_sustainability_packaging_sustainability_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `transport_shipping_ecm`.`safety`.`permit`(`permit_id`);

-- ========= sustainability --> shipment (7 constraint(s)) =========
-- Requires: sustainability schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ADD CONSTRAINT `fk_sustainability_shipment_carbon_footprint_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ADD CONSTRAINT `fk_sustainability_shipment_carbon_footprint_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ADD CONSTRAINT `fk_sustainability_carbon_offset_transaction_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ADD CONSTRAINT `fk_sustainability_fuel_consumption_record_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ADD CONSTRAINT `fk_sustainability_green_shipment_certificate_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ADD CONSTRAINT `fk_sustainability_supplier_emissions_disclosure_shipment_carrier_assignment_id` FOREIGN KEY (`shipment_carrier_assignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment`(`shipment_carrier_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ADD CONSTRAINT `fk_sustainability_packaging_sustainability_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);

-- ========= sustainability --> warehouse (6 constraint(s)) =========
-- Requires: sustainability schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ADD CONSTRAINT `fk_sustainability_saf_procurement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ADD CONSTRAINT `fk_sustainability_energy_consumption_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ADD CONSTRAINT `fk_sustainability_packaging_sustainability_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ADD CONSTRAINT `fk_sustainability_packaging_sustainability_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ADD CONSTRAINT `fk_sustainability_water_consumption_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= sustainability --> workforce (5 constraint(s)) =========
-- Requires: sustainability schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ADD CONSTRAINT `fk_sustainability_target_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ADD CONSTRAINT `fk_sustainability_green_shipment_certificate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ADD CONSTRAINT `fk_sustainability_saf_procurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_tertiary_waste_approved_by_user_employee_id` FOREIGN KEY (`tertiary_waste_approved_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= warehouse --> billing (4 constraint(s)) =========
-- Requires: warehouse schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ADD CONSTRAINT `fk_warehouse_inventory_position_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ADD CONSTRAINT `fk_warehouse_service_agreement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= warehouse --> contract (6 constraint(s)) =========
-- Requires: warehouse schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ADD CONSTRAINT `fk_warehouse_service_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ADD CONSTRAINT `fk_warehouse_facility_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= warehouse --> customer (11 constraint(s)) =========
-- Requires: warehouse schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ADD CONSTRAINT `fk_warehouse_sku_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ADD CONSTRAINT `fk_warehouse_inventory_position_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ADD CONSTRAINT `fk_warehouse_wip_record_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ADD CONSTRAINT `fk_warehouse_service_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= warehouse --> customs (10 constraint(s)) =========
-- Requires: warehouse schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ADD CONSTRAINT `fk_warehouse_facility_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ADD CONSTRAINT `fk_warehouse_sku_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ADD CONSTRAINT `fk_warehouse_inventory_position_ftz_inventory_id` FOREIGN KEY (`ftz_inventory_id`) REFERENCES `transport_shipping_ecm`.`customs`.`ftz_inventory`(`ftz_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_certificate_of_origin_id` FOREIGN KEY (`certificate_of_origin_id`) REFERENCES `transport_shipping_ecm`.`customs`.`certificate_of_origin`(`certificate_of_origin_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_ftz_admission_id` FOREIGN KEY (`ftz_admission_id`) REFERENCES `transport_shipping_ecm`.`customs`.`ftz_admission`(`ftz_admission_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);

-- ========= warehouse --> document (12 constraint(s)) =========
-- Requires: warehouse schema, document schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ADD CONSTRAINT `fk_warehouse_facility_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ADD CONSTRAINT `fk_warehouse_sku_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ADD CONSTRAINT `fk_warehouse_wip_record_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ADD CONSTRAINT `fk_warehouse_hazmat_storage_compliance_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ADD CONSTRAINT `fk_warehouse_service_agreement_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);

-- ========= warehouse --> finance (6 constraint(s)) =========
-- Requires: warehouse schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ADD CONSTRAINT `fk_warehouse_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ADD CONSTRAINT `fk_warehouse_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ADD CONSTRAINT `fk_warehouse_wip_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ADD CONSTRAINT `fk_warehouse_service_agreement_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `transport_shipping_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ADD CONSTRAINT `fk_warehouse_service_agreement_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `transport_shipping_ecm`.`finance`.`ledger`(`ledger_id`);

-- ========= warehouse --> fleet (11 constraint(s)) =========
-- Requires: warehouse schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);

-- ========= warehouse --> fulfillment (11 constraint(s)) =========
-- Requires: warehouse schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`order_line`(`order_line_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ADD CONSTRAINT `fk_warehouse_replenishment_order_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`rma`(`rma_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ADD CONSTRAINT `fk_warehouse_returns_receipt_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`order_line`(`order_line_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= warehouse --> network (16 constraint(s)) =========
-- Requires: warehouse schema, network schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ADD CONSTRAINT `fk_warehouse_facility_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ADD CONSTRAINT `fk_warehouse_facility_carrier_service_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ADD CONSTRAINT `fk_warehouse_facility_partner_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);

-- ========= warehouse --> pricing (5 constraint(s)) =========
-- Requires: warehouse schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ADD CONSTRAINT `fk_warehouse_wip_record_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);

-- ========= warehouse --> procurement (8 constraint(s)) =========
-- Requires: warehouse schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ADD CONSTRAINT `fk_warehouse_asn_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ADD CONSTRAINT `fk_warehouse_supply_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`equipment` ADD CONSTRAINT `fk_warehouse_equipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`carton` ADD CONSTRAINT `fk_warehouse_carton_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= warehouse --> route (7 constraint(s)) =========
-- Requires: warehouse schema, route schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);

-- ========= warehouse --> safety (5 constraint(s)) =========
-- Requires: warehouse schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ADD CONSTRAINT `fk_warehouse_storage_location_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ADD CONSTRAINT `fk_warehouse_sku_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_facility_inspection_id` FOREIGN KEY (`facility_inspection_id`) REFERENCES `transport_shipping_ecm`.`safety`.`facility_inspection`(`facility_inspection_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ADD CONSTRAINT `fk_warehouse_wip_record_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `transport_shipping_ecm`.`safety`.`permit`(`permit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ADD CONSTRAINT `fk_warehouse_hazmat_storage_compliance_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `transport_shipping_ecm`.`safety`.`emergency_response_plan`(`emergency_response_plan_id`);

-- ========= warehouse --> shipment (2 constraint(s)) =========
-- Requires: warehouse schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= warehouse --> workforce (31 constraint(s)) =========
-- Requires: warehouse schema, workforce schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ADD CONSTRAINT `fk_warehouse_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ADD CONSTRAINT `fk_warehouse_asn_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ADD CONSTRAINT `fk_warehouse_pick_wave_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ADD CONSTRAINT `fk_warehouse_outbound_order_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ADD CONSTRAINT `fk_warehouse_cycle_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ADD CONSTRAINT `fk_warehouse_cycle_count_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ADD CONSTRAINT `fk_warehouse_cycle_count_line_primary_cycle_counter_employee_id` FOREIGN KEY (`primary_cycle_counter_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ADD CONSTRAINT `fk_warehouse_replenishment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ADD CONSTRAINT `fk_warehouse_returns_receipt_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_position_id` FOREIGN KEY (`position_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ADD CONSTRAINT `fk_warehouse_wip_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ADD CONSTRAINT `fk_warehouse_wip_record_quaternary_wip_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_wip_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ADD CONSTRAINT `fk_warehouse_wip_record_tertiary_wip_created_by_user_employee_id` FOREIGN KEY (`tertiary_wip_created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ADD CONSTRAINT `fk_warehouse_hazmat_storage_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ADD CONSTRAINT `fk_warehouse_service_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ADD CONSTRAINT `fk_warehouse_service_agreement_quaternary_service_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_service_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ADD CONSTRAINT `fk_warehouse_service_agreement_tertiary_service_created_by_user_employee_id` FOREIGN KEY (`tertiary_service_created_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ADD CONSTRAINT `fk_warehouse_zone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`counter_team` ADD CONSTRAINT `fk_warehouse_counter_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`counter_team` ADD CONSTRAINT `fk_warehouse_counter_team_team_lead_employee_id` FOREIGN KEY (`team_lead_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`equipment` ADD CONSTRAINT `fk_warehouse_equipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> contract (2 constraint(s)) =========
-- Requires: workforce schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= workforce --> customer (1 constraint(s)) =========
-- Requires: workforce schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= workforce --> document (1 constraint(s)) =========
-- Requires: workforce schema, document schema
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ADD CONSTRAINT `fk_workforce_fte_plan_version_id` FOREIGN KEY (`version_id`) REFERENCES `transport_shipping_ecm`.`document`.`version`(`version_id`);

-- ========= workforce --> finance (18 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ADD CONSTRAINT `fk_workforce_worker_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `transport_shipping_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_tax_account_id` FOREIGN KEY (`tax_account_id`) REFERENCES `transport_shipping_ecm`.`finance`.`tax_account`(`tax_account_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ADD CONSTRAINT `fk_workforce_fte_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `transport_shipping_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ADD CONSTRAINT `fk_workforce_fte_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `transport_shipping_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ADD CONSTRAINT `fk_workforce_location_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `transport_shipping_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `transport_shipping_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> fleet (1 constraint(s)) =========
-- Requires: workforce schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ADD CONSTRAINT `fk_workforce_hours_of_service_log_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);

-- ========= workforce --> freight (1 constraint(s)) =========
-- Requires: workforce schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= workforce --> procurement (10 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ADD CONSTRAINT `fk_workforce_worker_assignment_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ADD CONSTRAINT `fk_workforce_crew_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= workforce --> route (1 constraint(s)) =========
-- Requires: workforce schema, route schema
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);

-- ========= workforce --> safety (8 constraint(s)) =========
-- Requires: workforce schema, safety schema
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_training_id` FOREIGN KEY (`training_id`) REFERENCES `transport_shipping_ecm`.`safety`.`training`(`training_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `transport_shipping_ecm`.`safety`.`observation`(`observation_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_occupational_health_case_id` FOREIGN KEY (`occupational_health_case_id`) REFERENCES `transport_shipping_ecm`.`safety`.`occupational_health_case`(`occupational_health_case_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ADD CONSTRAINT `fk_workforce_hours_of_service_log_fatigue_risk_assessment_id` FOREIGN KEY (`fatigue_risk_assessment_id`) REFERENCES `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment`(`fatigue_risk_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ADD CONSTRAINT `fk_workforce_drug_alcohol_test_driver_safety_program_id` FOREIGN KEY (`driver_safety_program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`driver_safety_program`(`driver_safety_program_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ADD CONSTRAINT `fk_workforce_workforce_training_completion_training_id` FOREIGN KEY (`training_id`) REFERENCES `transport_shipping_ecm`.`safety`.`training`(`training_id`);

-- ========= workforce --> sustainability (7 constraint(s)) =========
-- Requires: workforce schema, sustainability schema
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_carbon_offset_transaction_id` FOREIGN KEY (`carbon_offset_transaction_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction`(`carbon_offset_transaction_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ADD CONSTRAINT `fk_workforce_driver_qualification_fuel_consumption_record_id` FOREIGN KEY (`fuel_consumption_record_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record`(`fuel_consumption_record_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_energy_consumption_record_id` FOREIGN KEY (`energy_consumption_record_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`energy_consumption_record`(`energy_consumption_record_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ADD CONSTRAINT `fk_workforce_initiative_participation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ADD CONSTRAINT `fk_workforce_target_accountability_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);

-- ========= workforce --> warehouse (3 constraint(s)) =========
-- Requires: workforce schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_labor_activity_id` FOREIGN KEY (`labor_activity_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`labor_activity`(`labor_activity_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

