-- Schema for Domain: sales | Business: Food Beverage | Version: v1_mvm
-- Generated on: 2026-05-05 23:22:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`sales` COMMENT 'Commercial sales operations including sales orders, EDI transactions, contracts, pricing (RSP, EDLP), POS data integration, category management, planograms, facings, ACV/TDP metrics, sales force automation, and revenue capture across retail, foodservice, and DTC channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`order` (
    `order_id` BIGINT COMMENT 'Unique identifier for the order.',
    `account_id` BIGINT COMMENT 'Identifier of the customer who placed the order.',
    `bill_to_location_id` BIGINT COMMENT 'Identifier of the location for billing purposes.',
    `broker_id` BIGINT COMMENT 'Foreign key linking to sales.broker. Business justification: In F&B distribution, orders are frequently placed through food brokers and manufacturer representatives. Linking order.broker_id -> broker enables broker-attributed order tracking, commission calculat',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Orders are attributed to the marketing campaign that generated the demand; linking supports sales‑to‑marketing attribution and spend ROI analysis.',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_center. Business justification: Order is fulfilled from a distribution center; linking enables direct relationship and removes distribution_center_code.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Sales orders in F&B multi-entity operations are booked against a specific company code for revenue recognition, intercompany transfer pricing, and statutory reporting. Essential for cross-border F&B o',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: F&B orders require a named buyer/procurement contact for order confirmation, delivery coordination, and dispute resolution. EDI and direct sales orders are associated with a specific contact at the cu',
    `contract_id` BIGINT COMMENT 'Identifier of the sales contract governing the order.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Sales order backlog and revenue forecasting require orders to be associated with a fiscal period. F&B finance teams track open order value and booked revenue by fiscal period for management reporting ',
    `import_export_permit_id` BIGINT COMMENT 'Foreign key linking to regulatory.import_export_permit. Business justification: Cross-border F&B orders require a valid import/export permit for customs clearance and trade compliance. Export compliance teams must verify permit status before order fulfillment. Orders with incoter',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Order originates from a manufacturing plant; linking provides traceability and eliminates redundant plant_code.',
    `promotion_event_id` BIGINT COMMENT 'Identifier of any promotion applied to the order.',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: Required for Order‑Retailer Agreement compliance reporting; ties each order to the specific retailer agreement governing slotting fees and promotions.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for General Ledger posting of order revenue; financial statements and tax reporting depend on linking each sales order to its revenue GL account.',
    `rep_id` BIGINT COMMENT 'Identifier of the sales representative responsible for the order.',
    `ship_to_location_id` BIGINT COMMENT 'Identifier of the location to which the order will be shipped.',
    `store_id` BIGINT COMMENT 'Foreign key linking to sales.store. Business justification: In F&B, orders are frequently placed for specific retail store locations (Direct Store Delivery, DSD). Linking order.store_id -> store enables store-level order analysis and supports DSD operational w',
    `actual_delivery_date` DATE COMMENT 'Date the order was actually delivered.',
    `channel` STRING COMMENT 'Channel through which the order was placed.. Valid values are `retail|foodservice|direct_to_consumer|online|wholesale`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order record was first captured.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the order amounts.',
    `edi_850_reference` STRING COMMENT 'Reference number of the EDI 850 purchase order transaction.',
    `erp_sales_doc_number` STRING COMMENT 'Sales document number generated in the ERP system.',
    `freight_terms` STRING COMMENT 'Terms governing freight cost responsibility.. Valid values are `prepaid|collect|third_party|FOB|CIF|DDP`',
    `incoterms` STRING COMMENT 'International commercial terms governing shipment responsibilities.',
    `is_backorder` BOOLEAN COMMENT 'True if any line items are on backorder.',
    `is_split_order` BOOLEAN COMMENT 'True if the order is split across multiple shipments.',
    `order_number` STRING COMMENT 'Business identifier assigned to the order by the sales system.',
    `order_source` STRING COMMENT 'Origin channel through which the order was entered.. Valid values are `EDI|Web|Phone|SalesRep|MobileApp|API`',
    `order_status` STRING COMMENT 'Current lifecycle status of the order.. Valid values are `draft|open|confirmed|fulfilled|cancelled|closed`',
    `order_type` STRING COMMENT 'Classification of the order based on processing rules.. Valid values are `standard|rush|blanket|standing|return|exchange`',
    `payment_terms` STRING COMMENT 'Payment terms agreed for the order (e.g., Net 30).',
    `placed_timestamp` TIMESTAMP COMMENT 'Timestamp when the order was created in the source system.',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether the order is marked as high priority.',
    `promised_delivery_date` DATE COMMENT 'Date promised by the company to deliver the order.',
    `requested_delivery_date` DATE COMMENT 'Date requested by the customer for delivery.',
    `revenue_recognition_flag` BOOLEAN COMMENT 'Indicates whether the order is eligible for revenue recognition at booking.',
    `sales_region` STRING COMMENT 'Geographic sales region associated with the order.',
    `shipping_method` STRING COMMENT 'Method used to transport the order to the customer.. Valid values are `ground|air|sea|rail|parcel|drone`',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Aggregate discount amount applied to the order.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of line item list prices before discounts and taxes.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final amount after discounts and taxes.',
    `total_quantity` STRING COMMENT 'Sum of ordered quantities across all lines.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the order.',
    `total_volume_cu_m` DECIMAL(18,2) COMMENT 'Aggregate volume of all items in the order (cubic meters).',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of all items in the order (kilograms).',
    `trade_allowance_flag` BOOLEAN COMMENT 'Indicates if trade allowances (e.g., discounts, rebates) are applied.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the order record.',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Complete sales order document capturing all commercial sales transactions across retail, foodservice, and DTC channels, including both header-level and line-level detail in a single authoritative record. Header: order number, order date, requested delivery date, order type (standard, rush, blanket, standing), order status, channel, customer account reference, ship-to and bill-to locations, currency, payment terms, incoterms, total order value, EDI 850 reference, and ERP sales document number. Lines: line number, SKU/GTIN, ordered quantity, unit of measure (case, each, pallet), confirmed quantity, shipped quantity, open quantity, list price, net price after trade allowances, discount amount, line status, requested ship date, scheduled ship date, plant/DC assignment, batch number for FEFO compliance, and revenue recognition flag. SSOT for all outbound sales order commitments within the sales domain.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`invoice` (
    `invoice_id` BIGINT COMMENT 'System-generated unique identifier for the invoice record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer billed on this invoice.',
    `bill_to_location_id` BIGINT COMMENT 'Identifier of the party responsible for payment.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: In F&B multi-entity structures, invoices are issued by a specific legal entity (company code), driving VAT/GST reporting, intercompany billing, and statutory financial statements. Every billing docume',
    `contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Invoices in F&B are frequently issued under the terms of a master sales contract (pricing, payment terms, rebates). Linking invoice.sales_contract_id -> sales_contract formalizes this relationship and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: F&B invoices carry a cost center for internal cost allocation (freight, trade spend). invoice has a plain-text cost_center column — replacing with a proper FK enforces 3NF and enables accurate cost ce',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Revenue recognition and period-close reporting require sales invoices to be stamped with the fiscal period. F&B finance teams reconcile invoiced revenue to the correct fiscal period for P&L reporting ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Invoice posting to the GL is mandatory for revenue recognition and audit trails; linking invoice to GL account enables accurate income statement reporting.',
    `import_export_permit_id` BIGINT COMMENT 'Foreign key linking to regulatory.import_export_permit. Business justification: Commercial invoices for cross-border F&B shipments must reference the applicable import/export permit for customs documentation compliance. Customs authorities require permit numbers on commercial inv',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: An invoice is generated from a sales order — this is a fundamental commercial document chain in F&B. invoice.order_id -> order establishes the traceability from billing back to the originating sales t',
    `original_invoice_id` BIGINT COMMENT 'Reference to the original invoice when this record is a credit or debit memo.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: F&B invoices are attributed to a profit center for revenue P&L reporting by brand/channel/region. invoice has a plain-text profit_center column — replacing with a proper FK enforces 3NF and enables pr',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: Needed for financial reconciliation of promotional spend; links each sales invoice to the promotion event that generated the sales.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.recall_event. Business justification: During F&B product recalls, invoices for affected product shipments must be identified to issue credit memos and execute financial reconciliation. Recall financial impact reporting and accounts receiv',
    `ship_to_location_id` BIGINT COMMENT 'Identifier of the party receiving the goods.',
    `approval_status` STRING COMMENT 'Current approval state of the invoice.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was approved.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (optional).',
    `billing_city` STRING COMMENT 'City component of the billing address.',
    `billing_country` STRING COMMENT 'Three-letter country code of the billing address.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the billing address.. Valid values are `^[0-9A-Z-]{3,10}$`',
    `billing_state` STRING COMMENT 'State or province component of the billing address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 code of the transaction currency.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `due_date` DATE COMMENT 'Date by which payment must be received.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert from transaction currency to reporting currency, if different.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Charges for transportation and logistics associated with the invoice.',
    `invoice_date` TIMESTAMP COMMENT 'Timestamp when the invoice was issued to the customer.',
    `invoice_number` STRING COMMENT 'External business identifier assigned to the invoice (e.g., sequential number).',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice.. Valid values are `draft|open|posted|cancelled|void`',
    `invoice_type` STRING COMMENT 'Classification of the invoice purpose (standard, credit memo, debit memo, intercompany).. Valid values are `standard|credit_memo|debit_memo|intercompany`',
    `is_credit_memo` BOOLEAN COMMENT 'Indicates whether the invoice is a credit memo (true) or not (false).',
    `line_count` STRING COMMENT 'Number of line items included on the invoice.',
    `payment_method` STRING COMMENT 'Method used by the customer to settle the invoice.. Valid values are `credit_card|bank_transfer|cash|check|edi`',
    `payment_status` STRING COMMENT 'Current status of the payment for this invoice.. Valid values are `pending|paid|failed|partial|refunded`',
    `payment_terms` STRING COMMENT 'Contractual terms defining when payment is due (e.g., Net 30).',
    `posted_to_ledger_flag` BOOLEAN COMMENT 'Indicates whether the invoice has been posted to the general ledger.',
    `revenue_category` STRING COMMENT 'Classification of revenue (e.g., gross sales, trade spend, net revenue).',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of line net amounts before discounts, freight, and tax.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the invoice based on applicable tax codes.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied for tax calculation.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final amount payable after all discounts, freight, and tax.',
    `trade_discount_amount` DECIMAL(18,2) COMMENT 'Total amount of trade promotions or discounts applied to the invoice.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the invoice record.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Complete commercial invoice document issued to customers upon shipment or delivery of goods, capturing both header-level and line-level detail in a single authoritative billing record for revenue recognition. Header: invoice number, invoice date, invoice type (standard, credit memo, debit memo, intercompany), customer account, billing address, currency, subtotal, trade discount, freight, tax, total amount, payment terms, EDI 810 reference, and SAP SD billing document number. Lines: line number, SKU/GTIN, billed quantity, unit of measure, list price, invoice unit price, line discount, line net amount, tax code, cost center, profit center, GL account code, and revenue category (gross sales, trade spend, net revenue). SSOT for accounts receivable origination within sales domain; finance domain owns downstream AR aging and collections.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`contract` (
    `contract_id` BIGINT COMMENT 'System-generated unique identifier for the sales contract.',
    `account_hierarchy_id` BIGINT COMMENT 'Foreign key linking to customer.account_hierarchy. Business justification: National account contracts in F&B (e.g., with Kroger, Walmart) apply across the full account hierarchy. Linking sales_contract to account_hierarchy enables contract compliance reporting, slotting fee ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Contracts are negotiated per brand; linking enables brand‑level contract performance tracking and compliance reporting.',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_center. Business justification: Links supply contracts to the distribution center fulfilling them, needed for contract performance and capacity planning reports.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Sales contracts in F&B are executed by a specific legal entity, determining applicable tax jurisdiction, currency, and statutory reporting obligations. Required for multi-entity F&B contract managemen',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Needed for Contract Signatory Register, linking each sales contract to the customer contact who authorized the agreement, required for compliance audit.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation of contract‑related expenses to a cost center is needed for budgeting, variance analysis, and cost‑to‑serve calculations.',
    `label_approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_approval. Business justification: F&B sales contracts — especially for private label, co-branded, or market-specific products — specify the approved label version the product must carry. Contract compliance audits and new product laun',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Contract compliance checks require linking each sales contract to the product registration to verify the product is authorized for sale.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Contracts are allocated to profit centers for performance tracking and internal profitability reporting; required by monthly P&L consolidation.',
    `promotion_plan_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_plan. Business justification: Contracts are often executed under a defined promotion plan; this link supports contract‑level promotion budgeting and performance tracking.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: A sales contract is negotiated and owned by a sales representative. Linking sales_contract.rep_id -> rep establishes accountability and enables rep-level contract portfolio analysis. No bidirectional ',
    `account_id` BIGINT COMMENT 'Identifier of the retailer party associated with the contract.',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: In F&B, sales contracts (slotting, volume commitments, EDLP) are executed under the framework of a retailer agreement. Contract management teams need to see which retailer agreement governs each sales',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: F&B sales contracts (EDLP, shelf-space, slotting agreements) are structured by customer segment (grocery, club, convenience). Linking contract to segment enables contract performance reporting and tra',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Contract management report ties each sales contract to a specific SKU for volume commitments and pricing; SKU ID is essential for accurate contract enforcement.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Contract Specification Compliance: sales contracts reference agreed product specifications; linking ensures compliance monitoring and audit reporting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: In F&B private label and co-pack arrangements, a retailer sales contract must reference the approved manufacturing supplier producing the goods. Regulatory traceability, retailer audits, and FSMA comp',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Sales contracts in F&B are often scoped to specific geographic territories (e.g., exclusive distribution agreements within a region). Linking sales_contract.territory_id -> territory formalizes this s',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiration.',
    `contract_number` STRING COMMENT 'Unique contract number assigned by the company.',
    `contract_type` STRING COMMENT 'Category of the contract defining its primary purpose.. Valid values are `volume_rebate|pricing_agreement|distribution_agreement|co_packing_agreement|slotting_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|CAD|EUR|GBP|JPY|MXN`',
    `edlp_tier` STRING COMMENT 'Pricing tier for EDLP pricing structure.. Valid values are `tier1|tier2|tier3|tier4|tier5|tier6`',
    `effective_end_date` DATE COMMENT 'Date when the contract ends or expires; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the contract becomes binding.',
    `exclusive_flag` BOOLEAN COMMENT 'Indicates if the contract grants exclusive rights to the retailer.',
    `fee_per_store` DECIMAL(18,2) COMMENT 'Slotting fee amount charged per store.',
    `is_active` BOOLEAN COMMENT 'Indicates if the contract is currently active (derived from status).',
    `launch_date` DATE COMMENT 'Date when the product is scheduled to be launched in stores under this contract.',
    `min_shelf_duration_days` STRING COMMENT 'Minimum number of days the product must remain on shelf.',
    `payment_terms` STRING COMMENT 'Terms governing payment schedule and method.',
    `performance_clause` STRING COMMENT 'Text describing velocity‑based performance criteria and penalties.',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'Percentage rebate applied based on volume thresholds.',
    `rsp_commitment` DECIMAL(18,2) COMMENT 'Committed RSP per unit for the contract.',
    `sales_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `draft|active|suspended|terminated|expired`',
    `slotting_fee_total` DECIMAL(18,2) COMMENT 'Aggregate fee paid for shelf slotting across all stores.',
    `store_count` STRING COMMENT 'Number of retail locations covered by the contract.',
    `termination_notice_period_days` STRING COMMENT 'Number of days notice required to terminate the contract.',
    `total_committed_volume` DECIMAL(18,2) COMMENT 'Total volume of product units committed under the contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `version` STRING COMMENT 'Version number of the contract for amendment tracking.',
    `volume_uom` STRING COMMENT 'Unit of measure for the committed volume.. Valid values are `cases|units|kg|liters`',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Master commercial agreement between Food Beverage and a customer (retailer, foodservice operator, distributor) governing pricing, volume commitments, promotional terms, slotting fees, and service levels. Captures contract number, contract type (volume rebate, pricing agreement, distribution agreement, co-packing agreement, slotting agreement), effective dates, contracted volume, RSP commitments, EDLP pricing tiers, payment terms, exclusivity clauses, auto-renewal flag, and Salesforce CRM opportunity reference. For slotting-type contracts: includes retailer account, SKU/GTIN, store count, fee per store, total commitment, payment schedule, shelf section, launch date, minimum shelf duration, and velocity-based performance clauses. ADR: Slotting agreements are modeled as a contract_type within this product (not as a separate entity) because they are negotiated by sales/category teams during new item sell-in and directly tied to distribution point creation. Trade domain owns broader promotional agreements (TPM/TPO); this product owns the commercial commitment for shelf placement fees. Commission/incentive compensation calculation is owned by the finance/workforce domain; sales provides quota attainment data as input.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`rep` (
    `rep_id` BIGINT COMMENT 'Primary key for rep',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales reps in F&B are assigned to a cost center for compensation expense allocation and SG&A reporting. Finance tracks sales force costs by cost center for budget-vs-actual analysis and headcount cost',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: A sales rep is assigned to a primary territory — this is a core sales force management relationship. rep.territory_id -> territory normalizes the territory assignment. territory_code on rep is a denor',
    `assigned_customer_count` STRING COMMENT 'Number of customer accounts assigned to the rep.',
    `certification_status` STRING COMMENT 'Status of any required sales certifications.. Valid values are `certified|pending|expired`',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Commission percentage applied to sales.',
    `compensation_plan` STRING COMMENT 'Compensation structure applied to the rep.. Valid values are `salary|commission|salary_plus_commission|bonus|incentive`',
    `compliance_training_completed_date` DATE COMMENT 'Date when mandatory compliance training was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rep record was created in the system.',
    `email` STRING COMMENT 'Primary business email address for the rep.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_status` STRING COMMENT 'Current employment status of the rep.. Valid values are `active|inactive|terminated|on_leave|retired`',
    `external_rep_code` STRING COMMENT 'External identifier used by partners or third‑party systems.',
    `full_name` STRING COMMENT 'Legal full name of the sales representative.',
    `hire_date` DATE COMMENT 'Date the rep was hired.',
    `is_remote_worker` BOOLEAN COMMENT 'Indicates if the rep works remotely.',
    `language_preference` STRING COMMENT 'Preferred language for communication with the rep.. Valid values are `en|es|fr|de|zh|pt`',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review.',
    `next_performance_review_due` DATE COMMENT 'Scheduled date for the next performance review.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the rep.',
    `primary_contact_method` STRING COMMENT 'Preferred primary contact channel for the rep.. Valid values are `email|phone|mobile|messenger`',
    `quota_annual_cases` DECIMAL(18,2) COMMENT 'Target annual case volume quota.',
    `quota_annual_revenue` DECIMAL(18,2) COMMENT 'Target annual revenue quota for the rep.',
    `record_source` STRING COMMENT 'Source system where the rep record originated.. Valid values are `salesforce|sap|oracle|manual`',
    `rep_type` STRING COMMENT 'Category of sales role performed by the rep.. Valid values are `field_sales|key_account_manager|national_account_manager|broker|dsd_driver`',
    `sales_channel` STRING COMMENT 'Primary sales channel the rep operates in.. Valid values are `retail|foodservice|direct_to_consumer|ecommerce|wholesale`',
    `sales_district` STRING COMMENT 'Specific sales district within the region.',
    `sales_force_user_code` STRING COMMENT 'User identifier in Salesforce CRM for the rep.',
    `sales_region` STRING COMMENT 'Geographic sales region assigned to the rep.. Valid values are `NORTH|SOUTH|EAST|WEST|MIDWEST|INTERNATIONAL`',
    `sap_employee_number` STRING COMMENT 'Employee number used in SAP SD module.',
    `termination_date` DATE COMMENT 'Date the reps employment ended, if applicable.',
    `travel_region` STRING COMMENT 'Travel region classification for the rep.. Valid values are `domestic|international`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rep record.',
    CONSTRAINT pk_rep PRIMARY KEY(`rep_id`)
) COMMENT 'Sales force master record for field sales representatives, key account managers, and broker/agent personnel responsible for managing customer relationships and driving revenue. Captures rep ID, full name, rep type (field sales, key account manager, national account manager, broker, DSD driver), assigned territory, assigned customer accounts, sales region, sales district, quota (annual revenue and case volume), manager reference, employment status, Salesforce CRM user ID, and SAP SD sales employee number. SSOT for sales force identity within the sales domain.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`territory` (
    `territory_id` BIGINT COMMENT 'Primary key for territory',
    `market_id` BIGINT COMMENT 'Foreign key linking to marketing.market. Business justification: Sales territories are aligned to marketing markets in F&B commercial planning (territory quota vs. marketing investment by market). This link enables integrated commercial planning reports comparing s',
    `acv_coverage_target` DECIMAL(18,2) COMMENT 'Target ACV value (in USD) the territory aims to cover.',
    `assigned_account_count` STRING COMMENT 'Number of retail, foodservice, or DTC accounts assigned to the territory.',
    `assigned_channel` STRING COMMENT 'Primary sales channel(s) the territory serves: retail, foodservice, or direct‑to‑consumer.. Valid values are `retail|foodservice|dtc`',
    `country` STRING COMMENT 'Three‑letter ISO country code for the territory.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was first created in the system.',
    `district` STRING COMMENT 'Sub‑region within a region used for finer territory granularity.',
    `effective_end_date` DATE COMMENT 'Date when the territory definition expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the territory definition becomes active.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the territory is exclusive to a single sales channel or partner.',
    `last_review_date` DATE COMMENT 'Date of the most recent business review of the territory definition.',
    `market_share_target_percent` DECIMAL(18,2) COMMENT 'Desired market share percentage for the territory.',
    `priority_level` STRING COMMENT 'Business priority assigned to the territory for resource allocation.. Valid values are `high|medium|low`',
    `quota_amount` DECIMAL(18,2) COMMENT 'Monetary sales quota assigned to the territory for the planning period.',
    `sales_target_amount` DECIMAL(18,2) COMMENT 'Projected sales revenue target for the territory.',
    `state_province_list` STRING COMMENT 'Comma‑separated list of states or provinces included in the territory.',
    `tdp_coverage_target` STRING COMMENT 'Target number of distribution points the territory should reach.',
    `territory_code` STRING COMMENT 'Business code used to reference the territory in sales and planning systems.',
    `territory_description` STRING COMMENT 'Free‑form description providing additional context about the territory.',
    `territory_name` STRING COMMENT 'Human‑readable name of the sales territory.',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory.. Valid values are `active|inactive|planned|retired`',
    `territory_type` STRING COMMENT 'Classification of the territory: geographic, account‑based, or channel‑based.. Valid values are `geographic|account_based|channel_based`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the territory record.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Geographic and account-based sales territory definition used to assign sales reps, set quotas, and measure performance. Captures territory code, territory name, territory type (geographic, account-based, channel-based), region, district, country, state/province list, assigned channel (retail, foodservice, DTC), ACV (All Commodity Volume) coverage target, TDP (Total Distribution Points) target, number of assigned accounts, effective start and end dates, and territory manager reference. Enables territory planning, quota allocation, and sales performance measurement.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`quota` (
    `quota_id` BIGINT COMMENT 'System-generated unique identifier for the quota record.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: In F&B, sales quotas are derived from and reconciled against the revenue budget. Linking quota to the finance_budget record enables quota-vs-budget variance analysis and ensures sales targets align wi',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: F&B sales quotas are routinely set and tracked by product category (e.g., beverage quota vs. snack quota per rep/territory). This link supports category-level quota attainment reporting, a standard sa',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Sales quota-vs-actual revenue variance reporting in F&B aligns quotas to fiscal periods. Finance uses this link for management reporting and incentive compensation calculations. quota has text fiscal_',
    `rep_id` BIGINT COMMENT 'Identifier of the sales representative to whom the quota is assigned.',
    `territory_id` BIGINT COMMENT 'Identifier of the sales territory or region for the quota assignment.',
    `approval_date` DATE COMMENT 'Date the quota was formally approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quota record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary quotas (e.g., USD, EUR).',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1‑4) within the fiscal year for the quota.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the quota belongs.',
    `notes` STRING COMMENT 'Additional remarks, comments, or audit notes related to the quota.',
    `period_end` DATE COMMENT 'Last calendar date of the quota period; nullable for open‑ended periods.',
    `period_start` DATE COMMENT 'First calendar date of the quota period (e.g., start of month, quarter, or year).',
    `period_type` STRING COMMENT 'Granularity of the quota period (month, quarter, or year).. Valid values are `month|quarter|year`',
    `quota_description` STRING COMMENT 'Free‑form text describing the purpose or special conditions of the quota.',
    `quota_status` STRING COMMENT 'Current lifecycle state of the quota record.. Valid values are `draft|approved|active|closed|rejected`',
    `quota_type` STRING COMMENT 'Business dimension the quota targets (e.g., revenue, case volume, new distribution points, total distribution points, ACV, new SKU introductions).. Valid values are `revenue|case_volume|new_distribution_points|tdp|acv|new_sku`',
    `region` STRING COMMENT 'High‑level geographic region (e.g., NA, EMEA, APAC) associated with the quota.',
    `source` STRING COMMENT 'Origin of the quota allocation (top‑down corporate allocation, bottom‑up rep submission, or manual adjustment).. Valid values are `top_down|bottom_up|adjusted`',
    `stretch_target_value` DECIMAL(18,2) COMMENT 'Optional aggressive target above the primary quota to incentivize over‑performance.',
    `target_confidence` STRING COMMENT 'Confidence rating of the target based on forecasting methodology.. Valid values are `high|medium|low`',
    `target_measurement_method` STRING COMMENT 'Method used to derive the target (e.g., forecast, historical average, market share model).',
    `target_units` STRING COMMENT 'Unit of measure for the target value (e.g., USD, cases, points).',
    `target_value` DECIMAL(18,2) COMMENT 'Primary numeric target for the quota (e.g., $1,000,000 revenue or 200,000 cases).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the quota record.',
    CONSTRAINT pk_quota PRIMARY KEY(`quota_id`)
) COMMENT 'Sales quota assignment record defining revenue, volume, and distribution targets for a sales rep or territory over a defined period. Captures quota period (month, quarter, year), quota type (revenue, case volume, new distribution points, TDP), assigned rep or territory, target value, stretch target value, quota currency, quota status (draft, approved, active), approval date, approver reference, and quota source (top-down allocation, bottom-up submission). Enables sales performance management and incentive compensation calculation.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`pos_transaction` (
    `pos_transaction_id` BIGINT COMMENT 'System-generated unique identifier for the POS transaction record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Needed for POS Sales Attribution report, attributing each transaction to the retailer account for revenue and performance analysis.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: POS scan-level data must be linked to the driving campaign for marketing ROI measurement — calculating actual unit lift per campaign is a core F&B commercial analytics process. No existing campaign_id',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: POS transaction data in F&B is analyzed by product category for retail velocity, share-of-shelf, and category management reports. Replaces denormalized product_category and product_subcategory text co',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: POS transaction data is aggregated into fiscal periods for trade spend ROI analysis and sell-through revenue reporting in F&B. Finance reconciles POS-derived consumer offtake against invoiced shipment',
    `market_id` BIGINT COMMENT 'Foreign key linking to marketing.market. Business justification: POS transactions must be mapped to defined marketing markets (Nielsen/IRI DMAs) for market-share reporting. F&B commercial teams align scan data to marketing markets constantly. store_region is a deno',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: POS scan data in F&B is the primary source for validating promotion compliance and measuring incremental lift. Trade analysts link scan transactions to promotion events for post-event ROI reporting an',
    `sku_id` BIGINT COMMENT 'Unique identifier of the product (SKU) sold.',
    `store_id` BIGINT COMMENT 'Foreign key linking to sales.store. Business justification: POS scan data is captured at the retail store level. Linking pos_transaction.store_id -> store provides direct store-level traceability for consumer purchase activity. store_format and store_region on',
    `average_price` DECIMAL(18,2) COMMENT 'Average price per unit for this line (dollar_sales / units_sold).',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values.. Valid values are `USD|CAD|EUR|GBP`',
    `data_source` STRING COMMENT 'Origin of the POS record (retailer feed, syndicated provider, or direct partnership).. Valid values are `retailer|syndicated|direct`',
    `display_flag` BOOLEAN COMMENT 'True if the product was featured on a shelf display at time of sale.',
    `dollar_sales` DECIMAL(18,2) COMMENT 'Total sales amount in dollars for the line (units × price).',
    `feature_flag` BOOLEAN COMMENT 'True if the product was part of a special feature (e.g., end‑cap).',
    `line_number` STRING COMMENT 'Sequential number of the line within the receipt.',
    `month_of_year` STRING COMMENT 'Month number (1‑12) for the transaction date.',
    `pos_terminal_code` STRING COMMENT 'Identifier of the point‑of‑sale terminal that captured the scan.',
    `price_type` STRING COMMENT 'Classification of the price applied (regular, promotional, discount).. Valid values are `regular|promo|discount`',
    `promotion_flag` BOOLEAN COMMENT 'Indicates whether the unit was sold under a promotional price.',
    `receipt_number` BIGINT COMMENT 'Identifier linking this line to the parent receipt or transaction header.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first ingested into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `retailer_banner` STRING COMMENT 'Name of the retailer banner or chain (e.g., Walmart, Kroger).',
    `sales_channel` STRING COMMENT 'Channel through which the sale was made.. Valid values are `in_store|online|mobile`',
    `scan_timestamp` TIMESTAMP COMMENT 'Timestamp when the barcode was scanned by the terminal.',
    `store_format` STRING COMMENT 'Classification of the store format.. Valid values are `supermarket|grocery|mass_market|convenience`',
    `transaction_date` DATE COMMENT 'Calendar date of the transaction (store local time).',
    `transaction_day_of_week` STRING COMMENT 'Day of week on which the transaction occurred. [ENUM-REF-CANDIDATE: Mon|Tue|Wed|Thu|Fri|Sat|Sun — 7 candidates stripped; promote to reference product]',
    `transaction_reference_number` STRING COMMENT 'Business‑level identifier for the transaction (may be receipt number).',
    `transaction_status` STRING COMMENT 'Current processing status of the transaction line.. Valid values are `completed|pending|cancelled`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the transaction was recorded.',
    `transaction_type` STRING COMMENT 'Nature of the transaction line (sale, return, or inventory adjustment).. Valid values are `sale|return|adjustment`',
    `transaction_week` STRING COMMENT 'Week number (1‑52) derived from transaction_date.',
    `units_sold` STRING COMMENT 'Number of units of the product scanned in this line.',
    `week_of_year` STRING COMMENT 'ISO week number for the transaction date.',
    `year` STRING COMMENT 'Four‑digit year of the transaction.',
    CONSTRAINT pk_pos_transaction PRIMARY KEY(`pos_transaction_id`)
) COMMENT 'Point-of-sale scan data record capturing consumer purchase activity at the retail store level, sourced from retailer POS feeds, syndicated data providers (Nielsen/IRI/Circana/SPINS), and direct retailer data sharing programs (e.g., Walmart Luminate, Kroger 84.51°). Captures store ID, retailer banner, UPC/GTIN, transaction date/week, units sold, dollar sales, average retail price, promoted/display/feature flags, and data source. SSOT for raw/ingested POS scan data within the enterprise; analytics and insights domains consume this data for derived metrics (market share, promotional lift, price elasticity) but do not own the source records. Enables sell-through velocity analysis, promotional lift measurement, share tracking, and category management insights at the store-week-SKU grain.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`distribution_point` (
    `distribution_point_id` BIGINT COMMENT 'Unique system-generated identifier for the distribution point record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Needed for Distribution Planning Dashboard, associating each distribution point with the retailer account it serves to allocate inventory.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Distribution points capture presence of each brand; linking allows brand distribution metrics and market coverage reporting.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: TDP (Total Distribution Points) gains are a primary KPI for campaign effectiveness in F&B. Linking distribution_point to campaign enables measurement of campaign-driven distribution expansion — a stan',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_center. Business justification: Supports Distribution Point Allocation report linking retailer points to the supplying distribution center for inventory planning.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Distribution point snapshots in F&B are aligned to fiscal periods for trade spend ROI and distribution KPI reporting. Finance uses numeric/ACV distribution metrics by fiscal period to evaluate trade i',
    `market_id` BIGINT COMMENT 'Foreign key linking to marketing.market. Business justification: Distribution points are measured within defined marketing markets for ACV-weighted distribution reporting aligned to syndicated data (Nielsen/IRI). market_area is a denormalized plain-text descriptor ',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Distribution planning uses product registration data to ensure only compliant products are stocked at each point.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.recall_event. Business justification: When an F&B recall is initiated, distribution points stocking the affected product must be immediately identified for scope determination and retailer notification. Recall effectiveness checks and FDA',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: Retailer agreements in F&B include TDP (Total Distribution Points) and numeric distribution commitments. Agreement compliance reporting requires matching actual distribution_point snapshots against th',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Distribution analytics require linking each distribution point record to the exact SKU to track inventory, velocity, and shelf‑life per product.',
    `store_id` BIGINT COMMENT 'Foreign key linking to sales.store. Business justification: A distribution point represents SKU-level distribution presence at a specific retail store. Linking distribution_point.store_id -> store connects the distribution metric snapshot to the store master r',
    `acv_change_pct` DECIMAL(18,2) COMMENT 'Percent change in ACV weighted distribution versus prior period.',
    `acv_weighted_distribution_pct` DECIMAL(18,2) COMMENT 'Percentage of ACV represented by outlets where the SKU is active, weighted by sales volume.',
    `classification_type` STRING COMMENT 'Category of outlet: retail store, foodservice location, or direct‑to‑consumer channel.. Valid values are `store|foodservice|direct`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution point record was first created in the system.',
    `data_source` STRING COMMENT 'Origin of the syndicated data snapshot (Nielsen, IRI, or Circana).. Valid values are `nielsen|iri|circana`',
    `distribution_point_code` STRING COMMENT 'Business‑assigned code uniquely identifying the distribution point within the organization.',
    `distribution_status` STRING COMMENT 'Current status of the SKU at the outlet: authorized (contracted), active (selling), or voided (no longer carried).. Valid values are `authorized|active|voided`',
    `in_stock_flag` BOOLEAN COMMENT 'True if the SKU is currently stocked at the outlet; false otherwise.',
    `location_name` STRING COMMENT 'Human‑readable name of the outlet or distribution point.',
    `numeric_distribution_change_pct` DECIMAL(18,2) COMMENT 'Percent change in numeric distribution versus prior period.',
    `numeric_distribution_pct` DECIMAL(18,2) COMMENT 'Percentage of total outlets carrying the SKU, regardless of sales weight.',
    `period_over_period_change_pct` DECIMAL(18,2) COMMENT 'Percent change of the primary metric compared to the previous period.',
    `period_type` STRING COMMENT 'Aggregation window of the snapshot: weekly, 4‑week, 13‑week, or 52‑week.. Valid values are `weekly|4_week|13_week|52_week`',
    `record_status` STRING COMMENT 'Lifecycle status of the record itself: active, inactive, or archived.. Valid values are `active|inactive|archived`',
    `retailer_banner` STRING COMMENT 'Brand or banner under which the outlet operates (e.g., Walmart, Kroger, Starbucks).',
    `snapshot_date` DATE COMMENT 'Date of the syndicated data snapshot (weekly, 4‑week, etc.).',
    `tdp_change_pct` DECIMAL(18,2) COMMENT 'Percent change in TDP contribution versus prior period.',
    `tdp_contribution_pct` DECIMAL(18,2) COMMENT 'Share of total distribution points contributed by the outlet for the SKU.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the distribution point record.',
    `velocity_units_per_point` DECIMAL(18,2) COMMENT 'Average units sold per distribution point for the SKU over the snapshot period.',
    `void_date` DATE COMMENT 'Date on which the SKU distribution was terminated at the outlet.',
    CONSTRAINT pk_distribution_point PRIMARY KEY(`distribution_point_id`)
) COMMENT 'SSOT for SKU-level distribution presence, measurement, and periodic syndicated metric snapshots at retail and foodservice locations. Captures store/outlet ID, retailer banner, SKU/GTIN, distribution status (authorized, active, voided), ACV weighted distribution percentage, TDP (Total Distribution Points) contribution, numeric distribution percentage, velocity (units per point of distribution), in-stock status, void date, and periodic snapshot data by time period (weekly, 4-week, 13-week, 52-week) including snapshot date, market area, data source (Nielsen/IRI/Circana), and period-over-period change metrics. Enables distribution health monitoring, new item launch tracking, void management, TDP target attainment reporting, ACV trend analysis, and syndicated data reconciliation. Subsumes all periodic ACV/TDP snapshot reporting previously modeled separately.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`broker` (
    `broker_id` BIGINT COMMENT 'System-generated unique identifier for the broker record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Needed for Broker‑Account Assignment report, showing which broker services each customer account for commission calculations.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: In F&B, brokers are typically engaged to represent specific product categories (e.g., a dairy broker, a snack broker). Linking broker to product.category enables broker-category assignment management ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Broker commission payments in F&B are posted to a specific GL account (commission expense). Role-prefix commission_ used because broker may reference multiple GL accounts; this specifically identifi',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Broker commission expenses in F&B are charged to a cost center for trade spend and SG&A reporting. Finance tracks broker costs by cost center for budget control and profitability analysis by channel/r',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Broker coverage is defined by territory; replacing free‑text field with FK improves consistency and enables territory‑level reporting.',
    `address_line1` STRING COMMENT 'First line of the brokers mailing address.',
    `address_line2` STRING COMMENT 'Second line of the brokers mailing address, if applicable.',
    `bank_account_number` STRING COMMENT 'Brokers bank account number for commission payouts.',
    `bank_routing_number` STRING COMMENT 'Routing number for the brokers bank account.',
    `broker_name` STRING COMMENT 'Legal name of the broker organization or individual.',
    `broker_status` STRING COMMENT 'Current operational status of the broker relationship.. Valid values are `active|inactive|suspended|terminated|pending`',
    `broker_type` STRING COMMENT 'Classification of the broker based on the channel or market they serve.. Valid values are `retail|foodservice|dsd|export|online|other`',
    `city` STRING COMMENT 'City component of the brokers address.',
    `commission_basis` STRING COMMENT 'Metric on which the commission rate is calculated.. Valid values are `gross_sales|net_sales|cases`',
    `commission_rate` DECIMAL(18,2) COMMENT 'Percentage commission the broker earns on qualifying sales.',
    `contract_effective_from` DATE COMMENT 'Start date when the broker contract becomes binding.',
    `contract_effective_until` DATE COMMENT 'End date of the broker contract; null if open‑ended.',
    `contract_number` STRING COMMENT 'External reference number for the broker agreement.',
    `contract_status` STRING COMMENT 'Current status of the broker contract.. Valid values are `draft|active|suspended|terminated|expired`',
    `country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the brokers location.',
    `covered_channels` STRING COMMENT 'Sales channels (e.g., retail, foodservice, DSD) the broker operates in.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the broker record was first created in the system.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance evaluation for the broker.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the broker.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the broker.. Valid values are `net30|net45|net60`',
    `performance_tier` STRING COMMENT 'Tier assigned to the broker based on sales performance.. Valid values are `bronze|silver|gold|platinum`',
    `postal_code` STRING COMMENT 'ZIP or postal code for the brokers address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary broker contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the main person to contact at the broker.',
    `primary_contact_phone` STRING COMMENT 'Telephone number for the primary broker contact.. Valid values are `^+?[0-9]{7,15}$`',
    `sap_vendor_number` STRING COMMENT 'Vendor number assigned to the broker in SAP S/4HANA.',
    `state` STRING COMMENT 'State or province component of the brokers address.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identifier for the broker (e.g., EIN).. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the broker record.',
    CONSTRAINT pk_broker PRIMARY KEY(`broker_id`)
) COMMENT 'Master record for food and beverage sales brokers and manufacturer representatives who sell Food Beverage products on behalf of the company in specific channels or geographies. Captures broker ID, broker company name, broker type (retail broker, foodservice broker, DSD broker, export agent), coverage territory, covered channels, covered customer accounts, commission rate structure, commission basis (gross sales, net sales, cases), contract effective dates, performance tier, primary contact, and SAP vendor number. SSOT for broker identity and commercial terms within the sales domain; customer domain owns the broader customer/partner entity but sales owns the broker-as-selling-agent relationship, commission structures, and performance management. Enables broker management, commission calculation, and channel coverage governance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` (
    `rebate_agreement_id` BIGINT COMMENT 'Unique identifier for the rebate agreement record.',
    `account_hierarchy_id` BIGINT COMMENT 'Foreign key linking to customer.account_hierarchy. Business justification: F&B rebate agreements are routinely structured at the account hierarchy level — qualifying purchases across all banners of a retail chain aggregate toward rebate thresholds. Trade finance teams requir',
    `bill_to_location_id` BIGINT COMMENT 'Foreign key linking to customer.bill_to_location. Business justification: Rebate settlement processing in F&B requires knowing the customers billing location to issue credit memos and settlement payments. Accounts payable teams route EDI 844/849 rebate transactions to the ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Rebate agreements in F&B are scoped to a brand (e.g., all Brand X SKUs qualify for 3% rebate). Brand-level trade spend and rebate accrual reporting — required by finance and trade marketing — depend',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: F&B retailer rebate programs are structured at the product category level (e.g., dairy, snacks, beverages). Linking rebate_agreement to product.category enables category-level rebate qualification rep',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Rebate agreements in F&B are executed under a specific legal entity for tax reporting, intercompany settlement, and statutory financial disclosure. Multi-entity F&B companies require company code on r',
    `contract_id` BIGINT COMMENT 'Identifier of the underlying sales contract linked to this rebate agreement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rebate costs are charged to a cost center to enable accurate cost tracking and budget variance analysis.',
    `account_id` BIGINT COMMENT 'Identifier of the customer or account receiving the rebate.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Rebate accrual accounting in F&B requires rebate agreements to be tied to fiscal periods for period-end accrual posting and settlement timing. Finance runs rebate accrual reports by fiscal period for ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to trade.fund. Business justification: Rebate payouts in F&B are funded from trade funds. Trade finance teams track fund consumption by rebate agreement for budget control and fund reconciliation reporting. Without this FK, fund balance ma',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Rebate expense must be posted to a specific GL account for compliance and rebate settlement reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Rebate agreements in F&B are charged to a profit center for P&L accountability and trade spend reporting by brand/channel. Finance tracks trade investment by profit center; no existing FK on rebate_ag',
    `renewed_rebate_agreement_id` BIGINT COMMENT 'Self-referencing FK on rebate_agreement (renewed_rebate_agreement_id)',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: In F&B, rebate programs are structured under retailer agreements (scan-back, bill-back, volume rebates). Trade finance analysts reconciling rebate accruals against retailer commitments require this li',
    `accrual_method` STRING COMMENT 'Whether rebates are accrued over time or paid cash at settlement.. Valid values are `accrual|cash`',
    `agreement_name` STRING COMMENT 'Descriptive name of the rebate agreement.',
    `agreement_number` STRING COMMENT 'External business identifier or code for the rebate agreement.',
    `agreement_type` STRING COMMENT 'Classification of the agreement (e.g., volume‑based, growth‑based, or mixed).. Valid values are `volume|growth|mix`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rebate agreement record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in the agreement.',
    `effective_from` DATE COMMENT 'Date when the rebate agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date when the rebate agreement expires or is terminated (null for open‑ended).',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine eligibility (e.g., product mix, channel, promotional constraints).',
    `last_settlement_date` DATE COMMENT 'Date of the most recent rebate settlement.',
    `max_rebate_amount` DECIMAL(18,2) COMMENT 'Cap on the total rebate payable under the agreement.',
    `min_rebate_amount` DECIMAL(18,2) COMMENT 'Floor amount for rebate eligibility, if applicable.',
    `next_settlement_date` DATE COMMENT 'Planned date for the upcoming rebate settlement.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `rebate_agreement_description` STRING COMMENT 'Free‑form description of the agreement purpose and scope.',
    `rebate_agreement_status` STRING COMMENT 'Current lifecycle status of the agreement.. Valid values are `active|inactive|pending|suspended|terminated`',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'Percentage of sales value to be rebated once thresholds are met.',
    `record_status` STRING COMMENT 'Administrative status of the record for data‑governance purposes.. Valid values are `active|deleted|archived`',
    `region` STRING COMMENT 'Region or market where the rebate agreement applies (ISO 3166‑1 alpha‑3 code).',
    `sales_channel` STRING COMMENT 'Channel through which sales are captured for rebate calculation.. Valid values are `retail|foodservice|dtc|online|wholesale`',
    `settlement_frequency` STRING COMMENT 'How often rebate settlements are processed.. Valid values are `monthly|quarterly|annually`',
    `settlement_method` STRING COMMENT 'Method used to settle rebate amounts with the customer.. Valid values are `cash|credit|offset`',
    `threshold_quantity` DECIMAL(18,2) COMMENT 'Quantity threshold that triggers rebate eligibility (e.g., total cases purchased).',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold quantity.. Valid values are `cases|units|dollars|kg|liters`',
    `tier_levels` STRING COMMENT 'Definition of tier thresholds and corresponding rebate percentages, stored as a structured string.',
    `tiered_flag` BOOLEAN COMMENT 'Indicates whether the agreement uses tiered rebate structures.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rebate agreement record.',
    CONSTRAINT pk_rebate_agreement PRIMARY KEY(`rebate_agreement_id`)
) COMMENT 'Customer rebate agreement master record defining volume-based or growth-based rebate programs offered to retail and foodservice accounts — captures agreement terms, qualifying thresholds, rebate percentages, settlement frequency, and accrual method';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`store` (
    `store_id` BIGINT COMMENT 'Primary key for store',
    `account_id` BIGINT COMMENT 'Identifier of the franchisee entity that owns the store.',
    `market_id` BIGINT COMMENT 'Foreign key linking to marketing.market. Business justification: Every retail store belongs to a defined marketing market (DMA/Nielsen market). F&B field sales and marketing teams use store-to-market mapping for distribution reporting, media investment alignment, a',
    `parent_store_id` BIGINT COMMENT 'Self-referencing FK on store (parent_store_id)',
    `location_id` BIGINT COMMENT 'Foreign key linking to distribution.location. Business justification: Each retail store is served from a primary distribution location (DC or cross-dock) in F&B network planning. This link drives service-level assignment, lead-time calculation, and distribution network ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: In F&B, stores are classified into customer segments (e.g., premium grocery, value, convenience) to drive targeted assortment, planogram, and promotional execution decisions. Linking store to segment ',
    `ship_to_location_id` BIGINT COMMENT 'Foreign key linking to customer.ship_to_location. Business justification: In F&B DSD and warehouse delivery, each store maps to a logistics ship-to node for order fulfillment routing, delivery window scheduling, and dock requirements. Resolving store to ship_to_location is ',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: In DSD (Direct Store Delivery) and F&B retail operations, each store has an associated back-room or in-store storage location. This link enables store-level replenishment planning, DSD inventory manag',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: A retail store belongs to a sales territory for field sales coverage, quota assignment, and distribution tracking. Linking store.territory_id -> territory connects the store master to the territory ma',
    `address_line1` STRING COMMENT 'Primary street address of the store.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `city` STRING COMMENT 'City where the store is located.',
    `closing_date` DATE COMMENT 'Date the store ceased operations, if applicable.',
    `cluster` STRING COMMENT 'Group of stores with similar performance characteristics for analytics.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the store location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the store record was first created in the system.',
    `district` STRING COMMENT 'Sub‑region or district within a region.',
    `format` STRING COMMENT 'Operational format describing service style.',
    `is_franchise` BOOLEAN COMMENT 'True if the store operates under a franchise agreement.',
    `last_inventory_date` DATE COMMENT 'Date of the most recent full inventory count.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the store in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the store in decimal degrees.',
    `manager_email` STRING COMMENT 'Business email address of the store manager.',
    `manager_name` STRING COMMENT 'Full legal name of the store manager.',
    `manager_phone` STRING COMMENT 'Primary contact phone number for the store manager.',
    `opening_date` DATE COMMENT 'Date the store first opened for business.',
    `opening_hours` STRING COMMENT 'Standard weekly opening hours expressed in free‑text format.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the store address.',
    `region` STRING COMMENT 'Higher‑level geographic region grouping stores for reporting.',
    `sales_area_sqft` DECIMAL(18,2) COMMENT 'Retail space dedicated to sales activities, excluding back‑office areas.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total retail floor area of the store in square feet.',
    `state` STRING COMMENT 'State or province of the store location.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status, e.g., renovation, lease expiry.',
    `store_name` STRING COMMENT 'Human‑readable name of the store, often displayed to customers and in internal dashboards.',
    `store_number` STRING COMMENT 'Business-assigned alphanumeric identifier used in retail systems and reporting.',
    `store_status` STRING COMMENT 'Current lifecycle status of the store.',
    `store_type` STRING COMMENT 'Classification of the store based on ownership and format.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the store location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the store record.',
    CONSTRAINT pk_store PRIMARY KEY(`store_id`)
) COMMENT 'Master reference table for store. Referenced by store_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` (
    `contract_store_coverage_id` BIGINT COMMENT 'System-generated unique identifier for this contract-store coverage record.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to the master sales contract that governs this store coverage.',
    `store_id` BIGINT COMMENT 'Foreign key linking to the specific store covered under this contract.',
    `coverage_status` STRING COMMENT 'Current status of this stores coverage under the contract (active, pending, suspended, terminated). Allows per-store status management independent of the master contract status.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract-store coverage record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this specific stores coverage under this contract ends. This attribute was identified in the detection phase and allows per-store coverage dates that may differ from the master contract dates.',
    `effective_start_date` DATE COMMENT 'Date when this specific store became covered under this contract. This attribute was identified in the detection phase and allows per-store coverage dates that may differ from the master contract dates.',
    `fee_per_store` DECIMAL(18,2) COMMENT 'Slotting fee or other per-store financial obligation for this specific store under this contract. This attribute was identified in the detection phase and currently exists on sales_contract but logically belongs to the per-store relationship.',
    `min_shelf_duration_days` STRING COMMENT 'Minimum number of days the product must remain on shelf at this specific store under this contract. This attribute was identified in the detection phase and currently exists on sales_contract but logically belongs to the per-store relationship.',
    CONSTRAINT pk_contract_store_coverage PRIMARY KEY(`contract_store_coverage_id`)
) COMMENT 'This association product represents the Contract between sales_contract and store. It captures the specific stores covered under a master sales contract (chain-wide slotting, EDLP, or distribution agreement) and the per-store financial and operational terms. Each record links one sales_contract to one store with attributes that exist only in the context of this relationship, such as per-store fees, effective dates, and minimum shelf duration commitments.. Existence Justification: In Food & Beverage retail, master sales contracts (chain-wide slotting agreements, EDLP pricing agreements, distribution agreements) routinely cover multiple stores within a retail chain, and each store participates in multiple contracts simultaneously (e.g., a store may be covered by a slotting agreement for Brand A, an EDLP agreement for Brand B, and a promotional agreement for Brand C). The business actively manages contract-store coverage as a recognized operational entity in trade spend management systems, tracking per-store fees, coverage dates, and shelf duration commitments.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `food_beverage_ecm`.`sales`.`broker`(`broker_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `food_beverage_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_original_invoice_id` FOREIGN KEY (`original_invoice_id`) REFERENCES `food_beverage_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `food_beverage_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `food_beverage_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ADD CONSTRAINT `fk_sales_broker_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_renewed_rebate_agreement_id` FOREIGN KEY (`renewed_rebate_agreement_id`) REFERENCES `food_beverage_ecm`.`sales`.`rebate_agreement`(`rebate_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ADD CONSTRAINT `fk_sales_store_parent_store_id` FOREIGN KEY (`parent_store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ADD CONSTRAINT `fk_sales_store_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` ADD CONSTRAINT `fk_sales_contract_store_coverage_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` ADD CONSTRAINT `fk_sales_contract_store_coverage_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `food_beverage_ecm`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `bill_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bill-To Location Identifier (BILL_TO_LOC_ID)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (CONTRACT_ID)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `import_export_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Import Export Permit Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier (PROMOTION_ID)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (SALES_REP_ID)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location Identifier (SHIP_TO_LOC_ID)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Store Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ACT_DELIVERY_DT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel (CHANNEL)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct_to_consumer|online|wholesale');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CODE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `edi_850_reference` SET TAGS ('dbx_business_glossary_term' = 'EDI 850 Transaction Reference (EDI_850_REF)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `erp_sales_doc_number` SET TAGS ('dbx_business_glossary_term' = 'ERP Sales Document Number (ERP_SALES_DOC_NO)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms (FREIGHT_TERMS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party|FOB|CIF|DDP');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (INCOTERMS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `is_backorder` SET TAGS ('dbx_business_glossary_term' = 'Backorder Indicator (IS_BACKORDER)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `is_split_order` SET TAGS ('dbx_business_glossary_term' = 'Split Order Indicator (IS_SPLIT_ORDER)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number (ORD_NUM)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source (ORD_SOURCE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'EDI|Web|Phone|SalesRep|MobileApp|API');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status (ORD_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|open|confirmed|fulfilled|cancelled|closed');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type (ORD_TYPE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|rush|blanket|standing|return|exchange');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp (ORD_PLACED_TS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Order Flag (PRIORITY_FLAG)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date (PROM_DELIVERY_DT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date (REQ_DELIVERY_DT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `revenue_recognition_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Flag (REVENUE_RECO_FLAG)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (SALES_REGION)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method (SHIPPING_METHOD)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|sea|rail|parcel|drone');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount (TOTAL_DISC_AMT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount (TOTAL_GROSS_AMT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount (TOTAL_NET_AMT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Ordered Quantity (TOTAL_QTY)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount (TOTAL_TAX_AMT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `total_volume_cu_m` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (cubic meters) (TOTAL_VOLUME_CU_M)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (kg) (TOTAL_WEIGHT_KG)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `trade_allowance_flag` SET TAGS ('dbx_business_glossary_term' = 'Trade Allowance Flag (TRADE_ALLOWANCE_FLAG)');
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `bill_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bill-To Customer ID');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `import_export_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Import Export Permit Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `original_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice ID');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Customer ID');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_country` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z-]{3,10}$');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State/Province');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|open|posted|cancelled|void');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|intercompany');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `is_credit_memo` SET TAGS ('dbx_business_glossary_term' = 'Is Credit Memo Flag');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `line_count` SET TAGS ('dbx_business_glossary_term' = 'Line Count');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|cash|check|edi');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|failed|partial|refunded');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `posted_to_ledger_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to Ledger Flag');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `trade_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Discount Amount');
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract ID');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `account_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `label_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `promotion_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Account ID');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'volume_rebate|pricing_agreement|distribution_agreement|co_packing_agreement|slotting_agreement');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|MXN');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `edlp_tier` SET TAGS ('dbx_business_glossary_term' = 'Everyday Low Price (EDLP) Tier');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `edlp_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4|tier5|tier6');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `fee_per_store` SET TAGS ('dbx_business_glossary_term' = 'Fee Per Store');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `min_shelf_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Shelf Duration (Days)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `performance_clause` SET TAGS ('dbx_business_glossary_term' = 'Performance Clause');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `rsp_commitment` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP) Commitment');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `sales_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `sales_contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `slotting_fee_total` SET TAGS ('dbx_business_glossary_term' = 'Total Slotting Fee');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `store_count` SET TAGS ('dbx_business_glossary_term' = 'Store Count');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `total_committed_volume` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Volume');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'cases|units|kg|liters');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` SET TAGS ('dbx_subdomain' = 'territory_organization');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `assigned_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Customer Count (CUSTOMER_COUNT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status (CERT_STATUS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|expired');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent (COMMISSION_RATE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `compensation_plan` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan (COMP_PLAN)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `compensation_plan` SET TAGS ('dbx_value_regex' = 'salary|commission|salary_plus_commission|bonus|incentive');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `compensation_plan` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `compensation_plan` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `compliance_training_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completed Date (COMPLIANCE_TRAIN_DATE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Email Address (EMAIL)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|on_leave|retired');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `external_rep_code` SET TAGS ('dbx_business_glossary_term' = 'External Representative Code (EXT_REP_CODE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Full Name (FULL_NAME)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date (HIRE_DATE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `is_remote_worker` SET TAGS ('dbx_business_glossary_term' = 'Remote Worker Indicator (IS_REMOTE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANG_PREF)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|pt');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date (LAST_REVIEW_DATE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `next_performance_review_due` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Due Date (NEXT_REVIEW_DUE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Phone Number (PHONE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method (CONTACT_METHOD)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|messenger');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `quota_annual_cases` SET TAGS ('dbx_business_glossary_term' = 'Annual Case Volume Quota (QUOTA_CASES)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `quota_annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Quota (QUOTA_REVENUE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source System (SOURCE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `record_source` SET TAGS ('dbx_value_regex' = 'salesforce|sap|oracle|manual');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `rep_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Type (TYPE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `rep_type` SET TAGS ('dbx_value_regex' = 'field_sales|key_account_manager|national_account_manager|broker|dsd_driver');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Sales Channel (CHANNEL)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct_to_consumer|ecommerce|wholesale');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `sales_district` SET TAGS ('dbx_business_glossary_term' = 'Sales District (DISTRICT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `sales_force_user_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce User ID (SF_USER_ID)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `sales_force_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `sales_force_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (REGION)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'NORTH|SOUTH|EAST|WEST|MIDWEST|INTERNATIONAL');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `sap_employee_number` SET TAGS ('dbx_business_glossary_term' = 'SAP SD Sales Employee Number (SAP_EMP_NO)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `sap_employee_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `sap_employee_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TERMINATION_DATE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `travel_region` SET TAGS ('dbx_business_glossary_term' = 'Travel Region Classification (TRAVEL_REGION)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `travel_region` SET TAGS ('dbx_value_regex' = 'domestic|international');
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'territory_organization');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `acv_coverage_target` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Coverage Target');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `assigned_account_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Account Count');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `assigned_channel` SET TAGS ('dbx_business_glossary_term' = 'Assigned Channel');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `assigned_channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|dtc');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `district` SET TAGS ('dbx_business_glossary_term' = 'District');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Territory Flag');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `market_share_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Market Share Target Percent');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Territory Priority Level');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Quota Amount');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `sales_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Target Amount');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `state_province_list` SET TAGS ('dbx_business_glossary_term' = 'State/Province List');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `tdp_coverage_target` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Coverage Target');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|retired');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'geographic|account_based|channel_based');
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` SET TAGS ('dbx_subdomain' = 'territory_organization');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `quota_id` SET TAGS ('dbx_business_glossary_term' = 'Quota Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Approval Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quota Notes');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Quota Period End Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Quota Period Start Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Quota Period Type');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'month|quarter|year');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `quota_description` SET TAGS ('dbx_business_glossary_term' = 'Quota Description');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `quota_status` SET TAGS ('dbx_business_glossary_term' = 'Quota Status');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `quota_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|closed|rejected');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `quota_type` SET TAGS ('dbx_business_glossary_term' = 'Quota Type');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `quota_type` SET TAGS ('dbx_value_regex' = 'revenue|case_volume|new_distribution_points|tdp|acv|new_sku');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Quota Source');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'top_down|bottom_up|adjusted');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `stretch_target_value` SET TAGS ('dbx_business_glossary_term' = 'Quota Stretch Target Value');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `target_confidence` SET TAGS ('dbx_business_glossary_term' = 'Quota Target Confidence Level');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `target_confidence` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `target_measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Quota Measurement Method');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `target_units` SET TAGS ('dbx_business_glossary_term' = 'Quota Target Units');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Quota Target Value');
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale Transaction ID');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Store Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `average_price` SET TAGS ('dbx_business_glossary_term' = 'Average Retail Price');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'retailer|syndicated|direct');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `display_flag` SET TAGS ('dbx_business_glossary_term' = 'Display Flag');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `dollar_sales` SET TAGS ('dbx_business_glossary_term' = 'Dollar Sales');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `feature_flag` SET TAGS ('dbx_business_glossary_term' = 'Feature Flag');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `month_of_year` SET TAGS ('dbx_business_glossary_term' = 'Month of Year');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'POS Terminal Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'regular|promo|discount');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flag');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `retailer_banner` SET TAGS ('dbx_business_glossary_term' = 'Retailer Banner');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scan Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `store_format` SET TAGS ('dbx_business_glossary_term' = 'Store Format');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `store_format` SET TAGS ('dbx_value_regex' = 'supermarket|grocery|mass_market|convenience');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `transaction_day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Transaction Day of Week');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|pending|cancelled');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'sale|return|adjustment');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `transaction_week` SET TAGS ('dbx_business_glossary_term' = 'Transaction Week Number');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `week_of_year` SET TAGS ('dbx_business_glossary_term' = 'Week of Year');
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Transaction Year');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` SET TAGS ('dbx_subdomain' = 'retail_network');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `distribution_point_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Point Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Store Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `acv_change_pct` SET TAGS ('dbx_business_glossary_term' = 'ACV Change Percentage');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `acv_weighted_distribution_pct` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Weighted Distribution Percentage');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `classification_type` SET TAGS ('dbx_business_glossary_term' = 'Classification Type');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `classification_type` SET TAGS ('dbx_value_regex' = 'store|foodservice|direct');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'nielsen|iri|circana');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `distribution_point_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Point Code');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'authorized|active|voided');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `in_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'In‑Stock Indicator');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `numeric_distribution_change_pct` SET TAGS ('dbx_business_glossary_term' = 'Numeric Distribution Change Percentage');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `numeric_distribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Numeric Distribution Percentage');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `period_over_period_change_pct` SET TAGS ('dbx_business_glossary_term' = 'Period‑over‑Period Change Percentage');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'weekly|4_week|13_week|52_week');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `retailer_banner` SET TAGS ('dbx_business_glossary_term' = 'Retailer Banner');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `tdp_change_pct` SET TAGS ('dbx_business_glossary_term' = 'TDP Change Percentage');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `tdp_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Contribution Percentage');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `velocity_units_per_point` SET TAGS ('dbx_business_glossary_term' = 'Velocity (Units per Distribution Point)');
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` SET TAGS ('dbx_subdomain' = 'territory_organization');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Territory Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDRESS_LINE2)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number (BANK_ACC_NO)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (BANK_ROUTING_NO)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Full Name (NAME)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `broker_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `broker_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `broker_status` SET TAGS ('dbx_business_glossary_term' = 'Broker Lifecycle Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `broker_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_business_glossary_term' = 'Broker Type (TYPE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_value_regex' = 'retail|foodservice|dsd|export|online|other');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `commission_basis` SET TAGS ('dbx_business_glossary_term' = 'Commission Basis (BASIS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `commission_basis` SET TAGS ('dbx_value_regex' = 'gross_sales|net_sales|cases');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate (RATE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `contract_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `contract_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CONTRACT_NO)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country (COUNTRY)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `covered_channels` SET TAGS ('dbx_business_glossary_term' = 'Covered Channels (CHANNELS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date (REVIEW_DATE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (TERMS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier (TIER)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (POSTAL_CODE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email (EMAIL)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name (NAME)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number (PHONE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `sap_vendor_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Vendor Number (VENDOR_NO)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement ID (RAID)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `account_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `bill_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bill To Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Related Contract ID (RCID)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID (CAID)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `renewed_rebate_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method (AM)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'accrual|cash');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Name (RANAME)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Number (RAN)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Type (RAT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'volume|growth|mix');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CCY)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFD)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (EC)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `last_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Settlement Date (LSD)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `max_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Rebate Amount (MRA)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `min_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rebate Amount (mRA)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `next_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Settlement Date (NSD)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (AN)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `rebate_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Description (RAD)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `rebate_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Status (RAS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `rebate_agreement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage (RPCT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (RS)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|deleted|archived');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (GR)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel (SC)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|dtc|online|wholesale');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency (SF)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method (SM)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'cash|credit|offset');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Threshold Quantity (TQ)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure (TU)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'cases|units|dollars|kg|liters');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `tier_levels` SET TAGS ('dbx_business_glossary_term' = 'Tier Levels Definition (TLD)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `tiered_flag` SET TAGS ('dbx_business_glossary_term' = 'Tiered Rebate Flag (TRF)');
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` SET TAGS ('dbx_subdomain' = 'retail_network');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `parent_store_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` SET TAGS ('dbx_association_edges' = 'sales.sales_contract,sales.store');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` ALTER COLUMN `contract_store_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Store Coverage ID');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Store Coverage - Sales Contract Id');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Store Coverage - Store Id');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coverage Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective End Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` ALTER COLUMN `fee_per_store` SET TAGS ('dbx_business_glossary_term' = 'Fee Per Store');
ALTER TABLE `food_beverage_ecm`.`sales`.`contract_store_coverage` ALTER COLUMN `min_shelf_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Shelf Duration Days');
