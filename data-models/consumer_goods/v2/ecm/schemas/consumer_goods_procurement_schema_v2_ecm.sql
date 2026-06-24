-- Schema for Domain: procurement | Business:  | Version: v2_ecm
-- Generated on: 2026-06-24 00:22:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`procurement` COMMENT 'Owns sourcing, supplier management, and purchase order execution for raw materials, packaging, and indirect goods. Manages supplier master data, contracts, RFQs, purchase requisitions, PO lifecycle, goods receipt, invoice verification, MOQ terms, SDS documentation, supplier performance scorecards, VMI programs, and sustainable sourcing initiatives (FSC, RSPO).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Primary key',
    `supplier_code` STRING COMMENT 'Unique supplier code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credit_limit` DECIMAL(18,2) COMMENT 'Credit limit amount',
    `currency_code` STRING COMMENT 'Default currency',
    `duns_number` STRING COMMENT 'D&B DUNS number',
    `is_minority_owned` BOOLEAN COMMENT 'Minority-owned business flag',
    `is_strategic_supplier` BOOLEAN COMMENT 'Strategic supplier flag',
    `is_woman_owned` BOOLEAN COMMENT 'Woman-owned business flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `supplier_name` STRING COMMENT 'Legal name of supplier',
    `on_time_delivery_pct` DECIMAL(18,2) COMMENT 'OTD percentage',
    `payment_terms` STRING COMMENT 'Standard payment terms',
    `quality_rating` STRING COMMENT 'Quality performance rating',
    `supplier_status` STRING COMMENT 'Active, inactive, blocked',
    `supplier_type` STRING COMMENT 'Type of supplier (raw material, packaging, service)',
    `sustainability_rating` STRING COMMENT 'ESG rating',
    `tax_identification_number` STRING COMMENT 'Tax identification number',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for suppliers providing goods and services';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` (
    `supplier_site_id` BIGINT COMMENT 'Primary key',
    `supplier_id` BIGINT COMMENT 'Foreign key to supplier',
    `address_line_1` STRING COMMENT 'Address line 1',
    `address_line_2` STRING COMMENT 'Address line 2',
    `city` STRING COMMENT 'City',
    `country_code` STRING COMMENT 'Country code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `gmp_certified` BOOLEAN COMMENT 'GMP certification flag',
    `is_primary_site` BOOLEAN COMMENT 'Primary site flag',
    `iso_9001_certified` BOOLEAN COMMENT 'ISO 9001 certification',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `postal_code` STRING COMMENT 'Postal code',
    `site_code` STRING COMMENT 'Unique site code',
    `site_name` STRING COMMENT 'Site name',
    `site_type` STRING COMMENT 'Manufacturing, warehouse, office',
    `state_province` STRING COMMENT 'State or province',
    CONSTRAINT pk_supplier_site PRIMARY KEY(`supplier_site_id`)
) COMMENT 'Physical locations for suppliers';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` (
    `supplier_contract_id` BIGINT COMMENT 'Primary key',
    `supplier_id` BIGINT COMMENT 'Foreign key to supplier',
    `auto_renewal_flag` BOOLEAN COMMENT 'Auto-renewal flag',
    `contract_number` STRING COMMENT 'Contract number',
    `contract_status` STRING COMMENT 'Active, expired, terminated',
    `contract_type` STRING COMMENT 'Type of contract',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `end_date` DATE COMMENT 'Contract end date',
    `incoterms` STRING COMMENT 'Incoterms',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `payment_terms` STRING COMMENT 'Payment terms',
    `start_date` DATE COMMENT 'Contract start date',
    `total_value` DECIMAL(18,2) COMMENT 'Total contract value',
    CONSTRAINT pk_supplier_contract PRIMARY KEY(`supplier_contract_id`)
) COMMENT 'Contracts with suppliers';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` (
    `contract_line_id` BIGINT COMMENT 'Primary key',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key to contract',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `contract_line_description` STRING COMMENT 'Line description',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `line_number` STRING COMMENT 'Line number',
    `line_value` DECIMAL(18,2) COMMENT 'Line total value',
    `material_code` STRING COMMENT 'Material code',
    `quantity` DECIMAL(18,2) COMMENT 'Contracted quantity',
    `unit_of_measure` STRING COMMENT 'UOM',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price',
    CONSTRAINT pk_contract_line PRIMARY KEY(`contract_line_id`)
) COMMENT 'Line items in supplier contracts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Buyer',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `issue_date` DATE COMMENT 'Issue date',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `response_due_date` DATE COMMENT 'Response deadline',
    `rfq_number` STRING COMMENT 'RFQ number',
    `rfq_status` STRING COMMENT 'Draft, issued, closed',
    `title` STRING COMMENT 'RFQ title',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for quotation';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` (
    `rfq_response_id` BIGINT COMMENT 'Primary key',
    `rfq_id` BIGINT COMMENT 'Foreign key to RFQ',
    `supplier_id` BIGINT COMMENT 'Foreign key to supplier',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `lead_time_days` STRING COMMENT 'Lead time',
    `quoted_price` DECIMAL(18,2) COMMENT 'Quoted price',
    `response_date` DATE COMMENT 'Response date',
    `response_status` STRING COMMENT 'Submitted, awarded, rejected',
    CONSTRAINT pk_rfq_response PRIMARY KEY(`rfq_response_id`)
) COMMENT 'Supplier responses to RFQs';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Requester',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `required_by_date` DATE COMMENT 'Required by date',
    `requisition_date` DATE COMMENT 'Requisition date',
    `requisition_number` STRING COMMENT 'Requisition number',
    `requisition_status` STRING COMMENT 'Draft, approved, ordered',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal purchase requests';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Buyer',
    `supplier_id` BIGINT COMMENT 'Foreign key to supplier',
    `supplier_site_id` BIGINT COMMENT 'Foreign key to supplier site',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `incoterms` STRING COMMENT 'Incoterms',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `payment_terms` STRING COMMENT 'Payment terms',
    `po_date` DATE COMMENT 'PO date',
    `po_number` STRING COMMENT 'PO number',
    `po_status` STRING COMMENT 'Draft, issued, received, closed',
    `total_amount` DECIMAL(18,2) COMMENT 'Total PO amount',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Purchase orders to suppliers';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Primary key',
    `purchase_order_id` BIGINT COMMENT 'Foreign key to PO',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delivery_date` DATE COMMENT 'Requested delivery date',
    `po_line_description` STRING COMMENT 'Line description',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `line_amount` DECIMAL(18,2) COMMENT 'Line total',
    `line_number` STRING COMMENT 'Line number',
    `line_status` STRING COMMENT 'Open, received, closed',
    `material_code` STRING COMMENT 'Material code',
    `quantity` DECIMAL(18,2) COMMENT 'Ordered quantity',
    `unit_of_measure` STRING COMMENT 'UOM',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Purchase order line items';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key',
    `po_line_id` BIGINT COMMENT 'Foreign key to PO line',
    `purchase_order_id` BIGINT COMMENT 'Foreign key to PO',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `quality_inspection_required` BOOLEAN COMMENT 'QC required flag',
    `receipt_date` DATE COMMENT 'Receipt date',
    `receipt_number` STRING COMMENT 'Receipt number',
    `receipt_status` STRING COMMENT 'Pending, accepted, rejected',
    `received_quantity` DECIMAL(18,2) COMMENT 'Received quantity',
    `unit_of_measure` STRING COMMENT 'UOM',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Receipt of goods from suppliers';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'Primary key',
    `purchase_order_id` BIGINT COMMENT 'Foreign key to PO',
    `supplier_id` BIGINT COMMENT 'Foreign key to supplier',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `due_date` DATE COMMENT 'Payment due date',
    `invoice_amount` DECIMAL(18,2) COMMENT 'Invoice amount',
    `invoice_date` DATE COMMENT 'Invoice date',
    `invoice_number` STRING COMMENT 'Invoice number',
    `invoice_status` STRING COMMENT 'Pending, approved, paid',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `payment_terms` STRING COMMENT 'Payment terms',
    CONSTRAINT pk_supplier_invoice PRIMARY KEY(`supplier_invoice_id`)
) COMMENT 'Invoices from suppliers';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Primary key',
    `po_line_id` BIGINT COMMENT 'Foreign key to PO line',
    `supplier_invoice_id` BIGINT COMMENT 'Foreign key to invoice',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `invoice_line_description` STRING COMMENT 'Line description',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `line_amount` DECIMAL(18,2) COMMENT 'Line total',
    `line_number` STRING COMMENT 'Line number',
    `quantity` DECIMAL(18,2) COMMENT 'Invoiced quantity',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Supplier invoice line items';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` (
    `supplier_scorecard_id` BIGINT COMMENT 'Primary key',
    `supplier_id` BIGINT COMMENT 'Foreign key to supplier',
    `cost_score` DECIMAL(18,2) COMMENT 'Cost competitiveness score',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `defect_rate_ppm` DECIMAL(18,2) COMMENT 'Defect rate PPM',
    `delivery_score` DECIMAL(18,2) COMMENT 'Delivery score',
    `evaluation_period` STRING COMMENT 'Evaluation period',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `on_time_delivery_pct` DECIMAL(18,2) COMMENT 'OTD percentage',
    `overall_score` DECIMAL(18,2) COMMENT 'Overall score',
    `quality_score` DECIMAL(18,2) COMMENT 'Quality score',
    CONSTRAINT pk_supplier_scorecard PRIMARY KEY(`supplier_scorecard_id`)
) COMMENT 'Supplier performance metrics';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` (
    `sourcing_event_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Lead buyer',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `end_date` DATE COMMENT 'Event end date',
    `estimated_value` DECIMAL(18,2) COMMENT 'Estimated value',
    `event_name` STRING COMMENT 'Event name',
    `event_status` STRING COMMENT 'Draft, active, closed',
    `event_type` STRING COMMENT 'RFQ, auction, negotiation',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `start_date` DATE COMMENT 'Event start date',
    CONSTRAINT pk_sourcing_event PRIMARY KEY(`sourcing_event_id`)
) COMMENT 'Strategic sourcing events';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` (
    `spend_category_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Category manager',
    `parent_spend_category_id` BIGINT COMMENT 'Parent category',
    `category_code` STRING COMMENT 'Category code',
    `category_level` STRING COMMENT 'Hierarchy level',
    `category_name` STRING COMMENT 'Category name',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `is_strategic_category` BOOLEAN COMMENT 'Strategic flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    CONSTRAINT pk_spend_category PRIMARY KEY(`spend_category_id`)
) COMMENT 'Procurement spend categories';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` (
    `approved_supplier_list_id` BIGINT COMMENT 'Primary key',
    `supplier_id` BIGINT COMMENT 'Foreign key to supplier',
    `approval_date` DATE COMMENT 'Approval date',
    `approval_status` STRING COMMENT 'Approved, conditional, suspended',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `expiry_date` DATE COMMENT 'Approval expiry date',
    `is_preferred_supplier` BOOLEAN COMMENT 'Preferred supplier flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `material_code` STRING COMMENT 'Material code',
    `ranking` STRING COMMENT 'Supplier ranking',
    CONSTRAINT pk_approved_supplier_list PRIMARY KEY(`approved_supplier_list_id`)
) COMMENT 'Approved suppliers for materials';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` (
    `supplier_qualification_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Auditor',
    `supplier_id` BIGINT COMMENT 'Foreign key to supplier',
    `audit_score` DECIMAL(18,2) COMMENT 'Audit score',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `expiry_date` DATE COMMENT 'Expiry date',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `qualification_date` DATE COMMENT 'Qualification date',
    `qualification_status` STRING COMMENT 'Qualified, pending, failed',
    `qualification_type` STRING COMMENT 'Type of qualification',
    CONSTRAINT pk_supplier_qualification PRIMARY KEY(`supplier_qualification_id`)
) COMMENT 'Supplier qualification records';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` (
    `procurement_vmi_agreement_id` BIGINT COMMENT 'Primary key',
    `supplier_id` BIGINT COMMENT 'Foreign key to supplier',
    `agreement_number` STRING COMMENT 'Agreement number',
    `agreement_status` STRING COMMENT 'Active, inactive, expired',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_sharing_frequency` STRING COMMENT 'Daily, weekly, real-time',
    `end_date` DATE COMMENT 'End date',
    `inventory_ownership` STRING COMMENT 'Supplier, buyer, consignment',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `replenishment_model` STRING COMMENT 'Min/max, consumption-based',
    `start_date` DATE COMMENT 'Start date',
    CONSTRAINT pk_procurement_vmi_agreement PRIMARY KEY(`procurement_vmi_agreement_id`)
) COMMENT 'Vendor managed inventory agreements';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` (
    `price_condition_id` BIGINT COMMENT 'Primary key',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key to contract',
    `condition_type` STRING COMMENT 'Discount, surcharge, freight',
    `condition_unit` STRING COMMENT 'Percentage, fixed amount',
    `condition_value` DECIMAL(18,2) COMMENT 'Condition value',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `valid_from` DATE COMMENT 'Valid from date',
    `valid_to` DATE COMMENT 'Valid to date',
    CONSTRAINT pk_price_condition PRIMARY KEY(`price_condition_id`)
) COMMENT 'Pricing conditions and discounts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Primary key',
    `po_line_id` BIGINT COMMENT 'Foreign key to PO line',
    `purchase_order_id` BIGINT COMMENT 'Foreign key to PO',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delivery_status` STRING COMMENT 'Scheduled, shipped, delivered',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `schedule_line_number` STRING COMMENT 'Schedule line number',
    `scheduled_date` DATE COMMENT 'Scheduled delivery date',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'Scheduled quantity',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'Scheduled deliveries from suppliers';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` (
    `po_confirmation_id` BIGINT COMMENT 'Primary key',
    `purchase_order_id` BIGINT COMMENT 'Foreign key to PO',
    `confirmation_date` DATE COMMENT 'Confirmation date',
    `confirmation_number` STRING COMMENT 'Confirmation number',
    `confirmation_status` STRING COMMENT 'Accepted, rejected, modified',
    `confirmed_delivery_date` DATE COMMENT 'Confirmed delivery date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `supplier_comments` STRING COMMENT 'Supplier comments',
    CONSTRAINT pk_po_confirmation PRIMARY KEY(`po_confirmation_id`)
) COMMENT 'Supplier confirmations of purchase orders';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` (
    `service_entry_sheet_line_id` BIGINT COMMENT 'Primary key',
    `po_line_id` BIGINT COMMENT 'Foreign key to PO line',
    `service_entry_sheet_id` BIGINT COMMENT 'Foreign key to service entry sheet',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `line_amount` DECIMAL(18,2) COMMENT 'Line total',
    `line_number` STRING COMMENT 'Line number',
    `quantity` DECIMAL(18,2) COMMENT 'Service quantity',
    `service_description` STRING COMMENT 'Service description',
    `unit_of_measure` STRING COMMENT 'UOM',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price',
    CONSTRAINT pk_service_entry_sheet_line PRIMARY KEY(`service_entry_sheet_line_id`)
) COMMENT 'Service entry sheet line items';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` (
    `service_entry_sheet_id` BIGINT COMMENT 'Primary key',
    `purchase_order_id` BIGINT COMMENT 'Foreign key to PO',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `entry_date` DATE COMMENT 'Entry date',
    `entry_status` STRING COMMENT 'Draft, approved, invoiced',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `service_period_end` DATE COMMENT 'Service period end',
    `service_period_start` DATE COMMENT 'Service period start',
    `sheet_number` STRING COMMENT 'Sheet number',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount',
    CONSTRAINT pk_service_entry_sheet PRIMARY KEY(`service_entry_sheet_id`)
) COMMENT 'Service entry sheets for service procurement';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`service` (
    `service_id` BIGINT COMMENT 'Primary key',
    `supplier_id` BIGINT COMMENT '',
    `service_category` STRING COMMENT 'Service category',
    `service_code` STRING COMMENT 'Service code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `service_description` STRING COMMENT 'Description',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `service_name` STRING COMMENT 'Service name',
    `standard_rate` DECIMAL(18,2) COMMENT 'Standard rate',
    `unit_of_measure` STRING COMMENT 'UOM',
    CONSTRAINT pk_service PRIMARY KEY(`service_id`)
) COMMENT 'Master data for procured services';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` (
    `vmi_agreement_type_id` BIGINT COMMENT 'Primary key',
    `supplier_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `ownership_model` STRING COMMENT 'Ownership model',
    `replenishment_model` STRING COMMENT 'Replenishment model',
    `type_code` STRING COMMENT 'Type code',
    `type_description` STRING COMMENT 'Description',
    `type_name` STRING COMMENT 'Type name',
    CONSTRAINT pk_vmi_agreement_type PRIMARY KEY(`vmi_agreement_type_id`)
) COMMENT 'Types of VMI agreements';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` (
    `procurement_vmi_agreement2_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT 'Supplier party to the VMI agreement',
    `agreement_number` STRING COMMENT 'Business document number for the agreement',
    `agreement_status` STRING COMMENT 'Lifecycle status of the agreement',
    `agreement_type_code` STRING COMMENT 'Unique code identifying the VMI agreement type.',
    `agreement_type_description` STRING COMMENT '',
    `agreement_type_name` STRING COMMENT '',
    `auto_renew_flag` BOOLEAN COMMENT 'Whether the agreement auto-renews',
    `auto_replenish_flag` BOOLEAN COMMENT 'Whether automatic replenishment is enabled',
    `billing_frequency` STRING COMMENT 'Frequency of billing under this agreement type',
    `billing_trigger` STRING COMMENT 'Event that triggers billing (consumption, shipment, receipt)',
    `consignment_flag` BOOLEAN COMMENT 'Whether stock is held on consignment',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Currency for monetary terms',
    `default_lead_time_days` STRING COMMENT 'Default lead time in days for this agreement type',
    `procurement_vmi_agreement2_description` STRING COMMENT '',
    `effective_date` DATE COMMENT 'Date from which this agreement type becomes effective.',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `expiry_date` DATE COMMENT 'Date on which this agreement type expires.',
    `is_active` BOOLEAN COMMENT '',
    `is_consignment` BOOLEAN COMMENT 'Whether this agreement type involves consignment inventory',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `lead_time_days` STRING COMMENT 'Standard lead time in days for this agreement type',
    `max_order_quantity` DECIMAL(18,2) COMMENT 'Maximum order quantity allowed per replenishment cycle',
    `max_stock_level` DECIMAL(18,2) COMMENT 'Maximum stock level allowed under the agreement',
    `max_stock_threshold` DECIMAL(18,2) COMMENT '',
    `min_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity threshold for VMI replenishment',
    `min_stock_level` DECIMAL(18,2) COMMENT 'Minimum stock level the supplier must maintain',
    `min_stock_threshold` DECIMAL(18,2) COMMENT '',
    `ownership_model` STRING COMMENT 'Inventory ownership model (consignment, owned, hybrid)',
    `ownership_transfer_point` STRING COMMENT 'Point at which inventory ownership transfers',
    `penalty_clause_flag` BOOLEAN COMMENT 'Whether penalty clauses apply to this agreement type',
    `reorder_point` DECIMAL(18,2) COMMENT 'Reorder trigger quantity',
    `replenishment_frequency` STRING COMMENT 'Cadence of replenishment cycles',
    `replenishment_method` STRING COMMENT 'Method used for inventory replenishment under this agreement type',
    `replenishment_model` STRING COMMENT '',
    `requires_forecast_sharing` BOOLEAN COMMENT 'Whether this type requires forecast data sharing',
    `review_frequency` STRING COMMENT '',
    `review_frequency_days` STRING COMMENT 'Number of days between inventory review cycles',
    `safety_stock_method` STRING COMMENT 'Method for calculating safety stock levels',
    `service_level_target_pct` DECIMAL(18,2) COMMENT 'Target service level percentage for this agreement type',
    `procurement_vmi_agreement2_status` STRING COMMENT 'Current status of the agreement type (e.g., active, inactive, deprecated).',
    `type_code` STRING COMMENT 'Code identifying the VMI agreement type',
    `type_name` STRING COMMENT 'Name of the VMI agreement type',
    `vmi_agreement_type` STRING COMMENT 'Type/category of VMI agreement',
    `vmi_agreement_type_code` STRING COMMENT '',
    `expiration_date` DATE COMMENT 'Date the procurement_vmi_agreement2 expires',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity associated with the procurement_vmi_agreement2',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount associated with the procurement_vmi_agreement2',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the procurement_vmi_agreement2 was created',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when the procurement_vmi_agreement2 was last updated',
    CONSTRAINT pk_procurement_vmi_agreement2 PRIMARY KEY(`procurement_vmi_agreement2_id`)
) COMMENT 'Records for procurement vmi agreement2 in the procurement domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ADD CONSTRAINT `fk_procurement_rfq_response_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ADD CONSTRAINT `fk_procurement_rfq_response_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ADD CONSTRAINT `fk_procurement_spend_category_parent_spend_category_id` FOREIGN KEY (`parent_spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ADD CONSTRAINT `fk_procurement_procurement_vmi_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ADD CONSTRAINT `fk_procurement_price_condition_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ADD CONSTRAINT `fk_procurement_po_confirmation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ADD CONSTRAINT `fk_procurement_service_entry_sheet_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ADD CONSTRAINT `fk_procurement_service_entry_sheet_line_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ADD CONSTRAINT `fk_procurement_vmi_agreement_type_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ADD CONSTRAINT `fk_procurement_procurement_vmi_agreement2_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`procurement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` SET TAGS ('dbx_subdomain' = 'sourcing_events');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` SET TAGS ('dbx_subdomain' = 'sourcing_events');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'purchase_orders');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'purchase_orders');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'purchase_orders');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'receipt_invoice');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'receipt_invoice');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` SET TAGS ('dbx_subdomain' = 'receipt_invoice');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_subdomain' = 'sourcing_events');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` SET TAGS ('dbx_subdomain' = 'sourcing_events');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_subdomain' = 'inventory_agreements');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_ssot_reference' = 'inventory.inventory_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_ssot' = 'procurement.procurement_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_id` SET TAGS ('dbx_ssot_superseded_by' = 'inventory.inventory_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` SET TAGS ('dbx_subdomain' = 'purchase_orders');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'receipt_invoice');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` SET TAGS ('dbx_subdomain' = 'purchase_orders');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` SET TAGS ('dbx_subdomain' = 'service_procurement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_subdomain' = 'service_procurement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` SET TAGS ('dbx_subdomain' = 'service_procurement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` SET TAGS ('dbx_subdomain' = 'inventory_agreements');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `supplier_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` SET TAGS ('dbx_subdomain' = 'inventory_agreements');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `agreement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `auto_replenish_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Replenish Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `is_consignment` SET TAGS ('dbx_business_glossary_term' = 'Is Consignment');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `max_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `penalty_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Method');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `service_level_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `procurement_vmi_agreement2_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `expiration_date` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `expiration_date` SET TAGS ('dbx_classification' = 'date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `expiration_date` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `quantity` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `quantity` SET TAGS ('dbx_classification' = 'measure');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `quantity` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `amount` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `amount` SET TAGS ('dbx_classification' = 'measure');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `amount` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `created_at` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `created_at` SET TAGS ('dbx_classification' = 'audit');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `created_at` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `updated_at` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `updated_at` SET TAGS ('dbx_classification' = 'audit');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement2` ALTER COLUMN `updated_at` SET TAGS ('dbx_source' = 'business_context');
