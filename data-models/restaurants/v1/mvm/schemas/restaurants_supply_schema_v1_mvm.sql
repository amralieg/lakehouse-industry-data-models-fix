-- Schema for Domain: supply | Business: Restaurants | Version: v1_mvm
-- Generated on: 2026-05-06 04:01:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `restaurants_ecm`.`supply` COMMENT 'Manages end-to-end food and non-food supply chain including supplier master data, vendor management, sourcing, purchase orders, inbound logistics, distribution center operations, and ingredient traceability. Tracks COGS, supplier performance, contract compliance, and spend analytics via Coupa Procurement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `restaurants_ecm`.`supply`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supply_supplier data product (auto-inserted pre-linking).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Vendor master records carry a default GL account for automated AP posting — standard in foodservice ERP (SAP, Oracle). Role-prefixed default_ because a supplier may have multiple GL contexts; this i',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Suppliers are associated with a legal entity in the vendor master for tax reporting (1099, VAT), payment routing, and intercompany transaction identification. Standard in foodservice ERP vendor master',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for every supplier and vendor in the foodservice supply chain, including food and non-food suppliers, distributors, co-manufacturers, and their key contacts. Captures supplier identity, classification (broadline, specialty, local), approval status, diversity certification, payment terms, lead times, regulatory compliance status (FDA, USDA, HACCP), and primary/secondary contact information. SSOT for supplier identity and contact details across supply chain operations. Sourced from Coupa Procurement supplier master and SAP S/4HANA vendor master (MM).';

