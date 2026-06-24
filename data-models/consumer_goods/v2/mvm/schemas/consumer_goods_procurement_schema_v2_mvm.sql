-- Schema for Domain: procurement | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-24 01:55:09

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
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Supplier sites are approved and registered per legal entity for payment processing and tax reporting. In multi-entity consumer goods companies, a supplier site must be linked to a company code to enab',
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
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Supplier contracts are legal agreements between a supplier and a specific legal entity. Multi-entity consumer goods companies require company_code on contracts for legal enforceability, entity-level c',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Supplier contracts are budget-controlled at cost center level in consumer goods category management. Finance and procurement jointly track committed spend against cost center budgets; contract-level c',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Supplier quality agreement: consumer goods supplier contracts formally reference the quality specification the supplier must meet. This link enables contract compliance reporting, specification versio',
    `supplier_id` BIGINT COMMENT 'Foreign key to supplier',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: A supplier contract can be scoped to a specific supplier site (e.g., a manufacturing plant or distribution center). While contracts are often negotiated at the supplier level, site-specific contracts ',
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
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Contract lines are coded to GL accounts for spend categorization, commitment accounting, and budget control. Finance uses GL account coding on contract lines for accrual postings and to ensure procure',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Supplier contract lines in consumer goods specify negotiated pricing and terms per material. Linking contract_line to material enables material-level contract coverage reporting, cost benchmarking aga',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key to contract',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency',
    `contract_line_description` STRING COMMENT 'Line description',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `line_number` STRING COMMENT 'Line number',
    `line_value` DECIMAL(18,2) COMMENT 'Line total value',
    `quantity` DECIMAL(18,2) COMMENT 'Contracted quantity',
    `unit_of_measure` STRING COMMENT 'UOM',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price',
    CONSTRAINT pk_contract_line PRIMARY KEY(`contract_line_id`)
) COMMENT 'Line items in supplier contracts';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Primary key',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: POs are issued by a specific legal entity. Multi-entity consumer goods companies require company_code on POs for financial consolidation, intercompany reconciliation, and entity-level AP reporting. Es',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: POs must be coded to a cost center for budget consumption tracking and spend reporting. Consumer goods procurement teams assign every PO to a cost center for P&L accountability and period-end accruals',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Consumer goods companies assign PO spend to profit centers for brand/category P&L reporting. Procurement cost by profit center is a key management reporting dimension used in monthly brand contributio',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Purchase orders are frequently issued against a supplier contract (blanket PO, contract release order, or scheduled agreement). Linking purchase_order.supplier_contract_id → supplier_contract.supplier',
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
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: Each PO line represents a purchase of a specific material from a specific supplier. The approved_supplier_list (ASL) captures the approved supplier-material combinations with ranking and approval stat',
    `contract_line_id` BIGINT COMMENT 'Foreign key linking to procurement.contract_line. Business justification: A PO line can reference a specific contract line item, enabling line-level contract release tracking. This is standard in procurement systems (SAP ME21N, Oracle iProcurement) where each PO line is rel',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: PO lines require GL account assignment for three-way match, expense recognition, and budget consumption. This is fundamental to procure-to-pay in consumer goods ERP systems — finance requires GL codin',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Purchase order lines in consumer goods reference specific materials being procured. This link enables material-level spend analytics, PO-to-BOM reconciliation, MRP-driven procurement tracking, and goo',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Demand-driven procurement traceability: in make-to-order and direct replenishment CPG scenarios, PO lines are created in response to specific sales orders. Supply chain analysts and auditors require e',
    `purchase_order_id` BIGINT COMMENT 'Foreign key to PO',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delivery_date` DATE COMMENT 'Requested delivery date',
    `po_line_description` STRING COMMENT 'Line description',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `line_amount` DECIMAL(18,2) COMMENT 'Line total',
    `line_number` STRING COMMENT 'Line number',
    `line_status` STRING COMMENT 'Open, received, closed',
    `quantity` DECIMAL(18,2) COMMENT 'Ordered quantity',
    `unit_of_measure` STRING COMMENT 'UOM',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Purchase order line items';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Inbound receiving process requires knowing which manufacturing facility accepted the delivery. Enables facility-level inventory posting, GMP inbound traceability, and facility spend reporting. A Consu',
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
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Supplier invoices are received by a specific legal entity. Required for entity-level AP aging reports, VAT/tax compliance by jurisdiction, and intercompany invoice reconciliation in multi-entity consu',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Supplier invoices are coded to cost centers for expense allocation and accrual accounting. Finance teams require cost center coding on invoices for period-end close, budget variance reporting, and dep',
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
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Three-way match (PO → Goods Receipt → Invoice) is the cornerstone of procurement invoice verification. invoice_line already links to po_line (the PO leg). Adding goods_receipt_id to invoice_line compl',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` (
    `approved_supplier_list_id` BIGINT COMMENT 'Primary key',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: The Approved Supplier List in consumer goods is maintained per material — procurement teams qualify suppliers for specific raw materials/components. This link enables ASL-driven sourcing decisions, su',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Supplier qualification process: each approved_supplier_list entry governs a material_code that must conform to a quality specification. Procurement and quality teams jointly manage which specification',
    `supplier_id` BIGINT COMMENT 'Foreign key to supplier',
    `approval_date` DATE COMMENT 'Approval date',
    `approval_status` STRING COMMENT 'Approved, conditional, suspended',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `expiry_date` DATE COMMENT 'Approval expiry date',
    `is_preferred_supplier` BOOLEAN COMMENT 'Preferred supplier flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `ranking` STRING COMMENT 'Supplier ranking',
    CONSTRAINT pk_approved_supplier_list PRIMARY KEY(`approved_supplier_list_id`)
) COMMENT 'Approved suppliers for materials';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_contract_line_id` FOREIGN KEY (`contract_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`contract_line`(`contract_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`procurement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'purchase_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'purchase_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'purchase_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'purchase_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` SET TAGS ('dbx_subdomain' = 'purchase_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
