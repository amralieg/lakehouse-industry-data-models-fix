-- Cross-Domain Foreign Keys for Business: Chemical Mfg | Version: v1_mvm
-- Generated on: 2026-05-06 14:37:13
-- Total cross-domain FK constraints: 1338
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, customer, ehs, finance, inventory, logistics, maintenance, planning, product, production, quality, rawmaterial, sales, supply

-- ========= billing --> customer (17 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_case_id` FOREIGN KEY (`case_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);

-- ========= billing --> ehs (8 constraint(s)) =========
-- Requires: billing schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_hazop_study_id` FOREIGN KEY (`hazop_study_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`hazop_study`(`hazop_study_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_inspection_audit_id` FOREIGN KEY (`inspection_audit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`inspection_audit`(`inspection_audit_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_inspection_audit_id` FOREIGN KEY (`inspection_audit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`inspection_audit`(`inspection_audit_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);

-- ========= billing --> finance (26 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ADD CONSTRAINT `fk_billing_billing_party_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= billing --> inventory (5 constraint(s)) =========
-- Requires: billing schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_physical_inventory_count_id` FOREIGN KEY (`physical_inventory_count_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`physical_inventory_count`(`physical_inventory_count_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= billing --> maintenance (12 constraint(s)) =========
-- Requires: billing schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_work_order_operation_id` FOREIGN KEY (`work_order_operation_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order_operation`(`work_order_operation_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_breakdown_event_id` FOREIGN KEY (`breakdown_event_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`breakdown_event`(`breakdown_event_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);

-- ========= billing --> planning (6 constraint(s)) =========
-- Requires: billing schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_allocation_id` FOREIGN KEY (`customer_allocation_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`customer_allocation`(`customer_allocation_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_customer_allocation_id` FOREIGN KEY (`customer_allocation_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`customer_allocation`(`customer_allocation_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);

-- ========= billing --> product (17 constraint(s)) =========
-- Requires: billing schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_order_confirmation_id` FOREIGN KEY (`order_confirmation_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order_confirmation`(`order_confirmation_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_outbound_delivery_id` FOREIGN KEY (`outbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`product`.`outbound_delivery`(`outbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_returns_order_id` FOREIGN KEY (`returns_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`returns_order`(`returns_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_returns_order_id` FOREIGN KEY (`returns_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`returns_order`(`returns_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_returns_order_id` FOREIGN KEY (`returns_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`returns_order`(`returns_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_outbound_delivery_id` FOREIGN KEY (`outbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`product`.`outbound_delivery`(`outbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);

-- ========= billing --> production (7 constraint(s)) =========
-- Requires: billing schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);

-- ========= billing --> quality (3 constraint(s)) =========
-- Requires: billing schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_coc_record_id` FOREIGN KEY (`coc_record_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`coc_record`(`coc_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);

-- ========= billing --> rawmaterial (10 constraint(s)) =========
-- Requires: billing schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_coa_document_id` FOREIGN KEY (`coa_document_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`coa_document`(`coa_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_coa_document_id` FOREIGN KEY (`coa_document_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`coa_document`(`coa_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_incoming_inspection_id` FOREIGN KEY (`incoming_inspection_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection`(`incoming_inspection_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_coa_document_id` FOREIGN KEY (`coa_document_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`coa_document`(`coa_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= billing --> sales (15 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_distributor_agreement_id` FOREIGN KEY (`distributor_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`distributor_agreement`(`distributor_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_price_agreement_line_id` FOREIGN KEY (`price_agreement_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement_line`(`price_agreement_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_rebate_agreement_id` FOREIGN KEY (`rebate_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`rebate_agreement`(`rebate_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_distributor_agreement_id` FOREIGN KEY (`distributor_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`distributor_agreement`(`distributor_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_rebate_agreement_id` FOREIGN KEY (`rebate_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`rebate_agreement`(`rebate_agreement_id`);

-- ========= billing --> supply (5 constraint(s)) =========
-- Requires: billing schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_contract_price_id` FOREIGN KEY (`contract_price_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract_price`(`contract_price_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);

-- ========= customer --> billing (2 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_term`(`payment_term_id`);

-- ========= customer --> ehs (4 constraint(s)) =========
-- Requires: customer schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`regulatory_profile` ADD CONSTRAINT `fk_customer_regulatory_profile_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`regulatory_profile` ADD CONSTRAINT `fk_customer_regulatory_profile_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);

-- ========= customer --> finance (18 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`site` ADD CONSTRAINT `fk_customer_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`site` ADD CONSTRAINT `fk_customer_site_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`regulatory_profile` ADD CONSTRAINT `fk_customer_regulatory_profile_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= customer --> inventory (3 constraint(s)) =========
-- Requires: customer schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`site` ADD CONSTRAINT `fk_customer_site_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`regulatory_profile` ADD CONSTRAINT `fk_customer_regulatory_profile_hazmat_storage_rule_id` FOREIGN KEY (`hazmat_storage_rule_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`hazmat_storage_rule`(`hazmat_storage_rule_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= customer --> logistics (1 constraint(s)) =========
-- Requires: customer schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= customer --> maintenance (5 constraint(s)) =========
-- Requires: customer schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_notification_id` FOREIGN KEY (`notification_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`notification`(`notification_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= customer --> product (10 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_outbound_delivery_id` FOREIGN KEY (`outbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`product`.`outbound_delivery`(`outbound_delivery_id`);

-- ========= customer --> quality (6 constraint(s)) =========
-- Requires: customer schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`regulatory_profile` ADD CONSTRAINT `fk_customer_regulatory_profile_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_coa_template_id` FOREIGN KEY (`coa_template_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`coa_template`(`coa_template_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);

-- ========= customer --> rawmaterial (3 constraint(s)) =========
-- Requires: customer schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`regulatory_profile` ADD CONSTRAINT `fk_customer_regulatory_profile_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);

-- ========= customer --> sales (3 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);

-- ========= customer --> supply (4 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`site` ADD CONSTRAINT `fk_customer_site_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= ehs --> billing (1 constraint(s)) =========
-- Requires: ehs schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= ehs --> customer (3 constraint(s)) =========
-- Requires: ehs schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);

-- ========= ehs --> finance (24 constraint(s)) =========
-- Requires: ehs schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ADD CONSTRAINT `fk_ehs_waste_stream_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ADD CONSTRAINT `fk_ehs_regulatory_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ADD CONSTRAINT `fk_ehs_regulatory_submission_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ADD CONSTRAINT `fk_ehs_operating_permit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ADD CONSTRAINT `fk_ehs_operating_permit_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ADD CONSTRAINT `fk_ehs_inspection_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ADD CONSTRAINT `fk_ehs_inspection_audit_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ADD CONSTRAINT `fk_ehs_process_safety_info_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ADD CONSTRAINT `fk_ehs_facility_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ADD CONSTRAINT `fk_ehs_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ADD CONSTRAINT `fk_ehs_facility_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`facility` ADD CONSTRAINT `fk_ehs_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= ehs --> inventory (10 constraint(s)) =========
-- Requires: ehs schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_tank_id` FOREIGN KEY (`tank_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`tank`(`tank_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_tank_farm_level_id` FOREIGN KEY (`tank_farm_level_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`tank_farm_level`(`tank_farm_level_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ADD CONSTRAINT `fk_ehs_emission_source_tank_id` FOREIGN KEY (`tank_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`tank`(`tank_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ADD CONSTRAINT `fk_ehs_inspection_audit_tank_id` FOREIGN KEY (`tank_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`tank`(`tank_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ADD CONSTRAINT `fk_ehs_inspection_audit_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= ehs --> logistics (6 constraint(s)) =========
-- Requires: ehs schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_hazmat_declaration_id` FOREIGN KEY (`hazmat_declaration_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`hazmat_declaration`(`hazmat_declaration_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= ehs --> maintenance (10 constraint(s)) =========
-- Requires: ehs schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ADD CONSTRAINT `fk_ehs_inspection_audit_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);

-- ========= ehs --> product (13 constraint(s)) =========
-- Requires: ehs schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ADD CONSTRAINT `fk_ehs_emission_source_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ADD CONSTRAINT `fk_ehs_waste_stream_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ADD CONSTRAINT `fk_ehs_regulatory_submission_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ADD CONSTRAINT `fk_ehs_process_safety_info_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ADD CONSTRAINT `fk_ehs_safety_data_sheet_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= ehs --> production (5 constraint(s)) =========
-- Requires: ehs schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_production_deviation_id` FOREIGN KEY (`production_deviation_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_deviation`(`production_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ADD CONSTRAINT `fk_ehs_emission_source_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_unit`(`process_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);

-- ========= ehs --> quality (1 constraint(s)) =========
-- Requires: ehs schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`capa`(`capa_id`);

-- ========= ehs --> rawmaterial (25 constraint(s)) =========
-- Requires: ehs schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ADD CONSTRAINT `fk_ehs_emission_source_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ADD CONSTRAINT `fk_ehs_waste_stream_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ADD CONSTRAINT `fk_ehs_waste_stream_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ADD CONSTRAINT `fk_ehs_regulatory_submission_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ADD CONSTRAINT `fk_ehs_regulatory_submission_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`regulatory_submission` ADD CONSTRAINT `fk_ehs_regulatory_submission_reach_registration_id` FOREIGN KEY (`reach_registration_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`reach_registration`(`reach_registration_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ADD CONSTRAINT `fk_ehs_process_safety_info_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ADD CONSTRAINT `fk_ehs_process_safety_info_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ADD CONSTRAINT `fk_ehs_safety_data_sheet_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ADD CONSTRAINT `fk_ehs_safety_data_sheet_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= ehs --> supply (14 constraint(s)) =========
-- Requires: ehs schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_vendor_audit_id` FOREIGN KEY (`vendor_audit_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_audit`(`vendor_audit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_vendor_qualification_id` FOREIGN KEY (`vendor_qualification_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_qualification`(`vendor_qualification_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ADD CONSTRAINT `fk_ehs_safety_data_sheet_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= finance --> product (6 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= finance --> production (2 constraint(s)) =========
-- Requires: finance schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);

-- ========= finance --> rawmaterial (1 constraint(s)) =========
-- Requires: finance schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= inventory --> billing (3 constraint(s)) =========
-- Requires: inventory schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_billing_schedule_id` FOREIGN KEY (`billing_schedule_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_schedule`(`billing_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`interplant_transfer` ADD CONSTRAINT `fk_inventory_interplant_transfer_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= inventory --> customer (3 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_case_id` FOREIGN KEY (`case_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);

-- ========= inventory --> ehs (4 constraint(s)) =========
-- Requires: inventory schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank` ADD CONSTRAINT `fk_inventory_tank_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);

-- ========= inventory --> finance (22 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`physical_inventory_count` ADD CONSTRAINT `fk_inventory_physical_inventory_count_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`interplant_transfer` ADD CONSTRAINT `fk_inventory_interplant_transfer_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank` ADD CONSTRAINT `fk_inventory_tank_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= inventory --> maintenance (10 constraint(s)) =========
-- Requires: inventory schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_notification_id` FOREIGN KEY (`notification_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`notification`(`notification_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank` ADD CONSTRAINT `fk_inventory_tank_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);

-- ========= inventory --> planning (12 constraint(s)) =========
-- Requires: inventory schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_inventory_target_id` FOREIGN KEY (`inventory_target_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`inventory_target`(`inventory_target_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_campaign_plan_id` FOREIGN KEY (`campaign_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`campaign_plan`(`campaign_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`planned_order`(`planned_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_customer_allocation_id` FOREIGN KEY (`customer_allocation_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`customer_allocation`(`customer_allocation_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_customer_allocation_id` FOREIGN KEY (`customer_allocation_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`customer_allocation`(`customer_allocation_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`interplant_transfer` ADD CONSTRAINT `fk_inventory_interplant_transfer_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);

-- ========= inventory --> product (13 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_outbound_delivery_id` FOREIGN KEY (`outbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`product`.`outbound_delivery`(`outbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_returns_order_id` FOREIGN KEY (`returns_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`returns_order`(`returns_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`interplant_transfer` ADD CONSTRAINT `fk_inventory_interplant_transfer_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank` ADD CONSTRAINT `fk_inventory_tank_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= inventory --> production (12 constraint(s)) =========
-- Requires: inventory schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);

-- ========= inventory --> quality (12 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`interplant_transfer` ADD CONSTRAINT `fk_inventory_interplant_transfer_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= inventory --> rawmaterial (18 constraint(s)) =========
-- Requires: inventory schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_incoming_inspection_id` FOREIGN KEY (`incoming_inspection_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection`(`incoming_inspection_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`hazmat_storage_rule` ADD CONSTRAINT `fk_inventory_hazmat_storage_rule_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`interplant_transfer` ADD CONSTRAINT `fk_inventory_interplant_transfer_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank` ADD CONSTRAINT `fk_inventory_tank_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= inventory --> sales (5 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_distributor_agreement_id` FOREIGN KEY (`distributor_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`distributor_agreement`(`distributor_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);

-- ========= inventory --> supply (10 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= logistics --> billing (6 constraint(s)) =========
-- Requires: logistics schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_billing_party_id` FOREIGN KEY (`billing_party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_party`(`billing_party_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_billing_schedule_id` FOREIGN KEY (`billing_schedule_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_schedule`(`billing_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= logistics --> customer (19 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`qualification`(`qualification_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_primary_bill_site_id` FOREIGN KEY (`primary_bill_site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_origin_location_site_id` FOREIGN KEY (`origin_location_site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_primary_freight_site_id` FOREIGN KEY (`primary_freight_site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_regulatory_profile_id` FOREIGN KEY (`regulatory_profile_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`regulatory_profile`(`regulatory_profile_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= logistics --> ehs (4 constraint(s)) =========
-- Requires: logistics schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);

-- ========= logistics --> finance (30 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= logistics --> inventory (6 constraint(s)) =========
-- Requires: logistics schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_tank_id` FOREIGN KEY (`tank_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`tank`(`tank_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= logistics --> maintenance (4 constraint(s)) =========
-- Requires: logistics schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);

-- ========= logistics --> planning (7 constraint(s)) =========
-- Requires: logistics schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_customer_allocation_id` FOREIGN KEY (`customer_allocation_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`customer_allocation`(`customer_allocation_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`planned_order`(`planned_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);

-- ========= logistics --> product (23 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_packaging_config_id` FOREIGN KEY (`packaging_config_id`) REFERENCES `chemical_mfg_ecm`.`product`.`packaging_config`(`packaging_config_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sds`(`sds_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_packaging_config_id` FOREIGN KEY (`packaging_config_id`) REFERENCES `chemical_mfg_ecm`.`product`.`packaging_config`(`packaging_config_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_outbound_delivery_id` FOREIGN KEY (`outbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`product`.`outbound_delivery`(`outbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sds`(`sds_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_outbound_delivery_id` FOREIGN KEY (`outbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`product`.`outbound_delivery`(`outbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_outbound_delivery_id` FOREIGN KEY (`outbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`product`.`outbound_delivery`(`outbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sds`(`sds_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sds`(`sds_id`);

-- ========= logistics --> production (7 constraint(s)) =========
-- Requires: logistics schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);

-- ========= logistics --> rawmaterial (8 constraint(s)) =========
-- Requires: logistics schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_coa_document_id` FOREIGN KEY (`coa_document_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`coa_document`(`coa_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);

-- ========= logistics --> sales (4 constraint(s)) =========
-- Requires: logistics schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_distributor_agreement_id` FOREIGN KEY (`distributor_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`distributor_agreement`(`distributor_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);

-- ========= logistics --> supply (2 constraint(s)) =========
-- Requires: logistics schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= maintenance --> customer (5 constraint(s)) =========
-- Requires: maintenance schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ADD CONSTRAINT `fk_maintenance_notification_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= maintenance --> ehs (7 constraint(s)) =========
-- Requires: maintenance schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_process_safety_info_id` FOREIGN KEY (`process_safety_info_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`process_safety_info`(`process_safety_info_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_inspection_audit_id` FOREIGN KEY (`inspection_audit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`inspection_audit`(`inspection_audit_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ADD CONSTRAINT `fk_maintenance_measurement_point_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`emission_source`(`emission_source_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_emission_event_id` FOREIGN KEY (`emission_event_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`emission_event`(`emission_event_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_hazop_study_id` FOREIGN KEY (`hazop_study_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`hazop_study`(`hazop_study_id`);

-- ========= maintenance --> finance (15 constraint(s)) =========
-- Requires: maintenance schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ADD CONSTRAINT `fk_maintenance_notification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ADD CONSTRAINT `fk_maintenance_maintenance_plant_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= maintenance --> planning (8 constraint(s)) =========
-- Requires: maintenance schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_campaign_plan_id` FOREIGN KEY (`campaign_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`campaign_plan`(`campaign_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ADD CONSTRAINT `fk_maintenance_notification_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ADD CONSTRAINT `fk_maintenance_schedule_call_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);

-- ========= maintenance --> product (1 constraint(s)) =========
-- Requires: maintenance schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= maintenance --> production (6 constraint(s)) =========
-- Requires: maintenance schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ADD CONSTRAINT `fk_maintenance_schedule_call_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ADD CONSTRAINT `fk_maintenance_measurement_point_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);

-- ========= maintenance --> rawmaterial (6 constraint(s)) =========
-- Requires: maintenance schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);

-- ========= maintenance --> sales (1 constraint(s)) =========
-- Requires: maintenance schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= maintenance --> supply (11 constraint(s)) =========
-- Requires: maintenance schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= planning --> customer (11 constraint(s)) =========
-- Requires: planning schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`qualification`(`qualification_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ADD CONSTRAINT `fk_planning_allocation_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`qualification`(`qualification_id`);

-- ========= planning --> ehs (11 constraint(s)) =========
-- Requires: planning schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_process_safety_info_id` FOREIGN KEY (`process_safety_info_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`process_safety_info`(`process_safety_info_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_hazop_study_id` FOREIGN KEY (`hazop_study_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`hazop_study`(`hazop_study_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);

-- ========= planning --> finance (34 constraint(s)) =========
-- Requires: planning schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ADD CONSTRAINT `fk_planning_forecast_version_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ADD CONSTRAINT `fk_planning_mrp_run_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ADD CONSTRAINT `fk_planning_allocation_rule_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= planning --> maintenance (11 constraint(s)) =========
-- Requires: planning schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);

-- ========= planning --> product (27 constraint(s)) =========
-- Requires: planning schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_packaging_config_id` FOREIGN KEY (`packaging_config_id`) REFERENCES `chemical_mfg_ecm`.`product`.`packaging_config`(`packaging_config_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_packaging_config_id` FOREIGN KEY (`packaging_config_id`) REFERENCES `chemical_mfg_ecm`.`product`.`packaging_config`(`packaging_config_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_packaging_config_id` FOREIGN KEY (`packaging_config_id`) REFERENCES `chemical_mfg_ecm`.`product`.`packaging_config`(`packaging_config_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ADD CONSTRAINT `fk_planning_allocation_rule_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);

-- ========= planning --> production (18 constraint(s)) =========
-- Requires: planning schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ADD CONSTRAINT `fk_planning_mrp_run_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);

-- ========= planning --> quality (1 constraint(s)) =========
-- Requires: planning schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);

-- ========= planning --> rawmaterial (14 constraint(s)) =========
-- Requires: planning schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_reach_registration_id` FOREIGN KEY (`reach_registration_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`reach_registration`(`reach_registration_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_supplier_material_id` FOREIGN KEY (`supplier_material_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`supplier_material`(`supplier_material_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ADD CONSTRAINT `fk_planning_allocation_rule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= planning --> sales (7 constraint(s)) =========
-- Requires: planning schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ADD CONSTRAINT `fk_planning_forecast_version_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_distributor_id` FOREIGN KEY (`distributor_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`distributor`(`distributor_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ADD CONSTRAINT `fk_planning_allocation_rule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);

-- ========= planning --> supply (8 constraint(s)) =========
-- Requires: planning schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);

-- ========= product --> customer (10 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_shipping_address_site_id` FOREIGN KEY (`shipping_address_site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ADD CONSTRAINT `fk_product_order_confirmation_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ADD CONSTRAINT `fk_product_outbound_delivery_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ADD CONSTRAINT `fk_product_product_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ADD CONSTRAINT `fk_product_returns_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ADD CONSTRAINT `fk_product_returns_order_case_id` FOREIGN KEY (`case_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`case`(`case_id`);

-- ========= product --> ehs (3 constraint(s)) =========
-- Requires: product schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ADD CONSTRAINT `fk_product_product_hold_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ADD CONSTRAINT `fk_product_returns_order_waste_disposal_record_id` FOREIGN KEY (`waste_disposal_record_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_disposal_record`(`waste_disposal_record_id`);

-- ========= product --> finance (16 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ADD CONSTRAINT `fk_product_reach_dossier_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ADD CONSTRAINT `fk_product_reach_dossier_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ADD CONSTRAINT `fk_product_order_confirmation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ADD CONSTRAINT `fk_product_returns_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= product --> inventory (7 constraint(s)) =========
-- Requires: product schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_hazmat_storage_rule_id` FOREIGN KEY (`hazmat_storage_rule_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`hazmat_storage_rule`(`hazmat_storage_rule_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ADD CONSTRAINT `fk_product_order_confirmation_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ADD CONSTRAINT `fk_product_outbound_delivery_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ADD CONSTRAINT `fk_product_outbound_delivery_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ADD CONSTRAINT `fk_product_product_hold_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ADD CONSTRAINT `fk_product_returns_order_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= product --> logistics (1 constraint(s)) =========
-- Requires: product schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ADD CONSTRAINT `fk_product_outbound_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= product --> maintenance (10 constraint(s)) =========
-- Requires: product schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ADD CONSTRAINT `fk_product_packaging_config_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ADD CONSTRAINT `fk_product_packaging_config_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ADD CONSTRAINT `fk_product_status_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ADD CONSTRAINT `fk_product_product_hold_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= product --> planning (5 constraint(s)) =========
-- Requires: product schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_customer_allocation_id` FOREIGN KEY (`customer_allocation_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`customer_allocation`(`customer_allocation_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_forecast_version_id` FOREIGN KEY (`forecast_version_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_customer_allocation_id` FOREIGN KEY (`customer_allocation_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`customer_allocation`(`customer_allocation_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`planned_order`(`planned_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);

-- ========= product --> rawmaterial (12 constraint(s)) =========
-- Requires: product schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ADD CONSTRAINT `fk_product_sds_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ADD CONSTRAINT `fk_product_product_ghs_classification_rawmaterial_ghs_classification_id` FOREIGN KEY (`rawmaterial_ghs_classification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification`(`rawmaterial_ghs_classification_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ADD CONSTRAINT `fk_product_regulatory_status_material_regulatory_status_id` FOREIGN KEY (`material_regulatory_status_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status`(`material_regulatory_status_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ADD CONSTRAINT `fk_product_composition_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ADD CONSTRAINT `fk_product_composition_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ADD CONSTRAINT `fk_product_composition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ADD CONSTRAINT `fk_product_composition_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ADD CONSTRAINT `fk_product_composition_supplier_material_id` FOREIGN KEY (`supplier_material_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`supplier_material`(`supplier_material_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ADD CONSTRAINT `fk_product_reach_dossier_reach_registration_id` FOREIGN KEY (`reach_registration_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`reach_registration`(`reach_registration_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= product --> sales (8 constraint(s)) =========
-- Requires: product schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_distributor_id` FOREIGN KEY (`distributor_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`distributor`(`distributor_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_opportunity_product_id` FOREIGN KEY (`opportunity_product_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity_product`(`opportunity_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote_line`(`quote_line_id`);

-- ========= product --> supply (9 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ADD CONSTRAINT `fk_product_composition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ADD CONSTRAINT `fk_product_reach_dossier_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order` ADD CONSTRAINT `fk_product_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_contract_price_id` FOREIGN KEY (`contract_price_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract_price`(`contract_price_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= production --> customer (7 constraint(s)) =========
-- Requires: production schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`qualification`(`qualification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`qualification`(`qualification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_regulatory_profile_id` FOREIGN KEY (`regulatory_profile_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`regulatory_profile`(`regulatory_profile_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`qualification`(`qualification_id`);

-- ========= production --> ehs (13 constraint(s)) =========
-- Requires: production schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_process_safety_info_id` FOREIGN KEY (`process_safety_info_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`process_safety_info`(`process_safety_info_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_hazop_study_id` FOREIGN KEY (`hazop_study_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`hazop_study`(`hazop_study_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ADD CONSTRAINT `fk_production_process_unit_hazop_study_id` FOREIGN KEY (`hazop_study_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`hazop_study`(`hazop_study_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ADD CONSTRAINT `fk_production_process_unit_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ADD CONSTRAINT `fk_production_production_plant_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);

-- ========= production --> finance (19 constraint(s)) =========
-- Requires: production schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ADD CONSTRAINT `fk_production_process_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ADD CONSTRAINT `fk_production_process_unit_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ADD CONSTRAINT `fk_production_production_plant_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ADD CONSTRAINT `fk_production_production_plant_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ADD CONSTRAINT `fk_production_resource_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ADD CONSTRAINT `fk_production_resource_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ADD CONSTRAINT `fk_production_bill_of_materials_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`standard_cost`(`standard_cost_id`);

-- ========= production --> inventory (13 constraint(s)) =========
-- Requires: production schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_storage_bin_id` FOREIGN KEY (`storage_bin_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`storage_bin`(`storage_bin_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ADD CONSTRAINT `fk_production_process_unit_tank_id` FOREIGN KEY (`tank_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`tank`(`tank_id`);

-- ========= production --> maintenance (18 constraint(s)) =========
-- Requires: production schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_notification_id` FOREIGN KEY (`notification_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`notification`(`notification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_breakdown_event_id` FOREIGN KEY (`breakdown_event_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`breakdown_event`(`breakdown_event_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_task_list_id` FOREIGN KEY (`task_list_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`task_list`(`task_list_id`);

-- ========= production --> planning (14 constraint(s)) =========
-- Requires: production schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_campaign_plan_id` FOREIGN KEY (`campaign_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`campaign_plan`(`campaign_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);

-- ========= production --> product (25 constraint(s)) =========
-- Requires: production schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= production --> quality (19 constraint(s)) =========
-- Requires: production schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_inspection_characteristic_id` FOREIGN KEY (`inspection_characteristic_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_characteristic`(`inspection_characteristic_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_spc_control_id` FOREIGN KEY (`spc_control_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`spc_control`(`spc_control_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_inspection_characteristic_id` FOREIGN KEY (`inspection_characteristic_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_characteristic`(`inspection_characteristic_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ADD CONSTRAINT `fk_production_bill_of_materials_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);

-- ========= production --> rawmaterial (17 constraint(s)) =========
-- Requires: production schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_supplier_material_id` FOREIGN KEY (`supplier_material_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`supplier_material`(`supplier_material_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= production --> sales (4 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= production --> supply (4 constraint(s)) =========
-- Requires: production schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);

-- ========= quality --> billing (1 constraint(s)) =========
-- Requires: quality schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= quality --> customer (3 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= quality --> ehs (23 constraint(s)) =========
-- Requires: quality schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ADD CONSTRAINT `fk_quality_test_method_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`facility`(`facility_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ADD CONSTRAINT `fk_quality_sampling_plan_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_emission_event_id` FOREIGN KEY (`emission_event_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`emission_event`(`emission_event_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_waste_disposal_record_id` FOREIGN KEY (`waste_disposal_record_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_disposal_record`(`waste_disposal_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_hazop_study_id` FOREIGN KEY (`hazop_study_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`hazop_study`(`hazop_study_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_incident_investigation_id` FOREIGN KEY (`incident_investigation_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`incident_investigation`(`incident_investigation_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_inspection_audit_id` FOREIGN KEY (`inspection_audit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`inspection_audit`(`inspection_audit_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_waste_disposal_record_id` FOREIGN KEY (`waste_disposal_record_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_disposal_record`(`waste_disposal_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ADD CONSTRAINT `fk_quality_spc_control_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`emission_source`(`emission_source_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ADD CONSTRAINT `fk_quality_quality_specification_process_safety_info_id` FOREIGN KEY (`process_safety_info_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`process_safety_info`(`process_safety_info_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);

-- ========= quality --> finance (12 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> inventory (10 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ADD CONSTRAINT `fk_quality_quality_specification_hazmat_storage_rule_id` FOREIGN KEY (`hazmat_storage_rule_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`hazmat_storage_rule`(`hazmat_storage_rule_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_storage_bin_id` FOREIGN KEY (`storage_bin_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`storage_bin`(`storage_bin_id`);

-- ========= quality --> logistics (5 constraint(s)) =========
-- Requires: quality schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_shipment_line_id` FOREIGN KEY (`shipment_line_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment_line`(`shipment_line_id`);

-- ========= quality --> maintenance (16 constraint(s)) =========
-- Requires: quality schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_breakdown_event_id` FOREIGN KEY (`breakdown_event_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`breakdown_event`(`breakdown_event_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_notification_id` FOREIGN KEY (`notification_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`notification`(`notification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ADD CONSTRAINT `fk_quality_spc_control_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ADD CONSTRAINT `fk_quality_spc_control_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);

-- ========= quality --> planning (4 constraint(s)) =========
-- Requires: quality schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`planned_order`(`planned_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_inventory_target_id` FOREIGN KEY (`inventory_target_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`inventory_target`(`inventory_target_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);

-- ========= quality --> product (35 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ADD CONSTRAINT `fk_quality_sampling_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ADD CONSTRAINT `fk_quality_sampling_plan_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_order_id` FOREIGN KEY (`order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order`(`order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ADD CONSTRAINT `fk_quality_spc_control_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ADD CONSTRAINT `fk_quality_quality_specification_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ADD CONSTRAINT `fk_quality_quality_specification_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ADD CONSTRAINT `fk_quality_quality_specification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ADD CONSTRAINT `fk_quality_coa_template_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ADD CONSTRAINT `fk_quality_coa_template_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);

-- ========= quality --> production (2 constraint(s)) =========
-- Requires: quality schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);

-- ========= quality --> rawmaterial (25 constraint(s)) =========
-- Requires: quality schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_coa_document_id` FOREIGN KEY (`coa_document_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`coa_document`(`coa_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_material_id` FOREIGN KEY (`supplier_material_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`supplier_material`(`supplier_material_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ADD CONSTRAINT `fk_quality_sampling_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_supplier_material_id` FOREIGN KEY (`supplier_material_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`supplier_material`(`supplier_material_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_material_id` FOREIGN KEY (`supplier_material_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`supplier_material`(`supplier_material_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ADD CONSTRAINT `fk_quality_spc_control_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ADD CONSTRAINT `fk_quality_quality_specification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ADD CONSTRAINT `fk_quality_quality_specification_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= quality --> sales (1 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote_line`(`quote_line_id`);

-- ========= quality --> supply (10 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_vendor_audit_id` FOREIGN KEY (`vendor_audit_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_audit`(`vendor_audit_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);

-- ========= rawmaterial --> customer (1 constraint(s)) =========
-- Requires: rawmaterial schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= rawmaterial --> finance (18 constraint(s)) =========
-- Requires: rawmaterial schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ADD CONSTRAINT `fk_rawmaterial_material_master_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ADD CONSTRAINT `fk_rawmaterial_material_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ADD CONSTRAINT `fk_rawmaterial_material_master_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ADD CONSTRAINT `fk_rawmaterial_material_specification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ADD CONSTRAINT `fk_rawmaterial_material_specification_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ADD CONSTRAINT `fk_rawmaterial_supplier_material_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ADD CONSTRAINT `fk_rawmaterial_supplier_material_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ADD CONSTRAINT `fk_rawmaterial_supplier_material_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ADD CONSTRAINT `fk_rawmaterial_material_qualification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ADD CONSTRAINT `fk_rawmaterial_material_qualification_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ADD CONSTRAINT `fk_rawmaterial_material_qualification_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ADD CONSTRAINT `fk_rawmaterial_reach_registration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ADD CONSTRAINT `fk_rawmaterial_reach_registration_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ADD CONSTRAINT `fk_rawmaterial_reach_registration_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= rawmaterial --> inventory (1 constraint(s)) =========
-- Requires: rawmaterial schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= rawmaterial --> supply (19 constraint(s)) =========
-- Requires: rawmaterial schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ADD CONSTRAINT `fk_rawmaterial_sds_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ADD CONSTRAINT `fk_rawmaterial_supplier_material_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ADD CONSTRAINT `fk_rawmaterial_supplier_material_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ADD CONSTRAINT `fk_rawmaterial_supplier_material_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ADD CONSTRAINT `fk_rawmaterial_material_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ADD CONSTRAINT `fk_rawmaterial_material_qualification_vendor_qualification_id` FOREIGN KEY (`vendor_qualification_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_qualification`(`vendor_qualification_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ADD CONSTRAINT `fk_rawmaterial_coa_document_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ADD CONSTRAINT `fk_rawmaterial_coa_document_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ADD CONSTRAINT `fk_rawmaterial_coa_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ADD CONSTRAINT `fk_rawmaterial_reach_registration_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ADD CONSTRAINT `fk_rawmaterial_reach_registration_vendor_qualification_id` FOREIGN KEY (`vendor_qualification_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_qualification`(`vendor_qualification_id`);

-- ========= sales --> customer (18 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_regulatory_profile_id` FOREIGN KEY (`regulatory_profile_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`regulatory_profile`(`regulatory_profile_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`qualification`(`qualification_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_regulatory_profile_id` FOREIGN KEY (`regulatory_profile_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`regulatory_profile`(`regulatory_profile_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`qualification`(`qualification_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ADD CONSTRAINT `fk_sales_distributor_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`qualification`(`qualification_id`);

-- ========= sales --> ehs (2 constraint(s)) =========
-- Requires: sales schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);

-- ========= sales --> finance (25 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ADD CONSTRAINT `fk_sales_territory_assignment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ADD CONSTRAINT `fk_sales_organization_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ADD CONSTRAINT `fk_sales_organization_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= sales --> inventory (1 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= sales --> maintenance (6 constraint(s)) =========
-- Requires: sales schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ADD CONSTRAINT `fk_sales_distributor_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ADD CONSTRAINT `fk_sales_organization_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);

-- ========= sales --> product (19 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_reach_dossier_id` FOREIGN KEY (`reach_dossier_id`) REFERENCES `chemical_mfg_ecm`.`product`.`reach_dossier`(`reach_dossier_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sds`(`sds_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_packaging_config_id` FOREIGN KEY (`packaging_config_id`) REFERENCES `chemical_mfg_ecm`.`product`.`packaging_config`(`packaging_config_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_packaging_config_id` FOREIGN KEY (`packaging_config_id`) REFERENCES `chemical_mfg_ecm`.`product`.`packaging_config`(`packaging_config_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `chemical_mfg_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `chemical_mfg_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `chemical_mfg_ecm`.`product`.`grade`(`grade_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_packaging_config_id` FOREIGN KEY (`packaging_config_id`) REFERENCES `chemical_mfg_ecm`.`product`.`packaging_config`(`packaging_config_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sds`(`sds_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_tds_id` FOREIGN KEY (`tds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`tds`(`tds_id`);

-- ========= sales --> quality (6 constraint(s)) =========
-- Requires: sales schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_coa_template_id` FOREIGN KEY (`coa_template_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`coa_template`(`coa_template_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);

-- ========= sales --> rawmaterial (6 constraint(s)) =========
-- Requires: sales schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_reach_registration_id` FOREIGN KEY (`reach_registration_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`reach_registration`(`reach_registration_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);

-- ========= sales --> supply (1 constraint(s)) =========
-- Requires: sales schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);

-- ========= supply --> billing (2 constraint(s)) =========
-- Requires: supply schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_billing_party_id` FOREIGN KEY (`billing_party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_party`(`billing_party_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_term`(`payment_term_id`);

-- ========= supply --> customer (1 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);

-- ========= supply --> ehs (4 constraint(s)) =========
-- Requires: supply schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ADD CONSTRAINT `fk_supply_vendor_qualification_inspection_audit_id` FOREIGN KEY (`inspection_audit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`inspection_audit`(`inspection_audit_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ADD CONSTRAINT `fk_supply_material_info_record_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);

-- ========= supply --> finance (26 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_cost_element_id` FOREIGN KEY (`cost_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_element`(`cost_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= supply --> inventory (3 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= supply --> logistics (7 constraint(s)) =========
-- Requires: supply schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ADD CONSTRAINT `fk_supply_asn_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ADD CONSTRAINT `fk_supply_source_list_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`freight_order`(`freight_order_id`);

-- ========= supply --> maintenance (1 constraint(s)) =========
-- Requires: supply schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= supply --> planning (3 constraint(s)) =========
-- Requires: supply schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);

-- ========= supply --> production (11 constraint(s)) =========
-- Requires: supply schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ADD CONSTRAINT `fk_supply_vendor_qualification_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ADD CONSTRAINT `fk_supply_source_list_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ADD CONSTRAINT `fk_supply_material_info_record_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);

-- ========= supply --> quality (8 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ADD CONSTRAINT `fk_supply_vendor_qualification_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ADD CONSTRAINT `fk_supply_vendor_qualification_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ADD CONSTRAINT `fk_supply_source_list_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ADD CONSTRAINT `fk_supply_material_info_record_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);

-- ========= supply --> rawmaterial (11 constraint(s)) =========
-- Requires: supply schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_contract_material_material_master_id` FOREIGN KEY (`contract_material_material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_primary_contract_material_master_id` FOREIGN KEY (`primary_contract_material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ADD CONSTRAINT `fk_supply_source_list_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ADD CONSTRAINT `fk_supply_material_info_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

