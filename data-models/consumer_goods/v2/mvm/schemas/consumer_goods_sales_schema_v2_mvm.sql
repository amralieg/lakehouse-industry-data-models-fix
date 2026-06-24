-- Schema for Domain: sales | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-24 01:55:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`sales` COMMENT 'Owns commercial sales execution, order management, and revenue transactions across all channels (retail, wholesale, DTC, e-commerce). Manages sales orders, pricing agreements, sales force automation (SFA), retail account call records, POG compliance, RSP/MSRP price management, ACV/TDP/SOM metrics, and field sales KPIs. Integrates with Salesforce Consumer Goods Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` (
    `trade_account_id` BIGINT COMMENT 'Primary key',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Trade accounts (customers) are managed within a specific company code for credit limit management, AR aging, dunning, and intercompany customer reconciliation. In multi-entity consumer goods, a custom',
    `parent_trade_account_id` BIGINT COMMENT '',
    `territory_id` BIGINT COMMENT '',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` (
    `retail_store_id` BIGINT COMMENT 'Primary key',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Each retail store is served by a primary distribution center — a fundamental consumer goods supply chain relationship driving replenishment planning, route optimization, and DC-to-store service level ',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: In consumer goods with company-owned or franchise retail stores, each store is mapped to a profit center for store-level P&L reporting. Finance requires this link for retail performance management, st',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`order` (
    `order_id` BIGINT COMMENT 'Primary key',
    `account_address_id` BIGINT COMMENT '',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Sales orders in multi-entity consumer goods operations must be assigned to a company code for revenue recognition, intercompany billing, and statutory financial reporting. A finance domain expert woul',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Drop-ship fulfillment: in CPG, sales orders are frequently fulfilled directly by a supplier bypassing the warehouse. Operations and supply chain teams must know which supplier fulfills each drop-ship ',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.pricing_agreement. Business justification: In consumer goods sales, orders are frequently placed under a specific negotiated pricing agreement (e.g., a promotional deal or contract price). Linking order to pricing_agreement allows the system t',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Consumer goods companies assign sales orders to profit centers for channel/brand/regional P&L reporting. This is a standard SAP-style financial dimension enabling management reporting on sales perform',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Sales orders in consumer goods are placed or managed by a specific sales representative. Linking order to rep enables sales performance tracking, commission calculation, and field sales KPI reporting ',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: In consumer goods, orders are often placed for delivery to a specific retail store location (ship-to store), particularly in DTC and wholesale channels. This is distinct from account_address_id (which',
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
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Sales invoices must be posted to a specific company code for AR accounting, VAT/tax reporting, and statutory financial statements. In consumer goods with multiple legal entities, every invoice require',
    `order_id` BIGINT COMMENT '',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue from sales invoices must be attributed to profit centers for P&L reporting by brand, channel, or region. Consumer goods finance teams require invoice-level profit center assignment for gross m',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Trade pricing agreements in consumer goods are routinely negotiated at brand level (e.g., retailer receives 12% off all Brand X SKUs). Brand-level trade terms management is a named business process; a',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Pricing agreements (trade deals, rebate contracts) are legal instruments tied to a company code for revenue recognition under ASC 606/IFRS 15 and trade spend accounting. Finance requires this link to ',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to sales.price_list. Business justification: A pricing agreement with a trade account is typically built on top of a master price list — the agreement defines the discount_percentage or special terms applied to the base prices in the referenced ',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Trade pricing agreements and rebate contracts are tracked by profit center for trade spend management and profitability analysis by brand/channel. Consumer goods finance teams require this for accurat',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` (
    `return_order_id` BIGINT COMMENT 'Primary key',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Consumer goods recall management and GMP traceability require linking return orders to the originating manufacturing batch/lot. Quality investigations, regulatory reporting, and recall scope determina',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Return orders generate credit memos that must be posted to the originating company code for accurate AR reversal and revenue adjustment. Multi-entity consumer goods operations require this for interco',
    `order_id` BIGINT COMMENT '',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Returns reduce revenue on the originating profit center; consumer goods finance requires return orders to carry a profit center for accurate net revenue reporting, deduction management, and trade prom',
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
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales territories map to profit centers for geographic P&L reporting in consumer goods. This link enables revenue and margin analysis by territory aligned to the financial profit center hierarchy, sup',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Consumer goods field sales organizations routinely assign reps as brand ambassadors or brand-dedicated account managers. Brand-dedicated sales force management is a standard named process; sales ops r',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales reps are assigned to cost centers for sales force expense allocation, headcount cost reporting, and sales commission accrual. Consumer goods finance teams use this link for SG&A cost center repo',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` (
    `price_list_id` BIGINT COMMENT 'Primary key',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Price lists in multi-entity consumer goods are company-code-specific due to currency, tax jurisdiction, and transfer pricing requirements. Finance requires this link to validate that pricing aligns wi',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` (
    `account_assignment_id` BIGINT COMMENT 'Primary key for the account_assignment association',
    `rep_id` BIGINT COMMENT 'Foreign key linking to the sales rep who is assigned to the trade account',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to the B2B trade account being assigned',
    `end_date` DATE COMMENT 'The date on which the reps assignment to this account in this role ended. Null indicates an active assignment. Required for historical tracking and performance reporting. Sourced from detection phase relationship data.',
    `role` STRING COMMENT 'The functional role the rep holds on this account (e.g., Key Account Manager, Field Rep). A single account may have multiple reps in different roles simultaneously. Sourced from detection phase relationship data.',
    `start_date` DATE COMMENT 'The date on which the reps assignment to this account in this role became effective. Required for historical tracking and commission period calculations. Sourced from detection phase relationship data.',
    CONSTRAINT pk_account_assignment PRIMARY KEY(`account_assignment_id`)
) COMMENT 'This association product represents the Role-based assignment between a sales rep and a trade account. It captures which reps are actively (or historically) responsible for a given trade account, in what capacity, and for what period. Each record links one rep to one trade_account with attributes — role, start_date, end_date — that exist only in the context of this assignment relationship and are required for commission calculation and sales performance reporting.. Existence Justification: In consumer goods SFA (Salesforce Automation), a sales rep manages a portfolio of many trade accounts, and a large B2B trade account is actively served by multiple reps in distinct roles (e.g., key account manager, field rep, inside sales rep). This is a well-established operational concept — Account Team Membership or Account Assignment — that businesses actively create, update, and deactivate as territories shift and roles change. The relationship carries its own first-class attributes (role, start_date, end_date) that belong to neither the rep nor the account alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_parent_trade_account_id` FOREIGN KEY (`parent_trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ADD CONSTRAINT `fk_sales_account_contact_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ADD CONSTRAINT `fk_sales_account_address_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ADD CONSTRAINT `fk_sales_price_list_item_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` ADD CONSTRAINT `fk_sales_account_assignment_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` ADD CONSTRAINT `fk_sales_account_assignment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Dropship Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` SET TAGS ('dbx_association_edges' = 'sales.rep,sales.trade_account');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` ALTER COLUMN `account_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment - Account Assignment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment - Rep Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment - Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
