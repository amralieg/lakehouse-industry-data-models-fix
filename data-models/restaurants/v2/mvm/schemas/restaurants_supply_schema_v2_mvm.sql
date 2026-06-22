-- Schema for Domain: supply | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-06-22 16:55:47

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`supply` COMMENT 'Manages end-to-end food and non-food supply chain including supplier master data, vendor management, sourcing, purchase orders, inbound logistics, distribution center operations, and ingredient traceability. Tracks COGS, supplier performance, contract compliance, and spend analytics via Coupa Procurement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supply_supplier data product (auto-inserted pre-linking).',
    `address` STRING COMMENT '',
    `address_line` STRING COMMENT '',
    `address_line1` STRING COMMENT '',
    `city` STRING COMMENT '',
    `supplier_code` STRING COMMENT '',
    `contact_email` STRING COMMENT '',
    `contact_name` STRING COMMENT '',
    `contact_phone` STRING COMMENT '',
    `country` STRING COMMENT '',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `email` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `is_approved` BOOLEAN COMMENT '',
    `lead_time_days` STRING COMMENT '',
    `legal_name` STRING COMMENT '',
    `supplier_name` STRING COMMENT '',
    `onboarded_at` TIMESTAMP COMMENT '',
    `onboarded_date` DATE COMMENT '',
    `onboarding_date` DATE COMMENT '',
    `payment_terms` DECIMAL(18,2) COMMENT '',
    `phone` STRING COMMENT '',
    `postal_code` STRING COMMENT '',
    `primary_contact_name` STRING COMMENT 'Business attribute primary_contact_name derived from business context.',
    `state` STRING COMMENT '',
    `state_province` STRING COMMENT '',
    `supplier_status` STRING COMMENT '',
    `supplier_type` STRING COMMENT '',
    `supply_supplier_status` STRING COMMENT '',
    `tax_identification_number` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for every supplier and vendor in the foodservice supply chain, including food and non-food suppliers, distributors, co-manufacturers, and their key contacts. Captures supplier identity, classification (broadline, specialty, local), approval status, diversity certification, payment terms, lead times, regulatory compliance status (FDA, USDA, HACCP), and primary/secondary contact information. SSOT for supplier identity and contact details across supply chain operations. Sourced from Coupa Procurement supplier master and SAP S/4HANA vendor master (MM). [SSOT] Aliases canonical owner procurement.procurement_supplier for concept supplier. SSOT: authoritative source is procurement.procurement_supplier. SSOT: authoritative owner is procurement.procurement_supplier for concept supplier. [SSOT: authoritative owner is procurement.procurement_supplier] procurement is SSOT for supplier master';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`ingredient` (
    `ingredient_id` BIGINT COMMENT 'System-generated surrogate key uniquely identifying each ingredient record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Multi-brand restaurant enterprises maintain brand-specific ingredient catalogs (proprietary recipes, approved ingredient lists per brand). Brand-level ingredient management drives menu compliance, pro',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: Brand standards govern approved ingredient specifications (allergen thresholds, organic certification requirements, HACCP classifications). Linking ingredient to brand_standard enables compliance audi',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Each ingredient is governed by a primary HACCP plan defining its receiving, storage, and handling controls. Procurement and food safety teams use this link to enforce HACCP-compliant purchasing specif',
    `sop_document_id` BIGINT COMMENT 'Foreign key linking to foodsafety.sop_document. Business justification: Each ingredient has a governing SOP for safe handling, storage, and preparation (especially allergen-controlled or high-risk items). Food safety teams maintain ingredient-specific SOPs; this link enab',
    `allergen_flags` STRING COMMENT 'Pipe‑separated list of allergens present in the ingredient.. Valid values are `peanut|tree_nut|dairy|egg|gluten|soy`',
    `carbohydrate_content_percent` DECIMAL(18,2) COMMENT 'Percentage of carbohydrates by weight in the ingredient.',
    `ingredient_category` STRING COMMENT 'Broad classification of the ingredient for sourcing, menu engineering, and cost analysis.. Valid values are `protein|produce|dairy|dry_goods|packaging|beverage`',
    `ingredient_code` STRING COMMENT 'Business code or SKU assigned to the ingredient for ordering and inventory tracking.. Valid values are `^[A-Z0-9]{3,10}$`',
    `country_of_origin` STRING COMMENT 'Three‑letter country code indicating where the ingredient was produced or sourced.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the ingredient record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost_per_unit (e.g., USD, EUR).',
    `effective_from` DATE COMMENT 'Date when the ingredient becomes available for ordering.',
    `effective_until` DATE COMMENT 'Date after which the ingredient is no longer available (null if indefinite).',
    `fat_content_percent` DECIMAL(18,2) COMMENT 'Percentage of total fat by weight in the ingredient.',
    `haccp_classification` STRING COMMENT 'Risk level of the ingredient according to HACCP guidelines.. Valid values are `critical|high|medium|low`',
    `halal_flag` BOOLEAN COMMENT 'Indicates whether the ingredient meets halal certification requirements.',
    `ingredient_status` STRING COMMENT 'Current operational status of the ingredient in the catalog.. Valid values are `active|inactive|discontinued|pending`',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection.. Valid values are `passed|failed|pending`',
    `kosher_flag` BOOLEAN COMMENT 'Indicates whether the ingredient meets kosher certification requirements.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent food safety inspection for this ingredient.',
    `lead_time_days` STRING COMMENT 'Typical number of days from order placement to receipt of the ingredient.',
    `ingredient_name` STRING COMMENT 'Descriptive name of the ingredient as used in menus, procurement, and reporting.',
    `non_gmo_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is verified as non‑genetically modified.',
    `nutritional_calories_per_unit` DECIMAL(18,2) COMMENT 'Energy content per unit of the ingredient, expressed in kilocalories.',
    `organic_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is certified organic.',
    `packaging_type` STRING COMMENT 'Standard packaging format for the ingredient.. Valid values are `box|bag|bottle|can|bulk|pallet`',
    `par_level` STRING COMMENT 'Periodic Automatic Replenishment Level – minimum inventory quantity to trigger re‑order.',
    `protein_content_percent` DECIMAL(18,2) COMMENT 'Percentage of protein by weight in the ingredient.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the ingredient can be stored before it is considered expired.',
    `sodium_mg_per_unit` DECIMAL(18,2) COMMENT 'Sodium content per unit of the ingredient, expressed in milligrams.',
    `standard_weight_per_unit` DECIMAL(18,2) COMMENT 'Typical weight of one unit of the ingredient in the specified unit_of_measure.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Recommended storage temperature range for the ingredient, expressed in degrees Celsius.',
    `sub_category` STRING COMMENT 'More granular classification within the main category (e.g., "leafy_green", "citrus_fruit").',
    `traceability_batch_number` STRING COMMENT 'Batch or lot number used for ingredient traceability throughout the supply chain.',
    `unit_of_measure` STRING COMMENT 'Default unit used to quantify the ingredient in purchasing and inventory (e.g., kilograms, liters).. Valid values are `kg|g|lb|oz|liter|ml`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the ingredient record.',
    `usda_grade` STRING COMMENT 'USDA quality grade assigned to the ingredient.. Valid values are `A|B|C|U`',
    `vitamin_c_mg_per_unit` DECIMAL(18,2) COMMENT 'Vitamin C content per unit of the ingredient, expressed in milligrams.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Typical percentage of the ingredient that is wasted during preparation or storage.',
    CONSTRAINT pk_ingredient PRIMARY KEY(`ingredient_id`)
) COMMENT 'Master catalog of all food ingredients, raw materials, beverages, and packaging SKUs procured across the foodservice supply chain. Captures SKU code, ingredient name, commodity category, unit of measure, allergen flags (Big 9), USDA grade, country of origin, shelf life days, storage temperature requirements (ambient/refrigerated/frozen), and HACCP critical control classification. Serves as the supply-side item master linking to menu domain BOM for recipe costing. SSOT for ingredient identity across supply, inventory, and menu domains. Sourced from SAP MM material master and MarketMan Inventory Management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the supply_purchase_order data product (auto-inserted pre-linking).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PO approval authorization workflow: restaurant procurement requires tracking which employee (manager/buyer) formally approved each purchase order for spend-authority compliance, audit trails, and AP r',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_contract. Business justification: Purchase orders are frequently issued against negotiated supplier contracts to enforce contracted pricing, volume tiers, and payment terms. Linking supply_purchase_order to supplier_contract enables c',
    `supplier_id` BIGINT COMMENT '',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: PURCHASE_ORDER creation is done per restaurant location; linking PO to unit enables inventory budgeting and location‑specific spend reporting.',
    `actual_delivery_date` DATE COMMENT '',
    `approval_status` STRING COMMENT '',
    `approved_timestamp` TIMESTAMP COMMENT '',
    `buyer_name` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency` STRING COMMENT '',
    `currency_code` STRING COMMENT '',
    `expected_delivery_date` DATE COMMENT '',
    `freight_amount` DECIMAL(18,2) COMMENT '',
    `is_approved` BOOLEAN COMMENT '',
    `is_received` BOOLEAN COMMENT '',
    `line_count` STRING COMMENT '',
    `order_date` DATE COMMENT '',
    `payment_terms` STRING COMMENT '',
    `po_number` STRING COMMENT '',
    `po_status` STRING COMMENT '',
    `ship_to_location` STRING COMMENT '',
    `source_system_code` STRING COMMENT '',
    `subtotal_amount` DECIMAL(18,2) COMMENT '',
    `supply_purchase_order_status` STRING COMMENT '',
    `tax_amount` DECIMAL(18,2) COMMENT '',
    `total_amount` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `created_by` STRING COMMENT 'Created by',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Core transactional record for every purchase order issued to suppliers for food ingredients, beverages, packaging, and non-food supplies. Captures PO number, supplier reference, order date, requested delivery date, ship-to distribution center or restaurant, total PO value, currency, payment terms, approval status, and sourcing event linkage. Represents the contractual commitment to buy. Sourced from Coupa Procurement PO module and SAP S/4HANA MM purchasing. [SSOT] Aliases canonical owner procurement.procurement_purchase_order for concept purchase_order. SSOT: authoritative source is procurement.procurement_purchase_order. SSOT: authoritative owner is procurement.procurement_purchase_order for concept purchase_order. [SSOT: authoritative owner is procurement.procurement_purchase_order] procurement is SSOT for PO';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Primary key for purchase_order_line',
    `ingredient_id` BIGINT COMMENT 'Connect supply.purchase_order_line by adding column ingredient_id (BIGINT) with FK to supply.ingredient.ingredient_id because PO lines need to specify what ingredient is being ordered. P15: connect_table: supply.purchase_order_line** - add ',
    `purchase_order_id` BIGINT COMMENT 'Connect supply.purchase_order_line by adding column supply_purchase_order_id (BIGINT) with FK to supply.supply_purchase_order.supply_purchase_order_id because PO lines must reference their parent purchase order. P14: connect_table: supply.p',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Each PO line item is fulfilled for a specific restaurant; the FK supports line‑level receipt, cost allocation, and audit trails.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Currency of the line',
    `expected_delivery_date` DATE COMMENT '',
    `expected_receipt_date` DATE COMMENT '',
    `extended_amount` DECIMAL(18,2) COMMENT '',
    `is_fully_received` BOOLEAN COMMENT 'Whether the line is fully received',
    `line_number` STRING COMMENT '',
    `line_status` STRING COMMENT '',
    `line_total` DECIMAL(18,2) COMMENT 'Business attribute line_total derived from business context.',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Line total amount',
    `ordered_quantity` DECIMAL(18,2) COMMENT '',
    `purchase_order_line_status` STRING COMMENT '',
    `quantity_ordered` DECIMAL(18,2) COMMENT '',
    `quantity_received` STRING COMMENT '',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity received to date',
    `source_system_code` STRING COMMENT '',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax on the line',
    `unit_of_measure` STRING COMMENT '',
    `unit_price` DECIMAL(18,2) COMMENT '',
    `uom` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_purchase_order_line PRIMARY KEY(`purchase_order_line_id`)
) COMMENT 'Line-item detail for each purchase order, capturing individual SKU/ingredient ordered, quantity ordered, unit of measure, agreed unit price, extended line value, COGS allocation, requested delivery date per line, and line status (open, partially received, closed, cancelled). Enables PMIX-level COGS tracking and ingredient-level spend analytics. Sourced from SAP S/4HANA MM (EKPO) and Coupa PO line items.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'System‑generated unique identifier for each goods receipt transaction.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Goods receiving is a Critical Control Point under HACCP. Each receipt event must reference the applicable HACCP plan governing receiving procedures (temperature checks, visual inspection). Regulatory ',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the receipt inspection.',
    `primary_goods_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the receipt inspection.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: A goods receipt is the physical fulfillment event for a purchase order — every inbound delivery is matched against a PO. This FK enables three-way matching (PO → GR → Invoice), receiving variance anal',
    `unit_id` BIGINT COMMENT 'Identifier of the distribution center or restaurant where goods were received.',
    `batch_number` STRING COMMENT 'Internal batch identifier assigned during receiving for inventory control.',
    `comments` STRING COMMENT 'Optional textual remarks entered by the inspector during receipt.',
    `condition` STRING COMMENT 'Overall condition of the received shipment (accepted, rejected, or partially accepted).. Valid values are `accepted|rejected|partial`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the goods receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the total_cost field.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `expiration_date` DATE COMMENT 'Date after which the received goods should not be used or sold.',
    `goods_receipt_status` STRING COMMENT 'Current lifecycle status of the receipt (e.g., open, partial, closed, cancelled).. Valid values are `open|partial|closed|cancelled`',
    `is_cold_chain_compliant` BOOLEAN COMMENT 'True if temperature remained within required range during transport and receipt.',
    `lot_number` STRING COMMENT 'Supplier‑provided lot or batch number for traceability.',
    `receipt_number` STRING COMMENT 'Human‑readable receipt number assigned by the receiving system (e.g., MIGO document number).',
    `receipt_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the goods were recorded as received.',
    `receiving_method` STRING COMMENT 'How the goods arrived at the receiving location (e.g., dock, delivery, third‑party carrier, internal transfer).. Valid values are `dock|delivery|third_party|internal`',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Measured temperature (in Celsius) of the goods at the moment of receipt.',
    `temperature_deviation_flag` BOOLEAN COMMENT 'True if measured temperature fell outside the acceptable range.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total monetary value of the goods received, before any discounts or taxes.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Sum of all item quantities received in this receipt (units may be pieces, kg, liters, etc.).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the goods receipt record.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Transactional record of inbound goods received at a distribution center or restaurant, including both header-level receipt information and line-level detail per SKU. Header captures receipt date/time, receiving location, PO reference, receiving condition, and inspector ID. Lines capture specific ingredient/SKU received, quantity accepted/rejected, lot number, expiration date, temperature at receipt (cold chain compliance), storage location assigned, and variance from PO quantity. Critical for three-way match (PO-receipt-invoice), HACCP traceability, and ingredient-level lot tracking. Sourced from SAP S/4HANA MM (MIGO) and MarketMan receiving module.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` (
    `goods_receipt_line_id` BIGINT COMMENT 'Unique identifier for the goods receipt line record.',
    `goods_receipt_id` BIGINT COMMENT 'Identifier of the parent goods receipt transaction.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the receipt.',
    `purchase_order_line_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order_line. Business justification: Goods receipt lines must reference the originating purchase order line; the existing column name does not match the target PK, so a correctly named FK is added and the old column removed.',
    `receiving_user_employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the receipt.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Receiving-to-inventory-catalog reconciliation: each goods receipt line must map to the inventory stock_item it replenishes to trigger on-hand balance updates, validate SKU/UOM alignment, and support t',
    `stock_location_id` BIGINT COMMENT 'Identifier of the warehouse or store location where the item is stored.',
    `cogs_amount` DECIMAL(18,2) COMMENT 'Cost of goods sold value attributed to this receipt line for financial reporting.',
    `compliance_flag` BOOLEAN COMMENT 'True if the receipt meets HACCP and other regulatory compliance checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods receipt line record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `expiration_date` DATE COMMENT 'Date after which the product is no longer safe to use.',
    `inspected_timestamp` TIMESTAMP COMMENT 'Date and time when the received items were inspected for quality and compliance.',
    `inspection_status` STRING COMMENT 'Result of the quality inspection for the received items.. Valid values are `passed|failed|pending`',
    `is_perishable` BOOLEAN COMMENT 'Indicates whether the received item is perishable and requires special handling.',
    `is_returned` BOOLEAN COMMENT 'Indicates whether the line was later returned to the supplier.',
    `item_description` STRING COMMENT 'Free‑text description of the received product.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the goods receipt.',
    `lot_number` STRING COMMENT 'Manufacturer‑assigned lot or batch identifier for traceability.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured at receipt.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing quality assessment of the received items.',
    `recall_status` STRING COMMENT 'Indicates if the item is subject to a product recall.. Valid values are `none|pending|recalled`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item accepted into inventory.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the receipt was logged in the system.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item rejected during receipt inspection.',
    `supplier_batch_number` STRING COMMENT 'Batch identifier provided by the supplier, may differ from internal lot number.',
    `temperature_control_required` BOOLEAN COMMENT 'True if the item must be stored under temperature‑controlled conditions.',
    `temperature_recorded` DECIMAL(18,2) COMMENT 'Temperature measured at receipt for temperature‑controlled items.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total monetary value for the accepted quantity (unit_price * received_quantity).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., kilograms, pounds, each).. Valid values are `kg|lb|each|ltr|gal`',
    `unit_price` DECIMAL(18,2) COMMENT 'Cost per unit of the received item, in the transaction currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the goods receipt line record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary difference between expected cost and actual cost for the line.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between ordered quantity and received quantity (received_quantity - ordered_quantity).',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Physical volume of the received items, useful for storage planning.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the received quantity, expressed in kilograms.',
    CONSTRAINT pk_goods_receipt_line PRIMARY KEY(`goods_receipt_line_id`)
) COMMENT 'Line-level detail for each goods receipt event, capturing the specific ingredient/SKU received, quantity accepted, quantity rejected, unit of measure, lot number, expiration date, storage location assigned, and variance from PO quantity. Enables ingredient-level traceability from supplier to restaurant for HACCP and FDA recall compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Primary key for invoice',
    `purchase_order_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: AP processing and unit-level cost allocation require direct unit_id on invoices for food cost accruals, P&L reporting by location, and accounts payable workflows. Restaurant finance teams run unit-lev',
    `amount` DECIMAL(18,2) COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency` STRING COMMENT '',
    `currency_code` STRING COMMENT '',
    `due_date` DATE COMMENT '',
    `invoice_date` DATE COMMENT '',
    `invoice_number` STRING COMMENT '',
    `invoice_status` STRING COMMENT '',
    `is_paid` BOOLEAN COMMENT '',
    `matched_po_number` STRING COMMENT 'Business attribute matched_po_number for supply.invoice',
    `paid_at` TIMESTAMP COMMENT '',
    `paid_date` DATE COMMENT '',
    `payment_date` DECIMAL(18,2) COMMENT '',
    `payment_status` DECIMAL(18,2) COMMENT '',
    `payment_terms` STRING COMMENT '',
    `source_system_code` STRING COMMENT '',
    `tax_amount` DECIMAL(18,2) COMMENT '',
    `total_amount` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Accounts payable invoice record from a supplier for goods or services delivered. Captures invoice number, supplier ID, invoice date, due date, payment terms, gross amount, tax amount, net amount, currency, three-way match status (PO–GR–invoice), dispute flag, and payment status. Feeds SAP S/4HANA AP (FI-AP) for payment processing and COGS accrual. Sourced from Coupa invoice management and SAP S/4HANA FI.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` (
    `supplier_contract_id` BIGINT COMMENT 'System-generated unique identifier for the supplier contract record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Supplier contracts in restaurant enterprises are negotiated at brand level (e.g., Brand A exclusive sauce supplier). Brand-scoped contract management enables brand-level spend analysis, preferred supp',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supports Contract Ownership Register, linking each supplier contract to the employee owner for accountability and audit trails.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: A supplier contract is negotiated with a specific supplier — this is the foundational parent-child relationship for contract management. Every supply agreement belongs to exactly one supplier. Adding ',
    `audit_status` STRING COMMENT 'Result of the most recent contract audit.. Valid values are `passed|failed|pending`',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the contract against internal and regulatory standards.. Valid values are `compliant|non_compliant|under_review`',
    `confidentiality_clause` BOOLEAN COMMENT 'Indicates whether a confidentiality provision is included.',
    `contract_description` STRING COMMENT 'Free‑text description providing additional context about the contract.',
    `contract_document_url` STRING COMMENT 'Link to the stored electronic copy of the signed contract document.',
    `contract_type` STRING COMMENT 'Category of the contract indicating its business purpose.. Valid values are `purchase|distribution|exclusive|service|maintenance`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for contract pricing.. Valid values are `^[A-Z]{3}$`',
    `data_protection_clause` BOOLEAN COMMENT 'Indicates inclusion of data protection requirements (e.g., GDPR, CCPA).',
    `delivery_terms` STRING COMMENT 'Incoterms defining responsibility for delivery and risk.. Valid values are `FOB|CIF|EXW|DDP`',
    `dispute_resolution` STRING COMMENT 'Mechanism for resolving disputes (e.g., arbitration, litigation).',
    `effective_from` DATE COMMENT 'Date when the contract becomes legally binding.',
    `effective_until` DATE COMMENT 'Date when the contract expires or ends, if applicable.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the supplier has exclusive rights for the contracted items.',
    `exclusivity_region` STRING COMMENT 'Geographic region where exclusivity applies, if any.',
    `executed_date` DATE COMMENT 'Date the contract was executed and entered into the system.',
    `governing_law` STRING COMMENT 'Specific legal framework applied to interpret the contract.',
    `insurance_requirements` STRING COMMENT 'Minimum insurance coverage the supplier must maintain.',
    `legal_jurisdiction` STRING COMMENT 'State, province, or country whose laws govern the contract.',
    `liability_limit` DECIMAL(18,2) COMMENT 'Maximum monetary liability the supplier assumes under the contract.',
    `payment_method` DECIMAL(18,2) COMMENT 'Preferred method of payment for invoicing under the contract.',
    `payment_terms` STRING COMMENT 'Standard payment terms defined in the contract.. Valid values are `net30|net45|net60|upon_receipt`',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'Percentage rebate applied once the threshold amount is reached.',
    `rebate_threshold_amount` DECIMAL(18,2) COMMENT 'Cumulative spend amount that triggers a rebate.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiration required to issue a renewal notice.',
    `renewal_type` STRING COMMENT 'Indicates whether the contract renews automatically, manually, or not at all.. Valid values are `auto|manual|none`',
    `shipping_method` STRING COMMENT 'Primary mode of transportation for goods covered by the contract.. Valid values are `Truck|Rail|Air|Sea`',
    `signed_date` DATE COMMENT 'Date the contract was signed by all parties.',
    `supplier_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `draft|active|suspended|terminated|expired|pending`',
    `termination_notice_period_days` STRING COMMENT 'Number of days required to give notice before terminating the contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the contract record.',
    `volume_tier_1_min` STRING COMMENT 'Minimum quantity required to qualify for the first volume discount tier.',
    `volume_tier_1_price` DECIMAL(18,2) COMMENT 'Unit price applied when the purchase quantity meets tier 1 minimum.',
    `volume_tier_2_min` STRING COMMENT 'Minimum quantity required to qualify for the second volume discount tier.',
    `volume_tier_2_price` DECIMAL(18,2) COMMENT 'Unit price applied when the purchase quantity meets tier 2 minimum.',
    CONSTRAINT pk_supplier_contract PRIMARY KEY(`supplier_contract_id`)
) COMMENT 'Master record for negotiated supply agreements and their associated price schedules. Captures contract number, effective and expiration dates, volume commitments, rebate agreements, exclusivity terms, renewal type, and compliance status. Includes contracted unit prices per ingredient/SKU with validity periods, volume tiers, and price types (fixed, indexed, market-based). Used by supply chain for price validation during goods receipt and invoice matching, and for COGS variance analysis. Sourced from Coupa contract management module.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` (
    `ingredient_lot_id` BIGINT COMMENT 'System-generated unique identifier for each ingredient lot record.',
    `goods_receipt_line_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt_line. Business justification: Ingredient lots are created at the point of goods receipt — each lot record traces back to the specific goods receipt line that brought it into inventory. This FK is the critical traceability link ena',
    `haccp_plan_id` BIGINT COMMENT 'Reference to the HACCP plan governing this ingredient lot.',
    `ingredient_id` BIGINT COMMENT 'FK to supply.ingredient',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Allows Lot Responsibility Tracking, assigning the employee accountable for each ingredient lot to meet recall and quality investigation requirements.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Lot-to-inventory-catalog traceability: links a received ingredient lot to its inventory stock_item for FIFO/FEFO rotation, recall management, and lot-level cost tracking. A supply/inventory expert exp',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: HACCP compliance and lot recall require knowing the exact physical storage location of each ingredient lot. storage_location is a denormalized string on ingredient_lot; replacing it with a proper FK',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: ingredient_lot has a supplier_code (STRING) column that denormalizes supplier identity onto the lot record. Replacing this with a proper FK to supply_supplier enables supplier-level lot traceability, ',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Ingredient lots are stored at specific restaurant units for traceability; the FK supports lot‑by‑unit inventory, recall mapping, and waste analysis.',
    `batch_number` STRING COMMENT 'Batch identifier that groups multiple lots produced under the same conditions.',
    `best_by_date` DATE COMMENT 'Date by which the ingredient should be used for optimal quality.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of certifications applicable to the lot (e.g., "USDA Organic, Non‑GMO").',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Purchase cost for a single unit of the ingredient in the specified currency.',
    `country_of_origin` STRING COMMENT 'Three‑letter ISO country code where the ingredient originated.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lot record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for cost fields.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `disposition_date` DATE COMMENT 'Date the lot status last changed (e.g., when recalled or released).',
    `expiration_date` DATE COMMENT 'Date after which the ingredient must not be used.',
    `external_traceability_code` STRING COMMENT 'Identifier used by external regulators (e.g., FDA) for lot tracking.',
    `ingredient_category` STRING COMMENT 'High‑level classification of the ingredient for reporting and analytics.. Valid values are `Meat|Produce|Dairy|Dry_Goods|Spice|Beverage`',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.. Valid values are `passed|failed|pending`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent food‑safety inspection for this lot.',
    `lot_comments` STRING COMMENT 'Free‑form notes captured by quality or operations staff.',
    `lot_number` STRING COMMENT 'External lot number assigned by the supplier or manufacturer for traceability.',
    `lot_source_type` STRING COMMENT 'Origin of the lot in the supply chain.. Valid values are `farm|plant|manufacturer|importer`',
    `lot_status` STRING COMMENT 'Current lifecycle status of the lot for traceability and compliance.. Valid values are `quarantine|released|consumed|recalled|expired|in_transit`',
    `lot_type` STRING COMMENT 'Classification of the lot based on processing level.. Valid values are `raw|processed|prepped|finished`',
    `organic_certified` BOOLEAN COMMENT 'True if the ingredient lot is certified organic.',
    `production_date` DATE COMMENT 'Date the ingredient was produced or packaged by the supplier.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) from quality inspection results.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of ingredient received in the specified unit of measure.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether the lot has been subject to a recall (true) or not (false).',
    `recall_reason` STRING COMMENT 'Free‑text description of why the lot was recalled.',
    `received_date` DATE COMMENT 'Date the lot was received at the distribution center.',
    `receiving_dc_code` STRING COMMENT 'Code identifying the distribution center that received the lot.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Target storage temperature in degrees Celsius for temperature‑controlled lots.',
    `supplier_lot_reference` STRING COMMENT 'Reference code used by the supplier to identify the lot in their system.',
    `temperature_controlled` BOOLEAN COMMENT 'True if the lot requires temperature‑controlled storage.',
    `total_cost` DECIMAL(18,2) COMMENT 'Aggregate cost for the entire lot (quantity × cost per unit).',
    `traceability_enabled` BOOLEAN COMMENT 'Indicates whether the lot is included in the enterprise traceability program.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the quantity field (e.g., kilograms, liters).. Valid values are `kg|lb|g|oz|L|ml`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lot record.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Percentage of the lot that was discarded during processing.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Usable portion of the lot expressed as a percentage of total quantity.',
    CONSTRAINT pk_ingredient_lot PRIMARY KEY(`ingredient_lot_id`)
) COMMENT 'Lot and batch traceability record for received ingredients, enabling end-to-end traceability from supplier farm/plant through DC to restaurant for HACCP compliance and FDA recall management. Captures lot number, batch number, supplier lot reference, ingredient/SKU, production date, best-by date, country of origin, receiving DC, and lot disposition status (quarantine, released, consumed, recalled). Critical for food safety incident response.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` (
    `quality_inspection_id` BIGINT COMMENT 'Unique identifier for each quality inspection event.',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: Quality inspections verify incoming goods against specific brand standards (temperature requirements, HACCP compliance levels, allergen protocols). Direct brand_standard_id on quality_inspection enabl',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to foodsafety.critical_control_point. Business justification: Supply quality inspections are performed at specific HACCP Critical Control Points (e.g., receiving temperature CCP). Linking inspection records to the CCP being monitored is a core HACCP documentatio',
    `goods_receipt_line_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt_line. Business justification: Quality inspections are conducted on specific received goods at the line level — each inspection event is triggered by and associated with a goods receipt line. This FK enables receiving quality dashb',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Quality inspections verify adherence to the HACCP plan; linking inspection to the plan supports inspection checklists and compliance dashboards.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: Quality inspections are performed on specific ingredient lots — the lot_number (STRING) on quality_inspection is a denormalized reference to the ingredient_lot record. Replacing this with a proper FK ',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who performed the inspection.',
    `primary_quality_employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who performed the inspection.',
    `sop_document_id` BIGINT COMMENT 'Foreign key linking to foodsafety.sop_document. Business justification: Quality inspections must be conducted per a documented SOP — regulatory and GFSI standards require each inspection record to cite the procedure followed. This link enables audit trails showing which S',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Quality inspections of incoming goods occur at a specific restaurant unit. Direct unit_id enables unit-level quality scorecards, health inspection reporting, and regulatory compliance dashboards witho',
    `audit_trail_reference` BIGINT COMMENT 'Identifier of the audit‑trail record that captures detailed change history for this inspection.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the inspected item complies with applicable food‑safety regulations.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the required corrective action must be completed.',
    `corrective_action_required` BOOLEAN COMMENT 'True when the defect triggers a mandatory corrective‑action workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection record was first created in the system.',
    `defect_category` STRING COMMENT 'Category of defect identified when inspection fails.. Valid values are `contamination|foreign_body|spoilage|label_error|other`',
    `disposition_action` STRING COMMENT 'Action taken with the inspected item after the result (e.g., accept, reject, return to supplier, quarantine).. Valid values are `accept|reject|return_to_supplier|quarantine`',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity measured during the inspection, expressed as a percent.',
    `inspection_method` STRING COMMENT 'Whether the inspection was performed manually by a person or by an automated system.. Valid values are `manual|automated`',
    `inspection_notes` STRING COMMENT 'Additional observations, comments, or remarks recorded by the inspector.',
    `inspection_result` STRING COMMENT 'Overall outcome of the inspection – pass or fail.. Valid values are `pass|fail`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection was performed.',
    `inspection_type` STRING COMMENT 'Method used for the inspection (e.g., visual, temperature, microbiological, organoleptic).. Valid values are `visual|temperature|microbiological|organoleptic`',
    `quality_inspection_status` STRING COMMENT 'Operational status of the inspection record.. Valid values are `pending|completed|closed|cancelled`',
    `regulatory_reference` STRING COMMENT 'Regulatory standard or program governing the inspection (e.g., HACCP, FDA, USDA, ISO 22000).. Valid values are `HACCP|FDA|USDA|ISO22000`',
    `rejection_quantity` DECIMAL(18,2) COMMENT 'Amount of product rejected as a result of the inspection.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature measured for the product at inspection, expressed in degrees Celsius.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the rejection quantity.. Valid values are `kg|lb|units|liters`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the inspection record.',
    CONSTRAINT pk_quality_inspection PRIMARY KEY(`quality_inspection_id`)
) COMMENT 'Record of quality inspection events conducted on received goods at a DC or restaurant, capturing inspection date, inspector ID, ingredient/SKU and lot inspected, inspection type (visual, temperature, microbiological, organoleptic), pass/fail result, defect category, rejection quantity, and disposition action (accept, reject, return to supplier, quarantine). Feeds supplier performance scoring and HACCP corrective action workflows. Sourced from Zenput operational compliance and MarketMan receiving.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` (
    `supplier_ingredient_sourcing_id` BIGINT COMMENT 'Primary key for the supplier_ingredient_sourcing association',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking this sourcing record to the specific ingredient SKU in the ingredient master catalog.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking this sourcing record to the approved supplier in the supply_supplier master.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard purchase cost for one unit of the ingredient in the specified currency. [Moved from ingredient: cost_per_unit on ingredient represents a single standard cost, but in reality the price varies by supplier. The per-supplier unit price belongs on the supplier_ingredient_sourcing association as unit_price. The ingredient-level cost_per_unit may be retained as a standard/benchmark cost for menu costing purposes, but the procurement price lives on the association.]',
    `effective_from` DATE COMMENT 'The date from which this supplier is approved and contracted to supply this ingredient. Enables time-bounded approved supplier list management.',
    `effective_until` DATE COMMENT 'The date after which this supplier-ingredient sourcing agreement expires. Null if the agreement is open-ended. Used for contract renewal tracking and compliance.',
    `lead_time_days` STRING COMMENT 'Number of days from order placement to receipt for this specific supplier-ingredient combination. Overrides the generic lead times stored on supply_supplier and ingredient master records, which should be considered defaults only.',
    `min_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity of this ingredient that must be ordered from this supplier per purchase order. Belongs to the supplier-ingredient pairing, not to either master record.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the preferred (primary) source for this ingredient. Used by procurement to drive sourcing decisions and auto-populate purchase orders.',
    `unit_price` DECIMAL(18,2) COMMENT 'The negotiated purchase price per unit of this ingredient from this specific supplier. Varies by supplier-ingredient combination and cannot be stored on either master record alone.',
    CONSTRAINT pk_supplier_ingredient_sourcing PRIMARY KEY(`supplier_ingredient_sourcing_id`)
) COMMENT 'This association product represents the sourcing contract/agreement between a supplier and an ingredient in the foodservice supply chain. It captures which suppliers are approved to provide which ingredients, at what price, under what terms, and for what effective period. Each record links one supply_supplier to one ingredient and carries attributes — unit price, lead time, minimum order quantity, preferred flag, and effective dates — that exist only in the context of this specific supplier-ingredient pairing. This is the operational Vendor Item Master / Approved Supplier List (ASL) used by procurement for spend analytics, supplier rationalization, and COGS management.. Existence Justification: In foodservice procurement, a supplier can provide multiple ingredients (e.g., a broadline distributor like Sysco supplies hundreds of SKUs), and a single ingredient (e.g., Roma tomatoes) can be sourced from multiple approved suppliers at different prices, lead times, and minimum order quantities. This relationship — commonly called an Approved Supplier List (ASL) or Vendor Item Master — is actively managed by procurement teams in systems like Coupa and SAP MM, and carries its own operational data (unit price, lead time, preferred flag, effective dates) that belongs to neither the supplier nor the ingredient alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_goods_receipt_line_id` FOREIGN KEY (`goods_receipt_line_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt_line`(`goods_receipt_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ADD CONSTRAINT `fk_supply_ingredient_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ADD CONSTRAINT `fk_supply_quality_inspection_goods_receipt_line_id` FOREIGN KEY (`goods_receipt_line_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`goods_receipt_line`(`goods_receipt_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ADD CONSTRAINT `fk_supply_quality_inspection_ingredient_lot_id` FOREIGN KEY (`ingredient_lot_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient_lot`(`ingredient_lot_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ADD CONSTRAINT `fk_supply_supplier_ingredient_sourcing_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ADD CONSTRAINT `fk_supply_supplier_ingredient_sourcing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for supply_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address_line` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address_line` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address_line` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `supplier_code` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_email` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_name` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `country` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `email` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `is_active` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `is_approved` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `supplier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `supplier_name` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `onboarded_at` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `onboarded_date` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `phone` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `state` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `supply_supplier_status` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_supplier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` SET TAGS ('dbx_subdomain' = 'ingredient_procurement');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `sop_document_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Document Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `allergen_flags` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flags');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `allergen_flags` SET TAGS ('dbx_value_regex' = 'peanut|tree_nut|dairy|egg|gluten|soy');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `carbohydrate_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbohydrate Content (%)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_category` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Category');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_category` SET TAGS ('dbx_value_regex' = 'protein|produce|dairy|dry_goods|packaging|beverage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_code` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Code (SKU)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO‑3)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO‑4217)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `fat_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Fat Content (%)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `haccp_classification` SET TAGS ('dbx_business_glossary_term' = 'HACCP Classification');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `haccp_classification` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `halal_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_status` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `kosher_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Name');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `ingredient_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `non_gmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Non‑GMO Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `nutritional_calories_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Calories per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `organic_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'box|bag|bottle|can|bulk|pallet');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'PAR Level');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `protein_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Protein Content (%)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `sodium_mg_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Sodium (mg) per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `standard_weight_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Weight per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `sub_category` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Sub‑Category');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `traceability_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Traceability Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `traceability_batch_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|lb|oz|liter|ml');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `usda_grade` SET TAGS ('dbx_business_glossary_term' = 'USDA Grade');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `usda_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|U');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `vitamin_c_mg_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Vitamin C (mg) per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'ingredient_procurement');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for supply_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `created_at` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `currency` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `is_approved` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `is_received` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `line_count` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `ship_to_location` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `supply_purchase_order_status` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order` ALTER COLUMN `created_by` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` SET TAGS ('dbx_subdomain' = 'ingredient_procurement');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`purchase_order_line` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'receiving_quality');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `primary_goods_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `primary_goods_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `primary_goods_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Receipt Comments');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Receipt Condition');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partial');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'open|partial|closed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `is_cold_chain_compliant` SET TAGS ('dbx_business_glossary_term' = 'Cold‑Chain Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_method` SET TAGS ('dbx_business_glossary_term' = 'Receiving Method');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_method` SET TAGS ('dbx_value_regex' = 'dock|delivery|third_party|internal');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Receipt Temperature (°C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `temperature_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Deviation Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Received Cost');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Received Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` SET TAGS ('dbx_subdomain' = 'receiving_quality');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `goods_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Line ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Po Line Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold Amount');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `inspected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Is Perishable');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `is_returned` SET TAGS ('dbx_business_glossary_term' = 'Is Returned');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot / Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Line Notes');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'none|pending|recalled');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `supplier_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `temperature_recorded` SET TAGS ('dbx_business_glossary_term' = 'Recorded Temperature (°C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Line Total Cost');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|each|ltr|gal');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (Currency)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Amount Variance');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`goods_receipt_line` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` SET TAGS ('dbx_subdomain' = 'receiving_quality');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'purchase|distribution|exclusive|service|maintenance');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `data_protection_clause` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Clause');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DDP');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `dispute_resolution` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Clause');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `exclusivity_region` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Region');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Executed Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `legal_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Legal Jurisdiction');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `liability_limit` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|upon_receipt');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `rebate_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Threshold Amount');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'Truck|Rail|Air|Sea');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_1_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Minimum Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_1_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_2_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Minimum Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_2_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` SET TAGS ('dbx_subdomain' = 'ingredient_procurement');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Identifier');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `goods_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Line Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Identifier (HACCP_ID)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `best_by_date` SET TAGS ('dbx_business_glossary_term' = 'Best‑By Date (BEST_BY)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications (CERTS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost per Unit (COST_U)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date (DISP_DT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `external_traceability_code` SET TAGS ('dbx_business_glossary_term' = 'External Traceability Identifier (EXT_TRACE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `external_traceability_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_category` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Category (CAT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `ingredient_category` SET TAGS ('dbx_value_regex' = 'Meat|Produce|Dairy|Dry_Goods|Spice|Beverage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (INSP_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (INSP_DT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_comments` SET TAGS ('dbx_business_glossary_term' = 'Lot Comments (COMMENTS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_source_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Source Type (SRC_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_source_type` SET TAGS ('dbx_value_regex' = 'farm|plant|manufacturer|importer');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'quarantine|released|consumed|recalled|expired|in_transit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type (TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'raw|processed|prepped|finished');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag (ORG_CERT_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date (PROD_DT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score (QUAL_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received (QTY)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag (RECALL_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason (RECALL_RSN)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date (RCV_DT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `receiving_dc_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Distribution Center Code (DC_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C) (STOR_TEMP_C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `supplier_lot_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Reference (SLR)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag (TEMP_CTRL_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost (TOTAL_COST)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `traceability_enabled` SET TAGS ('dbx_business_glossary_term' = 'Traceability Enabled Flag (TRACE_EN_FLG)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `traceability_enabled` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|g|oz|L|ml');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage (WASTE_PCT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`ingredient_lot` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage (YIELD_PCT)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` SET TAGS ('dbx_subdomain' = 'receiving_quality');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `quality_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `goods_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Line Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `primary_quality_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `primary_quality_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `primary_quality_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `sop_document_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Document Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `defect_category` SET TAGS ('dbx_business_glossary_term' = 'Defect Category');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `defect_category` SET TAGS ('dbx_value_regex' = 'contamination|foreign_body|spoilage|label_error|other');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'accept|reject|return_to_supplier|quarantine');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'manual|automated');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'visual|temperature|microbiological|organoleptic');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Record Status');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|completed|closed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_value_regex' = 'HACCP|FDA|USDA|ISO22000');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `rejection_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejection Quantity');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°C)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|units|liters');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`quality_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` SET TAGS ('dbx_association_edges' = 'supply.supply_supplier,supply.ingredient');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ALTER COLUMN `supplier_ingredient_sourcing_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Ingredient Sourcing - Supplier Ingredient Sourcing Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Ingredient Sourcing - Ingredient Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Ingredient Sourcing - Supply Supplier Id');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost per Unit');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Effective From');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier-Ingredient Lead Time');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Supplier Unit Price');
