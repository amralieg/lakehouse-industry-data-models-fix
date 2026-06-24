-- Schema for Domain: sales | Business:  | Version: v2_ecm
-- Generated on: 2026-06-24 00:22:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`sales` COMMENT 'Owns commercial sales execution, order management, and revenue transactions across all channels (retail, wholesale, DTC, e-commerce). Manages sales orders, pricing agreements, sales force automation (SFA), retail account call records, POG compliance, RSP/MSRP price management, ACV/TDP/SOM metrics, and field sales KPIs. Integrates with Salesforce Consumer Goods Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` (
    `trade_account_id` BIGINT COMMENT 'Primary key',
    `account_segment_id` BIGINT COMMENT '',
    `parent_trade_account_id` BIGINT COMMENT '',
    `territory_id` BIGINT COMMENT '',
    `account_hierarchy_id` BIGINT COMMENT '',
    `account_name` STRING COMMENT '',
    `account_number` STRING COMMENT '',
    `account_status` STRING COMMENT '',
    `account_type` STRING COMMENT '',
    `annual_revenue` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `credit_limit` DECIMAL(18,2) COMMENT '',
    `duns_number` STRING COMMENT '',
    `employee_count` STRING COMMENT '',
    `industry_code` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `payment_terms` STRING COMMENT '',
    `tax_identification_number` STRING COMMENT '',
    CONSTRAINT pk_trade_account PRIMARY KEY(`trade_account_id`)
) COMMENT 'Customer account master for B2B trade relationships';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` (
    `account_contact_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `contact_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `email` STRING COMMENT '',
    `first_name` STRING COMMENT '',
    `is_primary` BOOLEAN COMMENT '',
    `job_title` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_name` STRING COMMENT '',
    `phone` STRING COMMENT '',
    CONSTRAINT pk_account_contact PRIMARY KEY(`account_contact_id`)
) COMMENT 'Contact persons associated with trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` (
    `account_address_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `address_line_1` STRING COMMENT '',
    `address_line_2` STRING COMMENT '',
    `address_type` STRING COMMENT '',
    `city` STRING COMMENT '',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `is_primary` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `latitude` DECIMAL(18,2) COMMENT '',
    `longitude` DECIMAL(18,2) COMMENT '',
    `postal_code` STRING COMMENT '',
    `state_province` STRING COMMENT '',
    CONSTRAINT pk_account_address PRIMARY KEY(`account_address_id`)
) COMMENT 'Physical and mailing addresses for trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` (
    `account_hierarchy_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `primary_trade_account_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `hierarchy_level` STRING COMMENT '',
    `hierarchy_type` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_account_hierarchy PRIMARY KEY(`account_hierarchy_id`)
) COMMENT 'Hierarchical relationships between trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` (
    `retail_store_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `address_line_1` STRING COMMENT '',
    `city` STRING COMMENT '',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `opening_date` DATE COMMENT '',
    `postal_code` STRING COMMENT '',
    `square_footage` DECIMAL(18,2) COMMENT '',
    `state_province` STRING COMMENT '',
    `store_format` STRING COMMENT '',
    `store_name` STRING COMMENT '',
    `store_number` STRING COMMENT '',
    `store_status` STRING COMMENT '',
    CONSTRAINT pk_retail_store PRIMARY KEY(`retail_store_id`)
) COMMENT 'Physical retail locations associated with trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` (
    `edi_trading_partner_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `connection_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `edi_identifier` STRING COMMENT '',
    `edi_qualifier` STRING COMMENT '',
    `edi_version` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `transaction_set_810_enabled` BOOLEAN COMMENT '',
    `transaction_set_850_enabled` BOOLEAN COMMENT '',
    `transaction_set_856_enabled` BOOLEAN COMMENT '',
    CONSTRAINT pk_edi_trading_partner PRIMARY KEY(`edi_trading_partner_id`)
) COMMENT 'EDI configuration for electronic data interchange with trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` (
    `customer_vmi_agreement_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `agreement_number` STRING COMMENT '',
    `agreement_status` STRING COMMENT '',
    `agreement_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `inventory_ownership` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `max_inventory_level` DECIMAL(18,2) COMMENT '',
    `min_inventory_level` DECIMAL(18,2) COMMENT '',
    `replenishment_frequency` STRING COMMENT '',
    CONSTRAINT pk_customer_vmi_agreement PRIMARY KEY(`customer_vmi_agreement_id`)
) COMMENT 'Vendor-managed inventory agreements with customers';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` (
    `account_sla_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lead_time_days` STRING COMMENT '',
    `penalty_amount` DECIMAL(18,2) COMMENT '',
    `sla_type` STRING COMMENT '',
    `target_fill_rate_pct` DECIMAL(18,2) COMMENT '',
    `target_otif_pct` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_account_sla PRIMARY KEY(`account_sla_id`)
) COMMENT 'Service level agreements with trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` (
    `account_segment_id` BIGINT COMMENT 'Primary key',
    `created_timestamp` TIMESTAMP COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `segment_code` STRING COMMENT '',
    `segment_description` STRING COMMENT '',
    `segment_name` STRING COMMENT '',
    `segment_tier` STRING COMMENT '',
    CONSTRAINT pk_account_segment PRIMARY KEY(`account_segment_id`)
) COMMENT 'Segmentation classification for trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` (
    `account_assortment_id` BIGINT COMMENT 'Primary key',
    `sku_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `assortment_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `is_authorized` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_account_assortment PRIMARY KEY(`account_assortment_id`)
) COMMENT 'Product assortment authorized for specific trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` (
    `account_credit_profile_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `credit_hold_flag` BOOLEAN COMMENT '',
    `credit_limit` DECIMAL(18,2) COMMENT '',
    `credit_rating` STRING COMMENT '',
    `days_sales_outstanding` DECIMAL(18,2) COMMENT '',
    `last_credit_review_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `payment_terms_days` STRING COMMENT '',
    CONSTRAINT pk_account_credit_profile PRIMARY KEY(`account_credit_profile_id`)
) COMMENT 'Credit and financial risk profile for trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` (
    `account_pricing_agreement_id` BIGINT COMMENT 'Primary key',
    `sku_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `agreement_number` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT '',
    `unit_price` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_account_pricing_agreement PRIMARY KEY(`account_pricing_agreement_id`)
) COMMENT 'Special pricing agreements with trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` (
    `account_status_history_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `change_reason` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `status_from` STRING COMMENT '',
    `status_to` STRING COMMENT '',
    `change_date` DATE COMMENT '',
    CONSTRAINT pk_account_status_history PRIMARY KEY(`account_status_history_id`)
) COMMENT 'Historical record of account status changes';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` (
    `account_compliance_record_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `assessment_date` DATE COMMENT '',
    `certification_number` STRING COMMENT '',
    `compliance_status` STRING COMMENT '',
    `compliance_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `expiry_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    CONSTRAINT pk_account_compliance_record PRIMARY KEY(`account_compliance_record_id`)
) COMMENT 'Compliance and regulatory records for trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`order` (
    `order_id` BIGINT COMMENT 'Primary key',
    `account_address_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `order_date` DATE COMMENT '',
    `order_number` STRING COMMENT '',
    `order_status` STRING COMMENT '',
    `order_type` STRING COMMENT '',
    `payment_terms` STRING COMMENT '',
    `requested_delivery_date` DATE COMMENT '',
    `total_amount` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Sales orders from trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Primary key',
    `order_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `due_date` DATE COMMENT '',
    `invoice_date` DATE COMMENT '',
    `invoice_number` STRING COMMENT '',
    `invoice_status` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `payment_received_date` DATE COMMENT '',
    `tax_amount` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Sales invoices issued to trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` (
    `pricing_agreement_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `agreement_number` STRING COMMENT '',
    `agreement_status` STRING COMMENT '',
    `agreement_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `discount_percentage` DECIMAL(18,2) COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_pricing_agreement PRIMARY KEY(`pricing_agreement_id`)
) COMMENT 'Master pricing agreements with trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Primary key',
    `rep_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `estimated_value` DECIMAL(18,2) COMMENT '',
    `expected_close_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `opportunity_name` STRING COMMENT '',
    `opportunity_status` STRING COMMENT '',
    `probability_pct` DECIMAL(18,2) COMMENT '',
    `stage` STRING COMMENT '',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Sales opportunities and pipeline management';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` (
    `account_call_id` BIGINT COMMENT 'Primary key',
    `rep_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `call_date` DATE COMMENT '',
    `call_outcome` STRING COMMENT '',
    `call_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    CONSTRAINT pk_account_call PRIMARY KEY(`account_call_id`)
) COMMENT 'Sales representative visits to trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` (
    `planogram_compliance_id` BIGINT COMMENT 'Primary key',
    `retail_store_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `audit_date` DATE COMMENT '',
    `compliance_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `facings_actual` STRING COMMENT '',
    `facings_planned` STRING COMMENT '',
    `out_of_stock_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_planogram_compliance PRIMARY KEY(`planogram_compliance_id`)
) COMMENT 'Retail planogram compliance tracking';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` (
    `pos_transaction_id` BIGINT COMMENT 'Primary key',
    `retail_store_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `discount_amount` DECIMAL(18,2) COMMENT '',
    `quantity_sold` DECIMAL(18,2) COMMENT '',
    `total_amount` DECIMAL(18,2) COMMENT '',
    `transaction_date` DATE COMMENT '',
    `transaction_number` STRING COMMENT '',
    `unit_price` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_pos_transaction PRIMARY KEY(`pos_transaction_id`)
) COMMENT 'Point-of-sale transaction data from retail stores';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` (
    `return_order_id` BIGINT COMMENT 'Primary key',
    `order_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `return_date` DATE COMMENT '',
    `return_number` STRING COMMENT '',
    `return_reason` STRING COMMENT '',
    `return_status` STRING COMMENT '',
    `total_amount` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_return_order PRIMARY KEY(`return_order_id`)
) COMMENT 'Product returns from trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`territory` (
    `territory_id` BIGINT COMMENT 'Primary key',
    `territory_code` STRING COMMENT '',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `territory_name` STRING COMMENT '',
    `region` STRING COMMENT '',
    `territory_type` STRING COMMENT '',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Sales territories for account assignment';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`rep` (
    `rep_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `territory_id` BIGINT COMMENT '',
    `rep_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `hire_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `rep_name` STRING COMMENT '',
    `rep_status` STRING COMMENT '',
    `rep_type` STRING COMMENT '',
    CONSTRAINT pk_rep PRIMARY KEY(`rep_id`)
) COMMENT 'Sales representatives';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`quota` (
    `quota_id` BIGINT COMMENT 'Primary key',
    `rep_id` BIGINT COMMENT '',
    `actual_amount` DECIMAL(18,2) COMMENT '',
    `amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `end_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `period` STRING COMMENT '',
    `quota_type` STRING COMMENT '',
    `start_date` DATE COMMENT '',
    CONSTRAINT pk_quota PRIMARY KEY(`quota_id`)
) COMMENT 'Sales quotas for representatives';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` (
    `distribution_point_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `address_line_1` STRING COMMENT '',
    `city` STRING COMMENT '',
    `distribution_point_code` STRING COMMENT '',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `distribution_point_name` STRING COMMENT '',
    `postal_code` STRING COMMENT '',
    `state_province` STRING COMMENT '',
    CONSTRAINT pk_distribution_point PRIMARY KEY(`distribution_point_id`)
) COMMENT 'Distribution points for product delivery';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` (
    `price_list_id` BIGINT COMMENT 'Primary key',
    `price_list_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `price_list_name` STRING COMMENT '',
    `price_list_status` STRING COMMENT '',
    CONSTRAINT pk_price_list PRIMARY KEY(`price_list_id`)
) COMMENT 'Master price lists for products';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` (
    `price_list_item_id` BIGINT COMMENT 'Primary key',
    `price_list_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT '',
    `unit_price` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_price_list_item PRIMARY KEY(`price_list_item_id`)
) COMMENT 'Individual SKU prices within price lists';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` (
    `sales_deduction_id` BIGINT COMMENT 'Primary key',
    `invoice_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `deduction_amount` DECIMAL(18,2) COMMENT '',
    `deduction_date` DATE COMMENT '',
    `deduction_number` STRING COMMENT '',
    `deduction_reason` STRING COMMENT '',
    `deduction_status` STRING COMMENT '',
    `deduction_type` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_sales_deduction PRIMARY KEY(`sales_deduction_id`)
) COMMENT 'Customer deductions and chargebacks';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` (
    `sales_rebate_agreement_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `agreement_number` STRING COMMENT '',
    `agreement_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT '',
    `rebate_percentage` DECIMAL(18,2) COMMENT '',
    `rebate_type` STRING COMMENT '',
    CONSTRAINT pk_sales_rebate_agreement PRIMARY KEY(`sales_rebate_agreement_id`)
) COMMENT 'Rebate agreements with trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` (
    `sales_dsd_route_id` BIGINT COMMENT 'Primary key',
    `rep_id` BIGINT COMMENT '',
    `territory_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `route_code` STRING COMMENT '',
    `route_frequency` STRING COMMENT '',
    `route_name` STRING COMMENT '',
    `route_status` STRING COMMENT '',
    CONSTRAINT pk_sales_dsd_route PRIMARY KEY(`sales_dsd_route_id`)
) COMMENT 'Direct store delivery routes';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` (
    `sales_dsd_delivery_id` BIGINT COMMENT 'Primary key',
    `retail_store_id` BIGINT COMMENT '',
    `sales_dsd_route_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `delivery_date` DATE COMMENT '',
    `delivery_number` STRING COMMENT '',
    `delivery_status` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `total_amount` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_sales_dsd_delivery PRIMARY KEY(`sales_dsd_delivery_id`)
) COMMENT 'Direct store delivery transactions';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` (
    `account_onboarding_id` BIGINT COMMENT 'Primary key',
    `rep_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `completion_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `onboarding_stage` STRING COMMENT '',
    `onboarding_status` STRING COMMENT '',
    `start_date` DATE COMMENT '',
    CONSTRAINT pk_account_onboarding PRIMARY KEY(`account_onboarding_id`)
) COMMENT 'New account onboarding workflow tracking';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` (
    `sales_vmi_agreement_id` BIGINT COMMENT 'Primary key',
    `customer_vmi_agreement_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `procurement_vmi_agreement_id` BIGINT COMMENT '',
    `agreement_status` STRING COMMENT '',
    `agreement_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `inventory_ownership` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `replenishment_model` STRING COMMENT '',
    `sales_vmi_agreement_status` STRING COMMENT '',
    CONSTRAINT pk_sales_vmi_agreement PRIMARY KEY(`sales_vmi_agreement_id`)
) COMMENT 'Sales-specific VMI agreement details';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`call` (
    `call_id` BIGINT COMMENT 'Primary key',
    `rep_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `call_date` DATE COMMENT '',
    `call_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `duration_minutes` STRING COMMENT '',
    `follow_up_required` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `outcome` STRING COMMENT '',
    `call_status` STRING COMMENT '',
    `effective_date` STRING COMMENT '',
    CONSTRAINT pk_call PRIMARY KEY(`call_id`)
) COMMENT 'Sales call activity tracking';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` (
    `compliance_assignment_id` BIGINT COMMENT 'Primary key',
    `trade_account_id` BIGINT COMMENT '',
    `assigned_date` DATE COMMENT '',
    `completion_date` DATE COMMENT '',
    `compliance_status` STRING COMMENT '',
    `compliance_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `due_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `compliance_assignment_status` STRING COMMENT '',
    CONSTRAINT pk_compliance_assignment PRIMARY KEY(`compliance_assignment_id`)
) COMMENT 'Compliance requirement assignments to trade accounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` (
    `account_team_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `assignment_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `end_date` DATE COMMENT '',
    `is_primary` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `team_role` STRING COMMENT '',
    CONSTRAINT pk_account_team PRIMARY KEY(`account_team_id`)
) COMMENT 'Team members assigned to manage trade accounts';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_account_segment_id` FOREIGN KEY (`account_segment_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_segment`(`account_segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_parent_trade_account_id` FOREIGN KEY (`parent_trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_account_hierarchy_id` FOREIGN KEY (`account_hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_hierarchy`(`account_hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ADD CONSTRAINT `fk_sales_account_contact_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ADD CONSTRAINT `fk_sales_account_address_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ADD CONSTRAINT `fk_sales_account_hierarchy_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ADD CONSTRAINT `fk_sales_account_hierarchy_primary_trade_account_id` FOREIGN KEY (`primary_trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ADD CONSTRAINT `fk_sales_edi_trading_partner_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ADD CONSTRAINT `fk_sales_customer_vmi_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ADD CONSTRAINT `fk_sales_account_sla_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ADD CONSTRAINT `fk_sales_account_assortment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ADD CONSTRAINT `fk_sales_account_credit_profile_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ADD CONSTRAINT `fk_sales_account_pricing_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ADD CONSTRAINT `fk_sales_account_status_history_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ADD CONSTRAINT `fk_sales_account_compliance_record_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ADD CONSTRAINT `fk_sales_planogram_compliance_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ADD CONSTRAINT `fk_sales_price_list_item_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ADD CONSTRAINT `fk_sales_sales_deduction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ADD CONSTRAINT `fk_sales_sales_deduction_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ADD CONSTRAINT `fk_sales_sales_rebate_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ADD CONSTRAINT `fk_sales_sales_dsd_route_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ADD CONSTRAINT `fk_sales_sales_dsd_route_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ADD CONSTRAINT `fk_sales_sales_dsd_delivery_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ADD CONSTRAINT `fk_sales_sales_dsd_delivery_sales_dsd_route_id` FOREIGN KEY (`sales_dsd_route_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route`(`sales_dsd_route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ADD CONSTRAINT `fk_sales_account_onboarding_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ADD CONSTRAINT `fk_sales_account_onboarding_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ADD CONSTRAINT `fk_sales_sales_vmi_agreement_customer_vmi_agreement_id` FOREIGN KEY (`customer_vmi_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement`(`customer_vmi_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ADD CONSTRAINT `fk_sales_sales_vmi_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ADD CONSTRAINT `fk_sales_compliance_assignment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ADD CONSTRAINT `fk_sales_account_team_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `sales_deduction_id` SET TAGS ('dbx_ssot_superseded_by' = 'promotion.promotion_deduction');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `sales_deduction_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `sales_rebate_agreement_id` SET TAGS ('dbx_ssot_superseded_by' = 'promotion.promotion_rebate_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `sales_rebate_agreement_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_ssot_reference' = 'distribution.distribution_dsd_route');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `sales_dsd_route_id` SET TAGS ('dbx_ssot_superseded_by' = 'distribution.distribution_dsd_route');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `sales_dsd_route_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_ssot_reference' = 'distribution.distribution_dsd_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `sales_dsd_delivery_id` SET TAGS ('dbx_ssot_superseded_by' = 'distribution.distribution_dsd_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `sales_dsd_delivery_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_association_edges' = 'customer.trade_account,procurement.supplier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_ssot_reference' = 'procurement.procurement_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `sales_vmi_agreement_id` SET TAGS ('dbx_ssot_superseded_by' = 'inventory.inventory_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `sales_vmi_agreement_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_id` SET TAGS ('dbx_references' = 'procurement.procurement_vmi_agreement.procurement_vmi_agreement_id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `sales_vmi_agreement_status` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` SET TAGS ('dbx_association_edges' = 'customer.trade_account,sales.rep');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `call_status` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `effective_date` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` SET TAGS ('dbx_association_edges' = 'customer.trade_account,regulatory.compliance_obligation');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_assignment_status` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