CREATE OR REPLACE TABLE `restaurants_ecm`.`supply`.`ingredient` (
    `ingredient_id` BIGINT COMMENT 'System-generated surrogate key uniquely identifying each ingredient record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Ingredients are mapped to GL accounts for inventory valuation and COGS posting (food cost GL vs. packaging GL). Foodservice cost accountants expect each ingredient to carry a GL account for automated ',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Required for HACCP compliance: each ingredient must be linked to its HACCP plan for safety documentation and audit reporting.',
    `allergen_flags` STRING COMMENT 'Pipe‑separated list of allergens present in the ingredient.. Valid values are `peanut|tree_nut|dairy|egg|gluten|soy`',
    `carbohydrate_content_percent` DECIMAL(18,2) COMMENT 'Percentage of carbohydrates by weight in the ingredient.',
    `country_of_origin` STRING COMMENT 'Three‑letter country code indicating where the ingredient was produced or sourced.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the ingredient record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost_per_unit (e.g., USD, EUR).',
    `effective_from` DATE COMMENT 'Date when the ingredient becomes available for ordering.',
    `effective_until` DATE COMMENT 'Date after which the ingredient is no longer available (null if indefinite).',
    `fat_content_percent` DECIMAL(18,2) COMMENT 'Percentage of total fat by weight in the ingredient.',
    `haccp_classification` STRING COMMENT 'Risk level of the ingredient according to HACCP guidelines.. Valid values are `critical|high|medium|low`',
    `halal_flag` BOOLEAN COMMENT 'Indicates whether the ingredient meets halal certification requirements.',
    `ingredient_category` STRING COMMENT 'Broad classification of the ingredient for sourcing, menu engineering, and cost analysis.. Valid values are `protein|produce|dairy|dry_goods|packaging|beverage`',
    `ingredient_code` STRING COMMENT 'Business code or SKU assigned to the ingredient for ordering and inventory tracking.. Valid values are `^[A-Z0-9]{3,10}$`',
    `ingredient_name` STRING COMMENT 'Descriptive name of the ingredient as used in menus, procurement, and reporting.',
    `ingredient_status` STRING COMMENT 'Current operational status of the ingredient in the catalog.. Valid values are `active|inactive|discontinued|pending`',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection.. Valid values are `passed|failed|pending`',
    `kosher_flag` BOOLEAN COMMENT 'Indicates whether the ingredient meets kosher certification requirements.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent food safety inspection for this ingredient.',
    `lead_time_days` STRING COMMENT 'Typical number of days from order placement to receipt of the ingredient.',
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

CREATE OR REPLACE TABLE `restaurants_ecm`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the supply_purchase_order data product (auto-inserted pre-linking).',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Foodservice procurement uses budget encumbrance: each PO consumes budget at creation. Linking PO to budget enables real-time budget consumption tracking and prevents over-spend against food/supply bud',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Procurement audit trail and PO approval workflows require tracking which employee created/approved each purchase order. Foodservice procurement teams assign designated buyers per supplier or category.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: POs are accrued into financial periods for food cost reporting and period-end close. Foodservice operators require period-level PO accrual reporting to manage COGS and inventory cut-off accurately.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Purchase orders are issued by individual franchisees; linking enables franchise‑level cost allocation and procurement performance reports.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: POs are GL-coded at creation for food cost accrual and three-way match in foodservice ERP systems. A domain expert expects every PO to carry a GL account for automated journal posting at goods receipt',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Each purchase order line orders a specific ingredient or SKU. purchase_order_line must reference ingredient to identify what is being procured. This links transactional procurement data to the ingredi',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: In multi-entity restaurant groups, POs are issued by a specific legal entity driving tax treatment, intercompany AP, and payment routing. Required for entity-level food cost reporting and regulatory c',
    `nro_project_id` BIGINT COMMENT 'Foreign key linking to realestate.nro_project. Business justification: NRO first-fill purchase orders: new restaurant openings require dedicated opening-inventory POs coordinated with the NRO project schedule and capex budget. Linking POs to the NRO project enables openi',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Internal purchase‑order entity must be associated with the restaurant site it serves for accurate inventory and financial reconciliation.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: A purchase order is issued to a specific supplier. supply_purchase_order must reference supply_supplier to identify which vendor the PO was sent to. This is a foundational procurement relationship — w',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: PURCHASE_ORDER creation is done per restaurant location; linking PO to unit enables inventory budgeting and location‑specific spend reporting.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Core transactional record for every purchase order issued to suppliers for food ingredients, beverages, packaging, and non-food supplies. Captures PO number, supplier reference, order date, requested delivery date, ship-to distribution center or restaurant, total PO value, currency, payment terms, approval status, and sourcing event linkage. Represents the contractual commitment to buy. Sourced from Coupa Procurement PO module and SAP S/4HANA MM purchasing.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'System‑generated unique identifier for each goods receipt transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links receipt of goods to cost center to allocate receiving costs and inventory valuation to the responsible cost center.',
    `distribution_center_id` BIGINT COMMENT 'Identifier of the distribution center or restaurant where goods were received.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Goods receipts must be assigned to a financial period for period-end cut-off and food cost accrual accuracy. Foodservice operators require GR-to-period mapping for accurate COGS reporting and inventor',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Goods receipts trigger GR/IR (goods receipt/invoice receipt) GL postings in three-way match. The GL account on the GR drives automated inventory or expense posting — fundamental to foodservice AP and ',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Goods receiving is a defined CCP in HACCP plans. Receiving managers follow the applicable HACCP plan to accept or reject deliveries based on temperature and condition criteria. Regulatory cold-chain c',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: A goods receipt is the dock-level confirmation of an inbound shipment arriving at a DC or restaurant. goods_receipt must reference inbound_shipment to link the physical receiving event to the freight ',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: A goods receipt records the inbound delivery of a specific ingredient batch. goods_receipt tracks batch_number, lot_number, expiration_date, temperature_celsius, and is_cold_chain_compliant — all ingr',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the receipt inspection.',
    `primary_goods_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the receipt inspection.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: A goods receipt is the physical confirmation of a purchase order being fulfilled. goods_receipt currently stores purchase_order_number as a denormalized STRING. Adding supply_purchase_order_id FK norm',
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

CREATE OR REPLACE TABLE `restaurants_ecm`.`supply`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Primary key for invoice',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Connects supplier invoice record in supply to AP invoice in finance for reconciliation and payment processing.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Supply invoices are cost-center coded for food cost allocation by restaurant unit or region. Foodservice operators require this for unit-level P&L reporting and franchise royalty calculations based on',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Supply invoices require GL account coding for AP posting and expense classification (food cost vs. paper/packaging). Standard in foodservice ERP; the GL code on the supply invoice drives automated jou',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Supply invoices are payable by a specific legal entity in multi-entity franchise groups. Required for intercompany reconciliation, VAT reporting, and entity-level AP aging reports in foodservice finan',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: An AP invoice is generated against a purchase order in the three-way matching process (PO → goods receipt → invoice). invoice must reference supply_purchase_order to enable PO-based invoice validation',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_contract. Business justification: An invoice should be validated against the governing supplier contract for price compliance, payment terms, and rebate calculations. invoice must reference supplier_contract to enable contract-based i',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: An AP invoice is received from a specific supplier. invoice must reference supply_supplier to link payables to the vendor master. This enables supplier spend analytics, payment terms enforcement, and ',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Accounts payable invoice record from a supplier for goods or services delivered. Captures invoice number, supplier ID, invoice date, due date, payment terms, gross amount, tax amount, net amount, currency, three-way match status (PO–GR–invoice), dispute flag, and payment status. Feeds SAP S/4HANA AP (FI-AP) for payment processing and COGS accrual. Sourced from Coupa invoice management and SAP S/4HANA FI.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`supply`.`supplier_contract` (
    `supplier_contract_id` BIGINT COMMENT 'System-generated unique identifier for the supplier contract record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Brand-level supplier contract management: in multi-brand foodservice, supplier contracts are scoped to specific brands (e.g., proprietary beef supplier for Brand A only). Supply chain directors and br',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supports Contract Ownership Register, linking each supplier contract to the employee owner for accountability and audit trails.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns contract financial responsibility to a cost center for budgeting, expense tracking, and compliance reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Supplier contracts specify the default GL account for contracted purchase expense coding (food cost, packaging). Foodservice procurement teams use this for automated GL coding of POs and invoices unde',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Supplier contracts are executed by a specific legal entity — critical for legal enforceability, tax jurisdiction, and financial reporting in multi-entity restaurant franchise groups. A procurement exp',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: A supplier contract is negotiated with a specific supplier. supplier_contract must reference supply_supplier to link the agreement to the vendor master. This enables contract compliance tracking, spen',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Regional preferred-supplier agreements and exclusivity clauses are scoped to franchise territories in multi-unit foodservice systems. The existing exclusivity_region text field is a denormalization of',
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
    `executed_date` DATE COMMENT 'Date the contract was executed and entered into the system.',
    `governing_law` STRING COMMENT 'Specific legal framework applied to interpret the contract.',
    `insurance_requirements` STRING COMMENT 'Minimum insurance coverage the supplier must maintain.',
    `legal_jurisdiction` STRING COMMENT 'State, province, or country whose laws govern the contract.',
    `liability_limit` DECIMAL(18,2) COMMENT 'Maximum monetary liability the supplier assumes under the contract.',
    `payment_method` STRING COMMENT 'Preferred method of payment for invoicing under the contract.. Valid values are `ACH|Check|Wire|CreditCard`',
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

CREATE OR REPLACE TABLE `restaurants_ecm`.`supply`.`contract_price` (
    `contract_price_id` BIGINT COMMENT 'System-generated unique identifier for the contract price record.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Contract prices are effective within financial periods for budget vs. actual food cost variance analysis. Foodservice finance teams require period-level contract price tracking to reconcile contracted',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: A contract price record defines the negotiated unit price for a specific ingredient or SKU. contract_price must reference ingredient to identify which item the price applies to. This enables price com',
    `stock_item_id` BIGINT COMMENT 'Identifier of the ingredient or stock keeping unit covered by this price.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_contract. Business justification: contract_price is the line-level price schedule record under a supplier_contract header. This is the canonical header-line relationship for contract pricing. contract_price must reference supplier_con',
    `contract_price_code` STRING COMMENT 'Business identifier or code assigned to the contract price (e.g., CP-2024-001).',
    `contract_price_status` STRING COMMENT 'Current lifecycle status of the price record.. Valid values are `active|expired|pending|draft`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the price record was initially created in the source system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the price (e.g., USD, EUR).',
    `default_price` DECIMAL(18,2) COMMENT 'Baseline price per unit (SKU) when no volume tier applies. [Moved from supplier_contract: default_price on supplier_contract represents a baseline price per SKU — but in a contract covering multiple ingredients, each ingredient has its own contracted price. This attribute is more accurately represented as contracted_unit_price on the contract_price association, where it is scoped to a specific contract-ingredient combination. Keeping it on supplier_contract implies a single price for the entire contract, which misrepresents multi-SKU contracts.]',
    `effective_from` DATE COMMENT 'Date when the contracted price becomes binding.',
    `effective_until` DATE COMMENT 'Date when the contracted price expires (null if open‑ended).',
    `is_current` BOOLEAN COMMENT 'Indicates whether this price record is the currently active price for the SKU.',
    `price_amount` DECIMAL(18,2) COMMENT 'Numeric value of the contracted unit price.',
    `price_change_reason` STRING COMMENT 'Free‑text explanation for why the price was changed or created.',
    `price_index_reference` STRING COMMENT 'External index or commodity reference used for indexed pricing (e.g., USDA Corn Index).',
    `price_tier_max_qty` DECIMAL(18,2) COMMENT 'Upper bound quantity for this price tier (null if no upper limit).',
    `price_tier_min_qty` DECIMAL(18,2) COMMENT 'Lower bound quantity for this price tier (volume break).',
    `price_type` STRING COMMENT 'Classification of the price calculation method.. Valid values are `fixed|indexed|market_based`',
    `price_uom` STRING COMMENT 'Unit of measure for the default price (e.g., per unit, per case). [Moved from supplier_contract: price_uom on supplier_contract is the UOM for the default_price, which is ingredient-specific. Since each ingredient in a contract may have a different UOM (e.g., beef by lb, buns by case), this attribute belongs on the contract_price association as unit_of_measure, scoped to the specific contract-ingredient price line.]. Valid values are `per_unit|per_case|per_kg|per_liter`',
    `record_audit_created` TIMESTAMP COMMENT 'Audit timestamp capturing when the record was first loaded into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit timestamp capturing the last load or refresh time for the record.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the price (e.g., kilogram, pound, each).. Valid values are `kg|lb|unit|liter|gallon|piece`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the price record.',
    CONSTRAINT pk_contract_price PRIMARY KEY(`contract_price_id`)
) COMMENT 'Contracted unit price records tied to a supplier contract for specific ingredients or SKUs over a defined validity period. Captures ingredient/SKU reference, contracted unit price, currency, price validity start and end dates, price tier (volume break), and price type (fixed, indexed, market-based). Enables COGS% variance analysis against actual invoice prices and supports menu costing in the menu domain.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`supply`.`distribution_center` (
    `distribution_center_id` BIGINT COMMENT 'System-generated unique identifier for the distribution center.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Distribution centers are cost centers in foodservice operations — DC labor, utilities, and lease costs are tracked against a finance cost center for logistics cost reporting and allocation to restaura',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: DC lease and operating costs post to specific GL accounts (right-of-use asset, lease liability, logistics expense). Required for IFRS 16/ASC 842 compliance and DC cost reporting in foodservice finance',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: DCs are owned or leased by a specific legal entity — required for IFRS 16/ASC 842 lease accounting, intercompany logistics charges to franchisees, and entity-level supply chain cost reporting.',
    `address_line1` STRING COMMENT 'Primary street address of the distribution center.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `city` STRING COMMENT 'City where the distribution center is located.',
    `close_time` TIMESTAMP COMMENT 'Time of day the facility closes (HH:mm, 24‑hour).',
    `compliance_documentation_url` STRING COMMENT 'Link to stored compliance certificates and audit documents.',
    `cost_per_square_meter` DECIMAL(18,2) COMMENT 'Operational cost metric expressed in local currency per m².',
    `country` STRING COMMENT 'Three‑letter ISO country code of the distribution center location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution center record was first created in the system.',
    `cross_dock_enabled` BOOLEAN COMMENT 'True if the facility supports cross‑docking operations.',
    `dc_code` STRING COMMENT 'Business‑visible code used to reference the distribution center in external systems.',
    `distribution_center_name` STRING COMMENT 'Human‑readable name of the distribution center.',
    `distribution_center_status` STRING COMMENT 'Current operational status of the distribution center.. Valid values are `active|inactive|closed|maintenance`',
    `emergency_contact_phone` STRING COMMENT 'Phone number for emergency notifications related to the facility.',
    `facility_type` STRING COMMENT 'Classification of the facility based on temperature control capabilities.. Valid values are `ambient|refrigerated|frozen|mixed`',
    `fire_suppression_system` STRING COMMENT 'Type of fire suppression system installed (e.g., sprinkler, FM‑200).',
    `haccp_compliant` BOOLEAN COMMENT 'True if the facility complies with HACCP food‑safety standards.',
    `inspection_score` DECIMAL(18,2) COMMENT 'Numeric score assigned during the last inspection (0‑100).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent health or safety inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the distribution center (decimal degrees).',
    `lease_expiration_date` DATE COMMENT 'Date when the current lease agreement ends (if applicable).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the distribution center (decimal degrees).',
    `number_of_loading_docks` STRING COMMENT 'Count of loading dock bays available for inbound/outbound trucks.',
    `open_time` TIMESTAMP COMMENT 'Time of day the facility opens (HH:mm, 24‑hour).',
    `operating_hours` STRING COMMENT 'Standard daily operating window expressed as text (e.g., 06:00‑22:00).',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the facility.. Valid values are `owned|leased|third_party`',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the distribution center address.',
    `refrigeration_type` STRING COMMENT 'Specific refrigeration technology employed (e.g., cascade, glycol).',
    `region` STRING COMMENT 'Broad region (e.g., North America, EMEA) used for reporting and logistics planning.',
    `security_level` STRING COMMENT 'Physical security classification of the facility.. Valid values are `low|medium|high`',
    `state_province` STRING COMMENT 'State or province of the distribution center location.',
    `storage_capacity_cubic_meters` DECIMAL(18,2) COMMENT 'Total usable storage volume of the center in cubic meters.',
    `supported_restaurant_count` STRING COMMENT 'Number of restaurant locations served by this distribution center.',
    `temperature_control_system` STRING COMMENT 'Description of the system used to maintain required temperatures.',
    `temperature_monitoring_interval_minutes` STRING COMMENT 'Frequency at which temperature readings are recorded.',
    `third_party_logistics_flag` BOOLEAN COMMENT 'Indicates whether a 3PL provider manages the facility.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the distribution center record.',
    `waste_management_certified` BOOLEAN COMMENT 'Indicates whether the center holds a certified waste‑management program.',
    CONSTRAINT pk_distribution_center PRIMARY KEY(`distribution_center_id`)
) COMMENT 'Master record for each distribution center (DC), warehouse, and logistics node in the foodservice supply network including company-owned DCs, third-party logistics (3PL) facilities, cross-dock locations, and commissary kitchens. Captures DC code, name, full address, geographic region/market, facility type (ambient, refrigerated, frozen, mixed-temp), total storage capacity (pallet positions), operating hours, supported restaurant count, primary and backup DC assignments, and facility manager. SSOT for DC identity used across inbound logistics, inventory allocation, and restaurant replenishment. Sourced from SAP EWM and network design tools.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`supply`.`inbound_shipment` (
    `inbound_shipment_id` BIGINT COMMENT 'System-generated unique identifier for the inbound freight shipment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight and logistics costs on inbound shipments are allocated to cost centers for supply chain cost reporting. Foodservice operators track freight-in by cost center to manage landed cost and unit-lev',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Shipments are delivered to individual restaurant sites; the FK enables logistics dashboards and delivery performance metrics per site.',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_center. Business justification: An inbound shipment is destined for a specific distribution center. inbound_shipment currently stores destination_location_code as a denormalized STRING. Adding distribution_center_id FK normalizes th',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Inbound shipments are accrued into financial periods for freight cost and inventory cut-off. Period-end close in foodservice requires shipments to be assigned to the correct period for accurate COGS a',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Freight costs on inbound shipments post to specific GL accounts (freight-in, logistics expense). Required for automated journal entry creation and accurate landed cost calculation in foodservice suppl',
    `nro_project_id` BIGINT COMMENT 'Foreign key linking to realestate.nro_project. Business justification: NRO supply coordination: first-fill shipments for new restaurant openings are scheduled against the NRO project timeline. Supply and NRO teams track opening-delivery alignment to project milestones. A',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: An inbound shipment fulfills one or more purchase orders. inbound_shipment must reference supply_purchase_order to link freight tracking to the originating procurement event. This enables PO fulfillme',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: An inbound shipment originates from a specific supplier. inbound_shipment must reference supply_supplier to track which vendor dispatched the freight. This enables supplier on-time delivery performanc',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Inbound shipments are routed to individual restaurant locations; linking enables shipment tracking, ETA dashboards, and dock scheduling per unit.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Real date and time when the shipment arrived at the destination.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Real date and time when the shipment left the origin.',
    `bill_of_lading_number` STRING COMMENT 'Identifier on the bill of lading document issued by the carrier.. Valid values are `^[A-Z0-9]{1,20}$`',
    `carrier_contact_phone` STRING COMMENT 'Primary phone number for the carriers logistics contact.. Valid values are `^+?[0-9]{7,15}$`',
    `carrier_name` STRING COMMENT 'Name of the transportation provider responsible for moving the shipment.',
    `carrier_scac_code` STRING COMMENT 'Standard Carrier Alpha Code used to uniquely identify the carrier in logistics systems.. Valid values are `^[A-Z0-9]{4}$`',
    `compliance_document_flag` BOOLEAN COMMENT 'Indicates whether all required compliance documents were attached.',
    `container_type` STRING COMMENT 'Physical container classification used for the shipment.. Valid values are `pallet|box|crate|bulk`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the freight cost.. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_status` STRING COMMENT 'Current status of customs clearance for the shipment.. Valid values are `pending|cleared|rejected`',
    `delay_minutes` STRING COMMENT 'Total minutes the shipment arrived later than the scheduled arrival.',
    `exception_reason` STRING COMMENT 'Free‑text description of any exception or issue affecting the shipment.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Total cost charged by the carrier for transporting the shipment.',
    `freight_invoice_number` STRING COMMENT 'Invoice number issued by the carrier for freight charges.',
    `freight_terms` STRING COMMENT 'Incoterm defining responsibility for freight costs and risk.. Valid values are `FOB|CIF|EXW|DDP`',
    `hazard_material_flag` BOOLEAN COMMENT 'True if the shipment contains regulated hazardous materials.',
    `is_expedited` BOOLEAN COMMENT 'True if the shipment was processed under an expedited service level.',
    `number_of_items` STRING COMMENT 'Count of individual items or SKUs contained in the shipment.',
    `origin_location_code` STRING COMMENT 'Code identifying the suppliers shipping location.',
    `payment_status` STRING COMMENT 'Current payment status of the freight invoice.. Valid values are `unpaid|paid|partial`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment was physically received at the destination.',
    `scheduled_arrival_timestamp` TIMESTAMP COMMENT 'Planned date and time when the shipment is expected to arrive at the destination.',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Planned date and time when the shipment is expected to leave the origin.',
    `seal_number` STRING COMMENT 'Security seal identifier applied to the container.',
    `shipment_number` STRING COMMENT 'Business identifier assigned by the carrier or logistics system for tracking the shipment.',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment.. Valid values are `in_transit|arrived|delayed|exception|cancelled`',
    `temperature_control_flag` BOOLEAN COMMENT 'Indicates whether the shipment required temperature-controlled transport.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature recorded during transport (°C).',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature recorded during transport (°C).',
    `transport_mode` STRING COMMENT 'Mode of transport used for the shipment.. Valid values are `refrigerated_truck|dry_van|ltl|ftl`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shipment record.',
    `volume_cubic_m` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the shipment in kilograms.',
    CONSTRAINT pk_inbound_shipment PRIMARY KEY(`inbound_shipment_id`)
) COMMENT 'Transactional record tracking each inbound freight shipment from a supplier to a distribution center or restaurant. Captures shipment ID, carrier name, mode of transport (refrigerated truck, dry van, LTL, FTL), origin supplier location, destination DC or restaurant, scheduled and actual arrival date/time, bill of lading number, freight cost, cold chain temperature log flag, and shipment status (in-transit, arrived, delayed, exception). Supports inbound logistics visibility and carrier performance tracking.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`supply`.`recall_event` (
    `recall_event_id` BIGINT COMMENT 'System-generated unique identifier for the recall event record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recall costs (disposal, logistics, customer compensation) are charged to a cost center for financial tracking, insurance claims, and regulatory cost reporting. Foodservice operators require cost cente',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to foodsafety.critical_control_point. Business justification: Recall events are frequently caused by a CCP failure (e.g., temperature exceedance, contamination at a specific process step). FDA/USDA recall root-cause investigations require identifying the specifi',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_center. Business justification: A recall event affects specific distribution center locations where the recalled ingredient was stored or distributed. recall_event currently stores affected_dc_locations as a denormalized STRING. Add',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Recall costs must be recorded in the correct financial period for P&L impact, regulatory disclosure, and insurance claim timing. Foodservice finance teams require period-level recall cost tracking for',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Recall expenses post to specific GL accounts (recall expense, extraordinary items) for financial statement disclosure and insurance recovery. Required for SEC/regulatory reporting and accurate P&L imp',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: FDA/USDA recall investigations require traceability to the HACCP plan governing the recalled ingredient at time of recall. Food safety directors must identify which HACCP plan was in effect and whethe',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: A recall event targets a specific ingredient or SKU. recall_event currently stores affected_ingredient_sku as a denormalized STRING. Adding ingredient_id FK normalizes this to the ingredient master, e',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FDA/USDA recall regulations (21 CFR Part 7) require a designated recall coordinator responsible for executing recalls, notifying affected restaurant locations, and filing regulatory reports. Every foo',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Recall scope identification requires knowing which inventory SKUs are affected by a recall event. recall_event already links to ingredient (supply domain) but not to the inventory stock_item. Foodserv',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: A recall event is initiated by or attributed to a specific supplier. recall_event must reference supply_supplier to identify the source vendor of the recalled product. This is essential for regulatory',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Territory-scoped recall containment is a named FDA/USDA regulatory process. When a recall is geographically bounded, linking recall_event to the affected franchise territory enables automated franchis',
    `affected_lot_numbers` STRING COMMENT 'Comma‑separated list of lot or batch numbers impacted by the recall.',
    `affected_restaurant_locations` STRING COMMENT 'List of restaurant sites that received the recalled product.',
    `compliance_fda` BOOLEAN COMMENT 'True if the product complies with FDA regulations.',
    `compliance_haccp` BOOLEAN COMMENT 'True if the product meets HACCP safety standards.',
    `compliance_usda` BOOLEAN COMMENT 'True if the product complies with USDA regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall event record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for total_cost.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `disposal_method` STRING COMMENT 'Method used to dispose of or handle the recalled product.. Valid values are `incineration|landfill|donation|return_to_supplier|other`',
    `is_cold_chain_compliant` BOOLEAN COMMENT 'Indicates whether the recalled product required cold‑chain handling and remained compliant.',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding the recall.',
    `product_category` STRING COMMENT 'Broad category of the recalled product.. Valid values are `dairy|meat|produce|bakery|beverage|other`',
    `quantity_recalled` DECIMAL(18,2) COMMENT 'Total amount of product recalled, expressed in the unit_of_measure.',
    `recall_class` STRING COMMENT 'Regulatory classification indicating severity and health risk of the recall.. Valid values are `Class I|Class II|Class III`',
    `recall_closure_timestamp` TIMESTAMP COMMENT 'Date and time when the recall was officially closed or resolved.',
    `recall_initiation_timestamp` TIMESTAMP COMMENT 'Date and time when the recall was initiated.',
    `recall_number` STRING COMMENT 'Official recall reference number assigned by regulatory agency or supplier.',
    `recall_reason` STRING COMMENT 'Root cause for the recall (e.g., contamination, allergen mislabeling, foreign material).',
    `recall_severity` STRING COMMENT 'Severity level assigned to the recall based on health risk.. Valid values are `high|medium|low`',
    `recall_status` STRING COMMENT 'Current lifecycle status of the recall event.. Valid values are `open|closed|in_progress|withdrawn`',
    `recall_type` STRING COMMENT 'Whether the recall was initiated voluntarily by the supplier or mandated by regulators.. Valid values are `voluntary|mandated`',
    `regulatory_notification_status` STRING COMMENT 'Status of notification to regulatory bodies (e.g., FDA, USDA).. Valid values are `notified|pending|completed`',
    `risk_score` STRING COMMENT 'Numeric risk rating (e.g., 1‑5) used for internal prioritization.',
    `source_system` STRING COMMENT 'Originating system where the recall event was recorded.. Valid values are `Coupa|Zenput|MarketMan|Other`',
    `temperature_deviation_flag` BOOLEAN COMMENT 'True if temperature excursions were detected for the recalled product.',
    `total_cost` DECIMAL(18,2) COMMENT 'Monetary value of the recalled quantity at the time of recall.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the recalled quantity.. Valid values are `kg|lb|unit|liter|gallon`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the recall event record.',
    CONSTRAINT pk_recall_event PRIMARY KEY(`recall_event_id`)
) COMMENT 'Operational record of a food product or ingredient recall event initiated by a supplier, regulatory agency (FDA/USDA), or internal quality team. Captures recall reference number, recall class (Class I, II, III), affected ingredient/SKU, affected lot numbers, recall reason (contamination, allergen mislabeling, foreign material), recall initiation date, affected DC and restaurant locations, quantity recalled, disposal method, and regulatory notification status. Enables rapid traceability response using ingredient_lot linkage.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` (
    `approved_vendor_item_id` BIGINT COMMENT 'Primary key for the approved_vendor_item association',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to the ingredient or SKU being sourced from this supplier.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the approved supplier in the supply_supplier master record.',
    `approval_status` STRING COMMENT 'Current approval status of this supplier for this specific ingredient on the Approved Vendor List. Managed by procurement and food safety teams.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard purchase cost for one unit of the ingredient in the specified currency. [Moved from ingredient: Purchase cost per unit is negotiated per supplier-ingredient combination. Storing it on the ingredient master implies a single price, which is incorrect when multiple suppliers offer the same ingredient at different prices. It belongs on the approved_vendor_item association as unit_price.]',
    `effective_from` DATE COMMENT 'Date on which this supplier-ingredient sourcing agreement becomes active and the supplier is approved to fulfill orders for this ingredient.',
    `effective_until` DATE COMMENT 'Date after which this supplier-ingredient sourcing agreement expires and the supplier is no longer approved for this ingredient. Null if the agreement is open-ended.',
    `lead_time_days` DECIMAL(18,2) COMMENT 'Number of days from order placement to receipt of this ingredient from this specific supplier. Supplier-specific and belongs to the sourcing relationship, not the ingredient master.',
    `min_order_quantity` DECIMAL(18,2) COMMENT 'Minimum number of units that must be ordered per purchase order for this supplier-ingredient combination. A contractual term that belongs to the sourcing relationship.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the designated primary (preferred) source for this ingredient. Used in multi-sourcing strategy to determine default sourcing decisions.',
    `unit_price` DECIMAL(18,2) COMMENT 'Negotiated purchase price per unit of the ingredient from this specific supplier. Varies by supplier-ingredient combination and cannot reside on either master record.',
    CONSTRAINT pk_approved_vendor_item PRIMARY KEY(`approved_vendor_item_id`)
) COMMENT 'This association product represents the sourcing contract between a supplier and an ingredient in the foodservice supply chain. It captures the Approved Vendor List (AVL) entry that procurement teams actively manage — recording which suppliers are approved to provide which ingredients, at what price, under what terms, and for what time period. Each record links one supply_supplier to one ingredient with attributes that exist only in the context of this supplier-ingredient sourcing relationship, enabling multi-sourcing strategy, price benchmarking, and supply continuity planning.. Existence Justification: In foodservice procurement, a supplier provides many ingredients (e.g., a broadline distributor like Sysco supplies beef, lettuce, cooking oil, and packaging), and a single ingredient (e.g., ground beef) is sourced from multiple approved suppliers at different prices, lead times, and minimum order quantities. This relationship is actively managed by procurement teams as an Approved Vendor List (AVL) or Supplier Item Catalog — a recognized operational business concept with its own lifecycle (approval, pricing updates, deactivation). The relationship carries substantial data (unit_price, lead_time_days, min_order_quantity, preferred_supplier_flag, effective_from, effective_until) that belongs to neither the supplier master nor the ingredient master alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `restaurants_ecm`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `restaurants_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `restaurants_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `restaurants_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `restaurants_ecm`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `restaurants_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `restaurants_ecm`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ADD CONSTRAINT `fk_supply_approved_vendor_item_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ADD CONSTRAINT `fk_supply_approved_vendor_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `restaurants_ecm`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `restaurants_ecm`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for supply_supplier');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Default Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `allergen_flags` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flags');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `allergen_flags` SET TAGS ('dbx_value_regex' = 'peanut|tree_nut|dairy|egg|gluten|soy');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `carbohydrate_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbohydrate Content (%)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO‑3)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO‑4217)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `fat_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Fat Content (%)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `haccp_classification` SET TAGS ('dbx_business_glossary_term' = 'HACCP Classification');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `haccp_classification` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `halal_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `ingredient_category` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Category');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `ingredient_category` SET TAGS ('dbx_value_regex' = 'protein|produce|dairy|dry_goods|packaging|beverage');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `ingredient_code` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Code (SKU)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `ingredient_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Name');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `ingredient_status` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Status');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `ingredient_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `kosher_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `non_gmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Non‑GMO Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `nutritional_calories_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Calories per Unit');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `organic_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'box|bag|bottle|can|bulk|pallet');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'PAR Level');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `protein_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Protein Content (%)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `sodium_mg_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Sodium (mg) per Unit');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `standard_weight_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Weight per Unit');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `sub_category` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Sub‑Category');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `traceability_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Traceability Batch Number');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|lb|oz|liter|ml');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `usda_grade` SET TAGS ('dbx_business_glossary_term' = 'USDA Grade');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `usda_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|U');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `vitamin_c_mg_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Vitamin C (mg) per Unit');
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for supply_purchase_order');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `nro_project_id` SET TAGS ('dbx_business_glossary_term' = 'Nro Project Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location Identifier');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `primary_goods_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `primary_goods_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `primary_goods_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location Identifier');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Batch Number');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Receipt Comments');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Receipt Condition');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partial');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'open|partial|closed|cancelled');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `is_cold_chain_compliant` SET TAGS ('dbx_business_glossary_term' = 'Cold‑Chain Compliance Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receiving_method` SET TAGS ('dbx_business_glossary_term' = 'Receiving Method');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receiving_method` SET TAGS ('dbx_value_regex' = 'dock|delivery|third_party|internal');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Receipt Temperature (°C)');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `temperature_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Deviation Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Received Cost');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Received Quantity');
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract ID');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'purchase|distribution|exclusive|service|maintenance');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `data_protection_clause` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Clause');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DDP');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `dispute_resolution` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Clause');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Executed Date');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `legal_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Legal Jurisdiction');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `liability_limit` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|Check|Wire|CreditCard');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|upon_receipt');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `rebate_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Threshold Amount');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'Truck|Rail|Air|Sea');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_1_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Minimum Quantity');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_1_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Unit Price');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_2_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Minimum Quantity');
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ALTER COLUMN `volume_tier_2_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Unit Price');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `contract_price_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Price ID');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'SKU ID');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `contract_price_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Code');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `contract_price_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Status');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `contract_price_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|draft');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `default_price` SET TAGS ('dbx_business_glossary_term' = 'Default Unit Price');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Unit Price Amount');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `price_tier_max_qty` SET TAGS ('dbx_business_glossary_term' = 'Price Tier Maximum Quantity');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `price_tier_min_qty` SET TAGS ('dbx_business_glossary_term' = 'Price Tier Minimum Quantity');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type (FIXED|INDEXED|MARKET_BASED)');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'fixed|indexed|market_based');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_unit|per_case|per_kg|per_liter');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|unit|liter|gallon|piece');
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` SET TAGS ('dbx_subdomain' = 'logistics_distribution');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Identifier');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `close_time` SET TAGS ('dbx_business_glossary_term' = 'Daily Close Time');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `compliance_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documentation URL');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `cost_per_square_meter` SET TAGS ('dbx_business_glossary_term' = 'Cost per Square Meter');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `cross_dock_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Dock Capability Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `dc_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Code');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `distribution_center_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Name');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `distribution_center_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Status');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `distribution_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|maintenance');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type (Ambient/Refrigerated/Frozen/Mixed)');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|mixed');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `haccp_compliant` SET TAGS ('dbx_business_glossary_term' = 'HACCP Compliance Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Inspection Score');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `number_of_loading_docks` SET TAGS ('dbx_business_glossary_term' = 'Number of Loading Docks');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `open_time` SET TAGS ('dbx_business_glossary_term' = 'Daily Open Time');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|third_party');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `refrigeration_type` SET TAGS ('dbx_business_glossary_term' = 'Refrigeration Type');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `storage_capacity_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Cubic Meters)');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `supported_restaurant_count` SET TAGS ('dbx_business_glossary_term' = 'Supported Restaurant Count');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `temperature_control_system` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control System');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `temperature_monitoring_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Interval (Minutes)');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `third_party_logistics_flag` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Logistics Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ALTER COLUMN `waste_management_certified` SET TAGS ('dbx_business_glossary_term' = 'Waste Management Certification');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` SET TAGS ('dbx_subdomain' = 'logistics_distribution');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment ID');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Site Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `nro_project_id` SET TAGS ('dbx_business_glossary_term' = 'Nro Project Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp (ACT_ARR_TS)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp (ACT_DEP_TS)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number (BOL_NUM)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Phone (CARRIER_PHONE)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name (CARRIER_NM)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier SCAC Code (CARRIER_SCAC)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `compliance_document_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Flag (COMP_DOC_FLG)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type (CONT_TYPE)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'pallet|box|crate|bulk');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (REC_CREATED_TS)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status (CUSTOMS_STATUS)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|rejected');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Minutes (DELAY_MIN)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason (EXCPT_REASON)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost (FREIGHT_COST)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `freight_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Number (FREIGHT_INV_NUM)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms (FREIGHT_TERMS)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DDP');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `hazard_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag (HAZ_MAT_FLG)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `is_expedited` SET TAGS ('dbx_business_glossary_term' = 'Expedited Shipment Flag (EXPEDITE_FLG)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `number_of_items` SET TAGS ('dbx_business_glossary_term' = 'Number of Items (ITEM_QTY)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code (ORIG_LOC)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAY_STATUS)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp (RECEIPT_TS)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `scheduled_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Timestamp (SCH_ARR_TS)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp (SCH_DEP_TS)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number (SEAL_NUM)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number (SHPMT_NUM)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status (SHIP_STATUS)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'in_transit|arrived|delayed|exception|cancelled');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Flag (TEMP_CTRL_FLG)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (TEMP_MAX_C)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (TEMP_MIN_C)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode (TRANS_MODE)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'refrigerated_truck|dry_van|ltl|ftl');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `volume_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters) (VOL_CU_M)');
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (KG) (WEIGHT_KG)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` SET TAGS ('dbx_subdomain' = 'logistics_distribution');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Identifier');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Coordinator Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `affected_lot_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot Numbers');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `affected_restaurant_locations` SET TAGS ('dbx_business_glossary_term' = 'Affected Restaurant Locations');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `compliance_fda` SET TAGS ('dbx_business_glossary_term' = 'FDA Compliance Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `compliance_haccp` SET TAGS ('dbx_business_glossary_term' = 'HACCP Compliance Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `compliance_usda` SET TAGS ('dbx_business_glossary_term' = 'USDA Compliance Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|landfill|donation|return_to_supplier|other');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `is_cold_chain_compliant` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliance Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Notes');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'dairy|meat|produce|bakery|beverage|other');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `quantity_recalled` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recalled');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_class` SET TAGS ('dbx_business_glossary_term' = 'Recall Class (Class I, Class II, Class III)');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_class` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recall Closure Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_initiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Reference Number');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_severity` SET TAGS ('dbx_business_glossary_term' = 'Recall Severity');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_severity` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|withdrawn');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Type');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'voluntary|mandated');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'notified|pending|completed');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Recall Risk Score');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Coupa|Zenput|MarketMan|Other');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `temperature_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Deviation Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost of Recalled Product');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|unit|liter|gallon');
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` SET TAGS ('dbx_association_edges' = 'supply.supply_supplier,supply.ingredient');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `approved_vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Item - Approved Vendor Item Id');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Item - Ingredient Id');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Item - Supply Supplier Id');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Approval Status');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost per Unit');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective From');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Until');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lead Time');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Supplier Unit Price');
ALTER TABLE `restaurants_ecm`.`supply`.`approved_vendor_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_financial' = 'true');
