-- Cross-Domain Foreign Keys for Business: Shipping Ports | Version: v1_mvm
-- Generated on: 2026-05-10 06:53:38
-- Total cross-domain FK constraints: 1628
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, booking, cargo, compliance, customer, finance, infrastructure, intermodal, marine, masterdata, security, tariff, terminal, vessel

-- ========= billing --> booking (22 constraint(s)) =========
-- Requires: billing schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_berth_reservation_id` FOREIGN KEY (`berth_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`berth_reservation`(`berth_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_booking_service_order_id` FOREIGN KEY (`booking_service_order_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_service_order`(`booking_service_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_slot_reservation_id` FOREIGN KEY (`slot_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`slot_reservation`(`slot_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_truck_gate_booking_id` FOREIGN KEY (`truck_gate_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`truck_gate_booking`(`truck_gate_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_booking_service_order_id` FOREIGN KEY (`booking_service_order_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_service_order`(`booking_service_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_anchorage_booking_id` FOREIGN KEY (`anchorage_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`anchorage_booking`(`anchorage_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_berth_reservation_id` FOREIGN KEY (`berth_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`berth_reservation`(`berth_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_booking_service_order_id` FOREIGN KEY (`booking_service_order_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_service_order`(`booking_service_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_slot_reservation_id` FOREIGN KEY (`slot_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`slot_reservation`(`slot_reservation_id`);

-- ========= billing --> cargo (1 constraint(s)) =========
-- Requires: billing schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);

-- ========= billing --> compliance (18 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_document`(`trade_document_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);

-- ========= billing --> customer (12 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `shipping_ports_ecm`.`customer`.`service_request`(`service_request_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`statement_of_account` ADD CONSTRAINT `fk_billing_statement_of_account_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= billing --> finance (40 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `shipping_ports_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `shipping_ports_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `shipping_ports_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `shipping_ports_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `shipping_ports_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `shipping_ports_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`statement_of_account` ADD CONSTRAINT `fk_billing_statement_of_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= billing --> infrastructure (23 constraint(s)) =========
-- Requires: billing schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_closure_id` FOREIGN KEY (`closure_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`closure`(`closure_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_dredging_campaign_id` FOREIGN KEY (`dredging_campaign_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`dredging_campaign`(`dredging_campaign_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_weighing_station_id` FOREIGN KEY (`weighing_station_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`weighing_station`(`weighing_station_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);

-- ========= billing --> intermodal (14 constraint(s)) =========
-- Requires: billing schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`transport_order`(`transport_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`transport_order`(`transport_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`transport_order`(`transport_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_haulier_id` FOREIGN KEY (`haulier_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`haulier`(`haulier_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_icd_facility_id` FOREIGN KEY (`icd_facility_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`icd_facility`(`icd_facility_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_rail_operator_id` FOREIGN KEY (`rail_operator_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_operator`(`rail_operator_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`transport_order`(`transport_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_icd_facility_id` FOREIGN KEY (`icd_facility_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`icd_facility`(`icd_facility_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`leg`(`leg_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_slot_booking_id` FOREIGN KEY (`slot_booking_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`slot_booking`(`slot_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`transport_order`(`transport_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_truck_appointment_id` FOREIGN KEY (`truck_appointment_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_appointment`(`truck_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_service_id` FOREIGN KEY (`service_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`service`(`service_id`);

-- ========= billing --> marine (12 constraint(s)) =========
-- Requires: billing schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_launch_dispatch_id` FOREIGN KEY (`launch_dispatch_id`) REFERENCES `shipping_ports_ecm`.`marine`.`launch_dispatch`(`launch_dispatch_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_marpol_operation_id` FOREIGN KEY (`marpol_operation_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marpol_operation`(`marpol_operation_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_mooring_operation_id` FOREIGN KEY (`mooring_operation_id`) REFERENCES `shipping_ports_ecm`.`marine`.`mooring_operation`(`mooring_operation_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_pilotage_assignment_id` FOREIGN KEY (`pilotage_assignment_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_assignment`(`pilotage_assignment_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_survey_appointment_id` FOREIGN KEY (`survey_appointment_id`) REFERENCES `shipping_ports_ecm`.`marine`.`survey_appointment`(`survey_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_towage_order_id` FOREIGN KEY (`towage_order_id`) REFERENCES `shipping_ports_ecm`.`marine`.`towage_order`(`towage_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_pilotage_assignment_id` FOREIGN KEY (`pilotage_assignment_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_assignment`(`pilotage_assignment_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_pilotage_assignment_id` FOREIGN KEY (`pilotage_assignment_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_assignment`(`pilotage_assignment_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_marine_service_order_id` FOREIGN KEY (`marine_service_order_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_service_order`(`marine_service_order_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_mooring_operation_id` FOREIGN KEY (`mooring_operation_id`) REFERENCES `shipping_ports_ecm`.`marine`.`mooring_operation`(`mooring_operation_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_pilotage_assignment_id` FOREIGN KEY (`pilotage_assignment_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_assignment`(`pilotage_assignment_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_towage_order_id` FOREIGN KEY (`towage_order_id`) REFERENCES `shipping_ports_ecm`.`marine`.`towage_order`(`towage_order_id`);

-- ========= billing --> masterdata (21 constraint(s)) =========
-- Requires: billing schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_edi_partner_id` FOREIGN KEY (`edi_partner_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`edi_partner`(`edi_partner_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);

-- ========= billing --> security (9 constraint(s)) =========
-- Requires: billing schema, security schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= billing --> tariff (29 constraint(s)) =========
-- Requires: billing schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_pricing_rule_id` FOREIGN KEY (`pricing_rule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pricing_rule`(`pricing_rule_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_card_line_id` FOREIGN KEY (`rate_card_line_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card_line`(`rate_card_line_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`receivable_account` ADD CONSTRAINT `fk_billing_receivable_account_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_discount_scheme_id` FOREIGN KEY (`discount_scheme_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`discount_scheme`(`discount_scheme_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_free_time_allowance_id` FOREIGN KEY (`free_time_allowance_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`free_time_allowance`(`free_time_allowance_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_mooring_tariff_id` FOREIGN KEY (`mooring_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`mooring_tariff`(`mooring_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_port_dues_schedule_id` FOREIGN KEY (`port_dues_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_dues_schedule`(`port_dues_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_storage_tariff_id` FOREIGN KEY (`storage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`storage_tariff`(`storage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_surcharge_rule_id` FOREIGN KEY (`surcharge_rule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`surcharge_rule`(`surcharge_rule_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);

-- ========= billing --> terminal (2 constraint(s)) =========
-- Requires: billing schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`equipment`(`equipment_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`equipment`(`equipment_id`);

-- ========= billing --> vessel (6 constraint(s)) =========
-- Requires: billing schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`revenue_event` ADD CONSTRAINT `fk_billing_revenue_event_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= booking --> billing (4 constraint(s)) =========
-- Requires: booking schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= booking --> cargo (4 constraint(s)) =========
-- Requires: booking schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_container_preadvice_id` FOREIGN KEY (`container_preadvice_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container_preadvice`(`container_preadvice_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`delivery_order`(`delivery_order_id`);

-- ========= booking --> compliance (20 constraint(s)) =========
-- Requires: booking schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);

-- ========= booking --> customer (24 constraint(s)) =========
-- Requires: booking schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `shipping_ports_ecm`.`customer`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `shipping_ports_ecm`.`customer`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_tertiary_cargo_notify_party_port_community_participant_id` FOREIGN KEY (`tertiary_cargo_notify_party_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_tertiary_quaternary_cargo_freight_forwarder_port_community_participant_id` FOREIGN KEY (`tertiary_quaternary_cargo_freight_forwarder_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= booking --> finance (19 constraint(s)) =========
-- Requires: booking schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);

-- ========= booking --> infrastructure (22 constraint(s)) =========
-- Requires: booking schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_quay_wall_id` FOREIGN KEY (`quay_wall_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`quay_wall`(`quay_wall_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_weighing_station_id` FOREIGN KEY (`weighing_station_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`weighing_station`(`weighing_station_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);

-- ========= booking --> intermodal (1 constraint(s)) =========
-- Requires: booking schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_truck_appointment_id` FOREIGN KEY (`truck_appointment_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_appointment`(`truck_appointment_id`);

-- ========= booking --> marine (2 constraint(s)) =========
-- Requires: booking schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_weather_tide_window_id` FOREIGN KEY (`weather_tide_window_id`) REFERENCES `shipping_ports_ecm`.`marine`.`weather_tide_window`(`weather_tide_window_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_weather_tide_window_id` FOREIGN KEY (`weather_tide_window_id`) REFERENCES `shipping_ports_ecm`.`marine`.`weather_tide_window`(`weather_tide_window_id`);

-- ========= booking --> masterdata (31 constraint(s)) =========
-- Requires: booking schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);

-- ========= booking --> security (8 constraint(s)) =========
-- Requires: booking schema, security schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);

-- ========= booking --> tariff (31 constraint(s)) =========
-- Requires: booking schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_port_dues_schedule_id` FOREIGN KEY (`port_dues_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_dues_schedule`(`port_dues_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_rate_card_line_id` FOREIGN KEY (`rate_card_line_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card_line`(`rate_card_line_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_mooring_tariff_id` FOREIGN KEY (`mooring_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`mooring_tariff`(`mooring_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_free_time_allowance_id` FOREIGN KEY (`free_time_allowance_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`free_time_allowance`(`free_time_allowance_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_storage_tariff_id` FOREIGN KEY (`storage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`storage_tariff`(`storage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_port_dues_schedule_id` FOREIGN KEY (`port_dues_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_dues_schedule`(`port_dues_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_storage_tariff_id` FOREIGN KEY (`storage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`storage_tariff`(`storage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_mooring_tariff_id` FOREIGN KEY (`mooring_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`mooring_tariff`(`mooring_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_port_dues_schedule_id` FOREIGN KEY (`port_dues_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_dues_schedule`(`port_dues_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);

-- ========= booking --> vessel (17 constraint(s)) =========
-- Requires: booking schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_agent_appointment_id` FOREIGN KEY (`agent_appointment_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_call_schedule_id` FOREIGN KEY (`call_schedule_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call_schedule`(`call_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_agent_appointment_id` FOREIGN KEY (`agent_appointment_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_anchorage_id` FOREIGN KEY (`anchorage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`anchorage`(`anchorage_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);

-- ========= cargo --> billing (7 constraint(s)) =========
-- Requires: cargo schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest_line` ADD CONSTRAINT `fk_cargo_manifest_line_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= cargo --> booking (14 constraint(s)) =========
-- Requires: cargo schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest_line` ADD CONSTRAINT `fk_cargo_manifest_line_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_booking_service_order_id` FOREIGN KEY (`booking_service_order_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_service_order`(`booking_service_order_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_slot_reservation_id` FOREIGN KEY (`slot_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`slot_reservation`(`slot_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_pre_arrival_id` FOREIGN KEY (`pre_arrival_id`) REFERENCES `shipping_ports_ecm`.`booking`.`pre_arrival`(`pre_arrival_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);

-- ========= cargo --> compliance (35 constraint(s)) =========
-- Requires: cargo schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest_line` ADD CONSTRAINT `fk_cargo_manifest_line_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest_line` ADD CONSTRAINT `fk_cargo_manifest_line_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest_line` ADD CONSTRAINT `fk_cargo_manifest_line_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);

-- ========= cargo --> customer (15 constraint(s)) =========
-- Requires: cargo schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_shipment_notify_party_port_community_participant_id` FOREIGN KEY (`shipment_notify_party_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_shipment_port_community_participant_id` FOREIGN KEY (`shipment_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= cargo --> finance (8 constraint(s)) =========
-- Requires: cargo schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);

-- ========= cargo --> infrastructure (20 constraint(s)) =========
-- Requires: cargo schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_weighing_station_id` FOREIGN KEY (`weighing_station_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`weighing_station`(`weighing_station_id`);

-- ========= cargo --> marine (3 constraint(s)) =========
-- Requires: cargo schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_marine_incident_id` FOREIGN KEY (`marine_incident_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_incident`(`marine_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_pilotage_assignment_id` FOREIGN KEY (`pilotage_assignment_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_assignment`(`pilotage_assignment_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_weather_tide_window_id` FOREIGN KEY (`weather_tide_window_id`) REFERENCES `shipping_ports_ecm`.`marine`.`weather_tide_window`(`weather_tide_window_id`);

-- ========= cargo --> masterdata (22 constraint(s)) =========
-- Requires: cargo schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest_line` ADD CONSTRAINT `fk_cargo_manifest_line_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest_line` ADD CONSTRAINT `fk_cargo_manifest_line_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);

-- ========= cargo --> security (9 constraint(s)) =========
-- Requires: cargo schema, security schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_access_event_id` FOREIGN KEY (`access_event_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_event`(`access_event_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);

-- ========= cargo --> tariff (26 constraint(s)) =========
-- Requires: cargo schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_storage_tariff_id` FOREIGN KEY (`storage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`storage_tariff`(`storage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_free_time_allowance_id` FOREIGN KEY (`free_time_allowance_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`free_time_allowance`(`free_time_allowance_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_surcharge_rule_id` FOREIGN KEY (`surcharge_rule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`surcharge_rule`(`surcharge_rule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest_line` ADD CONSTRAINT `fk_cargo_manifest_line_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest_line` ADD CONSTRAINT `fk_cargo_manifest_line_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_surcharge_rule_id` FOREIGN KEY (`surcharge_rule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`surcharge_rule`(`surcharge_rule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_surcharge_rule_id` FOREIGN KEY (`surcharge_rule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`surcharge_rule`(`surcharge_rule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_free_time_allowance_id` FOREIGN KEY (`free_time_allowance_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`free_time_allowance`(`free_time_allowance_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_free_time_allowance_id` FOREIGN KEY (`free_time_allowance_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`free_time_allowance`(`free_time_allowance_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);

-- ========= cargo --> terminal (1 constraint(s)) =========
-- Requires: cargo schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`equipment`(`equipment_id`);

-- ========= cargo --> vessel (16 constraint(s)) =========
-- Requires: cargo schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_shipment_vessel_call_id` FOREIGN KEY (`shipment_vessel_call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container` ADD CONSTRAINT `fk_cargo_container_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`bill_of_lading` ADD CONSTRAINT `fk_cargo_bill_of_lading_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_agent_appointment_id` FOREIGN KEY (`agent_appointment_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`handling_order` ADD CONSTRAINT `fk_cargo_handling_order_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`move` ADD CONSTRAINT `fk_cargo_move_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration` ADD CONSTRAINT `fk_cargo_dangerous_goods_declaration_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`container_preadvice` ADD CONSTRAINT `fk_cargo_container_preadvice_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`delivery_order` ADD CONSTRAINT `fk_cargo_delivery_order_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`demurrage_detention` ADD CONSTRAINT `fk_cargo_demurrage_detention_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`cargo`.`verified_gross_mass` ADD CONSTRAINT `fk_cargo_verified_gross_mass_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);

-- ========= compliance --> cargo (5 constraint(s)) =========
-- Requires: compliance schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);

-- ========= compliance --> customer (1 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ADD CONSTRAINT `fk_compliance_customs_broker_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= compliance --> finance (17 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ADD CONSTRAINT `fk_compliance_hs_code_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ADD CONSTRAINT `fk_compliance_isps_facility_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ADD CONSTRAINT `fk_compliance_isps_facility_record_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ADD CONSTRAINT `fk_compliance_import_export_permit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `shipping_ports_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `shipping_ports_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= compliance --> masterdata (40 constraint(s)) =========
-- Requires: compliance schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ADD CONSTRAINT `fk_compliance_isps_facility_record_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ADD CONSTRAINT `fk_compliance_isps_facility_record_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ADD CONSTRAINT `fk_compliance_import_export_permit_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ADD CONSTRAINT `fk_compliance_import_export_permit_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ADD CONSTRAINT `fk_compliance_trade_restriction_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ADD CONSTRAINT `fk_compliance_trade_restriction_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ADD CONSTRAINT `fk_compliance_customs_broker_edi_partner_id` FOREIGN KEY (`edi_partner_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`edi_partner`(`edi_partner_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ADD CONSTRAINT `fk_compliance_customs_broker_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ADD CONSTRAINT `fk_compliance_customs_broker_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);

-- ========= compliance --> security (7 constraint(s)) =========
-- Requires: compliance schema, security schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);

-- ========= compliance --> terminal (2 constraint(s)) =========
-- Requires: compliance schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_container_visit_id` FOREIGN KEY (`container_visit_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`container_visit`(`container_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_terminal`(`terminal_id`);

-- ========= compliance --> vessel (11 constraint(s)) =========
-- Requires: compliance schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_bunker_operation_id` FOREIGN KEY (`bunker_operation_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`bunker_operation`(`bunker_operation_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);

-- ========= customer --> cargo (6 constraint(s)) =========
-- Requires: customer schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_handling_order_id` FOREIGN KEY (`handling_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`handling_order`(`handling_order_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_demurrage_detention_id` FOREIGN KEY (`demurrage_detention_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`demurrage_detention`(`demurrage_detention_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);

-- ========= customer --> compliance (15 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`credit_assessment` ADD CONSTRAINT `fk_customer_credit_assessment_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`credit_assessment` ADD CONSTRAINT `fk_customer_credit_assessment_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);

-- ========= customer --> finance (12 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_profile` ADD CONSTRAINT `fk_customer_sla_profile_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`credit_assessment` ADD CONSTRAINT `fk_customer_credit_assessment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`credit_assessment` ADD CONSTRAINT `fk_customer_credit_assessment_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`relationship_manager` ADD CONSTRAINT `fk_customer_relationship_manager_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);

-- ========= customer --> infrastructure (8 constraint(s)) =========
-- Requires: customer schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_profile` ADD CONSTRAINT `fk_customer_sla_profile_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`relationship_manager` ADD CONSTRAINT `fk_customer_relationship_manager_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`permit`(`permit_id`);

-- ========= customer --> masterdata (23 constraint(s)) =========
-- Requires: customer schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_community_participant` ADD CONSTRAINT `fk_customer_port_community_participant_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_community_participant` ADD CONSTRAINT `fk_customer_port_community_participant_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_community_participant` ADD CONSTRAINT `fk_customer_port_community_participant_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_profile` ADD CONSTRAINT `fk_customer_sla_profile_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_profile` ADD CONSTRAINT `fk_customer_sla_profile_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_profile` ADD CONSTRAINT `fk_customer_sla_profile_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_profile` ADD CONSTRAINT `fk_customer_sla_profile_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_profile` ADD CONSTRAINT `fk_customer_sla_profile_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`relationship_manager` ADD CONSTRAINT `fk_customer_relationship_manager_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);

-- ========= customer --> security (4 constraint(s)) =========
-- Requires: customer schema, security schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_access_point_id` FOREIGN KEY (`access_point_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_point`(`access_point_id`);

-- ========= customer --> tariff (2 constraint(s)) =========
-- Requires: customer schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`participant_account` ADD CONSTRAINT `fk_customer_participant_account_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);

-- ========= customer --> vessel (3 constraint(s)) =========
-- Requires: customer schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`customer`.`sla_performance` ADD CONSTRAINT `fk_customer_sla_performance_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`customer`.`port_access_permit` ADD CONSTRAINT `fk_customer_port_access_permit_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);

-- ========= finance --> billing (4 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `shipping_ports_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= finance --> compliance (1 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);

-- ========= finance --> customer (2 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);

-- ========= finance --> infrastructure (1 constraint(s)) =========
-- Requires: finance schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_project_id` FOREIGN KEY (`project_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`project`(`project_id`);

-- ========= finance --> intermodal (2 constraint(s)) =========
-- Requires: finance schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_haulier_id` FOREIGN KEY (`haulier_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`haulier`(`haulier_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_rail_operator_id` FOREIGN KEY (`rail_operator_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_operator`(`rail_operator_id`);

-- ========= finance --> masterdata (18 constraint(s)) =========
-- Requires: finance schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`cost_centre` ADD CONSTRAINT `fk_finance_cost_centre_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`profit_centre` ADD CONSTRAINT `fk_finance_profit_centre_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);

-- ========= finance --> security (1 constraint(s)) =========
-- Requires: finance schema, security schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);

-- ========= finance --> terminal (1 constraint(s)) =========
-- Requires: finance schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_terminal`(`terminal_id`);

-- ========= infrastructure --> booking (1 constraint(s)) =========
-- Requires: infrastructure schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);

-- ========= infrastructure --> compliance (11 constraint(s)) =========
-- Requires: infrastructure schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`channel` ADD CONSTRAINT `fk_infrastructure_channel_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`permit` ADD CONSTRAINT `fk_infrastructure_permit_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`weighing_station` ADD CONSTRAINT `fk_infrastructure_weighing_station_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`facility` ADD CONSTRAINT `fk_infrastructure_facility_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);

-- ========= infrastructure --> customer (13 constraint(s)) =========
-- Requires: infrastructure schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`depth_survey` ADD CONSTRAINT `fk_infrastructure_depth_survey_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`structural_inspection` ADD CONSTRAINT `fk_infrastructure_structural_inspection_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`permit` ADD CONSTRAINT `fk_infrastructure_permit_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal` ADD CONSTRAINT `fk_infrastructure_infrastructure_terminal_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`facility` ADD CONSTRAINT `fk_infrastructure_facility_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`facility` ADD CONSTRAINT `fk_infrastructure_facility_facility_terminal_operator_port_community_participant_id` FOREIGN KEY (`facility_terminal_operator_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= infrastructure --> finance (34 constraint(s)) =========
-- Requires: infrastructure schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`quay_wall` ADD CONSTRAINT `fk_infrastructure_quay_wall_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`quay_wall` ADD CONSTRAINT `fk_infrastructure_quay_wall_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`navigational_aid` ADD CONSTRAINT `fk_infrastructure_navigational_aid_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`navigational_aid` ADD CONSTRAINT `fk_infrastructure_navigational_aid_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`channel` ADD CONSTRAINT `fk_infrastructure_channel_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`channel` ADD CONSTRAINT `fk_infrastructure_channel_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`depth_survey` ADD CONSTRAINT `fk_infrastructure_depth_survey_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`structural_inspection` ADD CONSTRAINT `fk_infrastructure_structural_inspection_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`structural_inspection` ADD CONSTRAINT `fk_infrastructure_structural_inspection_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`permit` ADD CONSTRAINT `fk_infrastructure_permit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal` ADD CONSTRAINT `fk_infrastructure_infrastructure_terminal_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal` ADD CONSTRAINT `fk_infrastructure_infrastructure_terminal_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal` ADD CONSTRAINT `fk_infrastructure_infrastructure_terminal_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`weighing_station` ADD CONSTRAINT `fk_infrastructure_weighing_station_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`weighing_station` ADD CONSTRAINT `fk_infrastructure_weighing_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`facility` ADD CONSTRAINT `fk_infrastructure_facility_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`facility` ADD CONSTRAINT `fk_infrastructure_facility_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port` ADD CONSTRAINT `fk_infrastructure_port_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port` ADD CONSTRAINT `fk_infrastructure_port_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);

-- ========= infrastructure --> masterdata (35 constraint(s)) =========
-- Requires: infrastructure schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`quay_wall` ADD CONSTRAINT `fk_infrastructure_quay_wall_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`quay_wall` ADD CONSTRAINT `fk_infrastructure_quay_wall_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`quay_wall` ADD CONSTRAINT `fk_infrastructure_quay_wall_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`terminal_zone` ADD CONSTRAINT `fk_infrastructure_terminal_zone_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`navigational_aid` ADD CONSTRAINT `fk_infrastructure_navigational_aid_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`channel` ADD CONSTRAINT `fk_infrastructure_channel_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`channel` ADD CONSTRAINT `fk_infrastructure_channel_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`depth_survey` ADD CONSTRAINT `fk_infrastructure_depth_survey_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`depth_survey` ADD CONSTRAINT `fk_infrastructure_depth_survey_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`anchorage_area` ADD CONSTRAINT `fk_infrastructure_anchorage_area_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`anchorage_area` ADD CONSTRAINT `fk_infrastructure_anchorage_area_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal` ADD CONSTRAINT `fk_infrastructure_infrastructure_terminal_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal` ADD CONSTRAINT `fk_infrastructure_infrastructure_terminal_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal` ADD CONSTRAINT `fk_infrastructure_infrastructure_terminal_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal` ADD CONSTRAINT `fk_infrastructure_infrastructure_terminal_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`facility` ADD CONSTRAINT `fk_infrastructure_facility_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`facility` ADD CONSTRAINT `fk_infrastructure_facility_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`facility` ADD CONSTRAINT `fk_infrastructure_facility_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port` ADD CONSTRAINT `fk_infrastructure_port_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port` ADD CONSTRAINT `fk_infrastructure_port_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);

-- ========= infrastructure --> security (16 constraint(s)) =========
-- Requires: infrastructure schema, security schema
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`berth` ADD CONSTRAINT `fk_infrastructure_berth_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`warehouse` ADD CONSTRAINT `fk_infrastructure_warehouse_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`navigational_aid` ADD CONSTRAINT `fk_infrastructure_navigational_aid_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`channel` ADD CONSTRAINT `fk_infrastructure_channel_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`depth_survey` ADD CONSTRAINT `fk_infrastructure_depth_survey_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`dredging_campaign` ADD CONSTRAINT `fk_infrastructure_dredging_campaign_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_access_point_id` FOREIGN KEY (`access_point_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_point`(`access_point_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`port_gate` ADD CONSTRAINT `fk_infrastructure_port_gate_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`project` ADD CONSTRAINT `fk_infrastructure_project_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`structural_inspection` ADD CONSTRAINT `fk_infrastructure_structural_inspection_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`structural_inspection` ADD CONSTRAINT `fk_infrastructure_structural_inspection_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`closure` ADD CONSTRAINT `fk_infrastructure_closure_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`permit` ADD CONSTRAINT `fk_infrastructure_permit_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal` ADD CONSTRAINT `fk_infrastructure_infrastructure_terminal_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`infrastructure`.`weighing_station` ADD CONSTRAINT `fk_infrastructure_weighing_station_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);

-- ========= intermodal --> booking (18 constraint(s)) =========
-- Requires: intermodal schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_truck_gate_booking_id` FOREIGN KEY (`truck_gate_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`truck_gate_booking`(`truck_gate_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_slot_reservation_id` FOREIGN KEY (`slot_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`slot_reservation`(`slot_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_truck_gate_booking_id` FOREIGN KEY (`truck_gate_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`truck_gate_booking`(`truck_gate_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_slot_reservation_id` FOREIGN KEY (`slot_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`slot_reservation`(`slot_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_slot_reservation_id` FOREIGN KEY (`slot_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`slot_reservation`(`slot_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_slot_reservation_id` FOREIGN KEY (`slot_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`slot_reservation`(`slot_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_slot_reservation_id` FOREIGN KEY (`slot_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`slot_reservation`(`slot_reservation_id`);

-- ========= intermodal --> cargo (24 constraint(s)) =========
-- Requires: intermodal schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_handling_order_id` FOREIGN KEY (`handling_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`handling_order`(`handling_order_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_dangerous_goods_declaration_id` FOREIGN KEY (`dangerous_goods_declaration_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration`(`dangerous_goods_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_dangerous_goods_declaration_id` FOREIGN KEY (`dangerous_goods_declaration_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration`(`dangerous_goods_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_verified_gross_mass_id` FOREIGN KEY (`verified_gross_mass_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`verified_gross_mass`(`verified_gross_mass_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_handling_order_id` FOREIGN KEY (`handling_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`handling_order`(`handling_order_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_dangerous_goods_declaration_id` FOREIGN KEY (`dangerous_goods_declaration_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration`(`dangerous_goods_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);

-- ========= intermodal --> compliance (36 constraint(s)) =========
-- Requires: intermodal schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon` ADD CONSTRAINT `fk_intermodal_rail_wagon_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_document`(`trade_document_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_document`(`trade_document_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_document`(`trade_document_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_document`(`trade_document_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_document`(`trade_document_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_trade_document_id` FOREIGN KEY (`trade_document_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_document`(`trade_document_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);

-- ========= intermodal --> customer (15 constraint(s)) =========
-- Requires: intermodal schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_port_access_permit_id` FOREIGN KEY (`port_access_permit_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_access_permit`(`port_access_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_port_access_permit_id` FOREIGN KEY (`port_access_permit_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_access_permit`(`port_access_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_tertiary_transport_carrier_participant_account_id` FOREIGN KEY (`tertiary_transport_carrier_participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);

-- ========= intermodal --> finance (17 constraint(s)) =========
-- Requires: intermodal schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon` ADD CONSTRAINT `fk_intermodal_rail_wagon_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon` ADD CONSTRAINT `fk_intermodal_rail_wagon_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= intermodal --> infrastructure (24 constraint(s)) =========
-- Requires: intermodal schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_weighing_station_id` FOREIGN KEY (`weighing_station_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`weighing_station`(`weighing_station_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_weighing_station_id` FOREIGN KEY (`weighing_station_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`weighing_station`(`weighing_station_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_weighing_station_id` FOREIGN KEY (`weighing_station_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`weighing_station`(`weighing_station_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);

-- ========= intermodal --> masterdata (30 constraint(s)) =========
-- Requires: intermodal schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon` ADD CONSTRAINT `fk_intermodal_rail_wagon_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_leg_port_location_id` FOREIGN KEY (`leg_port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_edi_partner_id` FOREIGN KEY (`edi_partner_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`edi_partner`(`edi_partner_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_edi_partner_id` FOREIGN KEY (`edi_partner_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`edi_partner`(`edi_partner_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);

-- ========= intermodal --> security (15 constraint(s)) =========
-- Requires: intermodal schema, security schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_access_point_id` FOREIGN KEY (`access_point_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_point`(`access_point_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_access_event_id` FOREIGN KEY (`access_event_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_event`(`access_event_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_access_point_id` FOREIGN KEY (`access_point_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_point`(`access_point_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`haulier` ADD CONSTRAINT `fk_intermodal_haulier_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_operator` ADD CONSTRAINT `fk_intermodal_rail_operator_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);

-- ========= intermodal --> tariff (30 constraint(s)) =========
-- Requires: intermodal schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_storage_tariff_id` FOREIGN KEY (`storage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`storage_tariff`(`storage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`icd_facility` ADD CONSTRAINT `fk_intermodal_icd_facility_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`transport_order` ADD CONSTRAINT `fk_intermodal_transport_order_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`service` ADD CONSTRAINT `fk_intermodal_service_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);

-- ========= intermodal --> terminal (4 constraint(s)) =========
-- Requires: intermodal schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_terminal`(`terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_visit` ADD CONSTRAINT `fk_intermodal_truck_visit_gate_transaction_id` FOREIGN KEY (`gate_transaction_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`gate_transaction`(`gate_transaction_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_berth_allocation_id` FOREIGN KEY (`berth_allocation_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`berth_allocation`(`berth_allocation_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_terminal`(`terminal_id`);

-- ========= intermodal --> vessel (6 constraint(s)) =========
-- Requires: intermodal schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_visit` ADD CONSTRAINT `fk_intermodal_rail_visit_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`truck_appointment` ADD CONSTRAINT `fk_intermodal_truck_appointment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`drayage_order` ADD CONSTRAINT `fk_intermodal_drayage_order_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`leg` ADD CONSTRAINT `fk_intermodal_leg_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`rail_wagon_load` ADD CONSTRAINT `fk_intermodal_rail_wagon_load_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`intermodal`.`slot_booking` ADD CONSTRAINT `fk_intermodal_slot_booking_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= marine --> billing (10 constraint(s)) =========
-- Requires: marine schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug_assignment` ADD CONSTRAINT `fk_marine_tug_assignment_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);

-- ========= marine --> booking (10 constraint(s)) =========
-- Requires: marine schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_pre_arrival_id` FOREIGN KEY (`pre_arrival_id`) REFERENCES `shipping_ports_ecm`.`booking`.`pre_arrival`(`pre_arrival_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_booking_service_order_id` FOREIGN KEY (`booking_service_order_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_service_order`(`booking_service_order_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_booking_service_order_id` FOREIGN KEY (`booking_service_order_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_service_order`(`booking_service_order_id`);

-- ========= marine --> compliance (5 constraint(s)) =========
-- Requires: marine schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_exemption` ADD CONSTRAINT `fk_marine_pilotage_exemption_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);

-- ========= marine --> customer (15 constraint(s)) =========
-- Requires: marine schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`surveyor` ADD CONSTRAINT `fk_marine_surveyor_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_tertiary_marine_approved_mooring_provider_port_community_participant_id` FOREIGN KEY (`tertiary_marine_approved_mooring_provider_port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= marine --> finance (20 constraint(s)) =========
-- Requires: marine schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot` ADD CONSTRAINT `fk_marine_pilot_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug_assignment` ADD CONSTRAINT `fk_marine_tug_assignment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug_assignment` ADD CONSTRAINT `fk_marine_tug_assignment_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= marine --> infrastructure (34 constraint(s)) =========
-- Requires: marine schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot` ADD CONSTRAINT `fk_marine_pilot_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_quay_wall_id` FOREIGN KEY (`quay_wall_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`quay_wall`(`quay_wall_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`surveyor` ADD CONSTRAINT `fk_marine_surveyor_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_quay_wall_id` FOREIGN KEY (`quay_wall_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`quay_wall`(`quay_wall_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_navigational_aid_id` FOREIGN KEY (`navigational_aid_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`navigational_aid`(`navigational_aid_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_quay_wall_id` FOREIGN KEY (`quay_wall_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`quay_wall`(`quay_wall_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`facility`(`facility_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_exemption` ADD CONSTRAINT `fk_marine_pilotage_exemption_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug_assignment` ADD CONSTRAINT `fk_marine_tug_assignment_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug_assignment` ADD CONSTRAINT `fk_marine_tug_assignment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`weather_tide_window` ADD CONSTRAINT `fk_marine_weather_tide_window_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`weather_tide_window` ADD CONSTRAINT `fk_marine_weather_tide_window_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`weather_tide_window` ADD CONSTRAINT `fk_marine_weather_tide_window_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`weather_tide_window` ADD CONSTRAINT `fk_marine_weather_tide_window_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_route` ADD CONSTRAINT `fk_marine_pilotage_route_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_route` ADD CONSTRAINT `fk_marine_pilotage_route_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_route` ADD CONSTRAINT `fk_marine_pilotage_route_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);

-- ========= marine --> intermodal (3 constraint(s)) =========
-- Requires: marine schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_icd_facility_id` FOREIGN KEY (`icd_facility_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`icd_facility`(`icd_facility_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`transport_order`(`transport_order_id`);

-- ========= marine --> masterdata (30 constraint(s)) =========
-- Requires: marine schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot` ADD CONSTRAINT `fk_marine_pilot_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot` ADD CONSTRAINT `fk_marine_pilot_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug` ADD CONSTRAINT `fk_marine_tug_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`surveyor` ADD CONSTRAINT `fk_marine_surveyor_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`surveyor` ADD CONSTRAINT `fk_marine_surveyor_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_exemption` ADD CONSTRAINT `fk_marine_pilotage_exemption_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_exemption` ADD CONSTRAINT `fk_marine_pilotage_exemption_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`weather_tide_window` ADD CONSTRAINT `fk_marine_weather_tide_window_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_route` ADD CONSTRAINT `fk_marine_pilotage_route_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);

-- ========= marine --> security (7 constraint(s)) =========
-- Requires: marine schema, security schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilot` ADD CONSTRAINT `fk_marine_pilot_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`surveyor` ADD CONSTRAINT `fk_marine_surveyor_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`tug_assignment` ADD CONSTRAINT `fk_marine_tug_assignment_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= marine --> tariff (9 constraint(s)) =========
-- Requires: marine schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_mooring_tariff_id` FOREIGN KEY (`mooring_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`mooring_tariff`(`mooring_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_exemption` ADD CONSTRAINT `fk_marine_pilotage_exemption_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_mooring_tariff_id` FOREIGN KEY (`mooring_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`mooring_tariff`(`mooring_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_port_dues_schedule_id` FOREIGN KEY (`port_dues_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_dues_schedule`(`port_dues_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_route` ADD CONSTRAINT `fk_marine_pilotage_route_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);

-- ========= marine --> vessel (16 constraint(s)) =========
-- Requires: marine schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`pilotage_assignment` ADD CONSTRAINT `fk_marine_pilotage_assignment_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`voyage`(`voyage_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_agent_appointment_id` FOREIGN KEY (`agent_appointment_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`towage_order` ADD CONSTRAINT `fk_marine_towage_order_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`mooring_operation` ADD CONSTRAINT `fk_marine_mooring_operation_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`launch_dispatch` ADD CONSTRAINT `fk_marine_launch_dispatch_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`survey_appointment` ADD CONSTRAINT `fk_marine_survey_appointment_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_incident` ADD CONSTRAINT `fk_marine_marine_incident_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marpol_operation` ADD CONSTRAINT `fk_marine_marpol_operation_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_agent_appointment_id` FOREIGN KEY (`agent_appointment_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`marine`.`marine_service_order` ADD CONSTRAINT `fk_marine_marine_service_order_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);

-- ========= security --> compliance (5 constraint(s)) =========
-- Requires: security schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ADD CONSTRAINT `fk_security_facility_security_plan_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ADD CONSTRAINT `fk_security_zone_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ADD CONSTRAINT `fk_security_access_credential_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ADD CONSTRAINT `fk_security_access_credential_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);

-- ========= security --> customer (2 constraint(s)) =========
-- Requires: security schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ADD CONSTRAINT `fk_security_access_credential_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ADD CONSTRAINT `fk_security_access_credential_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= security --> finance (2 constraint(s)) =========
-- Requires: security schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ADD CONSTRAINT `fk_security_facility_security_plan_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= security --> masterdata (7 constraint(s)) =========
-- Requires: security schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ADD CONSTRAINT `fk_security_facility_security_plan_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ADD CONSTRAINT `fk_security_facility_security_plan_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ADD CONSTRAINT `fk_security_zone_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ADD CONSTRAINT `fk_security_access_point_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ADD CONSTRAINT `fk_security_access_point_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ADD CONSTRAINT `fk_security_marsec_level_change_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);

-- ========= tariff --> compliance (11 constraint(s)) =========
-- Requires: tariff schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_tariff` ADD CONSTRAINT `fk_tariff_port_tariff_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`surcharge_rule` ADD CONSTRAINT `fk_tariff_surcharge_rule_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`towage_tariff` ADD CONSTRAINT `fk_tariff_towage_tariff_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);

-- ========= tariff --> customer (2 constraint(s)) =========
-- Requires: tariff schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= tariff --> finance (33 constraint(s)) =========
-- Requires: tariff schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_tariff` ADD CONSTRAINT `fk_tariff_port_tariff_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_tariff` ADD CONSTRAINT `fk_tariff_port_tariff_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_tariff` ADD CONSTRAINT `fk_tariff_port_tariff_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_tariff` ADD CONSTRAINT `fk_tariff_port_tariff_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`thc_schedule` ADD CONSTRAINT `fk_tariff_thc_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`thc_schedule` ADD CONSTRAINT `fk_tariff_thc_schedule_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`demurrage_schedule` ADD CONSTRAINT `fk_tariff_demurrage_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`demurrage_schedule` ADD CONSTRAINT `fk_tariff_demurrage_schedule_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`detention_schedule` ADD CONSTRAINT `fk_tariff_detention_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`surcharge_rule` ADD CONSTRAINT `fk_tariff_surcharge_rule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`discount_scheme` ADD CONSTRAINT `fk_tariff_discount_scheme_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`free_time_allowance` ADD CONSTRAINT `fk_tariff_free_time_allowance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`towage_tariff` ADD CONSTRAINT `fk_tariff_towage_tariff_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`towage_tariff` ADD CONSTRAINT `fk_tariff_towage_tariff_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`mooring_tariff` ADD CONSTRAINT `fk_tariff_mooring_tariff_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);

-- ========= tariff --> infrastructure (26 constraint(s)) =========
-- Requires: tariff schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_tariff` ADD CONSTRAINT `fk_tariff_port_tariff_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card_line` ADD CONSTRAINT `fk_tariff_rate_card_line_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`thc_schedule` ADD CONSTRAINT `fk_tariff_thc_schedule_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`thc_schedule` ADD CONSTRAINT `fk_tariff_thc_schedule_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`demurrage_schedule` ADD CONSTRAINT `fk_tariff_demurrage_schedule_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`surcharge_rule` ADD CONSTRAINT `fk_tariff_surcharge_rule_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`discount_scheme` ADD CONSTRAINT `fk_tariff_discount_scheme_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`free_time_allowance` ADD CONSTRAINT `fk_tariff_free_time_allowance_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`towage_tariff` ADD CONSTRAINT `fk_tariff_towage_tariff_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`towage_tariff` ADD CONSTRAINT `fk_tariff_towage_tariff_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`towage_tariff` ADD CONSTRAINT `fk_tariff_towage_tariff_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`mooring_tariff` ADD CONSTRAINT `fk_tariff_mooring_tariff_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`mooring_tariff` ADD CONSTRAINT `fk_tariff_mooring_tariff_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);

-- ========= tariff --> masterdata (35 constraint(s)) =========
-- Requires: tariff schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_tariff` ADD CONSTRAINT `fk_tariff_port_tariff_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_tariff` ADD CONSTRAINT `fk_tariff_port_tariff_un_locode_id` FOREIGN KEY (`un_locode_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`un_locode`(`un_locode_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`item` ADD CONSTRAINT `fk_tariff_item_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card` ADD CONSTRAINT `fk_tariff_rate_card_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card_line` ADD CONSTRAINT `fk_tariff_rate_card_line_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`rate_card_line` ADD CONSTRAINT `fk_tariff_rate_card_line_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`thc_schedule` ADD CONSTRAINT `fk_tariff_thc_schedule_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`thc_schedule` ADD CONSTRAINT `fk_tariff_thc_schedule_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`wharfage_schedule` ADD CONSTRAINT `fk_tariff_wharfage_schedule_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pilotage_tariff` ADD CONSTRAINT `fk_tariff_pilotage_tariff_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`storage_tariff` ADD CONSTRAINT `fk_tariff_storage_tariff_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`demurrage_schedule` ADD CONSTRAINT `fk_tariff_demurrage_schedule_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`demurrage_schedule` ADD CONSTRAINT `fk_tariff_demurrage_schedule_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`detention_schedule` ADD CONSTRAINT `fk_tariff_detention_schedule_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`detention_schedule` ADD CONSTRAINT `fk_tariff_detention_schedule_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`surcharge_rule` ADD CONSTRAINT `fk_tariff_surcharge_rule_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`discount_scheme` ADD CONSTRAINT `fk_tariff_discount_scheme_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`pricing_rule` ADD CONSTRAINT `fk_tariff_pricing_rule_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`free_time_allowance` ADD CONSTRAINT `fk_tariff_free_time_allowance_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`free_time_allowance` ADD CONSTRAINT `fk_tariff_free_time_allowance_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`towage_tariff` ADD CONSTRAINT `fk_tariff_towage_tariff_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`towage_tariff` ADD CONSTRAINT `fk_tariff_towage_tariff_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`mooring_tariff` ADD CONSTRAINT `fk_tariff_mooring_tariff_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`mooring_tariff` ADD CONSTRAINT `fk_tariff_mooring_tariff_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`tariff`.`port_dues_schedule` ADD CONSTRAINT `fk_tariff_port_dues_schedule_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);

-- ========= tariff --> security (1 constraint(s)) =========
-- Requires: tariff schema, security schema
ALTER TABLE `shipping_ports_ecm`.`tariff`.`surcharge_rule` ADD CONSTRAINT `fk_tariff_surcharge_rule_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);

-- ========= terminal --> billing (8 constraint(s)) =========
-- Requires: terminal schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`reefer_monitoring` ADD CONSTRAINT `fk_terminal_reefer_monitoring_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice_line`(`invoice_line_id`);

-- ========= terminal --> booking (10 constraint(s)) =========
-- Requires: terminal schema, booking schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_slot_reservation_id` FOREIGN KEY (`slot_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`slot_reservation`(`slot_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_truck_gate_booking_id` FOREIGN KEY (`truck_gate_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`truck_gate_booking`(`truck_gate_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_truck_gate_booking_id` FOREIGN KEY (`truck_gate_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`truck_gate_booking`(`truck_gate_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_voyage_nomination_id` FOREIGN KEY (`voyage_nomination_id`) REFERENCES `shipping_ports_ecm`.`booking`.`voyage_nomination`(`voyage_nomination_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_berth_reservation_id` FOREIGN KEY (`berth_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`berth_reservation`(`berth_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_booking_service_order_id` FOREIGN KEY (`booking_service_order_id`) REFERENCES `shipping_ports_ecm`.`booking`.`booking_service_order`(`booking_service_order_id`);

-- ========= terminal --> cargo (22 constraint(s)) =========
-- Requires: terminal schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_slot` ADD CONSTRAINT `fk_terminal_yard_slot_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_handling_order_id` FOREIGN KEY (`handling_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`handling_order`(`handling_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_verified_gross_mass_id` FOREIGN KEY (`verified_gross_mass_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`verified_gross_mass`(`verified_gross_mass_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_dangerous_goods_declaration_id` FOREIGN KEY (`dangerous_goods_declaration_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration`(`dangerous_goods_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_verified_gross_mass_id` FOREIGN KEY (`verified_gross_mass_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`verified_gross_mass`(`verified_gross_mass_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_container_preadvice_id` FOREIGN KEY (`container_preadvice_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container_preadvice`(`container_preadvice_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_dangerous_goods_declaration_id` FOREIGN KEY (`dangerous_goods_declaration_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration`(`dangerous_goods_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_handling_order_id` FOREIGN KEY (`handling_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`handling_order`(`handling_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_dangerous_goods_declaration_id` FOREIGN KEY (`dangerous_goods_declaration_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration`(`dangerous_goods_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_handling_order_id` FOREIGN KEY (`handling_order_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`handling_order`(`handling_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`reefer_monitoring` ADD CONSTRAINT `fk_terminal_reefer_monitoring_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_container_id` FOREIGN KEY (`container_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`container`(`container_id`);

-- ========= terminal --> compliance (12 constraint(s)) =========
-- Requires: terminal schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);

-- ========= terminal --> customer (9 constraint(s)) =========
-- Requires: terminal schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `shipping_ports_ecm`.`customer`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_participant_account_id` FOREIGN KEY (`participant_account_id`) REFERENCES `shipping_ports_ecm`.`customer`.`participant_account`(`participant_account_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `shipping_ports_ecm`.`customer`.`service_request`(`service_request_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_terminal` ADD CONSTRAINT `fk_terminal_terminal_terminal_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= terminal --> finance (20 constraint(s)) =========
-- Requires: terminal schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_block` ADD CONSTRAINT `fk_terminal_yard_block_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_block` ADD CONSTRAINT `fk_terminal_yard_block_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_block` ADD CONSTRAINT `fk_terminal_yard_block_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`reefer_monitoring` ADD CONSTRAINT `fk_terminal_reefer_monitoring_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment` ADD CONSTRAINT `fk_terminal_equipment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment` ADD CONSTRAINT `fk_terminal_equipment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `shipping_ports_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment` ADD CONSTRAINT `fk_terminal_equipment_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_lane` ADD CONSTRAINT `fk_terminal_gate_lane_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_terminal` ADD CONSTRAINT `fk_terminal_terminal_terminal_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `shipping_ports_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_terminal` ADD CONSTRAINT `fk_terminal_terminal_terminal_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);

-- ========= terminal --> infrastructure (9 constraint(s)) =========
-- Requires: terminal schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_block` ADD CONSTRAINT `fk_terminal_yard_block_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_weighing_station_id` FOREIGN KEY (`weighing_station_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`weighing_station`(`weighing_station_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_weighing_station_id` FOREIGN KEY (`weighing_station_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`weighing_station`(`weighing_station_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`warehouse`(`warehouse_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment` ADD CONSTRAINT `fk_terminal_equipment_terminal_zone_id` FOREIGN KEY (`terminal_zone_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`terminal_zone`(`terminal_zone_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_lane` ADD CONSTRAINT `fk_terminal_gate_lane_port_gate_id` FOREIGN KEY (`port_gate_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port_gate`(`port_gate_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_terminal` ADD CONSTRAINT `fk_terminal_terminal_terminal_port_id` FOREIGN KEY (`port_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`port`(`port_id`);

-- ========= terminal --> intermodal (13 constraint(s)) =========
-- Requires: terminal schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_slot` ADD CONSTRAINT `fk_terminal_yard_slot_icd_facility_id` FOREIGN KEY (`icd_facility_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`icd_facility`(`icd_facility_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_slot` ADD CONSTRAINT `fk_terminal_yard_slot_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`transport_order`(`transport_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_drayage_order_id` FOREIGN KEY (`drayage_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`drayage_order`(`drayage_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_haulier_id` FOREIGN KEY (`haulier_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`haulier`(`haulier_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_truck_appointment_id` FOREIGN KEY (`truck_appointment_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_appointment`(`truck_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_drayage_order_id` FOREIGN KEY (`drayage_order_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`drayage_order`(`drayage_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_haulier_id` FOREIGN KEY (`haulier_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`haulier`(`haulier_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_truck_appointment_id` FOREIGN KEY (`truck_appointment_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_appointment`(`truck_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_truck_appointment_id` FOREIGN KEY (`truck_appointment_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`truck_appointment`(`truck_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_service_id` FOREIGN KEY (`service_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`service`(`service_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_rail_visit_id` FOREIGN KEY (`rail_visit_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`rail_visit`(`rail_visit_id`);

-- ========= terminal --> marine (5 constraint(s)) =========
-- Requires: terminal schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_marine_service_order_id` FOREIGN KEY (`marine_service_order_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_service_order`(`marine_service_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_pilotage_assignment_id` FOREIGN KEY (`pilotage_assignment_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_assignment`(`pilotage_assignment_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_pilotage_exemption_id` FOREIGN KEY (`pilotage_exemption_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_exemption`(`pilotage_exemption_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_towage_order_id` FOREIGN KEY (`towage_order_id`) REFERENCES `shipping_ports_ecm`.`marine`.`towage_order`(`towage_order_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_weather_tide_window_id` FOREIGN KEY (`weather_tide_window_id`) REFERENCES `shipping_ports_ecm`.`marine`.`weather_tide_window`(`weather_tide_window_id`);

-- ========= terminal --> masterdata (17 constraint(s)) =========
-- Requires: terminal schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_block` ADD CONSTRAINT `fk_terminal_yard_block_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_block` ADD CONSTRAINT `fk_terminal_yard_block_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_slot` ADD CONSTRAINT `fk_terminal_yard_slot_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`container_type`(`container_type_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_imdg_class_id` FOREIGN KEY (`imdg_class_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`imdg_class`(`imdg_class_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`reefer_monitoring` ADD CONSTRAINT `fk_terminal_reefer_monitoring_commodity_code_id` FOREIGN KEY (`commodity_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`commodity_code`(`commodity_code_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_service_code_id` FOREIGN KEY (`service_code_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`service_code`(`service_code_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment` ADD CONSTRAINT `fk_terminal_equipment_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_terminal` ADD CONSTRAINT `fk_terminal_terminal_terminal_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);

-- ========= terminal --> security (13 constraint(s)) =========
-- Requires: terminal schema, security schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`yard_block` ADD CONSTRAINT `fk_terminal_yard_block_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_transaction` ADD CONSTRAINT `fk_terminal_gate_transaction_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment` ADD CONSTRAINT `fk_terminal_equipment_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_lane` ADD CONSTRAINT `fk_terminal_gate_lane_access_point_id` FOREIGN KEY (`access_point_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_point`(`access_point_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_lane` ADD CONSTRAINT `fk_terminal_gate_lane_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_terminal` ADD CONSTRAINT `fk_terminal_terminal_terminal_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);

-- ========= terminal --> tariff (13 constraint(s)) =========
-- Requires: terminal schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_demurrage_schedule_id` FOREIGN KEY (`demurrage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`demurrage_schedule`(`demurrage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_detention_schedule_id` FOREIGN KEY (`detention_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`detention_schedule`(`detention_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_storage_tariff_id` FOREIGN KEY (`storage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`storage_tariff`(`storage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_thc_schedule_id` FOREIGN KEY (`thc_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`thc_schedule`(`thc_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_mooring_tariff_id` FOREIGN KEY (`mooring_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`mooring_tariff`(`mooring_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_port_dues_schedule_id` FOREIGN KEY (`port_dues_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_dues_schedule`(`port_dues_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_service_order` ADD CONSTRAINT `fk_terminal_terminal_service_order_item_id` FOREIGN KEY (`item_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`item`(`item_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`terminal_terminal` ADD CONSTRAINT `fk_terminal_terminal_terminal_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);

-- ========= terminal --> vessel (7 constraint(s)) =========
-- Requires: terminal schema, vessel schema
ALTER TABLE `shipping_ports_ecm`.`terminal`.`container_visit` ADD CONSTRAINT `fk_terminal_container_visit_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`gate_appointment` ADD CONSTRAINT `fk_terminal_gate_appointment_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`equipment_dispatch` ADD CONSTRAINT `fk_terminal_equipment_dispatch_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`vessel_bay_plan` ADD CONSTRAINT `fk_terminal_vessel_bay_plan_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_call_id` FOREIGN KEY (`call_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`call`(`call_id`);
ALTER TABLE `shipping_ports_ecm`.`terminal`.`berth_allocation` ADD CONSTRAINT `fk_terminal_berth_allocation_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `shipping_ports_ecm`.`vessel`.`vessel`(`vessel_id`);

-- ========= vessel --> billing (7 constraint(s)) =========
-- Requires: vessel schema, billing schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`owner` ADD CONSTRAINT `fk_vessel_owner_receivable_account_id` FOREIGN KEY (`receivable_account_id`) REFERENCES `shipping_ports_ecm`.`billing`.`receivable_account`(`receivable_account_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_receivable_account_id` FOREIGN KEY (`receivable_account_id`) REFERENCES `shipping_ports_ecm`.`billing`.`receivable_account`(`receivable_account_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `shipping_ports_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `shipping_ports_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= vessel --> cargo (1 constraint(s)) =========
-- Requires: vessel schema, cargo schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `shipping_ports_ecm`.`cargo`.`shipment`(`shipment_id`);

-- ========= vessel --> compliance (4 constraint(s)) =========
-- Requires: vessel schema, compliance schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`certificate` ADD CONSTRAINT `fk_vessel_certificate_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);

-- ========= vessel --> customer (8 constraint(s)) =========
-- Requires: vessel schema, customer schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`owner` ADD CONSTRAINT `fk_vessel_owner_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`voyage` ADD CONSTRAINT `fk_vessel_voyage_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_contact_person_id` FOREIGN KEY (`contact_person_id`) REFERENCES `shipping_ports_ecm`.`customer`.`contact_person`(`contact_person_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_schedule` ADD CONSTRAINT `fk_vessel_call_schedule_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`service_route` ADD CONSTRAINT `fk_vessel_service_route_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`port_call` ADD CONSTRAINT `fk_vessel_port_call_port_community_participant_id` FOREIGN KEY (`port_community_participant_id`) REFERENCES `shipping_ports_ecm`.`customer`.`port_community_participant`(`port_community_participant_id`);

-- ========= vessel --> finance (15 constraint(s)) =========
-- Requires: vessel schema, finance schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`voyage` ADD CONSTRAINT `fk_vessel_voyage_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `shipping_ports_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `shipping_ports_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`service_route` ADD CONSTRAINT `fk_vessel_service_route_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `shipping_ports_ecm`.`finance`.`accrual`(`accrual_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `shipping_ports_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `shipping_ports_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `shipping_ports_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= vessel --> infrastructure (13 constraint(s)) =========
-- Requires: vessel schema, infrastructure schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_anchorage_area_id` FOREIGN KEY (`anchorage_area_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`anchorage_area`(`anchorage_area_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vts_log` ADD CONSTRAINT `fk_vessel_vts_log_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`channel`(`channel_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_schedule` ADD CONSTRAINT `fk_vessel_call_schedule_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`service_route` ADD CONSTRAINT `fk_vessel_service_route_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_berth_id` FOREIGN KEY (`berth_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`berth`(`berth_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`port_call` ADD CONSTRAINT `fk_vessel_port_call_infrastructure_terminal_id` FOREIGN KEY (`infrastructure_terminal_id`) REFERENCES `shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`(`infrastructure_terminal_id`);

-- ========= vessel --> intermodal (1 constraint(s)) =========
-- Requires: vessel schema, intermodal schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`service_route` ADD CONSTRAINT `fk_vessel_service_route_service_id` FOREIGN KEY (`service_id`) REFERENCES `shipping_ports_ecm`.`intermodal`.`service`(`service_id`);

-- ========= vessel --> marine (17 constraint(s)) =========
-- Requires: vessel schema, marine schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_pilotage_route_id` FOREIGN KEY (`pilotage_route_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_route`(`pilotage_route_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_marine_incident_id` FOREIGN KEY (`marine_incident_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_incident`(`marine_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_weather_tide_window_id` FOREIGN KEY (`weather_tide_window_id`) REFERENCES `shipping_ports_ecm`.`marine`.`weather_tide_window`(`weather_tide_window_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_pilot_id` FOREIGN KEY (`pilot_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilot`(`pilot_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_pilotage_assignment_id` FOREIGN KEY (`pilotage_assignment_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_assignment`(`pilotage_assignment_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_towage_order_id` FOREIGN KEY (`towage_order_id`) REFERENCES `shipping_ports_ecm`.`marine`.`towage_order`(`towage_order_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_weather_tide_window_id` FOREIGN KEY (`weather_tide_window_id`) REFERENCES `shipping_ports_ecm`.`marine`.`weather_tide_window`(`weather_tide_window_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vts_log` ADD CONSTRAINT `fk_vessel_vts_log_marine_incident_id` FOREIGN KEY (`marine_incident_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_incident`(`marine_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vts_log` ADD CONSTRAINT `fk_vessel_vts_log_pilot_id` FOREIGN KEY (`pilot_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilot`(`pilot_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vts_log` ADD CONSTRAINT `fk_vessel_vts_log_pilotage_assignment_id` FOREIGN KEY (`pilotage_assignment_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_assignment`(`pilotage_assignment_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`certificate` ADD CONSTRAINT `fk_vessel_certificate_marine_incident_id` FOREIGN KEY (`marine_incident_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_incident`(`marine_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_schedule` ADD CONSTRAINT `fk_vessel_call_schedule_pilotage_route_id` FOREIGN KEY (`pilotage_route_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_route`(`pilotage_route_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_survey_appointment_id` FOREIGN KEY (`survey_appointment_id`) REFERENCES `shipping_ports_ecm`.`marine`.`survey_appointment`(`survey_appointment_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_surveyor_id` FOREIGN KEY (`surveyor_id`) REFERENCES `shipping_ports_ecm`.`marine`.`surveyor`(`surveyor_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`service_route` ADD CONSTRAINT `fk_vessel_service_route_pilotage_route_id` FOREIGN KEY (`pilotage_route_id`) REFERENCES `shipping_ports_ecm`.`marine`.`pilotage_route`(`pilotage_route_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_marine_service_order_id` FOREIGN KEY (`marine_service_order_id`) REFERENCES `shipping_ports_ecm`.`marine`.`marine_service_order`(`marine_service_order_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`bunker_operation` ADD CONSTRAINT `fk_vessel_bunker_operation_weather_tide_window_id` FOREIGN KEY (`weather_tide_window_id`) REFERENCES `shipping_ports_ecm`.`marine`.`weather_tide_window`(`weather_tide_window_id`);

-- ========= vessel --> masterdata (13 constraint(s)) =========
-- Requires: vessel schema, masterdata schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vessel` ADD CONSTRAINT `fk_vessel_vessel_flag_state_id` FOREIGN KEY (`flag_state_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`flag_state`(`flag_state_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vessel` ADD CONSTRAINT `fk_vessel_vessel_vessel_master_id` FOREIGN KEY (`vessel_master_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_master`(`vessel_master_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vessel` ADD CONSTRAINT `fk_vessel_vessel_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`owner` ADD CONSTRAINT `fk_vessel_owner_country_id` FOREIGN KEY (`country_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`voyage` ADD CONSTRAINT `fk_vessel_voyage_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`certificate` ADD CONSTRAINT `fk_vessel_certificate_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_vessel_type_id` FOREIGN KEY (`vessel_type_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`vessel_type`(`vessel_type_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_schedule` ADD CONSTRAINT `fk_vessel_call_schedule_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_cargo_category_id` FOREIGN KEY (`cargo_category_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`cargo_category`(`cargo_category_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`service_route` ADD CONSTRAINT `fk_vessel_service_route_shipping_line_id` FOREIGN KEY (`shipping_line_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`shipping_line`(`shipping_line_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`port_call` ADD CONSTRAINT `fk_vessel_port_call_port_location_id` FOREIGN KEY (`port_location_id`) REFERENCES `shipping_ports_ecm`.`masterdata`.`port_location`(`port_location_id`);

-- ========= vessel --> security (9 constraint(s)) =========
-- Requires: vessel schema, security schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vts_log` ADD CONSTRAINT `fk_vessel_vts_log_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vts_log` ADD CONSTRAINT `fk_vessel_vts_log_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`psc_inspection` ADD CONSTRAINT `fk_vessel_psc_inspection_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`agent_appointment` ADD CONSTRAINT `fk_vessel_agent_appointment_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);

-- ========= vessel --> tariff (13 constraint(s)) =========
-- Requires: vessel schema, tariff schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call` ADD CONSTRAINT `fk_vessel_call_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`voyage` ADD CONSTRAINT `fk_vessel_voyage_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`voyage` ADD CONSTRAINT `fk_vessel_voyage_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`voyage` ADD CONSTRAINT `fk_vessel_voyage_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`anchorage` ADD CONSTRAINT `fk_vessel_anchorage_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_pilotage_tariff_id` FOREIGN KEY (`pilotage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`pilotage_tariff`(`pilotage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`movement` ADD CONSTRAINT `fk_vessel_movement_towage_tariff_id` FOREIGN KEY (`towage_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`towage_tariff`(`towage_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`call_schedule` ADD CONSTRAINT `fk_vessel_call_schedule_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`draft_survey` ADD CONSTRAINT `fk_vessel_draft_survey_wharfage_schedule_id` FOREIGN KEY (`wharfage_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`wharfage_schedule`(`wharfage_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`service_route` ADD CONSTRAINT `fk_vessel_service_route_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`rate_card`(`rate_card_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`port_call` ADD CONSTRAINT `fk_vessel_port_call_port_dues_schedule_id` FOREIGN KEY (`port_dues_schedule_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_dues_schedule`(`port_dues_schedule_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`port_call` ADD CONSTRAINT `fk_vessel_port_call_port_tariff_id` FOREIGN KEY (`port_tariff_id`) REFERENCES `shipping_ports_ecm`.`tariff`.`port_tariff`(`port_tariff_id`);

-- ========= vessel --> terminal (3 constraint(s)) =========
-- Requires: vessel schema, terminal schema
ALTER TABLE `shipping_ports_ecm`.`vessel`.`voyage` ADD CONSTRAINT `fk_vessel_voyage_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_terminal`(`terminal_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`vts_log` ADD CONSTRAINT `fk_vessel_vts_log_berth_allocation_id` FOREIGN KEY (`berth_allocation_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`berth_allocation`(`berth_allocation_id`);
ALTER TABLE `shipping_ports_ecm`.`vessel`.`service_route` ADD CONSTRAINT `fk_vessel_service_route_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `shipping_ports_ecm`.`terminal`.`terminal_terminal`(`terminal_id`);

