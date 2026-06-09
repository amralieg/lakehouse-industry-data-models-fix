-- Cross-Domain Foreign Keys for Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:23
-- Total cross-domain FK constraints: 1227
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, customer, ehs, finance, formulation, inventory, logistics, maintenance, order, planning, pricing, product, production, quality, rawmaterial, research, sales, supply, workforce

-- ========= billing --> customer (10 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_case_id` FOREIGN KEY (`case_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ADD CONSTRAINT `fk_billing_billing_rebate_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ADD CONSTRAINT `fk_billing_rebate_settlement_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ADD CONSTRAINT `fk_billing_dunning_notice_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= billing --> ehs (4 constraint(s)) =========
-- Requires: billing schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`emission_source`(`emission_source_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_operating_permit_id` FOREIGN KEY (`operating_permit_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);

-- ========= billing --> finance (8 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ADD CONSTRAINT `fk_billing_rebate_settlement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= billing --> formulation (3 constraint(s)) =========
-- Requires: billing schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ip_record_id` FOREIGN KEY (`ip_record_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`ip_record`(`ip_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_formula_change_request_id` FOREIGN KEY (`formula_change_request_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_change_request`(`formula_change_request_id`);

-- ========= billing --> maintenance (10 constraint(s)) =========
-- Requires: billing schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_work_order_operation_id` FOREIGN KEY (`work_order_operation_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order_operation`(`work_order_operation_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ADD CONSTRAINT `fk_billing_intercompany_billing_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ADD CONSTRAINT `fk_billing_dunning_notice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ADD CONSTRAINT `fk_billing_withholding_tax_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= billing --> planning (2 constraint(s)) =========
-- Requires: billing schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ADD CONSTRAINT `fk_billing_intercompany_billing_interplant_supply_plan_id` FOREIGN KEY (`interplant_supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`interplant_supply_plan`(`interplant_supply_plan_id`);

-- ========= billing --> pricing (6 constraint(s)) =========
-- Requires: billing schema, pricing schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ADD CONSTRAINT `fk_billing_billing_rebate_agreement_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ADD CONSTRAINT `fk_billing_rebate_settlement_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ADD CONSTRAINT `fk_billing_intercompany_billing_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`transfer_price`(`transfer_price_id`);

-- ========= billing --> product (7 constraint(s)) =========
-- Requires: billing schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_outbound_delivery_id` FOREIGN KEY (`outbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`product`.`outbound_delivery`(`outbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= billing --> production (3 constraint(s)) =========
-- Requires: billing schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);

-- ========= billing --> rawmaterial (6 constraint(s)) =========
-- Requires: billing schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ADD CONSTRAINT `fk_billing_intercompany_billing_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= billing --> research (4 constraint(s)) =========
-- Requires: billing schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);

-- ========= billing --> sales (9 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_price_agreement_line_id` FOREIGN KEY (`price_agreement_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement_line`(`price_agreement_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ADD CONSTRAINT `fk_billing_billing_rebate_agreement_sales_rebate_agreement_id` FOREIGN KEY (`sales_rebate_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`sales_rebate_agreement`(`sales_rebate_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ADD CONSTRAINT `fk_billing_rebate_settlement_sales_rebate_agreement_id` FOREIGN KEY (`sales_rebate_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`sales_rebate_agreement`(`sales_rebate_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);

-- ========= billing --> supply (5 constraint(s)) =========
-- Requires: billing schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ADD CONSTRAINT `fk_billing_billing_rebate_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);

-- ========= billing --> workforce (9 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_dispute_employee_id` FOREIGN KEY (`dispute_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_dispute_last_modified_by_user_employee_id` FOREIGN KEY (`dispute_last_modified_by_user_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ADD CONSTRAINT `fk_billing_rebate_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ADD CONSTRAINT `fk_billing_withholding_tax_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> billing (1 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= customer --> finance (5 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`site` ADD CONSTRAINT `fk_customer_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= customer --> inventory (2 constraint(s)) =========
-- Requires: customer schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`site` ADD CONSTRAINT `fk_customer_site_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`regulatory_profile` ADD CONSTRAINT `fk_customer_regulatory_profile_hazmat_storage_rule_id` FOREIGN KEY (`hazmat_storage_rule_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`hazmat_storage_rule`(`hazmat_storage_rule_id`);

-- ========= customer --> logistics (1 constraint(s)) =========
-- Requires: customer schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= customer --> product (6 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);

-- ========= customer --> production (1 constraint(s)) =========
-- Requires: customer schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`customer_lead` ADD CONSTRAINT `fk_customer_customer_lead_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);

-- ========= customer --> rawmaterial (1 constraint(s)) =========
-- Requires: customer schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`supply_contract` ADD CONSTRAINT `fk_customer_supply_contract_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= customer --> research (4 constraint(s)) =========
-- Requires: customer schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);

-- ========= customer --> sales (3 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`customer_lead` ADD CONSTRAINT `fk_customer_customer_lead_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= customer --> supply (2 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`site` ADD CONSTRAINT `fk_customer_site_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= customer --> workforce (12 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`site` ADD CONSTRAINT `fk_customer_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`regulatory_profile` ADD CONSTRAINT `fk_customer_regulatory_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`service_profile` ADD CONSTRAINT `fk_customer_service_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`service_profile` ADD CONSTRAINT `fk_customer_service_profile_tertiary_service_backup_tsr_employee_id` FOREIGN KEY (`tertiary_service_backup_tsr_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`qualification` ADD CONSTRAINT `fk_customer_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`status_history` ADD CONSTRAINT `fk_customer_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`customer_lead` ADD CONSTRAINT `fk_customer_customer_lead_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= ehs --> billing (2 constraint(s)) =========
-- Requires: ehs schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= ehs --> customer (10 constraint(s)) =========
-- Requires: ehs schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ADD CONSTRAINT `fk_ehs_chemical_exposure_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ADD CONSTRAINT `fk_ehs_emission_source_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ADD CONSTRAINT `fk_ehs_operating_permit_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ADD CONSTRAINT `fk_ehs_training_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ADD CONSTRAINT `fk_ehs_environmental_monitoring_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ADD CONSTRAINT `fk_ehs_tri_inventory_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ADD CONSTRAINT `fk_ehs_spill_release_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);

-- ========= ehs --> finance (14 constraint(s)) =========
-- Requires: ehs schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ADD CONSTRAINT `fk_ehs_ehs_regulatory_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`operating_permit` ADD CONSTRAINT `fk_ehs_operating_permit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ADD CONSTRAINT `fk_ehs_inspection_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ADD CONSTRAINT `fk_ehs_management_of_change_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ADD CONSTRAINT `fk_ehs_training_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ADD CONSTRAINT `fk_ehs_environmental_monitoring_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ADD CONSTRAINT `fk_ehs_spill_release_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`contractor_safety_record` ADD CONSTRAINT `fk_ehs_contractor_safety_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= ehs --> formulation (6 constraint(s)) =========
-- Requires: ehs schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ADD CONSTRAINT `fk_ehs_chemical_exposure_record_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ADD CONSTRAINT `fk_ehs_ehs_regulatory_submission_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);

-- ========= ehs --> inventory (3 constraint(s)) =========
-- Requires: ehs schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ADD CONSTRAINT `fk_ehs_chemical_exposure_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= ehs --> logistics (7 constraint(s)) =========
-- Requires: ehs schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ADD CONSTRAINT `fk_ehs_spill_release_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= ehs --> maintenance (19 constraint(s)) =========
-- Requires: ehs schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ADD CONSTRAINT `fk_ehs_hazop_node_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ADD CONSTRAINT `fk_ehs_chemical_exposure_record_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ADD CONSTRAINT `fk_ehs_chemical_exposure_record_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ADD CONSTRAINT `fk_ehs_inspection_audit_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ADD CONSTRAINT `fk_ehs_inspection_finding_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ADD CONSTRAINT `fk_ehs_inspection_finding_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ADD CONSTRAINT `fk_ehs_environmental_monitoring_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ADD CONSTRAINT `fk_ehs_ohs_risk_assessment_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ADD CONSTRAINT `fk_ehs_spill_release_event_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`control_device` ADD CONSTRAINT `fk_ehs_control_device_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);

-- ========= ehs --> product (19 constraint(s)) =========
-- Requires: ehs schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ADD CONSTRAINT `fk_ehs_hazop_node_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ADD CONSTRAINT `fk_ehs_chemical_exposure_record_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ADD CONSTRAINT `fk_ehs_emission_source_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_stream` ADD CONSTRAINT `fk_ehs_waste_stream_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ADD CONSTRAINT `fk_ehs_ehs_regulatory_submission_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ADD CONSTRAINT `fk_ehs_management_of_change_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ADD CONSTRAINT `fk_ehs_process_safety_info_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_data_sheet` ADD CONSTRAINT `fk_ehs_safety_data_sheet_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ADD CONSTRAINT `fk_ehs_environmental_monitoring_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ADD CONSTRAINT `fk_ehs_tri_inventory_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`spill_release_event` ADD CONSTRAINT `fk_ehs_spill_release_event_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= ehs --> production (7 constraint(s)) =========
-- Requires: ehs schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_production_deviation_id` FOREIGN KEY (`production_deviation_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_deviation`(`production_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ADD CONSTRAINT `fk_ehs_chemical_exposure_record_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_source` ADD CONSTRAINT `fk_ehs_emission_source_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_unit`(`process_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ADD CONSTRAINT `fk_ehs_environmental_monitoring_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);

-- ========= ehs --> quality (1 constraint(s)) =========
-- Requires: ehs schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`capa`(`capa_id`);

-- ========= ehs --> rawmaterial (5 constraint(s)) =========
-- Requires: ehs schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ADD CONSTRAINT `fk_ehs_chemical_exposure_record_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);

-- ========= ehs --> research (13 constraint(s)) =========
-- Requires: ehs schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emission_event` ADD CONSTRAINT `fk_ehs_emission_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ADD CONSTRAINT `fk_ehs_ehs_regulatory_submission_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ADD CONSTRAINT `fk_ehs_management_of_change_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`process_safety_info` ADD CONSTRAINT `fk_ehs_process_safety_info_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ADD CONSTRAINT `fk_ehs_training_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ADD CONSTRAINT `fk_ehs_environmental_monitoring_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ADD CONSTRAINT `fk_ehs_environmental_monitoring_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `chemical_mfg_ecm`.`research`.`sample`(`sample_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`tri_inventory` ADD CONSTRAINT `fk_ehs_tri_inventory_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ADD CONSTRAINT `fk_ehs_ohs_risk_assessment_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);

-- ========= ehs --> supply (7 constraint(s)) =========
-- Requires: ehs schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ADD CONSTRAINT `fk_ehs_chemical_exposure_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`waste_disposal_record` ADD CONSTRAINT `fk_ehs_waste_disposal_record_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ADD CONSTRAINT `fk_ehs_inspection_finding_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ADD CONSTRAINT `fk_ehs_training_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= ehs --> workforce (20 constraint(s)) =========
-- Requires: ehs schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`safety_incident` ADD CONSTRAINT `fk_ehs_safety_incident_tertiary_safety_investigation_lead_employee_id` FOREIGN KEY (`tertiary_safety_investigation_lead_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`incident_investigation` ADD CONSTRAINT `fk_ehs_incident_investigation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`capa_record` ADD CONSTRAINT `fk_ehs_capa_record_primary_capa_employee_id` FOREIGN KEY (`primary_capa_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_study` ADD CONSTRAINT `fk_ehs_hazop_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`hazop_node` ADD CONSTRAINT `fk_ehs_hazop_node_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`chemical_exposure_record` ADD CONSTRAINT `fk_ehs_chemical_exposure_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ehs_regulatory_submission` ADD CONSTRAINT `fk_ehs_ehs_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_audit` ADD CONSTRAINT `fk_ehs_inspection_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ADD CONSTRAINT `fk_ehs_inspection_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`inspection_finding` ADD CONSTRAINT `fk_ehs_inspection_finding_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`management_of_change` ADD CONSTRAINT `fk_ehs_management_of_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`training_record` ADD CONSTRAINT `fk_ehs_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`emergency_response_plan` ADD CONSTRAINT `fk_ehs_emergency_response_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`environmental_monitoring` ADD CONSTRAINT `fk_ehs_environmental_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ADD CONSTRAINT `fk_ehs_ohs_risk_assessment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment` ADD CONSTRAINT `fk_ehs_ohs_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> billing (1 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`finance`.`hedge_instrument` ADD CONSTRAINT `fk_finance_hedge_instrument_party_id` FOREIGN KEY (`party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`party`(`party_id`);

-- ========= finance --> production (4 constraint(s)) =========
-- Requires: finance schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);

-- ========= finance --> research (1 constraint(s)) =========
-- Requires: finance schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);

-- ========= finance --> workforce (17 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`cost_element` ADD CONSTRAINT `fk_finance_cost_element_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_primary_budget_employee_id` FOREIGN KEY (`primary_budget_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_tertiary_budget_approved_by_employee_id` FOREIGN KEY (`tertiary_budget_approved_by_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_tertiary_capex_project_manager_employee_id` FOREIGN KEY (`tertiary_capex_project_manager_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`fx_exposure` ADD CONSTRAINT `fk_finance_fx_exposure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= formulation --> customer (5 constraint(s)) =========
-- Requires: formulation schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ADD CONSTRAINT `fk_formulation_formula_change_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ADD CONSTRAINT `fk_formulation_scale_up_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ADD CONSTRAINT `fk_formulation_validation_batch_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ADD CONSTRAINT `fk_formulation_ip_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` ADD CONSTRAINT `fk_formulation_formula_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= formulation --> ehs (8 constraint(s)) =========
-- Requires: formulation schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ADD CONSTRAINT `fk_formulation_formula_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ADD CONSTRAINT `fk_formulation_formula_version_management_of_change_id` FOREIGN KEY (`management_of_change_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`management_of_change`(`management_of_change_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ADD CONSTRAINT `fk_formulation_formula_bom_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ADD CONSTRAINT `fk_formulation_recipe_line_item_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ADD CONSTRAINT `fk_formulation_recipe_step_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ADD CONSTRAINT `fk_formulation_formula_change_request_management_of_change_id` FOREIGN KEY (`management_of_change_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`management_of_change`(`management_of_change_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ADD CONSTRAINT `fk_formulation_moc_approval_management_of_change_id` FOREIGN KEY (`management_of_change_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`management_of_change`(`management_of_change_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` ADD CONSTRAINT `fk_formulation_formula_waste_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`waste_stream`(`waste_stream_id`);

-- ========= formulation --> finance (14 constraint(s)) =========
-- Requires: formulation schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ADD CONSTRAINT `fk_formulation_formula_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ADD CONSTRAINT `fk_formulation_formula_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ADD CONSTRAINT `fk_formulation_formula_version_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ADD CONSTRAINT `fk_formulation_formula_version_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ADD CONSTRAINT `fk_formulation_formula_change_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ADD CONSTRAINT `fk_formulation_formula_change_request_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ADD CONSTRAINT `fk_formulation_scale_up_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ADD CONSTRAINT `fk_formulation_scale_up_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ADD CONSTRAINT `fk_formulation_validation_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ADD CONSTRAINT `fk_formulation_validation_batch_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ADD CONSTRAINT `fk_formulation_formula_deviation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ADD CONSTRAINT `fk_formulation_formulation_process_simulation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ADD CONSTRAINT `fk_formulation_formula_substitution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ADD CONSTRAINT `fk_formulation_mes_recipe_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= formulation --> maintenance (4 constraint(s)) =========
-- Requires: formulation schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ADD CONSTRAINT `fk_formulation_recipe_step_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ADD CONSTRAINT `fk_formulation_formula_change_request_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ADD CONSTRAINT `fk_formulation_validation_batch_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ADD CONSTRAINT `fk_formulation_mes_recipe_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);

-- ========= formulation --> pricing (1 constraint(s)) =========
-- Requires: formulation schema, pricing schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` ADD CONSTRAINT `fk_formulation_pricing_assignment_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);

-- ========= formulation --> product (3 constraint(s)) =========
-- Requires: formulation schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ADD CONSTRAINT `fk_formulation_formula_version_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ADD CONSTRAINT `fk_formulation_recipe_line_item_reach_dossier_id` FOREIGN KEY (`reach_dossier_id`) REFERENCES `chemical_mfg_ecm`.`product`.`reach_dossier`(`reach_dossier_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ADD CONSTRAINT `fk_formulation_ip_record_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sds`(`sds_id`);

-- ========= formulation --> production (1 constraint(s)) =========
-- Requires: formulation schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ADD CONSTRAINT `fk_formulation_formula_deviation_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);

-- ========= formulation --> quality (3 constraint(s)) =========
-- Requires: formulation schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ADD CONSTRAINT `fk_formulation_validation_batch_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ADD CONSTRAINT `fk_formulation_formula_deviation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ADD CONSTRAINT `fk_formulation_formula_stability_test_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`stability_study`(`stability_study_id`);

-- ========= formulation --> rawmaterial (6 constraint(s)) =========
-- Requires: formulation schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ADD CONSTRAINT `fk_formulation_formula_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ADD CONSTRAINT `fk_formulation_blend_ratio_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ADD CONSTRAINT `fk_formulation_recipe_step_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ADD CONSTRAINT `fk_formulation_compatibility_matrix_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ADD CONSTRAINT `fk_formulation_formula_change_request_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ADD CONSTRAINT `fk_formulation_formula_deviation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= formulation --> research (4 constraint(s)) =========
-- Requires: formulation schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ADD CONSTRAINT `fk_formulation_formula_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ADD CONSTRAINT `fk_formulation_recipe_line_item_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ADD CONSTRAINT `fk_formulation_formula_change_request_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ADD CONSTRAINT `fk_formulation_scale_up_record_trial_batch_id` FOREIGN KEY (`trial_batch_id`) REFERENCES `chemical_mfg_ecm`.`research`.`trial_batch`(`trial_batch_id`);

-- ========= formulation --> supply (5 constraint(s)) =========
-- Requires: formulation schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ADD CONSTRAINT `fk_formulation_formula_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ADD CONSTRAINT `fk_formulation_formula_version_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ADD CONSTRAINT `fk_formulation_formula_bom_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ADD CONSTRAINT `fk_formulation_recipe_line_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ADD CONSTRAINT `fk_formulation_active_ingredient_spec_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= formulation --> workforce (12 constraint(s)) =========
-- Requires: formulation schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ADD CONSTRAINT `fk_formulation_formula_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ADD CONSTRAINT `fk_formulation_formula_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ADD CONSTRAINT `fk_formulation_formula_bom_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ADD CONSTRAINT `fk_formulation_recipe_step_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ADD CONSTRAINT `fk_formulation_formula_change_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ADD CONSTRAINT `fk_formulation_moc_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ADD CONSTRAINT `fk_formulation_scale_up_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ADD CONSTRAINT `fk_formulation_validation_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ADD CONSTRAINT `fk_formulation_formula_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ADD CONSTRAINT `fk_formulation_formulation_process_simulation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ADD CONSTRAINT `fk_formulation_formula_substitution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ADD CONSTRAINT `fk_formulation_mes_recipe_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> billing (2 constraint(s)) =========
-- Requires: inventory schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_lot_allocation` ADD CONSTRAINT `fk_inventory_inventory_lot_allocation_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice_line`(`invoice_line_id`);

-- ========= inventory --> customer (2 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);

-- ========= inventory --> finance (6 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= inventory --> formulation (1 constraint(s)) =========
-- Requires: inventory schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);

-- ========= inventory --> logistics (1 constraint(s)) =========
-- Requires: inventory schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot_shipment_allocation` ADD CONSTRAINT `fk_inventory_lot_shipment_allocation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= inventory --> maintenance (5 constraint(s)) =========
-- Requires: inventory schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`warehouse_task` ADD CONSTRAINT `fk_inventory_warehouse_task_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);

-- ========= inventory --> planning (2 constraint(s)) =========
-- Requires: inventory schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_inventory_target_id` FOREIGN KEY (`inventory_target_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`inventory_target`(`inventory_target_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);

-- ========= inventory --> pricing (3 constraint(s)) =========
-- Requires: inventory schema, pricing schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`interplant_transfer` ADD CONSTRAINT `fk_inventory_interplant_transfer_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`transfer_price`(`transfer_price_id`);

-- ========= inventory --> product (8 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_outbound_delivery_id` FOREIGN KEY (`outbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`product`.`outbound_delivery`(`outbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`interplant_transfer` ADD CONSTRAINT `fk_inventory_interplant_transfer_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= inventory --> production (6 constraint(s)) =========
-- Requires: inventory schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot_genealogy` ADD CONSTRAINT `fk_inventory_lot_genealogy_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot_genealogy` ADD CONSTRAINT `fk_inventory_lot_genealogy_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);

-- ========= inventory --> rawmaterial (12 constraint(s)) =========
-- Requires: inventory schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_stock_material_master_id` FOREIGN KEY (`stock_material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_tank_material_master_id` FOREIGN KEY (`tank_material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot_genealogy` ADD CONSTRAINT `fk_inventory_lot_genealogy_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`warehouse_task` ADD CONSTRAINT `fk_inventory_warehouse_task_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= inventory --> research (3 constraint(s)) =========
-- Requires: inventory schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);

-- ========= inventory --> sales (1 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= inventory --> supply (5 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= inventory --> workforce (15 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`physical_inventory_count` ADD CONSTRAINT `fk_inventory_physical_inventory_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`physical_inventory_count` ADD CONSTRAINT `fk_inventory_physical_inventory_count_primary_physical_counter_employee_id` FOREIGN KEY (`primary_physical_counter_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`tank_farm_level` ADD CONSTRAINT `fk_inventory_tank_farm_level_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`inventory_adjustment` ADD CONSTRAINT `fk_inventory_inventory_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`interplant_transfer` ADD CONSTRAINT `fk_inventory_interplant_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`count_session` ADD CONSTRAINT `fk_inventory_count_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`count_session` ADD CONSTRAINT `fk_inventory_count_session_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`inventory`.`warehouse_task` ADD CONSTRAINT `fk_inventory_warehouse_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= logistics --> billing (3 constraint(s)) =========
-- Requires: logistics schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= logistics --> customer (15 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_origin_location_site_id` FOREIGN KEY (`origin_location_site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_primary_bill_site_id` FOREIGN KEY (`primary_bill_site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_origin_location_site_id` FOREIGN KEY (`origin_location_site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_primary_freight_site_id` FOREIGN KEY (`primary_freight_site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ADD CONSTRAINT `fk_logistics_advance_ship_notice_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ADD CONSTRAINT `fk_logistics_dock_appointment_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= logistics --> finance (17 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ADD CONSTRAINT `fk_logistics_dock_appointment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= logistics --> formulation (2 constraint(s)) =========
-- Requires: logistics schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);

-- ========= logistics --> inventory (5 constraint(s)) =========
-- Requires: logistics schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_transfer_order_id` FOREIGN KEY (`transfer_order_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`transfer_order`(`transfer_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ADD CONSTRAINT `fk_logistics_dock_appointment_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= logistics --> planning (5 constraint(s)) =========
-- Requires: logistics schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`planned_order`(`planned_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ADD CONSTRAINT `fk_logistics_dock_appointment_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);

-- ========= logistics --> product (8 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_outbound_delivery_id` FOREIGN KEY (`outbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`product`.`outbound_delivery`(`outbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_packaging_config_id` FOREIGN KEY (`packaging_config_id`) REFERENCES `chemical_mfg_ecm`.`product`.`packaging_config`(`packaging_config_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= logistics --> production (3 constraint(s)) =========
-- Requires: logistics schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ADD CONSTRAINT `fk_logistics_dock_appointment_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);

-- ========= logistics --> rawmaterial (7 constraint(s)) =========
-- Requires: logistics schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ADD CONSTRAINT `fk_logistics_advance_ship_notice_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ADD CONSTRAINT `fk_logistics_dock_appointment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_qualification` ADD CONSTRAINT `fk_logistics_carrier_qualification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= logistics --> research (8 constraint(s)) =========
-- Requires: logistics schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_lab_experiment_id` FOREIGN KEY (`lab_experiment_id`) REFERENCES `chemical_mfg_ecm`.`research`.`lab_experiment`(`lab_experiment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ADD CONSTRAINT `fk_logistics_advance_ship_notice_trial_batch_id` FOREIGN KEY (`trial_batch_id`) REFERENCES `chemical_mfg_ecm`.`research`.`trial_batch`(`trial_batch_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ADD CONSTRAINT `fk_logistics_dock_appointment_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);

-- ========= logistics --> sales (1 constraint(s)) =========
-- Requires: logistics schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote_line`(`quote_line_id`);

-- ========= logistics --> supply (3 constraint(s)) =========
-- Requires: logistics schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ADD CONSTRAINT `fk_logistics_advance_ship_notice_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`asn`(`asn_id`);

-- ========= logistics --> workforce (5 constraint(s)) =========
-- Requires: logistics schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ADD CONSTRAINT `fk_logistics_dock_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= maintenance --> customer (5 constraint(s)) =========
-- Requires: maintenance schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ADD CONSTRAINT `fk_maintenance_notification_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= maintenance --> ehs (1 constraint(s)) =========
-- Requires: maintenance schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`asset_change_request` ADD CONSTRAINT `fk_maintenance_asset_change_request_management_of_change_id` FOREIGN KEY (`management_of_change_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`management_of_change`(`management_of_change_id`);

-- ========= maintenance --> finance (9 constraint(s)) =========
-- Requires: maintenance schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ADD CONSTRAINT `fk_maintenance_notification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`asset_change_request` ADD CONSTRAINT `fk_maintenance_asset_change_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= maintenance --> logistics (3 constraint(s)) =========
-- Requires: maintenance schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment_allocation` ADD CONSTRAINT `fk_maintenance_equipment_allocation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= maintenance --> pricing (3 constraint(s)) =========
-- Requires: maintenance schema, pricing schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_maintenance_strategy_id` FOREIGN KEY (`maintenance_strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ADD CONSTRAINT `fk_maintenance_measurement_point_market_price_index_id` FOREIGN KEY (`market_price_index_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`market_price_index`(`market_price_index_id`);

-- ========= maintenance --> product (1 constraint(s)) =========
-- Requires: maintenance schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= maintenance --> production (7 constraint(s)) =========
-- Requires: maintenance schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ADD CONSTRAINT `fk_maintenance_schedule_call_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ADD CONSTRAINT `fk_maintenance_measurement_point_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);

-- ========= maintenance --> rawmaterial (3 constraint(s)) =========
-- Requires: maintenance schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= maintenance --> sales (3 constraint(s)) =========
-- Requires: maintenance schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);

-- ========= maintenance --> supply (5 constraint(s)) =========
-- Requires: maintenance schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= maintenance --> workforce (19 constraint(s)) =========
-- Requires: maintenance schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ADD CONSTRAINT `fk_maintenance_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ADD CONSTRAINT `fk_maintenance_measurement_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`asset_change_request` ADD CONSTRAINT `fk_maintenance_asset_change_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`asset_change_request` ADD CONSTRAINT `fk_maintenance_asset_change_request_tertiary_asset_closed_by_employee_id` FOREIGN KEY (`tertiary_asset_closed_by_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_alt5_permit_closed_by_user_employee_id` FOREIGN KEY (`alt5_permit_closed_by_user_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_primary_permit_employee_id` FOREIGN KEY (`primary_permit_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_quaternary_permit_safety_officer_user_employee_id` FOREIGN KEY (`quaternary_permit_safety_officer_user_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_quinary_permit_fire_watch_user_employee_id` FOREIGN KEY (`quinary_permit_fire_watch_user_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_tertiary_permit_area_authority_user_employee_id` FOREIGN KEY (`tertiary_permit_area_authority_user_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ADD CONSTRAINT `fk_maintenance_task_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`checklist_template` ADD CONSTRAINT `fk_maintenance_checklist_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`rbi_assessment` ADD CONSTRAINT `fk_maintenance_rbi_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= order --> customer (4 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ADD CONSTRAINT `fk_order_inquiry_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_quotation_site_id` FOREIGN KEY (`quotation_site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);

-- ========= order --> research (2 constraint(s)) =========
-- Requires: order schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ADD CONSTRAINT `fk_order_inquiry_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);

-- ========= order --> supply (2 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ADD CONSTRAINT `fk_order_inquiry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= order --> workforce (8 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ADD CONSTRAINT `fk_order_inquiry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ADD CONSTRAINT `fk_order_inquiry_inquiry_employee_id` FOREIGN KEY (`inquiry_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ADD CONSTRAINT `fk_order_inquiry_inquiry_last_modified_by_user_employee_id` FOREIGN KEY (`inquiry_last_modified_by_user_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_quotation_created_by_employee_id` FOREIGN KEY (`quotation_created_by_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_quotation_employee_id` FOREIGN KEY (`quotation_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_quotation_last_modified_by_employee_id` FOREIGN KEY (`quotation_last_modified_by_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= planning --> customer (5 constraint(s)) =========
-- Requires: planning schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ADD CONSTRAINT `fk_planning_demand_plan_adjustment_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ADD CONSTRAINT `fk_planning_atp_check_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= planning --> ehs (1 constraint(s)) =========
-- Requires: planning schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);

-- ========= planning --> finance (6 constraint(s)) =========
-- Requires: planning schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= planning --> formulation (5 constraint(s)) =========
-- Requires: planning schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ADD CONSTRAINT `fk_planning_mrp_run_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);

-- ========= planning --> maintenance (3 constraint(s)) =========
-- Requires: planning schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);

-- ========= planning --> product (11 constraint(s)) =========
-- Requires: planning schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ADD CONSTRAINT `fk_planning_sop_consensus_record_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ADD CONSTRAINT `fk_planning_sop_consensus_record_product_family_id` FOREIGN KEY (`product_family_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_family`(`product_family_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ADD CONSTRAINT `fk_planning_demand_plan_adjustment_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ADD CONSTRAINT `fk_planning_atp_check_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= planning --> production (13 constraint(s)) =========
-- Requires: planning schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ADD CONSTRAINT `fk_planning_sop_consensus_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ADD CONSTRAINT `fk_planning_mrp_run_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ADD CONSTRAINT `fk_planning_supply_demand_balance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ADD CONSTRAINT `fk_planning_changeover_matrix_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ADD CONSTRAINT `fk_planning_rough_cut_capacity_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `chemical_mfg_ecm`.`production`.`resource`(`resource_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ADD CONSTRAINT `fk_planning_forecast_accuracy_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);

-- ========= planning --> rawmaterial (15 constraint(s)) =========
-- Requires: planning schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ADD CONSTRAINT `fk_planning_mrp_exception_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ADD CONSTRAINT `fk_planning_demand_plan_adjustment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ADD CONSTRAINT `fk_planning_supply_demand_balance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ADD CONSTRAINT `fk_planning_parameter_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ADD CONSTRAINT `fk_planning_atp_check_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ADD CONSTRAINT `fk_planning_forecast_accuracy_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ADD CONSTRAINT `fk_planning_interplant_supply_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ADD CONSTRAINT `fk_planning_shelf_life_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= planning --> research (4 constraint(s)) =========
-- Requires: planning schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);

-- ========= planning --> sales (4 constraint(s)) =========
-- Requires: planning schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_distributor_id` FOREIGN KEY (`distributor_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`distributor`(`distributor_id`);

-- ========= planning --> supply (2 constraint(s)) =========
-- Requires: planning schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= planning --> workforce (16 constraint(s)) =========
-- Requires: planning schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ADD CONSTRAINT `fk_planning_forecast_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ADD CONSTRAINT `fk_planning_sop_consensus_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ADD CONSTRAINT `fk_planning_sop_consensus_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ADD CONSTRAINT `fk_planning_sop_consensus_record_tertiary_sop_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_sop_last_modified_by_user_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ADD CONSTRAINT `fk_planning_mrp_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ADD CONSTRAINT `fk_planning_mrp_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_primary_production_employee_id` FOREIGN KEY (`primary_production_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_tertiary_supply_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_supply_last_modified_by_user_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ADD CONSTRAINT `fk_planning_demand_plan_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ADD CONSTRAINT `fk_planning_demand_plan_adjustment_primary_demand_employee_id` FOREIGN KEY (`primary_demand_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ADD CONSTRAINT `fk_planning_allocation_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ADD CONSTRAINT `fk_planning_allocation_rule_tertiary_allocation_updated_by_user_employee_id` FOREIGN KEY (`tertiary_allocation_updated_by_user_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= pricing --> customer (6 constraint(s)) =========
-- Requires: pricing schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ADD CONSTRAINT `fk_pricing_condition_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ADD CONSTRAINT `fk_pricing_special_price_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ADD CONSTRAINT `fk_pricing_price_change_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= pricing --> finance (9 constraint(s)) =========
-- Requires: pricing schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ADD CONSTRAINT `fk_pricing_strategy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ADD CONSTRAINT `fk_pricing_transfer_price_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ADD CONSTRAINT `fk_pricing_transfer_price_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= pricing --> formulation (5 constraint(s)) =========
-- Requires: pricing schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ADD CONSTRAINT `fk_pricing_cost_plus_model_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);

-- ========= pricing --> logistics (2 constraint(s)) =========
-- Requires: pricing schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ADD CONSTRAINT `fk_pricing_condition_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ADD CONSTRAINT `fk_pricing_cost_plus_model_freight_rate_id` FOREIGN KEY (`freight_rate_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`freight_rate`(`freight_rate_id`);

-- ========= pricing --> planning (5 constraint(s)) =========
-- Requires: pricing schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_horizon_id` FOREIGN KEY (`horizon_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`horizon`(`horizon_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_forecast_version_id` FOREIGN KEY (`forecast_version_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ADD CONSTRAINT `fk_pricing_condition_parameter_id` FOREIGN KEY (`parameter_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`parameter`(`parameter_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ADD CONSTRAINT `fk_pricing_price_change_event_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);

-- ========= pricing --> product (10 constraint(s)) =========
-- Requires: pricing schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ADD CONSTRAINT `fk_pricing_condition_record_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ADD CONSTRAINT `fk_pricing_special_price_request_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ADD CONSTRAINT `fk_pricing_formula_price_calculation_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ADD CONSTRAINT `fk_pricing_regional_price_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ADD CONSTRAINT `fk_pricing_competitor_price_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= pricing --> quality (3 constraint(s)) =========
-- Requires: pricing schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ADD CONSTRAINT `fk_pricing_condition_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ADD CONSTRAINT `fk_pricing_price_change_event_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= pricing --> rawmaterial (5 constraint(s)) =========
-- Requires: pricing schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ADD CONSTRAINT `fk_pricing_condition_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ADD CONSTRAINT `fk_pricing_market_price_index_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ADD CONSTRAINT `fk_pricing_transfer_price_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ADD CONSTRAINT `fk_pricing_price_change_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= pricing --> research (9 constraint(s)) =========
-- Requires: pricing schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ADD CONSTRAINT `fk_pricing_strategy_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ADD CONSTRAINT `fk_pricing_cost_plus_model_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ADD CONSTRAINT `fk_pricing_market_price_index_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ADD CONSTRAINT `fk_pricing_transfer_price_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ADD CONSTRAINT `fk_pricing_formula_price_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ADD CONSTRAINT `fk_pricing_formula_price_calculation_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);

-- ========= pricing --> sales (4 constraint(s)) =========
-- Requires: pricing schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ADD CONSTRAINT `fk_pricing_special_price_request_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ADD CONSTRAINT `fk_pricing_competitor_price_competitor_id` FOREIGN KEY (`competitor_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`competitor`(`competitor_id`);

-- ========= pricing --> workforce (18 constraint(s)) =========
-- Requires: pricing schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ADD CONSTRAINT `fk_pricing_strategy_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ADD CONSTRAINT `fk_pricing_cost_plus_model_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ADD CONSTRAINT `fk_pricing_surcharge_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_proposal_employee_id` FOREIGN KEY (`proposal_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_proposal_last_modified_by_user_employee_id` FOREIGN KEY (`proposal_last_modified_by_user_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_approval_employee_id` FOREIGN KEY (`approval_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ADD CONSTRAINT `fk_pricing_special_price_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ADD CONSTRAINT `fk_pricing_special_price_request_primary_special_employee_id` FOREIGN KEY (`primary_special_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ADD CONSTRAINT `fk_pricing_price_change_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ADD CONSTRAINT `fk_pricing_authority_matrix_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ADD CONSTRAINT `fk_pricing_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ADD CONSTRAINT `fk_pricing_calendar_calendar_pricing_manager_employee_id` FOREIGN KEY (`calendar_pricing_manager_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ADD CONSTRAINT `fk_pricing_calendar_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= product --> customer (11 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_shipping_address_site_id` FOREIGN KEY (`shipping_address_site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ADD CONSTRAINT `fk_product_order_confirmation_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ADD CONSTRAINT `fk_product_outbound_delivery_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ADD CONSTRAINT `fk_product_product_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ADD CONSTRAINT `fk_product_returns_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ADD CONSTRAINT `fk_product_proof_of_delivery_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ADD CONSTRAINT `fk_product_order_amendment_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);

-- ========= product --> finance (10 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= product --> formulation (2 constraint(s)) =========
-- Requires: product schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);

-- ========= product --> inventory (4 constraint(s)) =========
-- Requires: product schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ADD CONSTRAINT `fk_product_order_delivery_schedule_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ADD CONSTRAINT `fk_product_order_delivery_schedule_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ADD CONSTRAINT `fk_product_outbound_delivery_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ADD CONSTRAINT `fk_product_returns_order_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= product --> logistics (3 constraint(s)) =========
-- Requires: product schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ADD CONSTRAINT `fk_product_order_delivery_schedule_shipment_plan_id` FOREIGN KEY (`shipment_plan_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment_plan`(`shipment_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ADD CONSTRAINT `fk_product_outbound_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ADD CONSTRAINT `fk_product_proof_of_delivery_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`vehicle`(`vehicle_id`);

-- ========= product --> maintenance (3 constraint(s)) =========
-- Requires: product schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_asset_change_request_id` FOREIGN KEY (`asset_change_request_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`asset_change_request`(`asset_change_request_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);

-- ========= product --> planning (4 constraint(s)) =========
-- Requires: product schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_forecast_version_id` FOREIGN KEY (`forecast_version_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`planned_order`(`planned_order_id`);

-- ========= product --> pricing (4 constraint(s)) =========
-- Requires: product schema, pricing schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`proposal`(`proposal_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` ADD CONSTRAINT `fk_product_pricing_condition_assignment_condition_id` FOREIGN KEY (`condition_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`condition`(`condition_id`);

-- ========= product --> rawmaterial (5 constraint(s)) =========
-- Requires: product schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ADD CONSTRAINT `fk_product_composition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= product --> research (8 constraint(s)) =========
-- Requires: product schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `chemical_mfg_ecm`.`research`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_patent_filing_id` FOREIGN KEY (`patent_filing_id`) REFERENCES `chemical_mfg_ecm`.`research`.`patent_filing`(`patent_filing_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_compound_registry_id` FOREIGN KEY (`compound_registry_id`) REFERENCES `chemical_mfg_ecm`.`research`.`compound_registry`(`compound_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ADD CONSTRAINT `fk_product_order_delivery_schedule_trial_batch_id` FOREIGN KEY (`trial_batch_id`) REFERENCES `chemical_mfg_ecm`.`research`.`trial_batch`(`trial_batch_id`);

-- ========= product --> sales (8 constraint(s)) =========
-- Requires: product schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_distributor_id` FOREIGN KEY (`distributor_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`distributor`(`distributor_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_opportunity_product_id` FOREIGN KEY (`opportunity_product_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity_product`(`opportunity_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote_line`(`quote_line_id`);

-- ========= product --> supply (6 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ADD CONSTRAINT `fk_product_composition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`allocation` ADD CONSTRAINT `fk_product_allocation_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`po_line`(`po_line_id`);

-- ========= product --> workforce (14 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ADD CONSTRAINT `fk_product_grade_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ADD CONSTRAINT `fk_product_grade_quality_manager_employee_id` FOREIGN KEY (`quality_manager_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ADD CONSTRAINT `fk_product_order_confirmation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ADD CONSTRAINT `fk_product_order_delivery_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ADD CONSTRAINT `fk_product_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ADD CONSTRAINT `fk_product_product_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ADD CONSTRAINT `fk_product_returns_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ADD CONSTRAINT `fk_product_handling_instruction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ADD CONSTRAINT `fk_product_fulfillment_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ADD CONSTRAINT `fk_product_proof_of_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ADD CONSTRAINT `fk_product_order_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= production --> customer (2 constraint(s)) =========
-- Requires: production schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);

-- ========= production --> ehs (2 constraint(s)) =========
-- Requires: production schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_management_of_change_id` FOREIGN KEY (`management_of_change_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`management_of_change`(`management_of_change_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_management_of_change_id` FOREIGN KEY (`management_of_change_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`management_of_change`(`management_of_change_id`);

-- ========= production --> finance (4 constraint(s)) =========
-- Requires: production schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ADD CONSTRAINT `fk_production_equipment_effectiveness_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= production --> formulation (7 constraint(s)) =========
-- Requires: production schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_mes_recipe_id` FOREIGN KEY (`mes_recipe_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`mes_recipe`(`mes_recipe_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_formula_bom_id` FOREIGN KEY (`formula_bom_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_bom`(`formula_bom_id`);

-- ========= production --> inventory (5 constraint(s)) =========
-- Requires: production schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= production --> maintenance (15 constraint(s)) =========
-- Requires: production schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_notification_id` FOREIGN KEY (`notification_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`notification`(`notification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ADD CONSTRAINT `fk_production_mes_execution_log_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ADD CONSTRAINT `fk_production_equipment_effectiveness_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ADD CONSTRAINT `fk_production_equipment_effectiveness_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ADD CONSTRAINT `fk_production_equipment_effectiveness_notification_id` FOREIGN KEY (`notification_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`notification`(`notification_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ADD CONSTRAINT `fk_production_equipment_effectiveness_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= production --> planning (3 constraint(s)) =========
-- Requires: production schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`demand_forecast`(`demand_forecast_id`);

-- ========= production --> pricing (1 constraint(s)) =========
-- Requires: production schema, pricing schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= production --> product (12 constraint(s)) =========
-- Requires: production schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_product_family_id` FOREIGN KEY (`product_family_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_family`(`product_family_id`);

-- ========= production --> quality (4 constraint(s)) =========
-- Requires: production schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);

-- ========= production --> rawmaterial (9 constraint(s)) =========
-- Requires: production schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`control_recipe` ADD CONSTRAINT `fk_production_control_recipe_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= production --> research (5 constraint(s)) =========
-- Requires: production schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_synthesis_procedure_id` FOREIGN KEY (`synthesis_procedure_id`) REFERENCES `chemical_mfg_ecm`.`research`.`synthesis_procedure`(`synthesis_procedure_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ADD CONSTRAINT `fk_production_dcs_event_log_research_process_simulation_id` FOREIGN KEY (`research_process_simulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`research_process_simulation`(`research_process_simulation_id`);

-- ========= production --> sales (4 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);

-- ========= production --> supply (4 constraint(s)) =========
-- Requires: production schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ADD CONSTRAINT `fk_production_equipment_effectiveness_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` ADD CONSTRAINT `fk_production_production_procurement_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= production --> workforce (25 constraint(s)) =========
-- Requires: production schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_quaternary_batch_approved_by_employee_id` FOREIGN KEY (`quaternary_batch_approved_by_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_tertiary_batch_reviewed_by_employee_id` FOREIGN KEY (`tertiary_batch_reviewed_by_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_tertiary_production_approved_by_employee_id` FOREIGN KEY (`tertiary_production_approved_by_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_primary_process_initiator_employee_id` FOREIGN KEY (`primary_process_initiator_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ADD CONSTRAINT `fk_production_dcs_event_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ADD CONSTRAINT `fk_production_mes_execution_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_campaign_supervisor_employee_id` FOREIGN KEY (`campaign_supervisor_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ADD CONSTRAINT `fk_production_equipment_effectiveness_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ADD CONSTRAINT `fk_production_equipment_effectiveness_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ADD CONSTRAINT `fk_production_shift_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> billing (2 constraint(s)) =========
-- Requires: quality schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= quality --> customer (3 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= quality --> ehs (3 constraint(s)) =========
-- Requires: quality schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_incident`(`safety_incident_id`);

-- ========= quality --> finance (7 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ADD CONSTRAINT `fk_quality_lab_instrument_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> formulation (5 constraint(s)) =========
-- Requires: quality schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ADD CONSTRAINT `fk_quality_quality_specification_formula_spec_id` FOREIGN KEY (`formula_spec_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_spec`(`formula_spec_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);

-- ========= quality --> inventory (6 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= quality --> logistics (2 constraint(s)) =========
-- Requires: quality schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_shipment_line_id` FOREIGN KEY (`shipment_line_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment_line`(`shipment_line_id`);

-- ========= quality --> maintenance (6 constraint(s)) =========
-- Requires: quality schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);

-- ========= quality --> planning (4 constraint(s)) =========
-- Requires: quality schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`planned_order`(`planned_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_mrp_exception_id` FOREIGN KEY (`mrp_exception_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_exception`(`mrp_exception_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_inventory_target_id` FOREIGN KEY (`inventory_target_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`inventory_target`(`inventory_target_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);

-- ========= quality --> product (12 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= quality --> production (5 constraint(s)) =========
-- Requires: quality schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);

-- ========= quality --> rawmaterial (10 constraint(s)) =========
-- Requires: quality schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_coa_document_id` FOREIGN KEY (`coa_document_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`coa_document`(`coa_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ADD CONSTRAINT `fk_quality_sampling_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ADD CONSTRAINT `fk_quality_quality_specification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= quality --> research (7 constraint(s)) =========
-- Requires: quality schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `chemical_mfg_ecm`.`research`.`sample`(`sample_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ADD CONSTRAINT `fk_quality_spc_violation_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `chemical_mfg_ecm`.`research`.`sample`(`sample_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_lab_experiment_id` FOREIGN KEY (`lab_experiment_id`) REFERENCES `chemical_mfg_ecm`.`research`.`lab_experiment`(`lab_experiment_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `chemical_mfg_ecm`.`research`.`sample`(`sample_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `chemical_mfg_ecm`.`research`.`sample`(`sample_id`);

-- ========= quality --> supply (2 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= quality --> workforce (21 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ADD CONSTRAINT `fk_quality_test_method_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ADD CONSTRAINT `fk_quality_sampling_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ADD CONSTRAINT `fk_quality_spc_violation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ADD CONSTRAINT `fk_quality_lab_instrument_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ADD CONSTRAINT `fk_quality_instrument_calibration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_tertiary_audit_updated_by_user_employee_id` FOREIGN KEY (`tertiary_audit_updated_by_user_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= rawmaterial --> billing (1 constraint(s)) =========
-- Requires: rawmaterial schema, billing schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_lot_allocation` ADD CONSTRAINT `fk_rawmaterial_rawmaterial_lot_allocation_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice_line`(`invoice_line_id`);

-- ========= rawmaterial --> customer (2 constraint(s)) =========
-- Requires: rawmaterial schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ADD CONSTRAINT `fk_rawmaterial_coa_document_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= rawmaterial --> finance (5 constraint(s)) =========
-- Requires: rawmaterial schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ADD CONSTRAINT `fk_rawmaterial_material_master_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ADD CONSTRAINT `fk_rawmaterial_material_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ADD CONSTRAINT `fk_rawmaterial_material_master_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ADD CONSTRAINT `fk_rawmaterial_supplier_material_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= rawmaterial --> formulation (1 constraint(s)) =========
-- Requires: rawmaterial schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ADD CONSTRAINT `fk_rawmaterial_material_master_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);

-- ========= rawmaterial --> inventory (1 constraint(s)) =========
-- Requires: rawmaterial schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= rawmaterial --> research (1 constraint(s)) =========
-- Requires: rawmaterial schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ADD CONSTRAINT `fk_rawmaterial_material_qualification_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);

-- ========= rawmaterial --> sales (1 constraint(s)) =========
-- Requires: rawmaterial schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`distribution_agreement` ADD CONSTRAINT `fk_rawmaterial_distribution_agreement_distributor_id` FOREIGN KEY (`distributor_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`distributor`(`distributor_id`);

-- ========= rawmaterial --> supply (7 constraint(s)) =========
-- Requires: rawmaterial schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ADD CONSTRAINT `fk_rawmaterial_supplier_material_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ADD CONSTRAINT `fk_rawmaterial_material_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ADD CONSTRAINT `fk_rawmaterial_coa_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ADD CONSTRAINT `fk_rawmaterial_reach_registration_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= rawmaterial --> workforce (5 constraint(s)) =========
-- Requires: rawmaterial schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ADD CONSTRAINT `fk_rawmaterial_material_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ADD CONSTRAINT `fk_rawmaterial_material_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ADD CONSTRAINT `fk_rawmaterial_coa_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ADD CONSTRAINT `fk_rawmaterial_material_regulatory_status_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= research --> customer (2 constraint(s)) =========
-- Requires: research schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` ADD CONSTRAINT `fk_research_transfer_package_document_destination_location_site_id` FOREIGN KEY (`destination_location_site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`transfer_package_document` ADD CONSTRAINT `fk_research_transfer_package_document_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);

-- ========= research --> ehs (5 constraint(s)) =========
-- Requires: research schema, ehs schema
ALTER TABLE `chemical_mfg_ecm`.`research`.`compound_registry` ADD CONSTRAINT `fk_research_compound_registry_ohs_risk_assessment_id` FOREIGN KEY (`ohs_risk_assessment_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`ohs_risk_assessment`(`ohs_risk_assessment_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ADD CONSTRAINT `fk_research_experimental_formulation_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ADD CONSTRAINT `fk_research_lab_experiment_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ADD CONSTRAINT `fk_research_sample_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ADD CONSTRAINT `fk_research_structure_activity_record_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `chemical_mfg_ecm`.`ehs`.`safety_data_sheet`(`safety_data_sheet_id`);

-- ========= research --> finance (2 constraint(s)) =========
-- Requires: research schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ADD CONSTRAINT `fk_research_trial_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= research --> formulation (1 constraint(s)) =========
-- Requires: research schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ADD CONSTRAINT `fk_research_experimental_formulation_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);

-- ========= research --> maintenance (7 constraint(s)) =========
-- Requires: research schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ADD CONSTRAINT `fk_research_experimental_formulation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ADD CONSTRAINT `fk_research_synthesis_procedure_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ADD CONSTRAINT `fk_research_lab_experiment_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ADD CONSTRAINT `fk_research_lab_experiment_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ADD CONSTRAINT `fk_research_trial_batch_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ADD CONSTRAINT `fk_research_trial_batch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= research --> quality (4 constraint(s)) =========
-- Requires: research schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ADD CONSTRAINT `fk_research_rd_stability_study_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ADD CONSTRAINT `fk_research_rd_stability_study_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`analytical_method` ADD CONSTRAINT `fk_research_analytical_method_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ADD CONSTRAINT `fk_research_structure_activity_record_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`lab_instrument`(`lab_instrument_id`);

-- ========= research --> rawmaterial (4 constraint(s)) =========
-- Requires: research schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ADD CONSTRAINT `fk_research_experimental_formulation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ADD CONSTRAINT `fk_research_lab_experiment_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ADD CONSTRAINT `fk_research_trial_batch_coa_document_id` FOREIGN KEY (`coa_document_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`coa_document`(`coa_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ADD CONSTRAINT `fk_research_trial_batch_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);

-- ========= research --> workforce (10 constraint(s)) =========
-- Requires: research schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`experimental_formulation` ADD CONSTRAINT `fk_research_experimental_formulation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`synthesis_procedure` ADD CONSTRAINT `fk_research_synthesis_procedure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`lab_experiment` ADD CONSTRAINT `fk_research_lab_experiment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ADD CONSTRAINT `fk_research_trial_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`trial_batch` ADD CONSTRAINT `fk_research_trial_batch_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`rd_stability_study` ADD CONSTRAINT `fk_research_rd_stability_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`sample` ADD CONSTRAINT `fk_research_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`research`.`structure_activity_record` ADD CONSTRAINT `fk_research_structure_activity_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sales --> customer (16 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ADD CONSTRAINT `fk_sales_distributor_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`technical_inquiry` ADD CONSTRAINT `fk_sales_technical_inquiry_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`technical_inquiry` ADD CONSTRAINT `fk_sales_technical_inquiry_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`technical_inquiry` ADD CONSTRAINT `fk_sales_technical_inquiry_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sample_request` ADD CONSTRAINT `fk_sales_sample_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sample_request` ADD CONSTRAINT `fk_sales_sample_request_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sample_request` ADD CONSTRAINT `fk_sales_sample_request_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sales_rebate_agreement` ADD CONSTRAINT `fk_sales_sales_rebate_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`win_loss` ADD CONSTRAINT `fk_sales_win_loss_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);

-- ========= sales --> finance (5 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= sales --> formulation (6 constraint(s)) =========
-- Requires: sales schema, formulation schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`technical_inquiry` ADD CONSTRAINT `fk_sales_technical_inquiry_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sample_request` ADD CONSTRAINT `fk_sales_sample_request_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);

-- ========= sales --> inventory (1 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sample_request` ADD CONSTRAINT `fk_sales_sample_request_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`lot`(`lot_id`);

-- ========= sales --> logistics (2 constraint(s)) =========
-- Requires: sales schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`technical_inquiry` ADD CONSTRAINT `fk_sales_technical_inquiry_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sample_request` ADD CONSTRAINT `fk_sales_sample_request_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= sales --> maintenance (1 constraint(s)) =========
-- Requires: sales schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);

-- ========= sales --> pricing (4 constraint(s)) =========
-- Requires: sales schema, pricing schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= sales --> product (8 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `chemical_mfg_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`technical_inquiry` ADD CONSTRAINT `fk_sales_technical_inquiry_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sample_request` ADD CONSTRAINT `fk_sales_sample_request_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sales_rebate_agreement` ADD CONSTRAINT `fk_sales_sales_rebate_agreement_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `chemical_mfg_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`win_loss` ADD CONSTRAINT `fk_sales_win_loss_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= sales --> production (1 constraint(s)) =========
-- Requires: sales schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sales_lead` ADD CONSTRAINT `fk_sales_sales_lead_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);

-- ========= sales --> quality (5 constraint(s)) =========
-- Requires: sales schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`technical_inquiry` ADD CONSTRAINT `fk_sales_technical_inquiry_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sample_request` ADD CONSTRAINT `fk_sales_sample_request_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`win_loss` ADD CONSTRAINT `fk_sales_win_loss_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);

-- ========= sales --> rawmaterial (6 constraint(s)) =========
-- Requires: sales schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sales_lead` ADD CONSTRAINT `fk_sales_sales_lead_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= sales --> research (4 constraint(s)) =========
-- Requires: sales schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`technical_inquiry` ADD CONSTRAINT `fk_sales_technical_inquiry_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sample_request` ADD CONSTRAINT `fk_sales_sample_request_trial_batch_id` FOREIGN KEY (`trial_batch_id`) REFERENCES `chemical_mfg_ecm`.`research`.`trial_batch`(`trial_batch_id`);

-- ========= sales --> supply (2 constraint(s)) =========
-- Requires: sales schema, supply schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`rfq`(`rfq_id`);

-- ========= sales --> workforce (21 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_territory_backup_rep_employee_id` FOREIGN KEY (`territory_backup_rep_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_territory_overlay_rep_employee_id` FOREIGN KEY (`territory_overlay_rep_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_territory_sales_manager_employee_id` FOREIGN KEY (`territory_sales_manager_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ADD CONSTRAINT `fk_sales_territory_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ADD CONSTRAINT `fk_sales_territory_assignment_tertiary_territory_approved_by_employee_id` FOREIGN KEY (`tertiary_territory_approved_by_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ADD CONSTRAINT `fk_sales_distributor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`technical_inquiry` ADD CONSTRAINT `fk_sales_technical_inquiry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sample_request` ADD CONSTRAINT `fk_sales_sample_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sales_rebate_agreement` ADD CONSTRAINT `fk_sales_sales_rebate_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sales_lead` ADD CONSTRAINT `fk_sales_sales_lead_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`win_loss` ADD CONSTRAINT `fk_sales_win_loss_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`sales_organization` ADD CONSTRAINT `fk_sales_sales_organization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> customer (5 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ADD CONSTRAINT `fk_supply_supply_procurement_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_site_id` FOREIGN KEY (`site_id`) REFERENCES `chemical_mfg_ecm`.`customer`.`site`(`site_id`);

-- ========= supply --> finance (5 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ADD CONSTRAINT `fk_supply_supply_procurement_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `chemical_mfg_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= supply --> inventory (1 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= supply --> logistics (1 constraint(s)) =========
-- Requires: supply schema, logistics schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= supply --> pricing (4 constraint(s)) =========
-- Requires: supply schema, pricing schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= supply --> production (7 constraint(s)) =========
-- Requires: supply schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ADD CONSTRAINT `fk_supply_supply_procurement_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ADD CONSTRAINT `fk_supply_supply_procurement_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ADD CONSTRAINT `fk_supply_material_info_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ADD CONSTRAINT `fk_supply_toll_manufacturing_order_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);

-- ========= supply --> quality (1 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= supply --> rawmaterial (16 constraint(s)) =========
-- Requires: supply schema, rawmaterial schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ADD CONSTRAINT `fk_supply_asn_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_contract_material_material_master_id` FOREIGN KEY (`contract_material_material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_primary_contract_material_master_id` FOREIGN KEY (`primary_contract_material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ADD CONSTRAINT `fk_supply_sourcing_risk_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ADD CONSTRAINT `fk_supply_supply_procurement_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ADD CONSTRAINT `fk_supply_source_list_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ADD CONSTRAINT `fk_supply_material_info_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ADD CONSTRAINT `fk_supply_vendor_document_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ADD CONSTRAINT `fk_supply_toll_manufacturing_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` ADD CONSTRAINT `fk_supply_supply_agreement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= supply --> research (9 constraint(s)) =========
-- Requires: supply schema, research schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_lab_experiment_id` FOREIGN KEY (`lab_experiment_id`) REFERENCES `chemical_mfg_ecm`.`research`.`lab_experiment`(`lab_experiment_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ADD CONSTRAINT `fk_supply_asn_line_experimental_formulation_id` FOREIGN KEY (`experimental_formulation_id`) REFERENCES `chemical_mfg_ecm`.`research`.`experimental_formulation`(`experimental_formulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ADD CONSTRAINT `fk_supply_supply_procurement_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_lab_experiment_id` FOREIGN KEY (`lab_experiment_id`) REFERENCES `chemical_mfg_ecm`.`research`.`lab_experiment`(`lab_experiment_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_project_id` FOREIGN KEY (`project_id`) REFERENCES `chemical_mfg_ecm`.`research`.`project`(`project_id`);

-- ========= supply --> sales (2 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= supply --> workforce (11 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ADD CONSTRAINT `fk_supply_vendor_scorecard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ADD CONSTRAINT `fk_supply_vendor_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ADD CONSTRAINT `fk_supply_vendor_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ADD CONSTRAINT `fk_supply_sourcing_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ADD CONSTRAINT `fk_supply_supply_procurement_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ADD CONSTRAINT `fk_supply_supply_procurement_plan_tertiary_supply_planner_employee_id` FOREIGN KEY (`tertiary_supply_planner_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> inventory (1 constraint(s)) =========
-- Requires: workforce schema, inventory schema
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `chemical_mfg_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= workforce --> maintenance (4 constraint(s)) =========
-- Requires: workforce schema, maintenance schema
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ADD CONSTRAINT `fk_workforce_labor_time_entry_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);

-- ========= workforce --> planning (1 constraint(s)) =========
-- Requires: workforce schema, planning schema
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_rough_cut_capacity_id` FOREIGN KEY (`rough_cut_capacity_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`rough_cut_capacity`(`rough_cut_capacity_id`);

-- ========= workforce --> product (2 constraint(s)) =========
-- Requires: workforce schema, product schema
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ADD CONSTRAINT `fk_workforce_labor_time_entry_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);

-- ========= workforce --> production (1 constraint(s)) =========
-- Requires: workforce schema, production schema
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);

