-- Cross-Domain Foreign Keys for Business: Transport Shipping | Version: v1_mvm
-- Generated on: 2026-05-08 22:35:08
-- Total cross-domain FK constraints: 1408
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, claim, contract, customer, customs, fleet, freight, fulfillment, network, pricing, procurement, route, shipment, warehouse

-- ========= billing --> claim (1 constraint(s)) =========
-- Requires: billing schema, claim schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);

-- ========= billing --> contract (15 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_contract_surcharge_schedule_id` FOREIGN KEY (`contract_surcharge_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule`(`contract_surcharge_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_lane_commitment_id` FOREIGN KEY (`lane_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`lane_commitment`(`lane_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);

-- ========= billing --> customer (16 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_address_book_id` FOREIGN KEY (`address_book_id`) REFERENCES `transport_shipping_ecm`.`customer`.`address_book`(`address_book_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_address_book_id` FOREIGN KEY (`address_book_id`) REFERENCES `transport_shipping_ecm`.`customer`.`address_book`(`address_book_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);

-- ========= billing --> customs (6 constraint(s)) =========
-- Requires: billing schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_tariff_rate_id` FOREIGN KEY (`tariff_rate_id`) REFERENCES `transport_shipping_ecm`.`customs`.`tariff_rate`(`tariff_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_duty_assessment_id` FOREIGN KEY (`duty_assessment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`duty_assessment`(`duty_assessment_id`);

-- ========= billing --> network (23 constraint(s)) =========
-- Requires: billing schema, network schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_blocked_space_agreement_id` FOREIGN KEY (`blocked_space_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`blocked_space_agreement`(`blocked_space_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);

-- ========= billing --> pricing (10 constraint(s)) =========
-- Requires: billing schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);

-- ========= billing --> procurement (7 constraint(s)) =========
-- Requires: billing schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= billing --> route (15 constraint(s)) =========
-- Requires: billing schema, route schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_transit_time_standard_id` FOREIGN KEY (`transit_time_standard_id`) REFERENCES `transport_shipping_ecm`.`route`.`transit_time_standard`(`transit_time_standard_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_carrier_lane_allocation_id` FOREIGN KEY (`carrier_lane_allocation_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_lane_allocation`(`carrier_lane_allocation_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_transit_time_standard_id` FOREIGN KEY (`transit_time_standard_id`) REFERENCES `transport_shipping_ecm`.`route`.`transit_time_standard`(`transit_time_standard_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_transit_time_standard_id` FOREIGN KEY (`transit_time_standard_id`) REFERENCES `transport_shipping_ecm`.`route`.`transit_time_standard`(`transit_time_standard_id`);

-- ========= billing --> shipment (7 constraint(s)) =========
-- Requires: billing schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_exception_event_id` FOREIGN KEY (`exception_event_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`exception_event`(`exception_event_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);

-- ========= claim --> billing (1 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `transport_shipping_ecm`.`billing`.`credit_note`(`credit_note_id`);

-- ========= claim --> contract (8 constraint(s)) =========
-- Requires: claim schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ADD CONSTRAINT `fk_claim_claim_party_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_party`(`contract_party_id`);

-- ========= claim --> customer (16 constraint(s)) =========
-- Requires: claim schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ADD CONSTRAINT `fk_claim_claim_party_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ADD CONSTRAINT `fk_claim_claim_party_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ADD CONSTRAINT `fk_claim_policy_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ADD CONSTRAINT `fk_claim_claimant_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ADD CONSTRAINT `fk_claim_claimant_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= claim --> customs (15 constraint(s)) =========
-- Requires: claim schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_denied_party_screening_id` FOREIGN KEY (`denied_party_screening_id`) REFERENCES `transport_shipping_ecm`.`customs`.`denied_party_screening`(`denied_party_screening_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_denied_party_screening_id` FOREIGN KEY (`denied_party_screening_id`) REFERENCES `transport_shipping_ecm`.`customs`.`denied_party_screening`(`denied_party_screening_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_declaration_line_id` FOREIGN KEY (`declaration_line_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration_line`(`declaration_line_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ADD CONSTRAINT `fk_claim_claim_party_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);

-- ========= claim --> fleet (20 constraint(s)) =========
-- Requires: claim schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_asset_inspection_id` FOREIGN KEY (`asset_inspection_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`asset_inspection`(`asset_inspection_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`incident`(`incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`incident`(`incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_asset_inspection_id` FOREIGN KEY (`asset_inspection_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`asset_inspection`(`asset_inspection_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`incident`(`incident_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);

-- ========= claim --> freight (44 constraint(s)) =========
-- Requires: claim schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_cargo_id` FOREIGN KEY (`cargo_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cargo`(`cargo_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_intermodal_transfer_id` FOREIGN KEY (`intermodal_transfer_id`) REFERENCES `transport_shipping_ecm`.`freight`.`intermodal_transfer`(`intermodal_transfer_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_freight_carrier_assignment_id` FOREIGN KEY (`freight_carrier_assignment_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_carrier_assignment`(`freight_carrier_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_intermodal_transfer_id` FOREIGN KEY (`intermodal_transfer_id`) REFERENCES `transport_shipping_ecm`.`freight`.`intermodal_transfer`(`intermodal_transfer_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_cargo_id` FOREIGN KEY (`cargo_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cargo`(`cargo_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_freight_carrier_assignment_id` FOREIGN KEY (`freight_carrier_assignment_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_carrier_assignment`(`freight_carrier_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_intermodal_transfer_id` FOREIGN KEY (`intermodal_transfer_id`) REFERENCES `transport_shipping_ecm`.`freight`.`intermodal_transfer`(`intermodal_transfer_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_cargo_id` FOREIGN KEY (`cargo_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cargo`(`cargo_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_freight_carrier_assignment_id` FOREIGN KEY (`freight_carrier_assignment_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_carrier_assignment`(`freight_carrier_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_freight_leg_id` FOREIGN KEY (`freight_leg_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_leg`(`freight_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_intermodal_transfer_id` FOREIGN KEY (`intermodal_transfer_id`) REFERENCES `transport_shipping_ecm`.`freight`.`intermodal_transfer`(`intermodal_transfer_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_cargo_id` FOREIGN KEY (`cargo_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cargo`(`cargo_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= claim --> fulfillment (10 constraint(s)) =========
-- Requires: claim schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_delivery_attempt_id` FOREIGN KEY (`delivery_attempt_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`delivery_attempt`(`delivery_attempt_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`order_line`(`order_line_id`);

-- ========= claim --> network (25 constraint(s)) =========
-- Requires: claim schema, network schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ADD CONSTRAINT `fk_claim_claim_party_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ADD CONSTRAINT `fk_claim_claim_party_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ADD CONSTRAINT `fk_claim_policy_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ADD CONSTRAINT `fk_claim_policy_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);

-- ========= claim --> pricing (1 constraint(s)) =========
-- Requires: claim schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);

-- ========= claim --> procurement (18 constraint(s)) =========
-- Requires: claim schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= claim --> route (6 constraint(s)) =========
-- Requires: claim schema, route schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);

-- ========= claim --> shipment (11 constraint(s)) =========
-- Requires: claim schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_package_id` FOREIGN KEY (`package_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`package`(`package_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_shipment_carrier_assignment_id` FOREIGN KEY (`shipment_carrier_assignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment`(`shipment_carrier_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_package_id` FOREIGN KEY (`package_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`package`(`package_id`);

-- ========= claim --> warehouse (17 constraint(s)) =========
-- Requires: claim schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`asn`(`asn_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_handling_unit_id` FOREIGN KEY (`handling_unit_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`handling_unit`(`handling_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`asn`(`asn_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_handling_unit_id` FOREIGN KEY (`handling_unit_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`handling_unit`(`handling_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_handling_unit_id` FOREIGN KEY (`handling_unit_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`handling_unit`(`handling_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_outbound_order_line_id` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_order_line`(`outbound_order_line_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);

-- ========= contract --> billing (3 constraint(s)) =========
-- Requires: contract schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `transport_shipping_ecm`.`billing`.`credit_note`(`credit_note_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `transport_shipping_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= contract --> claim (1 constraint(s)) =========
-- Requires: contract schema, claim schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);

-- ========= contract --> customer (2 constraint(s)) =========
-- Requires: contract schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= contract --> customs (1 constraint(s)) =========
-- Requires: contract schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);

-- ========= contract --> freight (1 constraint(s)) =========
-- Requires: contract schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= contract --> network (18 constraint(s)) =========
-- Requires: contract schema, network schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ADD CONSTRAINT `fk_contract_sla_commitment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ADD CONSTRAINT `fk_contract_contract_surcharge_schedule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);

-- ========= contract --> pricing (5 constraint(s)) =========
-- Requires: contract schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ADD CONSTRAINT `fk_contract_contract_surcharge_schedule_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_dim_weight_rule_id` FOREIGN KEY (`dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);

-- ========= contract --> procurement (10 constraint(s)) =========
-- Requires: contract schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ADD CONSTRAINT `fk_contract_sla_commitment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ADD CONSTRAINT `fk_contract_contract_surcharge_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ADD CONSTRAINT `fk_contract_volume_commitment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ADD CONSTRAINT `fk_contract_penalty_clause_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= contract --> route (7 constraint(s)) =========
-- Requires: contract schema, route schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ADD CONSTRAINT `fk_contract_sla_commitment_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ADD CONSTRAINT `fk_contract_volume_commitment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);

-- ========= contract --> shipment (1 constraint(s)) =========
-- Requires: contract schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= customer --> claim (1 constraint(s)) =========
-- Requires: customer schema, claim schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);

-- ========= customer --> contract (14 constraint(s)) =========
-- Requires: customer schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `transport_shipping_ecm`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_penalty_clause_id` FOREIGN KEY (`penalty_clause_id`) REFERENCES `transport_shipping_ecm`.`contract`.`penalty_clause`(`penalty_clause_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `transport_shipping_ecm`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `transport_shipping_ecm`.`contract`.`service_scope`(`service_scope_id`);

-- ========= customer --> customs (16 constraint(s)) =========
-- Requires: customer schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `transport_shipping_ecm`.`customs`.`license_permit`(`license_permit_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `transport_shipping_ecm`.`customs`.`license_permit`(`license_permit_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_denied_party_screening_id` FOREIGN KEY (`denied_party_screening_id`) REFERENCES `transport_shipping_ecm`.`customs`.`denied_party_screening`(`denied_party_screening_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_incoterms_assignment_id` FOREIGN KEY (`incoterms_assignment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`incoterms_assignment`(`incoterms_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `transport_shipping_ecm`.`customs`.`license_permit`(`license_permit_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);

-- ========= customer --> fulfillment (2 constraint(s)) =========
-- Requires: customer schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);

-- ========= customer --> network (35 constraint(s)) =========
-- Requires: customer schema, network schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_network_event_id` FOREIGN KEY (`network_event_id`) REFERENCES `transport_shipping_ecm`.`network`.`network_event`(`network_event_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_partner_sla_id` FOREIGN KEY (`partner_sla_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_sla`(`partner_sla_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);

-- ========= customer --> pricing (9 constraint(s)) =========
-- Requires: customer schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);

-- ========= customer --> procurement (2 constraint(s)) =========
-- Requires: customer schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`partner_relationship` ADD CONSTRAINT `fk_customer_partner_relationship_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= customer --> route (20 constraint(s)) =========
-- Requires: customer schema, route schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`shipper_profile` ADD CONSTRAINT `fk_customer_shipper_profile_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`consignee_profile` ADD CONSTRAINT `fk_customer_consignee_profile_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`address_book` ADD CONSTRAINT `fk_customer_address_book_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`address_book` ADD CONSTRAINT `fk_customer_address_book_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`sla_entitlement` ADD CONSTRAINT `fk_customer_sla_entitlement_transit_time_standard_id` FOREIGN KEY (`transit_time_standard_id`) REFERENCES `transport_shipping_ecm`.`route`.`transit_time_standard`(`transit_time_standard_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_transit_time_standard_id` FOREIGN KEY (`transit_time_standard_id`) REFERENCES `transport_shipping_ecm`.`route`.`transit_time_standard`(`transit_time_standard_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);

-- ========= customer --> shipment (1 constraint(s)) =========
-- Requires: customer schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= customer --> warehouse (4 constraint(s)) =========
-- Requires: customer schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`customer`.`address_book` ADD CONSTRAINT `fk_customer_address_book_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_preference` ADD CONSTRAINT `fk_customer_service_preference_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= customs --> billing (5 constraint(s)) =========
-- Requires: customs schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ADD CONSTRAINT `fk_customs_denied_party_screening_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ADD CONSTRAINT `fk_customs_trade_party_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ADD CONSTRAINT `fk_customs_compliance_program_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= customs --> contract (10 constraint(s)) =========
-- Requires: customs schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ADD CONSTRAINT `fk_customs_compliance_program_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ADD CONSTRAINT `fk_customs_compliance_program_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_penalty_clause_id` FOREIGN KEY (`penalty_clause_id`) REFERENCES `transport_shipping_ecm`.`contract`.`penalty_clause`(`penalty_clause_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ADD CONSTRAINT `fk_customs_trade_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= customs --> customer (1 constraint(s)) =========
-- Requires: customs schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ADD CONSTRAINT `fk_customs_hs_classification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= customs --> freight (1 constraint(s)) =========
-- Requires: customs schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= customs --> network (9 constraint(s)) =========
-- Requires: customs schema, network schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ADD CONSTRAINT `fk_customs_trade_party_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ADD CONSTRAINT `fk_customs_compliance_program_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);

-- ========= customs --> pricing (6 constraint(s)) =========
-- Requires: customs schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ADD CONSTRAINT `fk_customs_denied_party_screening_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);

-- ========= customs --> procurement (16 constraint(s)) =========
-- Requires: customs schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ADD CONSTRAINT `fk_customs_hs_classification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ADD CONSTRAINT `fk_customs_trade_party_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ADD CONSTRAINT `fk_customs_origin_determination_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= customs --> route (11 constraint(s)) =========
-- Requires: customs schema, route schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_plan_leg_id` FOREIGN KEY (`plan_leg_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan_leg`(`plan_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ADD CONSTRAINT `fk_customs_compliance_program_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);

-- ========= customs --> shipment (9 constraint(s)) =========
-- Requires: customs schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_package_id` FOREIGN KEY (`package_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`package`(`package_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ADD CONSTRAINT `fk_customs_denied_party_screening_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= fleet --> billing (6 constraint(s)) =========
-- Requires: fleet schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `transport_shipping_ecm`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_freight_audit_id` FOREIGN KEY (`freight_audit_id`) REFERENCES `transport_shipping_ecm`.`billing`.`freight_audit`(`freight_audit_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ADD CONSTRAINT `fk_fleet_asset_licence_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= fleet --> claim (1 constraint(s)) =========
-- Requires: fleet schema, claim schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);

-- ========= fleet --> contract (14 constraint(s)) =========
-- Requires: fleet schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ADD CONSTRAINT `fk_fleet_container_unit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `transport_shipping_ecm`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ADD CONSTRAINT `fk_fleet_driver_profile_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_assignment` ADD CONSTRAINT `fk_fleet_driver_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_penalty_clause_id` FOREIGN KEY (`penalty_clause_id`) REFERENCES `transport_shipping_ecm`.`contract`.`penalty_clause`(`penalty_clause_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ADD CONSTRAINT `fk_fleet_asset_utilisation_volume_commitment_id` FOREIGN KEY (`volume_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`volume_commitment`(`volume_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);

-- ========= fleet --> customer (6 constraint(s)) =========
-- Requires: fleet schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `transport_shipping_ecm`.`customer`.`service_case`(`service_case_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_service_preference_id` FOREIGN KEY (`service_preference_id`) REFERENCES `transport_shipping_ecm`.`customer`.`service_preference`(`service_preference_id`);

-- ========= fleet --> customs (7 constraint(s)) =========
-- Requires: fleet schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ADD CONSTRAINT `fk_fleet_transport_asset_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `transport_shipping_ecm`.`customs`.`license_permit`(`license_permit_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ADD CONSTRAINT `fk_fleet_driver_profile_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ADD CONSTRAINT `fk_fleet_driver_profile_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `transport_shipping_ecm`.`customs`.`license_permit`(`license_permit_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ADD CONSTRAINT `fk_fleet_asset_inspection_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ADD CONSTRAINT `fk_fleet_asset_inspection_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);

-- ========= fleet --> freight (2 constraint(s)) =========
-- Requires: fleet schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= fleet --> network (10 constraint(s)) =========
-- Requires: fleet schema, network schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ADD CONSTRAINT `fk_fleet_container_unit_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ADD CONSTRAINT `fk_fleet_driver_profile_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_assignment` ADD CONSTRAINT `fk_fleet_driver_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ADD CONSTRAINT `fk_fleet_depot_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);

-- ========= fleet --> pricing (3 constraint(s)) =========
-- Requires: fleet schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_fuel_index_id` FOREIGN KEY (`fuel_index_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`fuel_index`(`fuel_index_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);

-- ========= fleet --> procurement (12 constraint(s)) =========
-- Requires: fleet schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ADD CONSTRAINT `fk_fleet_transport_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ADD CONSTRAINT `fk_fleet_transport_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ADD CONSTRAINT `fk_fleet_container_unit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ADD CONSTRAINT `fk_fleet_container_unit_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ADD CONSTRAINT `fk_fleet_driver_profile_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ADD CONSTRAINT `fk_fleet_asset_inspection_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= fleet --> route (18 constraint(s)) =========
-- Requires: fleet schema, route schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ADD CONSTRAINT `fk_fleet_container_unit_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ADD CONSTRAINT `fk_fleet_container_unit_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_assignment` ADD CONSTRAINT `fk_fleet_driver_assignment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ADD CONSTRAINT `fk_fleet_asset_inspection_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ADD CONSTRAINT `fk_fleet_asset_utilisation_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ADD CONSTRAINT `fk_fleet_asset_utilisation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ADD CONSTRAINT `fk_fleet_depot_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);

-- ========= fleet --> shipment (4 constraint(s)) =========
-- Requires: fleet schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_assignment` ADD CONSTRAINT `fk_fleet_driver_assignment_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= fleet --> warehouse (7 constraint(s)) =========
-- Requires: fleet schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ADD CONSTRAINT `fk_fleet_asset_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= freight --> billing (13 constraint(s)) =========
-- Requires: freight schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_billing_invoice_line_id` FOREIGN KEY (`billing_invoice_line_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_invoice_line`(`billing_invoice_line_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `transport_shipping_ecm`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_payment_allocation_id` FOREIGN KEY (`payment_allocation_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_allocation`(`payment_allocation_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `transport_shipping_ecm`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= freight --> claim (1 constraint(s)) =========
-- Requires: freight schema, claim schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);

-- ========= freight --> contract (16 constraint(s)) =========
-- Requires: freight schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_lane_commitment_id` FOREIGN KEY (`lane_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`lane_commitment`(`lane_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_lane_commitment_id` FOREIGN KEY (`lane_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`lane_commitment`(`lane_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_contract_surcharge_schedule_id` FOREIGN KEY (`contract_surcharge_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule`(`contract_surcharge_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);

-- ========= freight --> customer (31 constraint(s)) =========
-- Requires: freight schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_service_preference_id` FOREIGN KEY (`service_preference_id`) REFERENCES `transport_shipping_ecm`.`customer`.`service_preference`(`service_preference_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_service_preference_id` FOREIGN KEY (`service_preference_id`) REFERENCES `transport_shipping_ecm`.`customer`.`service_preference`(`service_preference_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `transport_shipping_ecm`.`customer`.`service_case`(`service_case_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_service_preference_id` FOREIGN KEY (`service_preference_id`) REFERENCES `transport_shipping_ecm`.`customer`.`service_preference`(`service_preference_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);

-- ========= freight --> customs (24 constraint(s)) =========
-- Requires: freight schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_broker_assignment_id` FOREIGN KEY (`broker_assignment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`broker_assignment`(`broker_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_ams_filing_id` FOREIGN KEY (`ams_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`ams_filing`(`ams_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_isf_filing_id` FOREIGN KEY (`isf_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`isf_filing`(`isf_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_broker_assignment_id` FOREIGN KEY (`broker_assignment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`broker_assignment`(`broker_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_broker_assignment_id` FOREIGN KEY (`broker_assignment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`broker_assignment`(`broker_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_duty_assessment_id` FOREIGN KEY (`duty_assessment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`duty_assessment`(`duty_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_broker_assignment_id` FOREIGN KEY (`broker_assignment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`broker_assignment`(`broker_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cargo` ADD CONSTRAINT `fk_freight_cargo_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cargo` ADD CONSTRAINT `fk_freight_cargo_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `transport_shipping_ecm`.`customs`.`license_permit`(`license_permit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cargo` ADD CONSTRAINT `fk_freight_cargo_origin_determination_id` FOREIGN KEY (`origin_determination_id`) REFERENCES `transport_shipping_ecm`.`customs`.`origin_determination`(`origin_determination_id`);

-- ========= freight --> fleet (23 constraint(s)) =========
-- Requires: freight schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);

-- ========= freight --> fulfillment (12 constraint(s)) =========
-- Requires: freight schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);

-- ========= freight --> network (33 constraint(s)) =========
-- Requires: freight schema, network schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_blocked_space_agreement_id` FOREIGN KEY (`blocked_space_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`blocked_space_agreement`(`blocked_space_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_consolidation_nvocc_operator_carrier_id` FOREIGN KEY (`consolidation_nvocc_operator_carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_blocked_space_agreement_id` FOREIGN KEY (`blocked_space_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`blocked_space_agreement`(`blocked_space_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_network_event_id` FOREIGN KEY (`network_event_id`) REFERENCES `transport_shipping_ecm`.`network`.`network_event`(`network_event_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);

-- ========= freight --> pricing (44 constraint(s)) =========
-- Requires: freight schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_dim_weight_rule_id` FOREIGN KEY (`dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_rate_line_id` FOREIGN KEY (`rate_line_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_line`(`rate_line_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cargo` ADD CONSTRAINT `fk_freight_cargo_dim_weight_rule_id` FOREIGN KEY (`dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);

-- ========= freight --> procurement (4 constraint(s)) =========
-- Requires: freight schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_supplier_quote_id` FOREIGN KEY (`supplier_quote_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_quote`(`supplier_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cargo` ADD CONSTRAINT `fk_freight_cargo_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`po_line`(`po_line_id`);

-- ========= freight --> route (24 constraint(s)) =========
-- Requires: freight schema, route schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_transit_time_standard_id` FOREIGN KEY (`transit_time_standard_id`) REFERENCES `transport_shipping_ecm`.`route`.`transit_time_standard`(`transit_time_standard_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_carrier_schedule_id` FOREIGN KEY (`carrier_schedule_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_schedule`(`carrier_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_destination_node_network_node_id` FOREIGN KEY (`destination_node_network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_carrier_schedule_id` FOREIGN KEY (`carrier_schedule_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_schedule`(`carrier_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_carrier_schedule_id` FOREIGN KEY (`carrier_schedule_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_schedule`(`carrier_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_carrier_schedule_id` FOREIGN KEY (`carrier_schedule_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_schedule`(`carrier_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_carrier_schedule_id` FOREIGN KEY (`carrier_schedule_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_schedule`(`carrier_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_origin_node_network_node_id` FOREIGN KEY (`origin_node_network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_plan_leg_id` FOREIGN KEY (`plan_leg_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan_leg`(`plan_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_primary_freight_network_node_id` FOREIGN KEY (`primary_freight_network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_corridor_leg_id` FOREIGN KEY (`corridor_leg_id`) REFERENCES `transport_shipping_ecm`.`route`.`corridor_leg`(`corridor_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_plan_leg_id` FOREIGN KEY (`plan_leg_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan_leg`(`plan_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_transit_time_standard_id` FOREIGN KEY (`transit_time_standard_id`) REFERENCES `transport_shipping_ecm`.`route`.`transit_time_standard`(`transit_time_standard_id`);

-- ========= freight --> shipment (1 constraint(s)) =========
-- Requires: freight schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= freight --> warehouse (16 constraint(s)) =========
-- Requires: freight schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ADD CONSTRAINT `fk_freight_freight_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_origin_cfs_facility_id` FOREIGN KEY (`origin_cfs_facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ADD CONSTRAINT `fk_freight_consolidation_pick_wave_id` FOREIGN KEY (`pick_wave_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`pick_wave`(`pick_wave_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_dock_appointment_id` FOREIGN KEY (`dock_appointment_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`dock_appointment`(`dock_appointment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_dock_appointment_id` FOREIGN KEY (`dock_appointment_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`dock_appointment`(`dock_appointment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_dock_appointment_id` FOREIGN KEY (`dock_appointment_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`dock_appointment`(`dock_appointment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`exception` ADD CONSTRAINT `fk_freight_exception_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);

-- ========= fulfillment --> billing (5 constraint(s)) =========
-- Requires: fulfillment schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_billing_invoice_line_id` FOREIGN KEY (`billing_invoice_line_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_invoice_line`(`billing_invoice_line_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_freight_audit_id` FOREIGN KEY (`freight_audit_id`) REFERENCES `transport_shipping_ecm`.`billing`.`freight_audit`(`freight_audit_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_zone_tax_schedule_id` FOREIGN KEY (`tax_schedule_id`) REFERENCES `transport_shipping_ecm`.`billing`.`tax_schedule`(`tax_schedule_id`);

-- ========= fulfillment --> contract (9 constraint(s)) =========
-- Requires: fulfillment schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_penalty_clause_id` FOREIGN KEY (`penalty_clause_id`) REFERENCES `transport_shipping_ecm`.`contract`.`penalty_clause`(`penalty_clause_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_zone_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `transport_shipping_ecm`.`contract`.`service_scope`(`service_scope_id`);

-- ========= fulfillment --> customer (11 constraint(s)) =========
-- Requires: fulfillment schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ADD CONSTRAINT `fk_fulfillment_consignee_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);

-- ========= fulfillment --> customs (10 constraint(s)) =========
-- Requires: fulfillment schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_broker_assignment_id` FOREIGN KEY (`broker_assignment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`broker_assignment`(`broker_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`consignee` ADD CONSTRAINT `fk_fulfillment_consignee_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);

-- ========= fulfillment --> fleet (12 constraint(s)) =========
-- Requires: fulfillment schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_zone_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);

-- ========= fulfillment --> freight (1 constraint(s)) =========
-- Requires: fulfillment schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);

-- ========= fulfillment --> network (13 constraint(s)) =========
-- Requires: fulfillment schema, network schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);

-- ========= fulfillment --> pricing (14 constraint(s)) =========
-- Requires: fulfillment schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`dispatch_run` ADD CONSTRAINT `fk_fulfillment_dispatch_run_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_zone_lane_rate_zone_id` FOREIGN KEY (`lane_rate_zone_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`lane_rate_zone`(`lane_rate_zone_id`);

-- ========= fulfillment --> procurement (5 constraint(s)) =========
-- Requires: fulfillment schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`merchant` ADD CONSTRAINT `fk_fulfillment_merchant_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= fulfillment --> route (14 constraint(s)) =========
-- Requires: fulfillment schema, route schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_transit_time_standard_id` FOREIGN KEY (`transit_time_standard_id`) REFERENCES `transport_shipping_ecm`.`route`.`transit_time_standard`(`transit_time_standard_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel` ADD CONSTRAINT `fk_fulfillment_parcel_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_carrier_schedule_id` FOREIGN KEY (`carrier_schedule_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_schedule`(`carrier_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`parcel_manifest` ADD CONSTRAINT `fk_fulfillment_parcel_manifest_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_delivery_zone` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_zone_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);

-- ========= fulfillment --> shipment (5 constraint(s)) =========
-- Requires: fulfillment schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch` ADD CONSTRAINT `fk_fulfillment_last_mile_dispatch_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`delivery_attempt` ADD CONSTRAINT `fk_fulfillment_delivery_attempt_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`fulfillment_carrier_assignment` ADD CONSTRAINT `fk_fulfillment_fulfillment_carrier_assignment_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`rma` ADD CONSTRAINT `fk_fulfillment_rma_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= fulfillment --> warehouse (2 constraint(s)) =========
-- Requires: fulfillment schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_pick_task_id` FOREIGN KEY (`pick_task_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`pick_task`(`pick_task_id`);
ALTER TABLE `transport_shipping_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= network --> contract (3 constraint(s)) =========
-- Requires: network schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ADD CONSTRAINT `fk_network_partner_performance_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ADD CONSTRAINT `fk_network_capacity_allocation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ADD CONSTRAINT `fk_network_partner_onboarding_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= network --> fleet (1 constraint(s)) =========
-- Requires: network schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ADD CONSTRAINT `fk_network_network_event_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);

-- ========= network --> route (2 constraint(s)) =========
-- Requires: network schema, route schema
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ADD CONSTRAINT `fk_network_capacity_allocation_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ADD CONSTRAINT `fk_network_blocked_space_agreement_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);

-- ========= pricing --> contract (10 constraint(s)) =========
-- Requires: pricing schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ADD CONSTRAINT `fk_pricing_surcharge_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ADD CONSTRAINT `fk_pricing_accessorial_charge_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ADD CONSTRAINT `fk_pricing_dim_weight_rule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);

-- ========= pricing --> customer (8 constraint(s)) =========
-- Requires: pricing schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `transport_shipping_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ADD CONSTRAINT `fk_pricing_dim_weight_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `transport_shipping_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ADD CONSTRAINT `fk_pricing_rate_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `transport_shipping_ecm`.`customer`.`segment`(`segment_id`);

-- ========= pricing --> fulfillment (1 constraint(s)) =========
-- Requires: pricing schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);

-- ========= pricing --> network (16 constraint(s)) =========
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);

-- ========= pricing --> procurement (7 constraint(s)) =========
-- Requires: pricing schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ADD CONSTRAINT `fk_pricing_surcharge_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_supplier_quote_id` FOREIGN KEY (`supplier_quote_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_quote`(`supplier_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_supplier_quote_id` FOREIGN KEY (`supplier_quote_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_quote`(`supplier_quote_id`);

-- ========= pricing --> route (14 constraint(s)) =========
-- Requires: pricing schema, route schema
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ADD CONSTRAINT `fk_pricing_rate_line_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ADD CONSTRAINT `fk_pricing_rate_line_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ADD CONSTRAINT `fk_pricing_tariff_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_transit_time_standard_id` FOREIGN KEY (`transit_time_standard_id`) REFERENCES `transport_shipping_ecm`.`route`.`transit_time_standard`(`transit_time_standard_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ADD CONSTRAINT `fk_pricing_lane_rate_zone_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ADD CONSTRAINT `fk_pricing_lane_rate_zone_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);

-- ========= procurement --> billing (1 constraint(s)) =========
-- Requires: procurement schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= procurement --> contract (4 constraint(s)) =========
-- Requires: procurement schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= procurement --> customs (5 constraint(s)) =========
-- Requires: procurement schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_declaration_line_id` FOREIGN KEY (`declaration_line_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration_line`(`declaration_line_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_duty_assessment_id` FOREIGN KEY (`duty_assessment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`duty_assessment`(`duty_assessment_id`);

-- ========= procurement --> freight (3 constraint(s)) =========
-- Requires: procurement schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_freight_charge_id` FOREIGN KEY (`freight_charge_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_charge`(`freight_charge_id`);

-- ========= procurement --> network (12 constraint(s)) =========
-- Requires: procurement schema, network schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);

-- ========= procurement --> route (4 constraint(s)) =========
-- Requires: procurement schema, route schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);

-- ========= procurement --> shipment (1 constraint(s)) =========
-- Requires: procurement schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

-- ========= procurement --> warehouse (9 constraint(s)) =========
-- Requires: procurement schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` ADD CONSTRAINT `fk_procurement_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);

-- ========= route --> contract (6 constraint(s)) =========
-- Requires: route schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`route`.`lane` ADD CONSTRAINT `fk_route_lane_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`transit_time_standard` ADD CONSTRAINT `fk_route_transit_time_standard_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_lane_allocation` ADD CONSTRAINT `fk_route_carrier_lane_allocation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan` ADD CONSTRAINT `fk_route_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_schedule` ADD CONSTRAINT `fk_route_carrier_schedule_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);

-- ========= route --> customs (5 constraint(s)) =========
-- Requires: route schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`route`.`service_corridor` ADD CONSTRAINT `fk_route_service_corridor_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`corridor_leg` ADD CONSTRAINT `fk_route_corridor_leg_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_broker_assignment_id` FOREIGN KEY (`broker_assignment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`broker_assignment`(`broker_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);

-- ========= route --> fleet (7 constraint(s)) =========
-- Requires: route schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`route`.`route_delivery_zone` ADD CONSTRAINT `fk_route_route_delivery_zone_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`hub_spoke_config` ADD CONSTRAINT `fk_route_hub_spoke_config_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);

-- ========= route --> freight (2 constraint(s)) =========
-- Requires: route schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`route`.`plan` ADD CONSTRAINT `fk_route_plan_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);

-- ========= route --> network (19 constraint(s)) =========
-- Requires: route schema, network schema
ALTER TABLE `transport_shipping_ecm`.`route`.`lane` ADD CONSTRAINT `fk_route_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane` ADD CONSTRAINT `fk_route_lane_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
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
ALTER TABLE `transport_shipping_ecm`.`route`.`hub_spoke_config` ADD CONSTRAINT `fk_route_hub_spoke_config_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`hub_spoke_config` ADD CONSTRAINT `fk_route_hub_spoke_config_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_performance` ADD CONSTRAINT `fk_route_lane_performance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_performance` ADD CONSTRAINT `fk_route_lane_performance_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_schedule` ADD CONSTRAINT `fk_route_carrier_schedule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_schedule` ADD CONSTRAINT `fk_route_carrier_schedule_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);

-- ========= route --> pricing (7 constraint(s)) =========
-- Requires: route schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_lane_allocation` ADD CONSTRAINT `fk_route_carrier_lane_allocation_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_lane_allocation` ADD CONSTRAINT `fk_route_carrier_lane_allocation_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan` ADD CONSTRAINT `fk_route_plan_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_rate_line_id` FOREIGN KEY (`rate_line_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_line`(`rate_line_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`lane_performance` ADD CONSTRAINT `fk_route_lane_performance_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`carrier_schedule` ADD CONSTRAINT `fk_route_carrier_schedule_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);

-- ========= route --> shipment (3 constraint(s)) =========
-- Requires: route schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`route`.`plan_leg` ADD CONSTRAINT `fk_route_plan_leg_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`route`.`eta_event` ADD CONSTRAINT `fk_route_eta_event_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);

-- ========= shipment --> billing (6 constraint(s)) =========
-- Requires: shipment schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_tax_schedule_id` FOREIGN KEY (`tax_schedule_id`) REFERENCES `transport_shipping_ecm`.`billing`.`tax_schedule`(`tax_schedule_id`);

-- ========= shipment --> claim (2 constraint(s)) =========
-- Requires: shipment schema, claim schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);

-- ========= shipment --> contract (19 constraint(s)) =========
-- Requires: shipment schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `transport_shipping_ecm`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_lane_commitment_id` FOREIGN KEY (`lane_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`lane_commitment`(`lane_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_penalty_clause_id` FOREIGN KEY (`penalty_clause_id`) REFERENCES `transport_shipping_ecm`.`contract`.`penalty_clause`(`penalty_clause_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_contract_surcharge_schedule_id` FOREIGN KEY (`contract_surcharge_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule`(`contract_surcharge_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_penalty_clause_id` FOREIGN KEY (`penalty_clause_id`) REFERENCES `transport_shipping_ecm`.`contract`.`penalty_clause`(`penalty_clause_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_agreement_version_id` FOREIGN KEY (`agreement_version_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement_version`(`agreement_version_id`);

-- ========= shipment --> customer (9 constraint(s)) =========
-- Requires: shipment schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_sla_entitlement_id` FOREIGN KEY (`sla_entitlement_id`) REFERENCES `transport_shipping_ecm`.`customer`.`sla_entitlement`(`sla_entitlement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ADD CONSTRAINT `fk_shipment_delivery_instruction_address_book_id` FOREIGN KEY (`address_book_id`) REFERENCES `transport_shipping_ecm`.`customer`.`address_book`(`address_book_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ADD CONSTRAINT `fk_shipment_delivery_instruction_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`credit_profile`(`credit_profile_id`);

-- ========= shipment --> customs (17 constraint(s)) =========
-- Requires: shipment schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_ams_filing_id` FOREIGN KEY (`ams_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`ams_filing`(`ams_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_duty_assessment_id` FOREIGN KEY (`duty_assessment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`duty_assessment`(`duty_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_ams_filing_id` FOREIGN KEY (`ams_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`ams_filing`(`ams_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_certificate_of_origin_id` FOREIGN KEY (`certificate_of_origin_id`) REFERENCES `transport_shipping_ecm`.`customs`.`certificate_of_origin`(`certificate_of_origin_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `transport_shipping_ecm`.`customs`.`license_permit`(`license_permit_id`);

-- ========= shipment --> fleet (20 constraint(s)) =========
-- Requires: shipment schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`package` ADD CONSTRAINT `fk_shipment_package_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`package` ADD CONSTRAINT `fk_shipment_package_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);

-- ========= shipment --> freight (15 constraint(s)) =========
-- Requires: shipment schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_cargo_id` FOREIGN KEY (`cargo_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cargo`(`cargo_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `transport_shipping_ecm`.`freight`.`quote`(`quote_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`package` ADD CONSTRAINT `fk_shipment_package_cargo_id` FOREIGN KEY (`cargo_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cargo`(`cargo_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_freight_leg_id` FOREIGN KEY (`freight_leg_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_leg`(`freight_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);

-- ========= shipment --> fulfillment (14 constraint(s)) =========
-- Requires: shipment schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`package` ADD CONSTRAINT `fk_shipment_package_pack_task_id` FOREIGN KEY (`pack_task_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`pack_task`(`pack_task_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`package` ADD CONSTRAINT `fk_shipment_package_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel`(`parcel_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ADD CONSTRAINT `fk_shipment_delivery_instruction_last_mile_dispatch_id` FOREIGN KEY (`last_mile_dispatch_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`last_mile_dispatch`(`last_mile_dispatch_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_center_id` FOREIGN KEY (`center_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_parcel_manifest_id` FOREIGN KEY (`parcel_manifest_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`parcel_manifest`(`parcel_manifest_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= shipment --> network (24 constraint(s)) =========
-- Requires: shipment schema, network schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_blocked_space_agreement_id` FOREIGN KEY (`blocked_space_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`blocked_space_agreement`(`blocked_space_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_network_event_id` FOREIGN KEY (`network_event_id`) REFERENCES `transport_shipping_ecm`.`network`.`network_event`(`network_event_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`delivery_instruction` ADD CONSTRAINT `fk_shipment_delivery_instruction_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);

-- ========= shipment --> pricing (14 constraint(s)) =========
-- Requires: shipment schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_rate_line_id` FOREIGN KEY (`rate_line_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_line`(`rate_line_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`package` ADD CONSTRAINT `fk_shipment_package_dim_weight_rule_id` FOREIGN KEY (`dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_dim_weight_rule_id` FOREIGN KEY (`dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_rate_line_id` FOREIGN KEY (`rate_line_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_line`(`rate_line_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);

-- ========= shipment --> procurement (5 constraint(s)) =========
-- Requires: shipment schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_charge` ADD CONSTRAINT `fk_shipment_shipment_charge_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_document` ADD CONSTRAINT `fk_shipment_shipment_document_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= shipment --> route (13 constraint(s)) =========
-- Requires: shipment schema, route schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment` ADD CONSTRAINT `fk_shipment_consignment_transit_time_standard_id` FOREIGN KEY (`transit_time_standard_id`) REFERENCES `transport_shipping_ecm`.`route`.`transit_time_standard`(`transit_time_standard_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_carrier_schedule_id` FOREIGN KEY (`carrier_schedule_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_schedule`(`carrier_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_corridor_leg_id` FOREIGN KEY (`corridor_leg_id`) REFERENCES `transport_shipping_ecm`.`route`.`corridor_leg`(`corridor_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`pod` ADD CONSTRAINT `fk_shipment_pod_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment` ADD CONSTRAINT `fk_shipment_shipment_carrier_assignment_carrier_schedule_id` FOREIGN KEY (`carrier_schedule_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_schedule`(`carrier_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_service_corridor_id` FOREIGN KEY (`service_corridor_id`) REFERENCES `transport_shipping_ecm`.`route`.`service_corridor`(`service_corridor_id`);

-- ========= shipment --> warehouse (9 constraint(s)) =========
-- Requires: shipment schema, warehouse schema
ALTER TABLE `transport_shipping_ecm`.`shipment`.`shipment_leg` ADD CONSTRAINT `fk_shipment_shipment_leg_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`tracking_event` ADD CONSTRAINT `fk_shipment_tracking_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`eta_milestone` ADD CONSTRAINT `fk_shipment_eta_milestone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`exception_event` ADD CONSTRAINT `fk_shipment_exception_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`consignment_status` ADD CONSTRAINT `fk_shipment_consignment_status_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`package` ADD CONSTRAINT `fk_shipment_package_handling_unit_id` FOREIGN KEY (`handling_unit_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`handling_unit`(`handling_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`package` ADD CONSTRAINT `fk_shipment_package_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_dock_appointment_id` FOREIGN KEY (`dock_appointment_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`dock_appointment`(`dock_appointment_id`);
ALTER TABLE `transport_shipping_ecm`.`shipment`.`freight_manifest` ADD CONSTRAINT `fk_shipment_freight_manifest_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);

-- ========= warehouse --> billing (4 constraint(s)) =========
-- Requires: warehouse schema, billing schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_freight_audit_id` FOREIGN KEY (`freight_audit_id`) REFERENCES `transport_shipping_ecm`.`billing`.`freight_audit`(`freight_audit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `transport_shipping_ecm`.`billing`.`performance_obligation`(`performance_obligation_id`);

-- ========= warehouse --> contract (11 constraint(s)) =========
-- Requires: warehouse schema, contract schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ADD CONSTRAINT `fk_warehouse_facility_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ADD CONSTRAINT `fk_warehouse_pick_wave_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `transport_shipping_ecm`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `transport_shipping_ecm`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);

-- ========= warehouse --> customer (15 constraint(s)) =========
-- Requires: warehouse schema, customer schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ADD CONSTRAINT `fk_warehouse_sku_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ADD CONSTRAINT `fk_warehouse_inventory_position_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_consignee_profile_id` FOREIGN KEY (`consignee_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`consignee_profile`(`consignee_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `transport_shipping_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ADD CONSTRAINT `fk_warehouse_cycle_count_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_shipper_profile_id` FOREIGN KEY (`shipper_profile_id`) REFERENCES `transport_shipping_ecm`.`customer`.`shipper_profile`(`shipper_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `transport_shipping_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= warehouse --> customs (18 constraint(s)) =========
-- Requires: warehouse schema, customs schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ADD CONSTRAINT `fk_warehouse_sku_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ADD CONSTRAINT `fk_warehouse_sku_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `transport_shipping_ecm`.`customs`.`license_permit`(`license_permit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ADD CONSTRAINT `fk_warehouse_sku_origin_determination_id` FOREIGN KEY (`origin_determination_id`) REFERENCES `transport_shipping_ecm`.`customs`.`origin_determination`(`origin_determination_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ADD CONSTRAINT `fk_warehouse_inventory_position_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_isf_filing_id` FOREIGN KEY (`isf_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`isf_filing`(`isf_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ADD CONSTRAINT `fk_warehouse_asn_line_declaration_line_id` FOREIGN KEY (`declaration_line_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration_line`(`declaration_line_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_declaration_line_id` FOREIGN KEY (`declaration_line_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration_line`(`declaration_line_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_certificate_of_origin_id` FOREIGN KEY (`certificate_of_origin_id`) REFERENCES `transport_shipping_ecm`.`customs`.`certificate_of_origin`(`certificate_of_origin_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_denied_party_screening_id` FOREIGN KEY (`denied_party_screening_id`) REFERENCES `transport_shipping_ecm`.`customs`.`denied_party_screening`(`denied_party_screening_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_incoterms_assignment_id` FOREIGN KEY (`incoterms_assignment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`incoterms_assignment`(`incoterms_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `transport_shipping_ecm`.`customs`.`license_permit`(`license_permit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hold`(`hold_id`);

-- ========= warehouse --> fleet (17 constraint(s)) =========
-- Requires: warehouse schema, fleet schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);

-- ========= warehouse --> freight (13 constraint(s)) =========
-- Requires: warehouse schema, freight schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_cargo_id` FOREIGN KEY (`cargo_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cargo`(`cargo_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_freight_carrier_assignment_id` FOREIGN KEY (`freight_carrier_assignment_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_carrier_assignment`(`freight_carrier_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_cargo_id` FOREIGN KEY (`cargo_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cargo`(`cargo_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_load_plan_id` FOREIGN KEY (`load_plan_id`) REFERENCES `transport_shipping_ecm`.`freight`.`load_plan`(`load_plan_id`);

-- ========= warehouse --> fulfillment (9 constraint(s)) =========
-- Requires: warehouse schema, fulfillment schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ADD CONSTRAINT `fk_warehouse_sku_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`rma`(`rma_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`order_line`(`order_line_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_consignee_id` FOREIGN KEY (`consignee_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`consignee`(`consignee_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`merchant`(`merchant_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ADD CONSTRAINT `fk_warehouse_outbound_order_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`order_line`(`order_line_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `transport_shipping_ecm`.`fulfillment`.`rma`(`rma_id`);

-- ========= warehouse --> network (12 constraint(s)) =========
-- Requires: warehouse schema, network schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ADD CONSTRAINT `fk_warehouse_facility_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);

-- ========= warehouse --> pricing (6 constraint(s)) =========
-- Requires: warehouse schema, pricing schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_carrier_buy_rate_id` FOREIGN KEY (`carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_dim_weight_rule_id` FOREIGN KEY (`dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_accessorial_charge_id` FOREIGN KEY (`accessorial_charge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`accessorial_charge`(`accessorial_charge_id`);

-- ========= warehouse --> procurement (17 constraint(s)) =========
-- Requires: warehouse schema, procurement schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ADD CONSTRAINT `fk_warehouse_inventory_position_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ADD CONSTRAINT `fk_warehouse_inventory_position_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ADD CONSTRAINT `fk_warehouse_asn_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ADD CONSTRAINT `fk_warehouse_asn_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ADD CONSTRAINT `fk_warehouse_asn_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= warehouse --> route (16 constraint(s)) =========
-- Requires: warehouse schema, route schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ADD CONSTRAINT `fk_warehouse_facility_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `transport_shipping_ecm`.`route`.`network_node`(`network_node_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_carrier_schedule_id` FOREIGN KEY (`carrier_schedule_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_schedule`(`carrier_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ADD CONSTRAINT `fk_warehouse_pick_wave_carrier_schedule_id` FOREIGN KEY (`carrier_schedule_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_schedule`(`carrier_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ADD CONSTRAINT `fk_warehouse_pick_wave_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_route_delivery_zone_id` FOREIGN KEY (`route_delivery_zone_id`) REFERENCES `transport_shipping_ecm`.`route`.`route_delivery_zone`(`route_delivery_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_transit_time_standard_id` FOREIGN KEY (`transit_time_standard_id`) REFERENCES `transport_shipping_ecm`.`route`.`transit_time_standard`(`transit_time_standard_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_carrier_schedule_id` FOREIGN KEY (`carrier_schedule_id`) REFERENCES `transport_shipping_ecm`.`route`.`carrier_schedule`(`carrier_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `transport_shipping_ecm`.`route`.`lane`(`lane_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `transport_shipping_ecm`.`route`.`plan`(`plan_id`);

-- ========= warehouse --> shipment (7 constraint(s)) =========
-- Requires: warehouse schema, shipment schema
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn` ADD CONSTRAINT `fk_warehouse_asn_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_consignment_id` FOREIGN KEY (`consignment_id`) REFERENCES `transport_shipping_ecm`.`shipment`.`consignment`(`consignment_id`);

