-- Schema for Domain: pricing | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`pricing` COMMENT 'Owns all pricing master data, price determination logic, promotional pricing rules, cost-plus calculations, channel-specific pricing, and price change governance across retail, foodservice, and DTC channels';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_list` (
    `price_list_id` BIGINT COMMENT 'System-generated unique identifier for the price list record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand‑level price lists are created to enforce brand pricing strategy; marketing brand managers need this link for campaign budgeting.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Price‑list creation/approval requires verification of the establishments regulatory registration; compliance report ties price list to establishment_registration.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue posting requires mapping each price list to a GL account for sales revenue recognition per legal entity.',
    `ibp_scenario_id` BIGINT COMMENT 'Foreign key linking to supply.ibp_scenario. Business justification: SCENARIO‑BASED PRICING: price list is tied to an IBP scenario to reflect scenario‑specific cost and margin targets.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Price list ownership is assigned to a pricing manager; required for Price List Ownership report.',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Contract‑based pricing: price lists are derived from supplier purchase contracts to ensure pricing reflects contract terms.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Corporate Sustainability‑Aligned Pricing Strategy links each price list to a specific carbon‑reduction target.',
    `superseded_price_list_id` BIGINT COMMENT 'Self-referencing FK on price_list (superseded_price_list_id)',
    `approval_status` STRING COMMENT 'Governance status of the price list approval workflow.. Valid values are `approved|rejected|under_review|pending`',
    `approved_by` STRING COMMENT 'Name of the person or role that approved the price list.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the price list was approved.',
    `change_reason` STRING COMMENT 'Business justification for the most recent change to the price list.',
    `channel` STRING COMMENT 'Commercial channel(s) to which the price list applies.. Valid values are `retail|foodservice|direct_to_consumer|online|wholesale`',
    `confidentiality_flag` STRING COMMENT 'Data classification level for the price list.. Valid values are `public|internal|confidential|restricted`',
    `cost_plus_percentage` DECIMAL(18,2) COMMENT 'Markup percentage applied to the standard cost to compute the list price.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the price list record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price list amounts.',
    `customer_segment` STRING COMMENT 'Target customer segment for the price list.. Valid values are `consumer|foodservice|enterprise|government|hospitality`',
    `effective_from` DATE COMMENT 'Date when the price list becomes valid.',
    `effective_until` DATE COMMENT 'Date when the price list expires; null for open‑ended.',
    `last_review_date` DATE COMMENT 'Date when the price list was last reviewed for relevance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the price list.',
    `margin_floor_percent` DECIMAL(18,2) COMMENT 'Minimum gross margin percentage required for the price list.',
    `owner` STRING COMMENT 'Business owner or responsible team for the price list.',
    `price_calculation_method` STRING COMMENT 'Algorithm or rule used to derive the list price.. Valid values are `cost_plus|market_based|competitor_based|fixed|tiered`',
    `price_ceiling_amount` DECIMAL(18,2) COMMENT 'Absolute maximum price allowed for any SKU in the list.',
    `price_floor_amount` DECIMAL(18,2) COMMENT 'Absolute minimum price that may be set for any SKU in the list.',
    `price_list_category` STRING COMMENT 'Higher‑level grouping such as core, promotions, or clearance.',
    `price_list_code` STRING COMMENT 'Business‑level unique code assigned to the price list (e.g., PL‑2024‑Q1).',
    `price_list_description` STRING COMMENT 'Free‑form description providing context or notes about the price list.',
    `price_list_name` STRING COMMENT 'Human‑readable name of the price list used for display and reporting.',
    `price_list_status` STRING COMMENT 'Current lifecycle status of the price list.. Valid values are `draft|active|inactive|retired|pending|archived`',
    `price_list_type` STRING COMMENT 'Classification of the price list purpose.. Valid values are `base|promotional|clearance|seasonal|custom`',
    `region` STRING COMMENT 'Region to which the price list is scoped.. Valid values are `NA|EU|APAC|LATAM|MEA`',
    `source_system` STRING COMMENT 'Originating ERP or pricing system (e.g., SAP S/4HANA, Oracle ERP).',
    `version_number` STRING COMMENT 'Incremental version of the price list for change tracking.',
    CONSTRAINT pk_price_list PRIMARY KEY(`price_list_id`)
) COMMENT 'Master record defining authorized base selling prices for SKUs by customer segment, channel (retail, foodservice, DTC), and effective date range. Serves as the SSOT for list price governance across all commercial channels. Captures price list name, version, currency, channel applicability, approval status, and effective/expiry dates. Distinct from sales.price_list which is the commercial-facing view — this domain owns the pricing master governance record including cost-plus build-up, margin floors, and pricing authority approvals.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_list_line` (
    `price_list_line_id` BIGINT COMMENT 'Unique identifier for the price list line record.',
    `carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_footprint. Business justification: Required for Sustainable Pricing Adjustment report that adjusts list price based on SKU carbon intensity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation for each priced SKU line uses a cost center to allocate overhead and production costs in financial reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the price.',
    `packaging_profile_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_profile. Business justification: Used in Packaging Cost Impact analysis to reflect recyclability and material cost in price list decisions.',
    `price_list_id` BIGINT COMMENT 'Identifier of the parent price list that groups this line.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Each price‑list line must be validated against the products registration status; pricing compliance checks use this FK.',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Traceability: price list lines are often tied to a specific purchase contract governing price, lead time, and MOQ.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Pricing team references product specification to apply spec‑based price premiums or discounts in price list lines, a standard process in food & beverage pricing.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Pricing of new SKU lines must reference the originating R&D project for launch coordination and price‑list approval.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU (product) to which this price applies.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Supplier‑specific pricing: each price list line must reference the supplier that provides the SKU under negotiated terms.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to supply.plan_version. Business justification: COST‑PLUS PRICING: each price line references the supply plan version that provides the latest cost base for markup calculations.',
    `superseded_price_list_line_id` BIGINT COMMENT 'Self-referencing FK on price_list_line (superseded_price_list_line_id)',
    `ceiling_price` DECIMAL(18,2) COMMENT 'Maximum allowable price for the SKU under this price list.',
    `channel` STRING COMMENT 'Sales channel for which this price is valid.. Valid values are `retail|foodservice|direct|online|wholesale`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price line record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the price.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage applied to the list price.',
    `effective_end_date` DATE COMMENT 'Date when this price expires; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when this price becomes effective.',
    `floor_price` DECIMAL(18,2) COMMENT 'Minimum allowable price for the SKU under this price list.',
    `line_sequence` STRING COMMENT 'Sequence order of the line within the price list.',
    `list_price` DECIMAL(18,2) COMMENT 'Standard list price before any discounts or promotions.',
    `min_order_qty` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered to qualify for this price.',
    `price_approval_status` STRING COMMENT 'Approval status of the price line.. Valid values are `approved|rejected|pending`',
    `price_change_reason` STRING COMMENT 'Reason for the price change (e.g., cost increase, promotion).',
    `price_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent price change.',
    `price_condition_code` STRING COMMENT 'Code representing any conditional pricing rule (e.g., volume break).',
    `price_currency_rate` DECIMAL(18,2) COMMENT 'Exchange rate to the base currency at the effective date.',
    `price_effective_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the price became effective (if time‑sensitive).',
    `price_expiration_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the price expires.',
    `price_margin_amount` DECIMAL(18,2) COMMENT 'Calculated margin amount for this price.',
    `price_margin_percent` DECIMAL(18,2) COMMENT 'Margin percentage derived from the price.',
    `price_notes` STRING COMMENT 'Free‑text notes regarding the price line.',
    `price_override_flag` BOOLEAN COMMENT 'True if this price overrides default pricing rules.',
    `price_source_system` STRING COMMENT 'Source system that originated the price record.',
    `price_status` STRING COMMENT 'Current lifecycle status of the price line.. Valid values are `active|inactive|pending|expired`',
    `price_tier` STRING COMMENT 'Identifier for tiered pricing structures.',
    `price_type` STRING COMMENT 'Classification of the price (e.g., list, promotional, cost‑plus).. Valid values are `list|promo|cost_plus|tiered|contract|clearance`',
    `price_version` STRING COMMENT 'Version number of the price line for audit tracking.',
    `region_code` STRING COMMENT 'Geographic region code where the price applies.. Valid values are `NA|EU|APAC|LATAM|MEA`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates if the price complies with applicable regulatory constraints.',
    `tax_included_flag` BOOLEAN COMMENT 'Indicates whether tax is included in the price.',
    `uom` STRING COMMENT 'Unit of measure for the price (e.g., each, kilogram).. Valid values are `EA|KG|L|ML|BOX`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price line.',
    CONSTRAINT pk_price_list_line PRIMARY KEY(`price_list_line_id`)
) COMMENT 'Individual SKU-level price record within a price list, capturing the authorized selling price for a specific SKU, unit of measure, and minimum order quantity. Stores list price, floor price, ceiling price, currency, UoM, and effective date range. Enables granular price governance at the SKU level across all active price lists.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_condition` (
    `price_condition_id` BIGINT COMMENT 'Unique identifier for the pricing condition record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer or business partner the condition applies to.',
    `demand_balance_id` BIGINT COMMENT 'Foreign key linking to supply.supply_demand_balance. Business justification: DYNAMIC DISCOUNT RULE: price condition evaluates supply‑demand balance gaps to trigger volume or shortage discounts.',
    `distribution_channel_id` BIGINT COMMENT 'Distribution channel (e.g., retail, foodservice, DTC) for the condition.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Discounts and surcharges defined in price conditions are posted to specific GL accounts for accurate financial impact tracking.',
    `price_group_id` BIGINT COMMENT 'Identifier of the price group used in the condition.',
    `procedure_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_procedure. Business justification: price_condition belongs to a pricing procedure; linking enables hierarchy and lookup of procedure details.',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Contract‑driven conditions: discounts, surcharges, and other price conditions are negotiated in purchase contracts.',
    `raw_material_id` BIGINT COMMENT 'Identifier of the material/product the condition applies to.',
    `sales_organization_id` BIGINT COMMENT 'Sales organization context for the condition.',
    `superseded_price_condition_id` BIGINT COMMENT 'Self-referencing FK on price_condition (superseded_price_condition_id)',
    `change_reason` STRING COMMENT 'Reason code for the most recent change to the condition.',
    `condition_category` STRING COMMENT 'Higher-level category grouping of condition (e.g., price, discount, rebate).',
    `condition_key` STRING COMMENT 'Composite key identifying the condition record (e.g., combination of customer, material, price group).',
    `condition_status` STRING COMMENT 'Current lifecycle status of the condition.. Valid values are `active|inactive|blocked|pending`',
    `condition_type` STRING COMMENT 'Type of pricing condition defining the pricing logic (e.g., base price, discount, surcharge).. Valid values are `PR00|K004|K005|RA01|K007|K008`',
    `condition_version` STRING COMMENT 'Version number of the condition record for change tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the condition record was created.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage if condition is a discount.',
    `is_exclusive` BOOLEAN COMMENT 'Flag indicating if the condition is exclusive (cannot be combined with others).',
    `is_manual` BOOLEAN COMMENT 'Indicates if the condition was entered manually versus system generated.',
    `last_changed_by` STRING COMMENT 'User identifier who last modified the condition.',
    `max_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity threshold for the condition to apply.',
    `min_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity threshold for the condition to apply.',
    `price_condition_description` STRING COMMENT 'Free-text description of the condition purpose or notes.',
    `price_condition_group` STRING COMMENT 'Group identifier for grouping related conditions.',
    `price_condition_source` STRING COMMENT 'Source system or origin of the condition record.',
    `pricing_procedure` STRING COMMENT 'Pricing procedure name that includes this condition.',
    `priority` STRING COMMENT 'Priority order for condition determination when multiple conditions apply.',
    `rate` DECIMAL(18,2) COMMENT 'Monetary rate or amount defined by the condition.',
    `scale_amount` DECIMAL(18,2) COMMENT 'Amount used for scaling calculations.',
    `scale_basis` STRING COMMENT 'Basis for scaling the condition (e.g., quantity thresholds).. Valid values are `quantity|weight|volume|value|percentage`',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Surcharge amount if condition adds a fee.',
    `tax_indicator` STRING COMMENT 'Indicator whether the condition amount is taxable.. Valid values are `taxable|non_taxable|exempt`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the rate (e.g., per unit, per kg).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the last update to the condition record.',
    `validity_end_date` DATE COMMENT 'Date until which the condition is valid (null if open-ended).',
    `validity_start_date` DATE COMMENT 'Date from which the condition is valid.',
    CONSTRAINT pk_price_condition PRIMARY KEY(`price_condition_id`)
) COMMENT 'SAP SD-aligned pricing condition record (Konditionssatz) defining the pricing logic applied during order pricing determination. Captures condition type (PR00, K004, K005, RA01), condition table key combination (customer/material, price group/material, channel/material), rate, currency, UoM, scale basis, and validity period. The atomic unit of price determination in the pricing engine.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`procedure` (
    `procedure_id` BIGINT COMMENT 'System-generated unique identifier for the pricing procedure record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Pricing procedures are defined per legal entity; linking to company code enables entity‑specific pricing rules and compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Pricing procedures are authored by a pricing analyst; tracked for Procedure Creation log.',
    `superseded_procedure_id` BIGINT COMMENT 'Self-referencing FK on procedure (superseded_procedure_id)',
    `allow_discount` BOOLEAN COMMENT 'Specifies if discount conditions may be applied.',
    `allow_surcharge` BOOLEAN COMMENT 'Specifies if surcharge conditions may be applied.',
    `approval_status` STRING COMMENT 'Current approval state of the pricing procedure.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the current version.',
    `calculation_method` STRING COMMENT 'Core algorithm used to compute the net price.. Valid values are `list_price|cost_plus|margin|dynamic`',
    `condition_type_count` STRING COMMENT 'Number of distinct condition types defined in the sequence.',
    `condition_type_sequence` STRING COMMENT 'Ordered list of condition types (steps) applied during price determination, stored as a delimited string.',
    `cost_plus_percentage` DECIMAL(18,2) COMMENT 'Percentage added to standard cost when using a cost‑plus calculation method.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing procedure record was created.',
    `distribution_channel` STRING COMMENT 'Channel (retail, foodservice, direct‑to‑consumer, online) for which the procedure is valid.. Valid values are `retail|foodservice|direct|online`',
    `division` STRING COMMENT 'Business division (e.g., Snacks, Beverages) linked to the procedure.',
    `effective_from` DATE COMMENT 'Date when the pricing procedure becomes active.',
    `effective_until` DATE COMMENT 'Date when the pricing procedure expires (null for open‑ended).',
    `include_freight` BOOLEAN COMMENT 'Indicates whether freight costs are added to the net price.',
    `include_tax` BOOLEAN COMMENT 'Indicates whether tax is included in the net price calculation.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this procedure is the default for its sales org/channel.',
    `max_condition_steps` STRING COMMENT 'Maximum number of steps allowed in the condition sequence.',
    `max_margin_percent` DECIMAL(18,2) COMMENT 'Maximum allowed profit margin expressed as a percentage.',
    `min_margin_percent` DECIMAL(18,2) COMMENT 'Minimum allowed profit margin expressed as a percentage.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the pricing procedure.',
    `price_change_approval_required` BOOLEAN COMMENT 'Indicates if a price change must go through an approval workflow.',
    `price_change_approval_status` STRING COMMENT 'Current status of the price change approval workflow.. Valid values are `pending|approved|rejected`',
    `price_change_approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the price change was approved.',
    `price_change_approver` STRING COMMENT 'User identifier of the approver for the price change.',
    `price_change_effective_date` DATE COMMENT 'Date on which a scheduled price change takes effect.',
    `price_change_history_flag` BOOLEAN COMMENT 'Indicates whether historical price changes are retained for audit.',
    `price_change_notice_days` STRING COMMENT 'Number of days required to notify customers of a price change.',
    `price_change_reason` STRING COMMENT 'Business reason for the price change (e.g., cost increase, promotion).',
    `price_override_allowed` BOOLEAN COMMENT 'Specifies whether sales users may manually override the calculated price.',
    `pricing_currency` STRING COMMENT 'ISO 4217 currency code used for the pricing calculations.. Valid values are `[A-Z]{3}`',
    `procedure_code` STRING COMMENT 'Business code used to reference the pricing procedure in transactions and master data.. Valid values are `^PP[0-9]{4}$`',
    `procedure_description` STRING COMMENT 'Detailed description of the pricing logic and business purpose.',
    `procedure_name` STRING COMMENT 'Human‑readable name of the pricing procedure.',
    `procedure_status` STRING COMMENT 'Current lifecycle status of the pricing procedure.. Valid values are `active|inactive|draft|retired`',
    `procedure_type` STRING COMMENT 'Classification of the procedure (e.g., standard list price, promotional, custom calculation).. Valid values are `standard|promo|custom`',
    `rounding_rule` STRING COMMENT 'Rounding rule applied to the final price.. Valid values are `up|down|nearest`',
    `sales_organization` STRING COMMENT 'Sales organization to which the pricing procedure applies.',
    `updated_by` STRING COMMENT 'System user who performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Sequential version of the pricing procedure for change management.',
    `created_by` STRING COMMENT 'System user who initially created the record.',
    CONSTRAINT pk_procedure PRIMARY KEY(`procedure_id`)
) COMMENT 'Master record defining the pricing procedure (calculation schema) used to determine the net selling price for a sales transaction. Captures procedure name, description, applicable sales organization, distribution channel, division, and the ordered sequence of condition types (steps) applied during price determination. Governs how list price, discounts, surcharges, freight, and taxes are combined to arrive at net price.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`procedure_step` (
    `procedure_step_id` BIGINT COMMENT 'Unique surrogate key for each step within a pricing procedure.',
    `capacity_constraint_id` BIGINT COMMENT 'Foreign key linking to supply.capacity_constraint. Business justification: SURCHARGE CALCULATION: procedure step uses capacity constraint data to apply surcharges when lane capacity is limited.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each step in a pricing procedure is created by a specific employee; needed for Step Ownership reporting.',
    `procedure_id` BIGINT COMMENT 'Identifier of the parent pricing procedure to which this step belongs.',
    `reference_procedure_step_id` BIGINT COMMENT 'Self-referencing FK on procedure_step (reference_procedure_step_id)',
    `account_key` STRING COMMENT 'Key that determines which GL account the pricing result posts to.',
    `active_status` STRING COMMENT 'Current lifecycle status of the step.. Valid values are `active|inactive|deleted`',
    `calculation_type` STRING COMMENT 'Method used to calculate the price impact (e.g., percentage, fixed amount).. Valid values are `percentage|fixed_amount|formula|lookup`',
    `calculation_value` DECIMAL(18,2) COMMENT 'Numeric value used by the calculation type (e.g., 5.0 for 5%).',
    `condition_operator` STRING COMMENT 'Logical operator used to evaluate the condition (e.g., =, >, <).. Valid values are `=|>|<|>=|<=`',
    `condition_type` STRING COMMENT 'Type of pricing condition applied in this step (e.g., discount, surcharge).. Valid values are `discount|surcharge|rebate|price_change|tax|fee`',
    `condition_value` DECIMAL(18,2) COMMENT 'Numeric value against which the condition is evaluated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the step record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code applicable to monetary values in the step.',
    `effective_from` DATE COMMENT 'Date from which the step becomes valid.',
    `effective_until` DATE COMMENT 'Date after which the step is no longer valid (null for open‑ended).',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the step must be executed for the pricing procedure to be valid.',
    `printed_flag` BOOLEAN COMMENT 'Indicates whether the step should be displayed on pricing condition printouts.',
    `priority` STRING COMMENT 'Numeric priority used when multiple steps have the same sequence; lower numbers run first.',
    `procedure_step_description` STRING COMMENT 'Free‑form description of the step purpose and behavior.',
    `requirement_routine` STRING COMMENT 'Name of the ABAP routine that evaluates additional business logic for the step.',
    `source_system` STRING COMMENT 'System of origin for the step record (e.g., SAP, Oracle).',
    `statistical_flag` BOOLEAN COMMENT 'True if the step is used only for statistical reporting and does not affect the price.',
    `step_category` STRING COMMENT 'Broad classification of the step (e.g., condition, calculation, output).',
    `step_name` STRING COMMENT 'Human‑readable name or label for the pricing step.',
    `step_sequence` STRING COMMENT 'Numeric order of the step within the pricing procedure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the step record.',
    `version_number` STRING COMMENT 'Version identifier for change management of the step definition.',
    CONSTRAINT pk_procedure_step PRIMARY KEY(`procedure_step_id`)
) COMMENT 'Individual step within a pricing procedure defining the sequence, condition type, from/to reference steps, requirement routine, calculation type, account key, and whether the step is mandatory, statistical, or printed. Enables full reconstruction of the pricing calculation schema for audit and troubleshooting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`channel_price` (
    `channel_price_id` BIGINT COMMENT 'System-generated unique identifier for the channel price record.',
    `sku_id` BIGINT COMMENT 'Unique product identifier used for inventory and sales tracking.',
    `superseded_channel_price_id` BIGINT COMMENT 'Self-referencing FK on channel_price (superseded_channel_price_id)',
    `channel_code` STRING COMMENT 'Code representing the commercial channel (e.g., retail, foodservice, direct-to-consumer).. Valid values are `retail|foodservice|dtc|club|convenience|vending`',
    `channel_price_status` STRING COMMENT 'Current lifecycle status of the price record.. Valid values are `active|inactive|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the price record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the net price.. Valid values are `USD|CAD|EUR|GBP|JPY|MXN`',
    `effective_end_date` DATE COMMENT 'Last calendar date on which the price is valid; null indicates an open‑ended price.',
    `effective_start_date` DATE COMMENT 'First calendar date on which the price becomes valid.',
    `minimum_order_quantity` STRING COMMENT 'Minimum quantity that must be ordered to qualify for the channel price.',
    `net_price` DECIMAL(18,2) COMMENT 'Authorized selling price for the SKU in the specified channel, expressed in the transaction currency.',
    `notes` STRING COMMENT 'Additional free‑form comments or business rules associated with the price.',
    `price_change_reason` STRING COMMENT 'Free‑text explanation for why the price was changed (e.g., cost increase, promotion launch).',
    `price_source` STRING COMMENT 'Origin of the price calculation method (e.g., cost‑plus, everyday low price, promotional, negotiated).. Valid values are `cost_plus|edlp|promo|negotiated`',
    `price_tier` STRING COMMENT 'Classification of the price level (e.g., standard, premium, discount, promotional).. Valid values are `standard|premium|discount|promo`',
    `price_type` STRING COMMENT 'Indicates whether the amount is a net price, list price, or promotional price.. Valid values are `net|list|promo`',
    `price_version` STRING COMMENT 'Sequential version number for the price record, incremented on each change.',
    `uom` STRING COMMENT 'Unit in which the net price is expressed (e.g., each, case, kilogram).. Valid values are `each|case|kg|lb|liter|gallon`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the price record.',
    CONSTRAINT pk_channel_price PRIMARY KEY(`channel_price_id`)
) COMMENT 'Channel-specific net price record capturing the authorized selling price for a SKU within a specific commercial channel (retail, foodservice, DTC, club, convenience, vending). Stores channel code, SKU, net price, currency, UoM, effective date range, and channel pricing tier. Enables channel-differentiated pricing strategies including EDLP (Everyday Low Price) for retail vs. cost-plus for foodservice vs. DTC direct pricing.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` (
    `cost_plus_model_id` BIGINT COMMENT 'Unique surrogate key for the cost-plus pricing model record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cost‑plus models require approval by a pricing manager; needed for Model Approval compliance report.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost‑plus models allocate costs to a cost center to reflect internal cost allocation for margin calculations.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: cost_plus_model is defined per price list; linking provides context and removes duplicated channel attribute.',
    `superseded_cost_plus_model_id` BIGINT COMMENT 'Self-referencing FK on cost_plus_model (superseded_cost_plus_model_id)',
    `applicable_product_category` STRING COMMENT 'Product category or segment to which the model is applicable.. Valid values are `snack|beverage|dairy|frozen|prepared_meal`',
    `approval_status` STRING COMMENT 'Governance status indicating whether the model has been approved for use.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the model.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the model received approval.',
    `cost_plus_model_description` STRING COMMENT 'Free‑form description of the model purpose, assumptions, and scope.',
    `cost_plus_model_status` STRING COMMENT 'Current lifecycle state of the pricing model.. Valid values are `draft|active|inactive|archived`',
    `cost_source_code` BIGINT COMMENT 'Reference to the standard cost record used as the base cost for this model.',
    `cost_type` STRING COMMENT 'Type of cost used as the base for markup calculations.. Valid values are `standard_cost|moving_average|contract_cost`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the model record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary values. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|MXN|JPY|CNY|AUD|CHF|SEK|NZD — promote to reference product]',
    `effective_from` DATE COMMENT 'Date when the cost-plus model becomes active.',
    `effective_until` DATE COMMENT 'Date when the model expires or is superseded; null if open‑ended.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this model is the default for its channel and category.',
    `last_review_date` DATE COMMENT 'Date when the model was last reviewed for relevance and accuracy.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'Percentage markup applied to the base cost to derive the target price.',
    `maximum_price` DECIMAL(18,2) COMMENT 'Ceiling price that the model will not exceed.',
    `minimum_price` DECIMAL(18,2) COMMENT 'Floor price enforced by the model to prevent under‑pricing.',
    `model_code` STRING COMMENT 'Unique alphanumeric code assigned to the pricing model for reference in ERP and pricing systems.',
    `model_name` STRING COMMENT 'Descriptive name of the cost-plus pricing model used by pricing analysts.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments from pricing analysts.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the model has been validated against FDA/USDA pricing regulations.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory model reviews.',
    `target_contribution_margin_percent` DECIMAL(18,2) COMMENT 'Desired contribution margin percentage for the SKU or product category.',
    `target_gross_margin_percent` DECIMAL(18,2) COMMENT 'Desired gross margin percentage that the model aims to achieve.',
    `updated_by` STRING COMMENT 'System user identifier that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the model record.',
    `version_number` STRING COMMENT 'Incremental version of the pricing model for change management.',
    `created_by` STRING COMMENT 'System user identifier that created the model record.',
    CONSTRAINT pk_cost_plus_model PRIMARY KEY(`cost_plus_model_id`)
) COMMENT 'Cost-plus pricing model master record defining the markup methodology applied to COGS to derive target selling prices for a SKU or product category. Captures model name, applicable channel, base cost type (standard cost, moving average, contract cost), markup percentage, target gross margin %, target contribution margin %, and approval status. Links to finance standard cost for COGS input and drives floor price governance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`promotional_price` (
    `promotional_price_id` BIGINT COMMENT 'System-generated unique identifier for each promotional price record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: REQUIRED: Link promotional pricing to the specific customer account it targets; essential for account‑specific promotion execution and reporting.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotional prices are defined per marketing campaign to ensure compliance with FTC/FDA claims and budget tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Promotions are created by marketing employees; tracked for Promotion Creation audit.',
    `label_approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_approval. Business justification: Promotions involving marketing claims need label approval verification; regulatory label approval is linked to promotional_price.',
    `sku_id` BIGINT COMMENT 'Unique product identifier (SKU, UPC, GTIN) to which the promotional price applies.',
    `superseded_promotional_price_id` BIGINT COMMENT 'Self-referencing FK on promotional_price (superseded_promotional_price_id)',
    `channel` STRING COMMENT 'Channel where the promotion is offered: retail stores, food‑service, direct‑to‑consumer, or online.. Valid values are `RETAIL|FOOD_SERVICE|DTC|ONLINE`',
    `created_by_user` STRING COMMENT 'User identifier who created the promotional price record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotional price record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the promotional price.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `customer_segment` STRING COMMENT 'Targeted customer segment for the promotion.. Valid values are `CONSUMER|HOSPITALITY|GROCERY|DISCOUNT`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute monetary discount applied to the base price.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base price.',
    `effective_end_date` DATE COMMENT 'Date when the promotional price expires.',
    `effective_start_date` DATE COMMENT 'Date when the promotional price becomes active.',
    `minimum_quantity` STRING COMMENT 'Minimum quantity a customer must buy to qualify for the promotion.',
    `price_type` STRING COMMENT 'Indicates whether the promotional price is net, list, or gross.. Valid values are `NET|LIST|GROSS`',
    `price_uom` STRING COMMENT 'Unit of measure for the promotional price (per unit, per weight, per volume).. Valid values are `PER_UNIT|PER_WEIGHT|PER_VOLUME`',
    `promotion_category` STRING COMMENT 'High‑level category of the promotion for reporting and analytics.. Valid values are `PRICE_REDUCTION|VOLUME_INCENTIVE|DISPLAY`',
    `promotion_code` STRING COMMENT 'Business identifier code assigned to the promotion for tracking and reference.',
    `promotion_description` STRING COMMENT 'Detailed description of the promotion, including marketing copy and conditions.',
    `promotion_name` STRING COMMENT 'Human‑readable name describing the promotion.',
    `promotion_source_system` STRING COMMENT 'Originating system that created the promotional price record.. Valid values are `SAP|ORACLE|SALESFORCE|CUSTOM`',
    `promotion_status` STRING COMMENT 'Current lifecycle status of the promotion.. Valid values are `ACTIVE|INACTIVE|EXPIRED|PENDING`',
    `promotion_type` STRING COMMENT 'Category of promotion such as Temporary Price Reduction (TPR), Buy‑One‑Get‑One (BOGO), multi‑buy, scan‑down, or display pricing.. Valid values are `TPR|BOGO|MULTI_BUY|SCAN_DOWN|DISPLAY`',
    `promotional_price` DECIMAL(18,2) COMMENT 'Discounted price offered during the promotion, expressed in the transaction currency.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the promotion complies with FDA/USDA labeling and pricing regulations.',
    `updated_by_user` STRING COMMENT 'User identifier who last updated the promotional price record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the promotional price record.',
    CONSTRAINT pk_promotional_price PRIMARY KEY(`promotional_price_id`)
) COMMENT 'Promotional pricing record capturing time-limited price reductions, TPR (Temporary Price Reductions), feature/display pricing, and deal pricing applied to SKUs for specific customers or channels. Captures promotion type (TPR, BOGO, multi-buy, scan-down), promotional price, discount amount/percentage, minimum purchase quantity, effective start/end dates, and redemption channel. Distinct from trade.promotion_event which tracks the trade promotion execution — this record owns the promotional price point itself.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_scale` (
    `price_scale_id` BIGINT COMMENT 'System-generated unique identifier for the price scale record.',
    `price_list_line_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_line. Business justification: price_scale applies to specific price list lines; linking eliminates redundant channel and segment data.',
    `parent_price_scale_id` BIGINT COMMENT 'Self-referencing FK on price_scale (parent_price_scale_id)',
    `base_price` DECIMAL(18,2) COMMENT 'Price applied to the lowest tier or default when no tier matches.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price scale record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price values (e.g., USD, EUR).',
    `discount_type` STRING COMMENT 'Method of discount applied in tiers – percentage or fixed amount.',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount (percentage or amount) applied at tier level.',
    `effective_from` DATE COMMENT 'Date when the price scale becomes valid for transactions.',
    `effective_until` DATE COMMENT 'Date when the price scale expires; null for open‑ended.',
    `is_promotional` BOOLEAN COMMENT 'Indicates whether the price scale is part of a promotional pricing program.',
    `price_change_approval_date` DATE COMMENT 'Date on which the price scale change was approved.',
    `price_change_approved_by` STRING COMMENT 'Identifier of the manager who approved the price scale change.',
    `price_change_reason` STRING COMMENT 'Reason documented for creating or modifying the price scale (e.g., cost‑plus, market response).',
    `price_scale_description` STRING COMMENT 'Free‑form description providing context or business rules for the price scale.',
    `price_scale_status` STRING COMMENT 'Current lifecycle status of the price scale.. Valid values are `active|inactive|pending|retired`',
    `scale_basis` STRING COMMENT 'Metric on which the tiering is based: quantity of units, weight, or monetary value.. Valid values are `quantity|weight|value`',
    `scale_code` STRING COMMENT 'Business code used to reference the price scale in ERP and pricing systems.',
    `scale_name` STRING COMMENT 'Human‑readable name describing the price scale (e.g., "Volume Discount Tier 1").',
    `scale_type` STRING COMMENT 'Method of tier calculation – graduated (incremental) or from‑value (single break).. Valid values are `graduated|from_value`',
    `tier_count` STRING COMMENT 'Total number of tier lines defined for this price scale.',
    `unit_of_measure` STRING COMMENT 'Unit used for the scale basis (e.g., each, kg, liter).',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the price scale.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price scale record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the price scale.',
    CONSTRAINT pk_price_scale PRIMARY KEY(`price_scale_id`)
) COMMENT 'Volume-based price scale (tiered pricing) record defining quantity break thresholds and corresponding unit prices or discount rates for a SKU or product group. Captures scale basis (quantity, weight, value), scale type (graduated, from-value), scale lines with lower bound quantities and corresponding prices/discounts, and applicable customer segment or channel. Enables volume incentive pricing and quantity discount structures.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_change_request` (
    `price_change_request_id` BIGINT COMMENT 'System-generated unique identifier for the price change request.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: REQUIRED: Price change requests are initiated for a particular customer account; linking enables request tracking and impact analysis.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved or rejected the request.',
    `non_conformance_id` BIGINT COMMENT 'Foreign key linking to quality.non_conformance. Business justification: When a quality non‑conformance occurs, a price change request may be issued to reflect discounts or compensation, linking the request to the non‑conformance record.',
    `primary_price_employee_id` BIGINT COMMENT 'Identifier of the employee who originated the price change request.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Price change requests are evaluated for regulatory compliance against the products registration record.',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Price change requests originate from contract renegotiations; linking ensures request is tied to the governing contract.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Price change requests for new/reformulated products stem from R&D updates; linking ensures traceability for finance and compliance.',
    `superseded_price_change_request_id` BIGINT COMMENT 'Self-referencing FK on price_change_request (superseded_price_change_request_id)',
    `channel` STRING COMMENT 'Distribution channel(s) to which the price change applies.. Valid values are `retail|foodservice|direct|online`',
    `competitive_rationale` STRING COMMENT 'Explanation of competitive pressures or market conditions driving the price change.',
    `cost_plus_percentage` DECIMAL(18,2) COMMENT 'Percentage markup over cost used to calculate the proposed price, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the request record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the price values.. Valid values are `^[A-Z]{3}$`',
    `current_price` DECIMAL(18,2) COMMENT 'Existing price before the change is applied.',
    `effective_date` DATE COMMENT 'Date on which the approved price change becomes active in the market.',
    `forecasted_margin_impact` DECIMAL(18,2) COMMENT 'Projected change in gross margin dollars resulting from the price change.',
    `forecasted_sales_impact` DECIMAL(18,2) COMMENT 'Projected change in sales volume attributable to the price change.',
    `justification_text` STRING COMMENT 'Narrative explanation of the business reason for the price change.',
    `margin_impact_percent` DECIMAL(18,2) COMMENT 'Estimated impact on gross margin expressed as a percentage of sales.',
    `market_segment` STRING COMMENT 'Target consumer segment for the price change.. Valid values are `mass|premium|value|organic`',
    `price_ceiling` DECIMAL(18,2) COMMENT 'Maximum allowable price for the SKU(s) based on market or regulatory limits.',
    `price_change_amount` DECIMAL(18,2) COMMENT 'Numeric difference between proposed and current price (positive for increase, negative for decrease).',
    `price_change_request_status` STRING COMMENT 'Current workflow state of the price change request.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `price_floor` DECIMAL(18,2) COMMENT 'Minimum allowable price for the SKU(s) based on policy or cost constraints.',
    `proposed_price` DECIMAL(18,2) COMMENT 'New price being requested for the affected SKU(s).',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region for the price change.. Valid values are `^[A-Z]{3}$`',
    `request_number` STRING COMMENT 'Human‑readable business identifier for the request, often used in communications and approvals.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the price change request was initially submitted.',
    `request_type` STRING COMMENT 'Classification of the price change (e.g., new price, increase, decrease, promotional).. Valid values are `new|increase|decrease|promotional`',
    `sku_count` STRING COMMENT 'Number of distinct SKUs impacted by this request.',
    `total_sku_quantity` STRING COMMENT 'Aggregate quantity of all affected SKUs (e.g., total units) referenced in the request.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the request record.',
    CONSTRAINT pk_price_change_request PRIMARY KEY(`price_change_request_id`)
) COMMENT 'Price change governance record capturing the full lifecycle of a proposed price change from initiation through approval and activation. Captures requestor, change type (new price, price increase, price decrease, promotional), affected SKUs, affected channels/customers, proposed price, current price, effective date, business justification, margin impact, competitive rationale, and approval workflow status. Enforces pricing governance and change control across the organization.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_approval` (
    `price_approval_id` BIGINT COMMENT 'Unique identifier for the price approval record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who made the approval decision.',
    `price_change_request_id` BIGINT COMMENT 'Business identifier for the price change request.',
    `primary_price_employee_id` BIGINT COMMENT 'Identifier of the employee who submitted the price change request.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Price approval workflow checks product registration compliance before finalizing a price change.',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Approval workflow must reference the purchase contract that defines the price being approved.',
    `escalated_from_price_approval_id` BIGINT COMMENT 'Self-referencing FK on price_approval (escalated_from_price_approval_id)',
    `approval_deadline` DATE COMMENT 'Date by which the approval must be completed.',
    `approver_role` STRING COMMENT 'Organizational role of the approver within the pricing governance hierarchy.. Valid values are `manager|director|vp|cfo`',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the detailed audit log entry for this approval.',
    `channel` STRING COMMENT 'Channel to which the price change applies.. Valid values are `retail|foodservice|dtc`',
    `comments` STRING COMMENT 'Free‑text comments provided by the approver.',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the price change passed internal compliance validation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the approval record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price values.. Valid values are `^[A-Z]{3}$`',
    `decision` STRING COMMENT 'Final decision taken for the price change request.. Valid values are `approved|rejected|escalated`',
    `decision_timestamp` TIMESTAMP COMMENT 'Timestamp when the approval decision was recorded.',
    `delegation_flag` BOOLEAN COMMENT 'Indicates whether the approval was delegated to another approver.',
    `effective_date` DATE COMMENT 'Date when the new price becomes effective.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the request was escalated beyond the current approver.',
    `escalation_reason` STRING COMMENT 'Reason provided for escalating the price change request.',
    `new_price` DECIMAL(18,2) COMMENT 'Price amount after the change.',
    `previous_price` DECIMAL(18,2) COMMENT 'Price amount before the change.',
    `price_approval_status` STRING COMMENT 'Current lifecycle status of the approval workflow.. Valid values are `pending|approved|rejected|escalated`',
    `price_change_amount` DECIMAL(18,2) COMMENT 'Monetary difference between new and previous price.',
    `price_change_category` STRING COMMENT 'Higher‑level categorization of the price change.. Valid values are `standard|special|seasonal`',
    `price_change_impact_currency` STRING COMMENT 'Currency code for the impact estimate.. Valid values are `^[A-Z]{3}$`',
    `price_change_impact_description` STRING COMMENT 'Narrative description of the estimated impact.',
    `price_change_impact_estimate` DECIMAL(18,2) COMMENT 'Projected financial impact (e.g., revenue effect) of the price change.',
    `price_change_justification` STRING COMMENT 'Detailed narrative explaining the business need for the price adjustment.',
    `price_change_percentage` DECIMAL(18,2) COMMENT 'Percentage change between new and previous price.',
    `price_change_reason` STRING COMMENT 'Business justification for the price adjustment.',
    `price_change_type` STRING COMMENT 'Classification of the price change rationale.. Valid values are `cost_plus|promotional|markdown|clearance`',
    `request_source` STRING COMMENT 'Origin of the price change request.. Valid values are `system|manual|api`',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp when the price change request was submitted.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the approval record.',
    CONSTRAINT pk_price_approval PRIMARY KEY(`price_approval_id`)
) COMMENT 'Approval workflow record for price change requests, capturing each approval step, approver identity, approval level (manager, director, VP, CFO), decision (approved, rejected, escalated), decision date, comments, and delegation details. Provides full audit trail for pricing governance and SOX compliance on price change authorization.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` (
    `pricing_price_history_id` BIGINT COMMENT 'System-generated unique identifier for each price change history record.',
    `price_change_request_id` BIGINT COMMENT 'Identifier of the originating price change request.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Historical price changes are audited for compliance; linking to product_registration enables traceability.',
    `sku_id` BIGINT COMMENT 'Unique identifier of the SKU whose price changed.',
    `previous_pricing_price_history_id` BIGINT COMMENT 'Self-referencing FK on pricing_price_history (previous_pricing_price_history_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the price change was approved.',
    `approved_by` STRING COMMENT 'User identifier of the approver.',
    `change_amount` DECIMAL(18,2) COMMENT 'Absolute difference between new price and previous price.',
    `change_percent` DECIMAL(18,2) COMMENT 'Percentage change between new price and previous price.',
    `change_reason_code` STRING COMMENT 'Standardized code describing why the price was changed.. Valid values are `cost_increase|promotion|competitor|regulatory|seasonal|other`',
    `channel_code` STRING COMMENT 'Code representing the sales channel where the price is applied.. Valid values are `retail|foodservice|direct_to_consumer|online|wholesale|partner`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price history record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price values.',
    `customer_segment_code` STRING COMMENT 'Code indicating the customer segment or market segment for the price.. Valid values are `consumer|foodservice|industrial|government|private_label|other`',
    `effective_date` DATE COMMENT 'Date on which the new price becomes effective.',
    `event_source` STRING COMMENT 'Source system that generated the price change event.. Valid values are `SAP|Oracle|Custom|Salesforce|JDA|MES`',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the price change event was recorded in the system.',
    `event_type` STRING COMMENT 'Classification of the event; always price_change for this table.. Valid values are `price_change`',
    `expiry_date` DATE COMMENT 'Date on which the price ceases to be valid; null if open‑ended.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this price record is currently active (true) or superseded (false).',
    `new_price` DECIMAL(18,2) COMMENT 'Price of the SKU after the change, expressed in the base currency.',
    `previous_price` DECIMAL(18,2) COMMENT 'Price of the SKU before the change, expressed in the base currency.',
    `price_change_approval_status` STRING COMMENT 'Current approval status of the price change request.. Valid values are `pending|approved|rejected`',
    `price_change_category` STRING COMMENT 'High‑level category describing the pricing strategy applied.. Valid values are `cost_plus|margin_based|competitive|strategic|regulatory|other`',
    `price_change_method` STRING COMMENT 'Method by which the price change was applied.. Valid values are `manual|system|batch`',
    `price_change_notes` STRING COMMENT 'Free‑form notes explaining context or details of the price change.',
    `price_change_origin` STRING COMMENT 'Origin of the price change request (internal business decision or external mandate).. Valid values are `internal|external`',
    `price_type` STRING COMMENT 'Classification of the price (e.g., regular, promotional, clearance).. Valid values are `regular|promotional|clearance|seasonal|contract|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price history record.',
    `created_by` STRING COMMENT 'User identifier of the person or process that created the record.',
    CONSTRAINT pk_pricing_price_history PRIMARY KEY(`pricing_price_history_id`)
) COMMENT 'Historical price change audit record capturing every price change event for a SKU across all channels and customer segments. Stores previous price, new price, change amount, change percentage, effective date, expiry date, change reason code, and the originating price change request reference. Enables price trend analysis, regulatory audit support, and competitive pricing benchmarking over time.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` (
    `customer_price_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the customer price agreement record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer party to which the agreement applies.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: customer_price_agreement is scoped to a price zone; linking removes duplicated region and channel fields.',
    `sku_id` BIGINT COMMENT 'Identifier of the product or SKU covered by the agreement.',
    `renewed_customer_price_agreement_id` BIGINT COMMENT 'Self-referencing FK on customer_price_agreement (renewed_customer_price_agreement_id)',
    `agreement_number` STRING COMMENT 'External reference number or code assigned to the pricing agreement.',
    `agreement_type` STRING COMMENT 'Classification of the agreement (e.g., contract, blanket, spot, volume).. Valid values are `contract|blanket|spot|volume`',
    `approval_status` STRING COMMENT 'Current approval state of the agreement.. Valid values are `approved|rejected|pending`',
    `approved_by` STRING COMMENT 'Name or identifier of the user who approved the agreement.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the agreement was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the agreement record was created.',
    `customer_price_agreement_status` STRING COMMENT 'Current lifecycle status of the pricing agreement.. Valid values are `active|inactive|pending|draft|terminated`',
    `discount_type` STRING COMMENT 'Method used to calculate the discount (percentage, fixed amount, or none).. Valid values are `percentage|amount|none`',
    `discount_value` DECIMAL(18,2) COMMENT 'Value of the discount expressed as a percentage or fixed amount, based on discount_type.',
    `effective_from` DATE COMMENT 'Date when the agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date when the agreement expires or is terminated (null for open‑ended).',
    `min_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that can be ordered per transaction under the agreement.',
    `net_price` DECIMAL(18,2) COMMENT 'Negotiated net price per unit after discounts.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks related to the agreement.',
    `price_agreement_effective_quantity_max` DECIMAL(18,2) COMMENT 'Maximum quantity threshold for the price to apply.',
    `price_agreement_effective_quantity_min` DECIMAL(18,2) COMMENT 'Minimum quantity threshold for the price to apply.',
    `price_agreement_revision` STRING COMMENT 'Revision sequence within a version, used for minor updates.',
    `price_agreement_scope` STRING COMMENT 'Geographic scope of the agreement (global, regional, or local).. Valid values are `global|regional|local`',
    `price_agreement_target_customer_type` STRING COMMENT 'Category of the customer party (retailer, foodservice, distributor, etc.).. Valid values are `retailer|foodservice|distributor|other`',
    `price_agreement_version` STRING COMMENT 'Version number of the agreement record for change tracking.',
    `price_basis` STRING COMMENT 'Underlying methodology used to calculate the price (cost‑plus, market, list, or custom).. Valid values are `cost_plus|market|list|custom`',
    `price_change_reason` STRING COMMENT 'Free‑text explanation for any price adjustments made during the agreement lifecycle.',
    `price_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the net price.',
    `price_margin_percent` DECIMAL(18,2) COMMENT 'Target margin percentage applied to the base cost to derive the net price.',
    `price_source_system` STRING COMMENT 'Source system where the price agreement originated.. Valid values are `SAP|Oracle|Salesforce|Custom|Other`',
    `price_tax_included` BOOLEAN COMMENT 'Indicates whether tax is already included in the net price.',
    `price_tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (percentage) for the agreement.',
    `price_tier_description` STRING COMMENT 'Human‑readable description of the price tier.',
    `price_tier_level` STRING COMMENT 'Numeric tier identifier for tiered pricing structures.',
    `price_uom` STRING COMMENT 'Unit of measure for the net price (e.g., per case, per kilogram, per liter).. Valid values are `per_case|per_kg|per_liter`',
    `price_validity_status` STRING COMMENT 'Current validity state of the price (e.g., current, expired, upcoming).. Valid values are `current|expired|upcoming`',
    `renewal_date` DATE COMMENT 'Scheduled date for agreement renewal, if applicable.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement is set for automatic renewal.',
    `termination_reason` STRING COMMENT 'Reason provided for early termination or non‑renewal of the agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the agreement.',
    `volume_commitment` DECIMAL(18,2) COMMENT 'Minimum purchase volume the customer commits to under the agreement.',
    CONSTRAINT pk_customer_price_agreement PRIMARY KEY(`customer_price_agreement_id`)
) COMMENT 'Customer-specific pricing agreement record capturing negotiated net prices, special pricing arrangements, and contract pricing for key accounts (retailers, foodservice chains, distributors). Captures customer account, SKU or product group, agreed net price, discount structure, volume commitment, effective date range, agreement type (contract, blanket, spot), and approval status. Distinct from sales.contract (commercial agreement) — this record owns the specific price terms within that agreement.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_exception` (
    `price_exception_id` BIGINT COMMENT 'System-generated unique identifier for the pricing exception record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or user who approved the pricing exception.',
    `order_id` BIGINT COMMENT 'Reference to the sales order associated with the pricing exception.',
    `price_list_id` BIGINT COMMENT 'Reference to the authorized price list or contract governing the transaction.',
    `sku_id` BIGINT COMMENT 'Identifier of the product or SKU affected by the pricing exception.',
    `pos_transaction_id` BIGINT COMMENT 'Reference to the underlying transaction (e.g., invoice) where the exception applied.',
    `related_price_exception_id` BIGINT COMMENT 'Self-referencing FK on price_exception (related_price_exception_id)',
    `approval_date` DATE COMMENT 'Date on which the exception was formally approved.',
    `channel` STRING COMMENT 'Channel through which the transaction occurred (retail, foodservice, direct‑to‑consumer).. Valid values are `retail|foodservice|direct_to_consumer`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the exception complies with internal pricing governance policies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the exception amount.. Valid values are `[A-Z]{3}`',
    `effective_date` DATE COMMENT 'Date from which the approved exception becomes effective.',
    `exception_amount` DECIMAL(18,2) COMMENT 'Monetary deviation amount from the authorized price.',
    `exception_code` STRING COMMENT 'Business identifier assigned to the exception for external reference and tracking.',
    `exception_percentage` DECIMAL(18,2) COMMENT 'Percentage deviation of the transaction price from the authorized price.',
    `exception_reason_code` STRING COMMENT 'Standardized code representing the underlying reason for the exception.',
    `exception_timestamp` TIMESTAMP COMMENT 'Exact date and time when the pricing exception was recorded.',
    `exception_type` STRING COMMENT 'Category of the pricing deviation (e.g., below floor price, above ceiling price, outside agreement).. Valid values are `below_floor|above_ceiling|outside_agreement`',
    `expiration_date` DATE COMMENT 'Date after which the exception is no longer valid, if applicable.',
    `is_manual_override` BOOLEAN COMMENT 'Indicates whether the exception required a manual price override.',
    `justification` STRING COMMENT 'Business reason provided for granting the pricing exception.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the exception.',
    `price_exception_status` STRING COMMENT 'Current lifecycle status of the pricing exception.. Valid values are `pending|approved|rejected|revoked`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the exception record.',
    CONSTRAINT pk_price_exception PRIMARY KEY(`price_exception_id`)
) COMMENT 'Record of approved pricing exceptions where a transaction price deviates from the authorized price list or customer price agreement. Captures exception type (below floor price, above ceiling, outside agreement), exception amount, exception percentage, business justification, approver, approval date, and the specific order or transaction reference. Enables exception tracking, leakage identification, and pricing discipline enforcement.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`competitor_price` (
    `competitor_price_id` BIGINT COMMENT 'System-generated unique identifier for each competitor price observation record.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: competitor_price observations are tied to a geographic price zone; linking enables zone‑based analysis.',
    `store_id` BIGINT COMMENT 'Internal identifier of the specific store or location where the price was captured.',
    `previous_competitor_price_id` BIGINT COMMENT 'Self-referencing FK on competitor_price (previous_competitor_price_id)',
    `competitor_name` STRING COMMENT 'Legal name of the competitor brand or company offering the observed product.',
    `competitor_sku_code` STRING COMMENT 'Identifier used by the competitor for the product (e.g., UPC, GTIN, SKU).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price record was first loaded into the data lake.',
    `data_capture_method` STRING COMMENT 'Method used to capture the price observation.. Valid values are `scan|manual|automated`',
    `effective_end_date` DATE COMMENT 'Date when the observed price ceased to be effective (if known).',
    `effective_start_date` DATE COMMENT 'Date when the observed price became effective for the competitor.',
    `geography_region` STRING COMMENT 'Broad geographic region (e.g., North America, EMEA) for analytical grouping.',
    `is_promotion` BOOLEAN COMMENT 'Indicates whether the observed price is a promotional price (true) or regular price (false).',
    `notes` STRING COMMENT 'Free‑form comments or observations about the price record.',
    `observation_timestamp` TIMESTAMP COMMENT 'Date and time when the competitor price was captured.',
    `observed_price` DECIMAL(18,2) COMMENT 'Base retail price observed for the competitor product (excluding promotions).',
    `price_change_reason` STRING COMMENT 'Business reason for the price change (e.g., seasonal, cost‑plus, competitor action).',
    `price_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code of the observed price.. Valid values are `^[A-Z]{3}$`',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Derived price per standard unit (e.g., per ounce, per liter).',
    `price_per_volume` DECIMAL(18,2) COMMENT 'Derived price per volume measure where applicable.',
    `price_source` STRING COMMENT 'Origin of the price data (e.g., Nielsen, IRI, field observation, web scrape).. Valid values are `Nielsen|IRI|Field|WebScrape`',
    `price_status` STRING COMMENT 'Current status of the observed price record.. Valid values are `active|inactive|discontinued`',
    `price_uom` STRING COMMENT 'Unit of measure for the price (e.g., per unit, per ounce, per liter).. Valid values are `per_unit|per_oz|per_liter|per_kg|per_gallon`',
    `product_category` STRING COMMENT 'High‑level category or segment to which the observed product belongs.',
    `product_name` STRING COMMENT 'Descriptive name of the product observed in the competitors offering.',
    `promotion_type` STRING COMMENT 'Classification of the promotion applied to the price.. Valid values are `discount|bogo|bundle|clearance|none`',
    `promotional_price` DECIMAL(18,2) COMMENT 'Discounted price observed when the product was on promotion.',
    `retailer_channel` STRING COMMENT 'Channel through which the retailer sells (e.g., retail store, foodservice, direct‑to‑consumer, online).. Valid values are `retail|foodservice|dtc|online|wholesale|other`',
    `retailer_name` STRING COMMENT 'Name of the retail outlet or chain where the price was observed.',
    `shelf_price` DECIMAL(18,2) COMMENT 'Price displayed on the shelf label, may include taxes or fees.',
    `store_city` STRING COMMENT 'City of the store location.',
    `store_country` STRING COMMENT 'Three‑letter ISO country code of the store location.. Valid values are `^[A-Z]{3}$`',
    `store_state` STRING COMMENT 'State or province of the store location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price record.',
    CONSTRAINT pk_competitor_price PRIMARY KEY(`competitor_price_id`)
) COMMENT 'Competitive price intelligence record capturing observed market prices for competitor products at specific retail accounts, channels, or geographies. Captures competitor brand, competitor SKU description, observed retail price, observed promotional price, shelf price, price per unit/oz/liter, data source (syndicated Nielsen/IRI, field observation, web scrape), observation date, and retailer/channel. Feeds competitive pricing strategy and price gap analysis.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` (
    `retail_shelf_price_id` BIGINT COMMENT 'System-generated unique identifier for each retail shelf price record.',
    `promotional_price_id` BIGINT COMMENT 'Identifier of the promotion linked to this price, if applicable.',
    `account_id` BIGINT COMMENT 'Identifier of the retailer account (e.g., chain or banner) responsible for the store.',
    `sku_id` BIGINT COMMENT 'Internal product identifier used for inventory and sales tracking.',
    `store_id` BIGINT COMMENT 'Unique identifier of the retail store where the price was observed.',
    `previous_retail_shelf_price_id` BIGINT COMMENT 'Self-referencing FK on retail_shelf_price (previous_retail_shelf_price_id)',
    `actual_price` DECIMAL(18,2) COMMENT 'Price observed on the shelf at the time of capture.',
    `competitor_price` DECIMAL(18,2) COMMENT 'Average competitor price used for gap calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price values.',
    `effective_end_date` DATE COMMENT 'Date after which the price is no longer valid; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date from which the price is considered effective.',
    `gtin` STRING COMMENT 'Global identifier for trade items, may be 14‑digit.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the price record.',
    `price_change_reason` STRING COMMENT 'Reason for a price adjustment (e.g., promotion, cost increase, competitor match).',
    `price_date` DATE COMMENT 'Calendar date on which the shelf price was captured.',
    `price_elasticity_flag` BOOLEAN COMMENT 'True if the price observation is used in elasticity modeling.',
    `price_gap_to_competition` DECIMAL(18,2) COMMENT 'Difference between actual shelf price and the average competitor price for the same SKU.',
    `price_per_oz` DECIMAL(18,2) COMMENT 'Price expressed per fluid ounce or ounce, used for volume‑based comparison.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Price expressed per standard unit of measure (e.g., per pack, per case).',
    `price_source` STRING COMMENT 'Origin of the price data (e.g., internal audit, third‑party data feed, POS system, manual entry).. Valid values are `audit|third_party|system|manual`',
    `price_status` STRING COMMENT 'Current lifecycle status of the price record.. Valid values are `active|inactive|archived`',
    `price_type` STRING COMMENT 'Indicates whether the price is a recommended retail price (RRP) or the actual observed shelf price.. Valid values are `recommended|actual`',
    `promotion_flag` BOOLEAN COMMENT 'Indicates whether the price is associated with an active promotion.',
    `recommended_price` DECIMAL(18,2) COMMENT 'Manufacturer‑recommended price for the SKU at the store.',
    `uom` STRING COMMENT 'Standard unit of measure for the price (e.g., each, pack, case).',
    `upc` STRING COMMENT '12‑digit barcode identifier for the product.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price record.',
    CONSTRAINT pk_retail_shelf_price PRIMARY KEY(`retail_shelf_price_id`)
) COMMENT 'Retail shelf price (RSP) record capturing the actual consumer-facing shelf price observed or recommended for Food Beverage SKUs at retail accounts. Captures retailer account, store banner, SKU, recommended retail price (RRP), actual observed shelf price, price per unit, price per oz/liter, shelf price date, and data source. Enables RSP compliance monitoring, price gap to competition, and consumer price elasticity inputs.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` (
    `price_elasticity_id` BIGINT COMMENT 'Unique surrogate key for the price elasticity record.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: price_elasticity estimates are zone‑specific; linking removes duplicated channel and market region fields.',
    `sku_id` BIGINT COMMENT 'Unique product identifier (SKU) to which the elasticity applies.',
    `previous_price_elasticity_id` BIGINT COMMENT 'Self-referencing FK on price_elasticity (previous_price_elasticity_id)',
    `confidence_interval_high` DECIMAL(18,2) COMMENT 'Upper bound of the statistical confidence interval for the elasticity estimate.',
    `confidence_interval_low` DECIMAL(18,2) COMMENT 'Lower bound of the statistical confidence interval for the elasticity estimate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the elasticity record was first created in the system.',
    `cross_competitor_sku` STRING COMMENT 'SKU of a key competitor product used for cross‑price elasticity calculation.',
    `cross_price_elasticity` DECIMAL(18,2) COMMENT 'Estimated demand sensitivity to price changes of the competitor product (cross‑elasticity).',
    `elasticity_model_version` STRING COMMENT 'Version identifier of the elasticity estimation model used.',
    `estimation_method` STRING COMMENT 'Methodology used to estimate elasticity (econometric, machine learning, or hybrid).. Valid values are `econometric|ml|hybrid`',
    `notes` STRING COMMENT 'Free‑form comments or business notes about the elasticity record.',
    `own_price_elasticity` DECIMAL(18,2) COMMENT 'Estimated demand sensitivity to changes in the products own price (percentage change in quantity per percentage change in price).',
    `price_elasticity_status` STRING COMMENT 'Current lifecycle status of the elasticity record.. Valid values are `active|inactive|deprecated`',
    `price_threshold` DECIMAL(18,2) COMMENT 'Psychological price point at which demand behavior changes sharply.',
    `source_system` STRING COMMENT 'Originating system that generated the elasticity estimate.. Valid values are `SAP_IBP|Oracle_ERP|Salesforce`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the elasticity record.',
    `validity_end_date` DATE COMMENT 'Date after which the elasticity estimate expires (null if open‑ended).',
    `validity_start_date` DATE COMMENT 'Date from which the elasticity estimate is considered valid.',
    CONSTRAINT pk_price_elasticity PRIMARY KEY(`price_elasticity_id`)
) COMMENT 'Price elasticity parameter record capturing the estimated demand sensitivity to price changes for a SKU within a specific channel and market. Stores own-price elasticity coefficient, cross-price elasticity with key competitors, price threshold (psychological price points), elasticity model version, estimation method (econometric, ML), confidence interval, and validity period. Used as input to pricing optimization and revenue management decisions — this is a business parameter record, not an analytics output.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` (
    `surcharge_rule_id` BIGINT COMMENT 'System-generated unique identifier for each surcharge rule.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Surcharge rules are created by pricing staff; required for Surcharge Rule Creation tracking.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: surcharge_rule definitions are scoped to price zones; linking removes duplicated scope attributes.',
    `parent_surcharge_rule_id` BIGINT COMMENT 'Self-referencing FK on surcharge_rule (parent_surcharge_rule_id)',
    `approval_status` STRING COMMENT 'Current approval state of the surcharge rule.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Identifier of the employee who approved the rule.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule was approved.',
    `calculation_method` STRING COMMENT 'Method used to calculate the surcharge amount.. Valid values are `flat_fee|percentage|tiered`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the surcharge complies with relevant regulations (e.g., FDA, GFSI).',
    `cost_center_code` STRING COMMENT 'Internal cost center responsible for the surcharge.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary fields.. Valid values are `USD|EUR|GBP|JPY|CAD`',
    `effective_end_date` DATE COMMENT 'Date when the surcharge rule expires (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the surcharge rule becomes active.',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount applied when calculation_method is flat_fee.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether this surcharge can be combined with other surcharges.',
    `minimum_order_quantity` STRING COMMENT 'Minimum quantity required for the surcharge to apply.',
    `minimum_order_uom` STRING COMMENT 'Unit of measure for minimum_order_quantity (e.g., case, pallet).',
    `notes` STRING COMMENT 'Additional remarks or operational notes.',
    `percent_rate` DECIMAL(18,2) COMMENT 'Percentage applied to the base price when calculation_method is percentage.',
    `priority` STRING COMMENT 'Integer indicating the order in which rules are evaluated (lower = higher priority).',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory review for the surcharge rule.. Valid values are `not_required|pending|approved|rejected`',
    `responsible_owner` STRING COMMENT 'Employee identifier of the owner of the surcharge rule.',
    `rule_code` STRING COMMENT 'Business code used to reference the surcharge rule in pricing systems.',
    `rule_name` STRING COMMENT 'Human‑readable name describing the surcharge rule.',
    `surcharge_rule_description` STRING COMMENT 'Free‑form description of the surcharge rule purpose and logic.',
    `surcharge_rule_status` STRING COMMENT 'Current lifecycle status of the surcharge rule.. Valid values are `active|inactive|retired|draft`',
    `surcharge_type` STRING COMMENT 'Category of surcharge applied (e.g., fuel, small order, cold chain handling).. Valid values are `fuel|small_order|cold_chain|minimum_order|dtc_fulfillment`',
    `tax_applicable` BOOLEAN COMMENT 'True if the surcharge is subject to tax.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Tax rate applied to the surcharge amount when tax_applicable is true.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'Monetary threshold that must be met for the surcharge to trigger (e.g., minimum order value).',
    `threshold_unit` STRING COMMENT 'Currency of the threshold_amount.. Valid values are `USD|EUR|GBP|JPY|CAD`',
    `tier_structure` STRING COMMENT 'JSON‑encoded definition of tier thresholds and corresponding fees for tiered calculation_method.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the rule.',
    CONSTRAINT pk_surcharge_rule PRIMARY KEY(`surcharge_rule_id`)
) COMMENT 'Master record defining surcharges, fees, and uplifts applied on top of base prices — including fuel surcharges, small order surcharges, cold chain handling fees, minimum order value fees, and DTC fulfillment fees. Captures surcharge type, calculation method (flat fee, percentage, tiered), applicable channel, applicable customer segment, threshold conditions, effective date range, and approval status.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`discount_rule` (
    `discount_rule_id` BIGINT COMMENT 'System-generated unique identifier for the discount rule record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Discount rules are authored by pricing analysts; needed for Discount Rule Ownership report.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: discount_rule applicability is defined per price zone; linking consolidates channel and region data.',
    `parent_discount_rule_id` BIGINT COMMENT 'Self-referencing FK on discount_rule (parent_discount_rule_id)',
    `applicable_customer_segment` STRING COMMENT 'Customer segment (e.g., retail, foodservice, DTC) to which the discount rule may be applied.',
    `applicable_product_category` STRING COMMENT 'Product category or family for which the discount is valid.',
    `applicable_product_sku` STRING COMMENT 'Specific SKU (Stock Keeping Unit) that the discount can be applied to; blank means all SKUs in the category.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether the discount rule must be approved before activation.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the discount rule received approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the discount rule.',
    `calculation_basis` STRING COMMENT 'Base price element on which the discount is applied (e.g., net price, list price, cost‑plus).',
    `compliance_flag` STRING COMMENT 'Regulatory or certification requirement associated with the discount rule.. Valid values are `FDA|GFSI|USDA|EFSA|ISO22000|ISO9001`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the discount rule record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values in the rule.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `discount_rule_description` STRING COMMENT 'Free‑form description of the discount rule purpose and application.',
    `discount_rule_status` STRING COMMENT 'Current lifecycle state of the discount rule.. Valid values are `active|inactive|pending|retired`',
    `discount_type` STRING COMMENT 'Category of discount calculation method (e.g., percentage off, fixed amount, per case, tiered).. Valid values are `percentage|fixed_amount|per_case|tiered`',
    `discount_unit` STRING COMMENT 'Unit that qualifies discount_value (percent, currency amount, or per‑case amount).. Valid values are `percent|currency|per_case`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount; interpreted according to discount_unit (percentage, currency amount, or per‑case amount).',
    `effective_end_date` DATE COMMENT 'Date after which the discount rule is no longer valid; null indicates open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the discount rule becomes valid.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether this discount can be combined with other discounts.',
    `last_review_date` DATE COMMENT 'Date when the discount rule was last reviewed for relevance or compliance.',
    `maximum_discount_cap` DECIMAL(18,2) COMMENT 'Upper limit on the total discount amount that can be granted per transaction.',
    `minimum_order_quantity` STRING COMMENT 'Minimum number of units that must be ordered for the discount to be eligible.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum monetary value of the order required for the discount to apply.',
    `notes` STRING COMMENT 'Additional remarks, exceptions, or operational notes.',
    `priority_rank` STRING COMMENT 'Relative priority of the rule when multiple discounts are applicable; lower numbers indicate higher priority.',
    `regulatory_approval_required` BOOLEAN COMMENT 'True if the discount rule must be reviewed by regulatory compliance before activation.',
    `rule_code` STRING COMMENT 'Human‑readable code used to reference the discount rule in pricing systems.',
    `rule_name` STRING COMMENT 'Descriptive name of the discount rule for reporting and UI display.',
    `stack_order` STRING COMMENT 'Sequence order for applying stackable discounts; lower numbers apply first.',
    `updated_by` STRING COMMENT 'User identifier who performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the discount rule record.',
    `version_number` STRING COMMENT 'Incremental version of the discount rule for change management.',
    `created_by` STRING COMMENT 'User identifier who initially created the discount rule.',
    CONSTRAINT pk_discount_rule PRIMARY KEY(`discount_rule_id`)
) COMMENT 'Master record defining authorized discount structures applicable to sales transactions — including off-invoice discounts, cash discounts, early payment discounts, new distribution discounts, and loyalty discounts. Captures discount type, calculation basis (percentage, fixed amount, per-case), applicable customer group, applicable product group, minimum order quantity/value, maximum discount cap, effective date range, and approval authority.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`transfer_price` (
    `transfer_price_id` BIGINT COMMENT 'System-generated unique identifier for the intercompany transfer price record.',
    `cost_plus_model_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_plus_model. Business justification: transfer_price uses cost‑plus percentages defined in cost_plus_model; linking removes redundant percentage field.',
    `raw_material_id` BIGINT COMMENT 'Unique identifier of the material or SKU being transferred.',
    `company_code_id` BIGINT COMMENT 'Identifier of the legal entity (company code) that supplies the goods or materials.',
    `receiving_entity_company_code_id` BIGINT COMMENT 'Identifier of the legal entity (company code) that receives the goods or materials.',
    `superseded_transfer_price_id` BIGINT COMMENT 'Self-referencing FK on transfer_price (superseded_transfer_price_id)',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the transfer price.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer price was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer price record was initially created in the system.',
    `cup_reference` STRING COMMENT 'Reference to the comparable uncontrolled price source or transaction used for the CUP method.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the transfer price is expressed.. Valid values are `^[A-Z]{3}$`',
    `documentation_reference` STRING COMMENT 'Reference identifier (e.g., document number or URL) to the supporting tax authority documentation.',
    `effective_end_date` DATE COMMENT 'Date on which the transfer price expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the transfer price becomes effective for intercompany transactions.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special conditions related to the transfer price.',
    `price_amount` DECIMAL(18,2) COMMENT 'Authorized transfer price amount expressed in the transaction currency.',
    `price_code` STRING COMMENT 'Business identifier or code assigned to the transfer price agreement for reference in contracts and reporting.',
    `price_type` STRING COMMENT 'Classification of the price (intercompany, internal transfer, external market).. Valid values are `intercompany|internal|external`',
    `price_version` STRING COMMENT 'Version number of the transfer price record to track revisions over time.',
    `pricing_method` STRING COMMENT 'Method used to calculate the transfer price (e.g., Cost‑Plus, Resale‑Minus, Comparable Uncontrolled Price, Transactional Net Margin Method).. Valid values are `cost_plus|resale_minus|cup|tnmm`',
    `reason` STRING COMMENT 'Business rationale for establishing or changing the transfer price (e.g., cost alignment, market parity).',
    `resale_minus_amount` DECIMAL(18,2) COMMENT 'Fixed amount subtracted from the resale price when the Resale‑Minus method is used.',
    `sku_code` STRING COMMENT 'Stock Keeping Unit code that uniquely identifies the product for inventory and pricing.',
    `source_system` STRING COMMENT 'Name of the source ERP or planning system where the record originated (e.g., SAP S/4HANA, Oracle ERP).',
    `tax_authority_code` STRING COMMENT 'Two‑letter code of the tax authority that governs the transfer pricing documentation.. Valid values are `^[A-Z]{2}$`',
    `tnmm_reference` STRING COMMENT 'Reference to the data set or benchmark used for the Transactional Net Margin Method.',
    `transfer_price_status` STRING COMMENT 'Current lifecycle status of the transfer price (e.g., active, inactive, pending approval, expired, draft).. Valid values are `active|inactive|pending|expired|draft`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the transfer price record.',
    CONSTRAINT pk_transfer_price PRIMARY KEY(`transfer_price_id`)
) COMMENT 'Intercompany transfer pricing record defining the authorized prices at which finished goods, raw materials, and semi-finished products are transferred between Food Beverage legal entities (company codes) across geographies. Captures sending entity, receiving entity, material/SKU, transfer price, currency, pricing method (cost-plus, resale minus, CUP, TNMM), effective date range, and tax authority documentation reference. Critical for OECD transfer pricing compliance and intercompany P&L integrity.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_simulation` (
    `price_simulation_id` BIGINT COMMENT 'Unique identifier for the price simulation record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Price simulations are run to forecast revenue impact of a specific marketing campaign; linking ties simulation results to the campaign.',
    `formulation_version_id` BIGINT COMMENT 'Foreign key linking to research.formulation_version. Business justification: Simulations are run on a specific formulation version to forecast margin, revenue, and competitive response.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: price_simulation scenarios are scoped to price zones; linking removes duplicated channel, segment, and category attributes.',
    `employee_id` BIGINT COMMENT 'Internal user responsible for the simulation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Price simulations impact profit center forecasts; linking to profit center aligns simulated margins with financial planning.',
    `sku_id` BIGINT COMMENT 'SKU of the product being simulated.',
    `baseline_price_simulation_id` BIGINT COMMENT 'Self-referencing FK on price_simulation (baseline_price_simulation_id)',
    `approval_status` STRING COMMENT 'Current approval state of the simulation.. Valid values are `pending|approved|rejected`',
    `approved_by` BIGINT COMMENT 'User who approved the simulation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the simulation was approved.',
    `competitive_response_assumption` STRING COMMENT 'Assumed competitive reaction (e.g., price cuts, promotions) used in the simulation.',
    `cost_plus_percentage` DECIMAL(18,2) COMMENT 'Cost‑plus markup percentage applied in the scenario, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the simulation record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for the proposed price.',
    `data_source_system` STRING COMMENT 'Source system that originated the simulation data (e.g., SAP, Oracle).',
    `effective_end_date` DATE COMMENT 'Date when the proposed price would cease to be effective.',
    `effective_start_date` DATE COMMENT 'Date when the proposed price would become effective.',
    `estimated_margin` DECIMAL(18,2) COMMENT 'Projected gross margin amount (currency) for the scenario.',
    `estimated_revenue` DECIMAL(18,2) COMMENT 'Projected revenue generated by the scenario.',
    `estimated_volume_units` DECIMAL(18,2) COMMENT 'Projected sales volume under the scenario (in the specified unit).',
    `forecasted_impact` STRING COMMENT 'Narrative of expected market impact from the simulation.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the simulation.',
    `margin_percent` DECIMAL(18,2) COMMENT 'Projected margin expressed as a percentage of revenue.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the simulation.',
    `price_change_reason` STRING COMMENT 'Business rationale for the proposed price change.',
    `price_simulation_status` STRING COMMENT 'Current lifecycle status of the simulation.. Valid values are `draft|reviewed|submitted|approved|rejected|archived`',
    `proposed_price` DECIMAL(18,2) COMMENT 'Proposed selling price per unit in the scenario.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the simulation complies with relevant pricing regulations.',
    `scenario_description` STRING COMMENT 'Detailed description of the pricing scenario purpose and assumptions.',
    `scenario_name` STRING COMMENT 'Human‑readable name of the pricing scenario.',
    `scenario_status_reason` STRING COMMENT 'Explanation for the current status of the simulation.',
    `sensitivity_analysis_flag` BOOLEAN COMMENT 'Indicates if a sensitivity analysis was conducted.',
    `sensitivity_range_percent` DECIMAL(18,2) COMMENT 'Percentage range used in sensitivity analysis.',
    `simulation_code` STRING COMMENT 'Business identifier code for the simulation, used for external reference.',
    `simulation_date` DATE COMMENT 'Date on which the simulation was executed.',
    `simulation_scenario_type` STRING COMMENT 'Classification of the scenario type.. Valid values are `what_if|price_optimization|cost_plus|promotion|other`',
    `updated_by` BIGINT COMMENT 'User who performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the simulation record.',
    `version_number` STRING COMMENT 'Version of the simulation record for change tracking.',
    `volume_uom` STRING COMMENT 'Unit of measure for the estimated volume.. Valid values are `cases|units|kg|liters|gallons|pounds`',
    `created_by` BIGINT COMMENT 'User who created the simulation record.',
    CONSTRAINT pk_price_simulation PRIMARY KEY(`price_simulation_id`)
) COMMENT 'Price simulation and what-if scenario record capturing proposed pricing scenarios evaluated before a price change is submitted for approval. Captures scenario name, simulation date, proposed price points, estimated volume impact, estimated revenue impact, estimated margin impact, competitive response assumptions, and simulation status (draft, reviewed, submitted). Enables data-driven pricing decisions and supports the price change governance workflow.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` (
    `foodservice_price_id` BIGINT COMMENT 'System-generated unique identifier for the foodservice price record.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: foodservice_price varies by price zone and segment; linking consolidates these attributes.',
    `sku_id` BIGINT COMMENT 'Unique product identifier for which the price is defined.',
    `superseded_foodservice_price_id` BIGINT COMMENT 'Self-referencing FK on foodservice_price (superseded_foodservice_price_id)',
    `approval_status` STRING COMMENT 'Approval state of the price record.. Valid values are `approved|pending|rejected`',
    `approved_by` STRING COMMENT 'User or system that approved the price.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the price was approved.',
    `broadline_price` DECIMAL(18,2) COMMENT 'Price set by a broadline distributor for the SKU.',
    `broadline_price_uom` STRING COMMENT 'Unit of measure for the broadline price.. Valid values are `case|unit|portion|split_case`',
    `case_price` DECIMAL(18,2) COMMENT 'Authorized net price for a full case of the SKU.',
    `case_price_uom` STRING COMMENT 'Unit of measure for the case price (typically case).. Valid values are `case|unit|portion|split_case`',
    `contract_price` DECIMAL(18,2) COMMENT 'Price agreed under a specific contract with the operator or distributor.',
    `contract_price_uom` STRING COMMENT 'Unit of measure for the contract price.. Valid values are `case|unit|portion|split_case`',
    `cost_plus_percentage` DECIMAL(18,2) COMMENT 'Markup percentage applied over cost to derive the price.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the price.. Valid values are `^[A-Z]{3}$`',
    `distributor` STRING COMMENT 'Name or code of the distributor providing the product to the foodservice channel.',
    `effective_end_date` DATE COMMENT 'Date when the price expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when the price becomes effective.',
    `foodservice_price_status` STRING COMMENT 'Current lifecycle status of the price record.. Valid values are `active|inactive|pending|expired`',
    `margin_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage for the price.',
    `minimum_order_quantity` STRING COMMENT 'Minimum quantity required to qualify for this price.',
    `notes` STRING COMMENT 'Additional free-form comments about the price.',
    `operator_segment` STRING COMMENT 'Segment of the foodservice operator (e.g., Quick Service Restaurant, Food Service Restaurant).. Valid values are `QSR|FSR|Healthcare|Education|Lodging|Vending`',
    `portion_price` DECIMAL(18,2) COMMENT 'Authorized net price for a single portion of the SKU.',
    `portion_price_uom` STRING COMMENT 'Unit of measure for the portion price.. Valid values are `case|unit|portion|split_case`',
    `price_calculation_method` STRING COMMENT 'Method used to calculate the price.. Valid values are `cost_plus|margin|fixed|dynamic`',
    `price_category` STRING COMMENT 'Business category of the price.. Valid values are `standard|promotional|contract|special`',
    `price_ceiling_amount` DECIMAL(18,2) COMMENT 'Maximum allowable price for the SKU.',
    `price_change_reason` STRING COMMENT 'Reason for the most recent price change.',
    `price_floor_amount` DECIMAL(18,2) COMMENT 'Minimum allowable price for the SKU.',
    `price_source` STRING COMMENT 'Origin of the price data.. Valid values are `distributor|operator|broadline|internal`',
    `price_source_system` STRING COMMENT 'System of record that supplied the price data.',
    `price_tier` STRING COMMENT 'Tier classification for volume or contract based pricing.. Valid values are `tier1|tier2|tier3|tier4|tier5`',
    `price_type` STRING COMMENT 'Classification of the price (e.g., net, gross, contract).. Valid values are `net|gross|contract|broadline|promotional`',
    `price_version` STRING COMMENT 'Version number of the price record for change tracking.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates if the price complies with applicable regulations (e.g., FDA labeling).',
    `split_case_price` DECIMAL(18,2) COMMENT 'Authorized net price for a split case (half case) of the SKU.',
    `split_case_price_uom` STRING COMMENT 'Unit of measure for the split-case price.. Valid values are `case|unit|portion|split_case`',
    `uom` STRING COMMENT 'Standard unit of measure for price values.. Valid values are `case|unit|portion|split_case`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price record.',
    CONSTRAINT pk_foodservice_price PRIMARY KEY(`foodservice_price_id`)
) COMMENT 'Foodservice-specific pricing record capturing authorized net prices for SKUs sold through foodservice channels (QSR, FSR, healthcare, education, lodging, vending). Captures operator segment, distributor, SKU, case price, split-case price, portion price, contract price, broadline distributor price, and effective date range. Foodservice pricing is structurally distinct from retail — governed by distributor cost-plus models, operator contracts, and broadline pricing agreements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`dtc_price` (
    `dtc_price_id` BIGINT COMMENT 'System‑generated unique identifier for the DTC price record.',
    `price_rule_id` BIGINT COMMENT 'Identifier of the pricing rule or algorithm that generated this price.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: dtc_price is channel‑specific; linking to price_zone eliminates duplicated channel attribute.',
    `sku_id` BIGINT COMMENT 'Unique product code for which the DTC price applies.',
    `superseded_dtc_price_id` BIGINT COMMENT 'Self-referencing FK on dtc_price (superseded_dtc_price_id)',
    `approved_by` STRING COMMENT 'Identifier of the person who approved the price.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the price received approval.',
    `bundle_price` DECIMAL(18,2) COMMENT 'Price for a pre‑defined product bundle sold through DTC.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the price record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price values.',
    `dtc_price_description` STRING COMMENT 'Human‑readable description of the price record purpose or scope.',
    `dynamic_pricing_algorithm` STRING COMMENT 'Algorithm type used for dynamic pricing (rule‑based, machine‑learning, or manual).. Valid values are `rule_based|ml|manual`',
    `effective_end_date` DATE COMMENT 'Date when the price ceases to be valid (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the price becomes valid for the DTC channel.',
    `is_dynamic` BOOLEAN COMMENT 'Indicates whether the price is subject to dynamic adjustment.',
    `margin_floor` DECIMAL(18,2) COMMENT 'Minimum gross margin that must be achieved for the price.',
    `member_price` DECIMAL(18,2) COMMENT 'Discounted price offered to loyalty‑program members.',
    `notes` STRING COMMENT 'Additional comments or business context for the price record.',
    `price_approval_status` STRING COMMENT 'Governance status indicating whether the price has been approved.. Valid values are `approved|pending|rejected`',
    `price_category` STRING COMMENT 'Business classification of the price (standard, promotional, clearance).. Valid values are `standard|promotional|clearance`',
    `price_ceiling_amount` DECIMAL(18,2) COMMENT 'Maximum allowable price for the SKU in the DTC channel.',
    `price_change_reason` STRING COMMENT 'Free‑text explanation for why the price was changed.',
    `price_code` STRING COMMENT 'Business‑level code used to reference the price record in external processes.',
    `price_effective_days` STRING COMMENT 'Number of days the price is scheduled to be active (derived from start/end dates).',
    `price_effective_flag` BOOLEAN COMMENT 'True if the price is currently active based on effective dates.',
    `price_floor_amount` DECIMAL(18,2) COMMENT 'Minimum allowable price for the SKU in the DTC channel.',
    `price_review_date` DATE COMMENT 'Scheduled date for the next price review.',
    `price_source` STRING COMMENT 'Originating system or process that supplied the price.. Valid values are `sap|oracle|custom|manual`',
    `price_status` STRING COMMENT 'Current lifecycle status of the price record.. Valid values are `active|inactive|pending|retired`',
    `price_type` STRING COMMENT 'Classification of the price (regular, member, subscriber, or bundle).. Valid values are `regular|member|subscriber|bundle`',
    `price_uom` STRING COMMENT 'Measurement unit for the price (e.g., per unit, per kilogram).. Valid values are `per_unit|per_kg|per_liter`',
    `price_version` STRING COMMENT 'Sequential version number for change tracking.',
    `regular_price` DECIMAL(18,2) COMMENT 'Standard price charged to non‑member consumers.',
    `subscriber_price` DECIMAL(18,2) COMMENT 'Price applied to customers enrolled in a subscription service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the price record.',
    CONSTRAINT pk_dtc_price PRIMARY KEY(`dtc_price_id`)
) COMMENT 'Direct-to-consumer (DTC) pricing record capturing authorized prices for SKUs sold through owned e-commerce, subscription, and DTC channels. Captures SKU, DTC channel (website, app, subscription box, marketplace), regular price, member price, subscriber price, bundle price, currency, effective date range, and margin floor. DTC pricing is distinct from retail and foodservice — governed by consumer psychology, dynamic pricing rules, and subscription economics.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_zone` (
    `price_zone_id` BIGINT COMMENT 'System-generated unique identifier for the price zone master record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Price zones are often defined per company code to reflect regional pricing policies within each legal entity.',
    `parent_zone_price_zone_id` BIGINT COMMENT 'Identifier of the parent price zone in the hierarchical structure, if any.',
    `parent_price_zone_id` BIGINT COMMENT 'Self-referencing FK on price_zone (parent_price_zone_id)',
    `applicable_channels` STRING COMMENT 'Pipe‑separated list of sales channels where the zone pricing is valid.. Valid values are `retail|foodservice|direct_to_consumer|online|wholesale`',
    `confidentiality_flag` STRING COMMENT 'Data classification level for the price zone record.. Valid values are `public|internal|confidential|restricted`',
    `country_codes` STRING COMMENT 'Comma‑separated list of ISO‑3 country codes included in the zone.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price zone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for pricing in the zone.',
    `effective_end_date` DATE COMMENT 'Date when the price zone ceases to be active (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the price zone becomes active for pricing calculations.',
    `geographic_scope` STRING COMMENT 'Level of geographic granularity the zone applies to.. Valid values are `country|region|state|metro|nielsen_market`',
    `hierarchy_level` STRING COMMENT 'Numeric level indicating depth in the zone hierarchy (1 = top level).',
    `is_default` BOOLEAN COMMENT 'True if this zone is the default fallback for pricing calculations.',
    `last_review_date` DATE COMMENT 'Date of the most recent governance review of the zone.',
    `maximum_price` DECIMAL(18,2) COMMENT 'Ceiling price that cannot be exceeded for any SKU in this zone.',
    `metro_area` STRING COMMENT 'Metro area name (e.g., New York City) covered by the zone.',
    `minimum_price` DECIMAL(18,2) COMMENT 'Floor price that cannot be undercut for any SKU in this zone.',
    `nielsen_market` STRING COMMENT 'Nielsen market identifier used for analytics and pricing alignment.',
    `notes` STRING COMMENT 'Free‑form comments or business rationale for the zone.',
    `price_change_approval_required` BOOLEAN COMMENT 'Indicates whether a price change for this zone must be approved.',
    `price_change_approval_status` STRING COMMENT 'Current approval status of the pending price change.. Valid values are `pending|approved|rejected`',
    `price_change_approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the price change was approved or rejected.',
    `price_change_approver` STRING COMMENT 'Name or identifier of the person who approved the price change.',
    `price_change_effective_date` DATE COMMENT 'Date on which a scheduled price change becomes effective.',
    `price_change_history_flag` BOOLEAN COMMENT 'True if historical price change records are retained for this zone.',
    `price_change_notice_days` STRING COMMENT 'Number of days required to notify stakeholders before a price change takes effect.',
    `price_change_reason` STRING COMMENT 'Business rationale for the price change (e.g., cost increase, market competition).',
    `price_multiplier` DECIMAL(18,2) COMMENT 'Factor applied to base price when pricing within this zone (e.g., 1.10 for 10% uplift).',
    `price_zone_code` STRING COMMENT 'Business code used to reference the price zone in pricing rules and systems.',
    `price_zone_description` STRING COMMENT 'Detailed textual description of the zones purpose and characteristics.',
    `price_zone_name` STRING COMMENT 'Human‑readable name of the geographic price zone.',
    `price_zone_status` STRING COMMENT 'Current lifecycle status of the price zone.. Valid values are `active|inactive|planned|retired`',
    `price_zone_type` STRING COMMENT 'Classification of the zone based on its primary differentiation driver.. Valid values are `geographic|demographic|channel_specific`',
    `pricing_authority` STRING COMMENT 'Organizational unit or role responsible for approving pricing within the zone.',
    `region` STRING COMMENT 'Name of the region (e.g., Midwest, South‑East) covered by the zone.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the zone complies with all applicable pricing regulations.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory reviews of the price zone.',
    `source_system` STRING COMMENT 'Originating system that created or maintains the price zone record (e.g., SAP S/4HANA).',
    `state_province` STRING COMMENT 'State or province name included in the zone.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price zone record.',
    `version_number` STRING COMMENT 'Version identifier for the price zone definition.',
    `created_by` STRING COMMENT 'User or system account that created the price zone record.',
    CONSTRAINT pk_price_zone PRIMARY KEY(`price_zone_id`)
) COMMENT 'Geographic price zone master record defining regional pricing territories where differentiated pricing is authorized. Captures zone name, zone code, geographic scope (country, region, state/province, metro area, Nielsen market), applicable channels, pricing authority, and zone hierarchy. Enables geographic price differentiation strategies — e.g., premium pricing in high-cost metros vs. value pricing in price-sensitive rural markets.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` (
    `price_waterfall_id` BIGINT COMMENT 'System-generated unique identifier for each price waterfall step record.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: price_waterfall steps are tied to a price zone; linking eliminates redundant channel, segment, and region data.',
    `pos_transaction_id` BIGINT COMMENT 'Identifier of the parent transaction (order, invoice, or sales event) to which this waterfall step belongs.',
    `reference_price_waterfall_id` BIGINT COMMENT 'Self-referencing FK on price_waterfall (reference_price_waterfall_id)',
    `amount_allowance` DECIMAL(18,2) COMMENT 'Off‑invoice or trade allowance value applied at this step.',
    `amount_discount` DECIMAL(18,2) COMMENT 'Total discount value applied at this step.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Monetary amount before any discounts, allowances, or taxes are applied.',
    `amount_net` DECIMAL(18,2) COMMENT 'Resulting amount after this steps adjustments; the net‑to‑net price at the bottom of the waterfall.',
    `amount_tax` DECIMAL(18,2) COMMENT 'Tax component (e.g., sales tax, VAT) applied at this step.',
    `approval_status` STRING COMMENT 'Current approval state of the price step.. Valid values are `approved|rejected|pending`',
    `approved_by` BIGINT COMMENT 'User identifier of the person who approved the price step.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the price step received approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price waterfall step record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this price step ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when this price step becomes effective for the transaction.',
    `is_manual_adjustment` BOOLEAN COMMENT 'True if the step was entered or modified manually rather than by automated logic.',
    `notes` STRING COMMENT 'Free‑form comments or business rationale for the price step.',
    `price_change_reason` STRING COMMENT 'Narrative description of why the price amount was changed.',
    `price_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent price change affecting this step.',
    `price_source` STRING COMMENT 'Origin of the price value (system‑generated, manually entered, or external feed).. Valid values are `system|manual|external`',
    `price_type` STRING COMMENT 'Classification of the price (e.g., list price, net price, promotional price, contract price).. Valid values are `list|net|promo|contract`',
    `price_waterfall_status` STRING COMMENT 'Current lifecycle status of the price step record.. Valid values are `active|inactive|pending|reversed|cancelled`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU or service to which the price step applies.',
    `reason_code` STRING COMMENT 'Code indicating why this price step was applied.. Valid values are `price_change|promotion|contractual|error`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the price step complies with applicable regulations (e.g., FDA pricing rules).',
    `source_system` STRING COMMENT 'Originating system that supplied the price step data.. Valid values are `SAP|Oracle|Salesforce|JDA|MES`',
    `step_category` STRING COMMENT 'Broad category of the step used for analytics and reporting.. Valid values are `gross|discount|allowance|tax|net`',
    `step_name` STRING COMMENT 'Descriptive name of the waterfall step (e.g., Gross List Price, Trade Promotion Discount).',
    `step_sequence` STRING COMMENT 'Ordinal position of the step within the price waterfall, starting at 1 for the gross list price.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price waterfall step record.',
    `version_number` STRING COMMENT 'Version of the price step record for audit and change tracking.',
    CONSTRAINT pk_price_waterfall PRIMARY KEY(`price_waterfall_id`)
) COMMENT 'Price waterfall record capturing the step-by-step decomposition of gross-to-net price for a specific transaction, customer, or period. Captures gross list price, invoice discounts, off-invoice allowances, trade promotion accruals, cash discounts, freight allowances, and net-net price at each waterfall step. Enables pocket price analysis, net revenue management (NRM), and identification of price leakage across the commercial value chain.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` (
    `revenue_realization_id` BIGINT COMMENT 'System-generated unique identifier for the revenue realization record.',
    `account_id` BIGINT COMMENT 'Internal identifier of the customer or account associated with the transaction.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue realization records need the GL account used for posting net revenue to the general ledger.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: revenue_realization records are associated with a price zone for regional revenue reporting.',
    `sku_id` BIGINT COMMENT 'Internal identifier of the SKU for which net revenue is recorded.',
    `prior_period_revenue_realization_id` BIGINT COMMENT 'Self-referencing FK on revenue_realization (prior_period_revenue_realization_id)',
    `allowance_flag` BOOLEAN COMMENT 'True if allowance amounts are applied.',
    `case_size_quantity` STRING COMMENT 'Number of individual units contained in one case.',
    `cost_plus_flag` BOOLEAN COMMENT 'Indicates whether a cost‑plus pricing model was used.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `discount_flag` BOOLEAN COMMENT 'True if discount amounts are applied.',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total gross revenue before any deductions for the SKU in the period.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Actual net revenue after all deductions for the SKU.',
    `net_revenue_per_case` DECIMAL(18,2) COMMENT 'Net revenue earned per case (standard packaging) of the SKU.',
    `net_revenue_per_unit` DECIMAL(18,2) COMMENT 'Net revenue earned per individual unit of the SKU.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the revenue record.',
    `period_date` DATE COMMENT 'The fiscal period (date) to which the revenue realization applies.',
    `price_type` STRING COMMENT 'Classification of the price basis used for the revenue calculation.. Valid values are `list|promotional|cost_plus|trade_spend`',
    `pricing_version` STRING COMMENT 'Version number of the pricing logic applied.',
    `processing_timestamp` TIMESTAMP COMMENT 'Timestamp when the revenue realization was processed.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the revenue realization record was first created.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `return_flag` BOOLEAN COMMENT 'True if return amounts are deducted.',
    `revenue_realization_status` STRING COMMENT 'Current processing status of the revenue record.. Valid values are `posted|pending|reversed`',
    `source_system` STRING COMMENT 'Originating source system for the revenue data.. Valid values are `SAP|Oracle|Salesforce|JDA`',
    `total_allowance_amount` DECIMAL(18,2) COMMENT 'Total allowance amount (e.g., rebates, volume allowances) applied.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Sum of all discount amounts applied to the SKU.',
    `total_return_amount` DECIMAL(18,2) COMMENT 'Value of product returns deducted from revenue.',
    `total_trade_spend_amount` DECIMAL(18,2) COMMENT 'Aggregate trade spend (promotions, slotting fees, etc.) applied to the SKU.',
    `trade_spend_flag` BOOLEAN COMMENT 'True if trade spend deductions are present.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for quantity (e.g., each, case).. Valid values are `each|case`',
    CONSTRAINT pk_revenue_realization PRIMARY KEY(`revenue_realization_id`)
) COMMENT 'Net revenue realization record capturing the actual realized net revenue per unit for a SKU after all deductions, allowances, and trade spend are applied. Captures gross revenue, total deductions (trade spend, discounts, allowances, returns), net revenue, net revenue per case, net revenue per unit, and period. Serves as the SSOT for net revenue management (NRM) reporting and pricing effectiveness measurement at the SKU/channel/customer level.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` (
    `price_list_assignment_id` BIGINT COMMENT 'Primary key for the price_list_assignment association',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution_center',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to price_list',
    `channel` STRING COMMENT 'Commercial channel (e.g., retail, foodservice, DTC) for which the price list applies at the center',
    `effective_from` DATE COMMENT 'Start date when the price list becomes active for the distribution center',
    `effective_until` DATE COMMENT 'End date when the price list ceases to be active for the distribution center',
    `region` STRING COMMENT 'Geographic region scope of the price list at the distribution center',
    CONSTRAINT pk_price_list_assignment PRIMARY KEY(`price_list_assignment_id`)
) COMMENT 'Association linking distribution centers to price lists, capturing which price list is active for a center by channel, region and effective date range.. Existence Justification: A distribution center can be linked to multiple price lists simultaneously, based on channel, region and effective date ranges, and a single price list can be applied to many distribution centers. The business actively manages these assignments, tracking effective dates, channel and region for each link.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_rule` (
    `price_rule_id` BIGINT COMMENT 'Primary key for price_rule',
    `parent_price_rule_id` BIGINT COMMENT 'Self-referencing FK on price_rule (parent_price_rule_id)',
    `applicability_scope` STRING COMMENT 'Scope of entities the rule applies to (e.g., channel, product, customer, region, store).',
    `condition_expression` STRING COMMENT 'Logical expression defining conditions under which the rule is triggered.',
    `price_rule_description` STRING COMMENT 'Detailed description of the rule logic and purpose.',
    `discount_value` DECIMAL(18,2) COMMENT 'Principal numeric value of the rule (e.g., percentage or fixed amount).',
    `effective_from` DATE COMMENT 'Date when the rule becomes active.',
    `effective_until` DATE COMMENT 'Date when the rule expires or is superseded (null if open‑ended).',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the rule excludes other rules when applied (true = exclusive).',
    `last_applied_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule was last applied to a transaction.',
    `priority` STRING COMMENT 'Integer indicating rule precedence when multiple rules apply (lower number = higher priority).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the price rule record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price rule record.',
    `rule_code` STRING COMMENT 'Business code used to reference the pricing rule in external systems.',
    `rule_name` STRING COMMENT 'Human‑readable name of the pricing rule.',
    `rule_type` STRING COMMENT 'Classification of the rule defining its calculation method.',
    `rule_version` STRING COMMENT 'Version identifier for the rule definition (e.g., v1.0, v2.1).',
    `price_rule_status` STRING COMMENT 'Current lifecycle status of the pricing rule.',
    `usage_count` BIGINT COMMENT 'Cumulative count of how many times the rule has been applied.',
    CONSTRAINT pk_price_rule PRIMARY KEY(`price_rule_id`)
) COMMENT 'Master reference table for price_rule. Referenced by price_rule_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`pricing`.`price_group` (
    `price_group_id` BIGINT COMMENT 'Primary key for price_group',
    `parent_price_group_id` BIGINT COMMENT 'Self-referencing FK on price_group (parent_price_group_id)',
    `applicable_channels` STRING COMMENT 'Comma‑separated list of sales channels where this price group is valid.',
    `price_group_code` STRING COMMENT 'Business code that uniquely identifies the price group across systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the price group record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values in this price group.',
    `default_discount_percent` DECIMAL(18,2) COMMENT 'Standard discount percentage applied to the price group in promotional scenarios.',
    `default_margin_percent` DECIMAL(18,2) COMMENT 'Standard margin percentage applied to products assigned to this group when no specific margin is defined.',
    `price_group_description` STRING COMMENT 'Detailed free‑text description of the price group purpose and rules.',
    `effective_from` DATE COMMENT 'First date on which the price group becomes active for pricing calculations.',
    `effective_to` DATE COMMENT 'Date on which the price group ceases to be active; null if open‑ended.',
    `is_exclusive` BOOLEAN COMMENT 'True if the price group is mutually exclusive with other groups for a given product.',
    `last_review_date` DATE COMMENT 'Date when the price group was last reviewed for relevance and compliance.',
    `max_quantity` STRING COMMENT 'Maximum purchase quantity for which the price group pricing is valid.',
    `min_quantity` STRING COMMENT 'Minimum purchase quantity required for the price group pricing to apply.',
    `price_group_name` STRING COMMENT 'Human‑readable name of the price group used in pricing rules and reports.',
    `notes` STRING COMMENT 'Free‑form notes for internal use, such as special handling instructions.',
    `price_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor used to adjust base prices for this group (e.g., 1.05 for a 5% uplift).',
    `price_override_flag` BOOLEAN COMMENT 'Indicates whether manual price overrides are permitted for this group.',
    `region_scope` STRING COMMENT 'Geographic region or market segment to which the price group applies (e.g., NA, EU, APAC).',
    `review_cycle` STRING COMMENT 'Frequency at which the price group is evaluated and potentially updated.',
    `price_group_status` STRING COMMENT 'Current lifecycle status of the price group.',
    `price_group_type` STRING COMMENT 'Classification of the price group indicating its pricing strategy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the price group record.',
    CONSTRAINT pk_price_group PRIMARY KEY(`price_group_id`)
) COMMENT 'Master reference table for price_group. Referenced by price_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_superseded_price_list_id` FOREIGN KEY (`superseded_price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_superseded_price_list_line_id` FOREIGN KEY (`superseded_price_list_line_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list_line`(`price_list_line_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ADD CONSTRAINT `fk_pricing_price_condition_price_group_id` FOREIGN KEY (`price_group_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_group`(`price_group_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ADD CONSTRAINT `fk_pricing_price_condition_procedure_id` FOREIGN KEY (`procedure_id`) REFERENCES `food_beverage_ecm`.`pricing`.`procedure`(`procedure_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ADD CONSTRAINT `fk_pricing_price_condition_superseded_price_condition_id` FOREIGN KEY (`superseded_price_condition_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_condition`(`price_condition_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ADD CONSTRAINT `fk_pricing_procedure_superseded_procedure_id` FOREIGN KEY (`superseded_procedure_id`) REFERENCES `food_beverage_ecm`.`pricing`.`procedure`(`procedure_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ADD CONSTRAINT `fk_pricing_procedure_step_procedure_id` FOREIGN KEY (`procedure_id`) REFERENCES `food_beverage_ecm`.`pricing`.`procedure`(`procedure_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ADD CONSTRAINT `fk_pricing_procedure_step_reference_procedure_step_id` FOREIGN KEY (`reference_procedure_step_id`) REFERENCES `food_beverage_ecm`.`pricing`.`procedure_step`(`procedure_step_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_superseded_channel_price_id` FOREIGN KEY (`superseded_channel_price_id`) REFERENCES `food_beverage_ecm`.`pricing`.`channel_price`(`channel_price_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ADD CONSTRAINT `fk_pricing_cost_plus_model_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ADD CONSTRAINT `fk_pricing_cost_plus_model_superseded_cost_plus_model_id` FOREIGN KEY (`superseded_cost_plus_model_id`) REFERENCES `food_beverage_ecm`.`pricing`.`cost_plus_model`(`cost_plus_model_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ADD CONSTRAINT `fk_pricing_promotional_price_superseded_promotional_price_id` FOREIGN KEY (`superseded_promotional_price_id`) REFERENCES `food_beverage_ecm`.`pricing`.`promotional_price`(`promotional_price_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ADD CONSTRAINT `fk_pricing_price_scale_price_list_line_id` FOREIGN KEY (`price_list_line_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list_line`(`price_list_line_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ADD CONSTRAINT `fk_pricing_price_scale_parent_price_scale_id` FOREIGN KEY (`parent_price_scale_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_scale`(`price_scale_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ADD CONSTRAINT `fk_pricing_price_change_request_superseded_price_change_request_id` FOREIGN KEY (`superseded_price_change_request_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_change_request`(`price_change_request_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ADD CONSTRAINT `fk_pricing_price_approval_price_change_request_id` FOREIGN KEY (`price_change_request_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_change_request`(`price_change_request_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ADD CONSTRAINT `fk_pricing_price_approval_escalated_from_price_approval_id` FOREIGN KEY (`escalated_from_price_approval_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_approval`(`price_approval_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ADD CONSTRAINT `fk_pricing_pricing_price_history_price_change_request_id` FOREIGN KEY (`price_change_request_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_change_request`(`price_change_request_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ADD CONSTRAINT `fk_pricing_pricing_price_history_previous_pricing_price_history_id` FOREIGN KEY (`previous_pricing_price_history_id`) REFERENCES `food_beverage_ecm`.`pricing`.`pricing_price_history`(`pricing_price_history_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ADD CONSTRAINT `fk_pricing_customer_price_agreement_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ADD CONSTRAINT `fk_pricing_customer_price_agreement_renewed_customer_price_agreement_id` FOREIGN KEY (`renewed_customer_price_agreement_id`) REFERENCES `food_beverage_ecm`.`pricing`.`customer_price_agreement`(`customer_price_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ADD CONSTRAINT `fk_pricing_price_exception_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ADD CONSTRAINT `fk_pricing_price_exception_related_price_exception_id` FOREIGN KEY (`related_price_exception_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_exception`(`price_exception_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ADD CONSTRAINT `fk_pricing_competitor_price_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ADD CONSTRAINT `fk_pricing_competitor_price_previous_competitor_price_id` FOREIGN KEY (`previous_competitor_price_id`) REFERENCES `food_beverage_ecm`.`pricing`.`competitor_price`(`competitor_price_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ADD CONSTRAINT `fk_pricing_retail_shelf_price_promotional_price_id` FOREIGN KEY (`promotional_price_id`) REFERENCES `food_beverage_ecm`.`pricing`.`promotional_price`(`promotional_price_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ADD CONSTRAINT `fk_pricing_retail_shelf_price_previous_retail_shelf_price_id` FOREIGN KEY (`previous_retail_shelf_price_id`) REFERENCES `food_beverage_ecm`.`pricing`.`retail_shelf_price`(`retail_shelf_price_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ADD CONSTRAINT `fk_pricing_price_elasticity_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ADD CONSTRAINT `fk_pricing_price_elasticity_previous_price_elasticity_id` FOREIGN KEY (`previous_price_elasticity_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_elasticity`(`price_elasticity_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ADD CONSTRAINT `fk_pricing_surcharge_rule_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ADD CONSTRAINT `fk_pricing_surcharge_rule_parent_surcharge_rule_id` FOREIGN KEY (`parent_surcharge_rule_id`) REFERENCES `food_beverage_ecm`.`pricing`.`surcharge_rule`(`surcharge_rule_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ADD CONSTRAINT `fk_pricing_discount_rule_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ADD CONSTRAINT `fk_pricing_discount_rule_parent_discount_rule_id` FOREIGN KEY (`parent_discount_rule_id`) REFERENCES `food_beverage_ecm`.`pricing`.`discount_rule`(`discount_rule_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ADD CONSTRAINT `fk_pricing_transfer_price_cost_plus_model_id` FOREIGN KEY (`cost_plus_model_id`) REFERENCES `food_beverage_ecm`.`pricing`.`cost_plus_model`(`cost_plus_model_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ADD CONSTRAINT `fk_pricing_transfer_price_superseded_transfer_price_id` FOREIGN KEY (`superseded_transfer_price_id`) REFERENCES `food_beverage_ecm`.`pricing`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_baseline_price_simulation_id` FOREIGN KEY (`baseline_price_simulation_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_simulation`(`price_simulation_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ADD CONSTRAINT `fk_pricing_foodservice_price_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ADD CONSTRAINT `fk_pricing_foodservice_price_superseded_foodservice_price_id` FOREIGN KEY (`superseded_foodservice_price_id`) REFERENCES `food_beverage_ecm`.`pricing`.`foodservice_price`(`foodservice_price_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ADD CONSTRAINT `fk_pricing_dtc_price_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ADD CONSTRAINT `fk_pricing_dtc_price_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ADD CONSTRAINT `fk_pricing_dtc_price_superseded_dtc_price_id` FOREIGN KEY (`superseded_dtc_price_id`) REFERENCES `food_beverage_ecm`.`pricing`.`dtc_price`(`dtc_price_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_parent_zone_price_zone_id` FOREIGN KEY (`parent_zone_price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_parent_price_zone_id` FOREIGN KEY (`parent_price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ADD CONSTRAINT `fk_pricing_price_waterfall_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ADD CONSTRAINT `fk_pricing_price_waterfall_reference_price_waterfall_id` FOREIGN KEY (`reference_price_waterfall_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_waterfall`(`price_waterfall_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ADD CONSTRAINT `fk_pricing_revenue_realization_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ADD CONSTRAINT `fk_pricing_revenue_realization_prior_period_revenue_realization_id` FOREIGN KEY (`prior_period_revenue_realization_id`) REFERENCES `food_beverage_ecm`.`pricing`.`revenue_realization`(`revenue_realization_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` ADD CONSTRAINT `fk_pricing_price_list_assignment_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_parent_price_rule_id` FOREIGN KEY (`parent_price_rule_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_group` ADD CONSTRAINT `fk_pricing_price_group_parent_price_group_id` FOREIGN KEY (`parent_price_group_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_group`(`price_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`pricing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `food_beverage_ecm`.`pricing` SET TAGS ('dbx_domain' = 'pricing');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `ibp_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Ibp Scenario Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `superseded_price_list_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|under_review|pending');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Price List Channel');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct_to_consumer|online|wholesale');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `cost_plus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Plus Percentage');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|foodservice|enterprise|government|hospitality');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `margin_floor_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Floor Percent');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Price List Owner');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Price Calculation Method');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_calculation_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_based|competitor_based|fixed|tiered');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_ceiling_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Ceiling Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_floor_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Floor Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_category` SET TAGS ('dbx_business_glossary_term' = 'Price List Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_code` SET TAGS ('dbx_business_glossary_term' = 'Price List Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_description` SET TAGS ('dbx_business_glossary_term' = 'Price List Description');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_name` SET TAGS ('dbx_business_glossary_term' = 'Price List Name');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired|pending|archived');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_type` SET TAGS ('dbx_business_glossary_term' = 'Price List Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_type` SET TAGS ('dbx_value_regex' = 'base|promotional|clearance|seasonal|custom');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC|LATAM|MEA');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Price List Version Number');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_list_line_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Line ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Price Approver User ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Version Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `superseded_price_list_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `ceiling_price` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct|online|wholesale');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `floor_price` SET TAGS ('dbx_business_glossary_term' = 'Floor Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `min_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Price Approval Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Change Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Price Condition Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_currency_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Effective Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Expiration Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Margin Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Margin Percentage');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_notes` SET TAGS ('dbx_business_glossary_term' = 'Price Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Override Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_source_system` SET TAGS ('dbx_business_glossary_term' = 'Price Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|promo|cost_plus|tiered|contract|clearance');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `price_version` SET TAGS ('dbx_business_glossary_term' = 'Price Version');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC|LATAM|MEA');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|ML|BOX');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `price_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `demand_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Demand Balance Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `distribution_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `price_group_id` SET TAGS ('dbx_business_glossary_term' = 'Price Group ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `sales_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `superseded_price_condition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `condition_category` SET TAGS ('dbx_business_glossary_term' = 'Condition Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `condition_key` SET TAGS ('dbx_business_glossary_term' = 'Condition Key');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Type (PR00 etc.)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_value_regex' = 'PR00|K004|K005|RA01|K007|K008');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `condition_version` SET TAGS ('dbx_business_glossary_term' = 'Condition Version');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Exclusive');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Entry');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `last_changed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Changed By');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `max_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `min_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `price_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `price_condition_group` SET TAGS ('dbx_business_glossary_term' = 'Condition Group');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `price_condition_source` SET TAGS ('dbx_business_glossary_term' = 'Condition Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `pricing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Condition Priority');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `rate` SET TAGS ('dbx_business_glossary_term' = 'Condition Rate');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `scale_amount` SET TAGS ('dbx_business_glossary_term' = 'Scale Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `scale_basis` SET TAGS ('dbx_business_glossary_term' = 'Scale Basis');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `scale_basis` SET TAGS ('dbx_value_regex' = 'quantity|weight|volume|value|percentage');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Indicator');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `tax_indicator` SET TAGS ('dbx_value_regex' = 'taxable|non_taxable|exempt');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Identifier (PPI)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `superseded_procedure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `allow_discount` SET TAGS ('dbx_business_glossary_term' = 'Allow Discount Flag (ADF)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `allow_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Allow Surcharge Flag (ASF)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (AS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (AB)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method (CM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'list_price|cost_plus|margin|dynamic');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `condition_type_count` SET TAGS ('dbx_business_glossary_term' = 'Condition Type Count (CTC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `condition_type_sequence` SET TAGS ('dbx_business_glossary_term' = 'Condition Type Sequence (CTS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `cost_plus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Plus Percentage (CPP)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel (DC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct|online');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division (DIV)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `include_freight` SET TAGS ('dbx_business_glossary_term' = 'Include Freight Flag (IFF)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `include_tax` SET TAGS ('dbx_business_glossary_term' = 'Include Tax Flag (ITF)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Flag (IDF)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `max_condition_steps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Condition Steps (MCS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `max_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Margin Percent (XMP)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `min_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Margin Percent (MMP)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `price_change_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approval Required Flag (PCARF)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `price_change_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approval Status (PCAS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `price_change_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `price_change_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approval Timestamp (PCAT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `price_change_approver` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approver (PCA)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `price_change_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Price Change Effective Date (PCED)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `price_change_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Change History Flag (PCHF)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `price_change_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Price Change Notice Days (PCND)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason (PCR)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `price_override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Price Override Allowed Flag (POAF)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `pricing_currency` SET TAGS ('dbx_business_glossary_term' = 'Pricing Currency (PC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `pricing_currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Code (PPC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `procedure_code` SET TAGS ('dbx_value_regex' = '^PP[0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Description (PPD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `procedure_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Name (PPN)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Status (PPS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Type (PPT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_value_regex' = 'standard|promo|custom');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Rounding Rule (RR)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_value_regex' = 'up|down|nearest');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization (SO)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UB)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VN)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CB)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `procedure_step_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Step Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `capacity_constraint_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `reference_procedure_step_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `account_key` SET TAGS ('dbx_business_glossary_term' = 'Account Key (Pricing)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `calculation_type` SET TAGS ('dbx_business_glossary_term' = 'Calculation Type (Pricing)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `calculation_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|formula|lookup');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `calculation_value` SET TAGS ('dbx_business_glossary_term' = 'Calculation Value');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `condition_operator` SET TAGS ('dbx_business_glossary_term' = 'Condition Operator');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `condition_operator` SET TAGS ('dbx_value_regex' = '=|>|<|>=|<=');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type (Pricing)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `condition_type` SET TAGS ('dbx_value_regex' = 'discount|surcharge|rebate|price_change|tax|fee');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `condition_value` SET TAGS ('dbx_business_glossary_term' = 'Condition Value');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `printed_flag` SET TAGS ('dbx_business_glossary_term' = 'Printed Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Step Priority');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `procedure_step_description` SET TAGS ('dbx_business_glossary_term' = 'Step Description');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `requirement_routine` SET TAGS ('dbx_business_glossary_term' = 'Requirement Routine');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `statistical_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `step_category` SET TAGS ('dbx_business_glossary_term' = 'Step Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `step_name` SET TAGS ('dbx_business_glossary_term' = 'Step Name');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Number');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` SET TAGS ('dbx_subdomain' = 'price_execution');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_price_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Price ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `superseded_channel_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'retail|foodservice|dtc|club|convenience|vending');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|MXN');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'cost_plus|edlp|promo|negotiated');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|discount|promo');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'net|list|promo');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_version` SET TAGS ('dbx_business_glossary_term' = 'Price Version');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'each|case|kg|lb|liter|gallon');
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_plus_model_id` SET TAGS ('dbx_business_glossary_term' = 'Cost-Plus Model Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `superseded_cost_plus_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `applicable_product_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `applicable_product_category` SET TAGS ('dbx_value_regex' = 'snack|beverage|dairy|frozen|prepared_meal');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_plus_model_description` SET TAGS ('dbx_business_glossary_term' = 'Model Description');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_plus_model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_plus_model_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|archived');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_source_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Source Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Base Cost Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'standard_cost|moving_average|contract_cost');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Model Indicator');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage (MP)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `maximum_price` SET TAGS ('dbx_business_glossary_term' = 'Maximum Price (Ceiling)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `minimum_price` SET TAGS ('dbx_business_glossary_term' = 'Minimum Price (Floor)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Cost-Plus Model Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Cost-Plus Model Name (CPM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Model Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `target_contribution_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Contribution Margin Percentage (TCM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `target_gross_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Margin Percentage (TGM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Model Version Number');
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` SET TAGS ('dbx_subdomain' = 'price_execution');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotional_price_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `label_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `superseded_promotional_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'RETAIL|FOOD_SERVICE|DTC|ONLINE');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'CONSUMER|HOSPITALITY|GROCERY|DISCOUNT');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `minimum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'NET|LIST|GROSS');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'PER_UNIT|PER_WEIGHT|PER_VOLUME');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotion_category` SET TAGS ('dbx_business_glossary_term' = 'Promotion Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotion_category` SET TAGS ('dbx_value_regex' = 'PRICE_REDUCTION|VOLUME_INCENTIVE|DISPLAY');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotion_description` SET TAGS ('dbx_business_glossary_term' = 'Promotion Description');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Name');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotion_source_system` SET TAGS ('dbx_business_glossary_term' = 'Promotion Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotion_source_system` SET TAGS ('dbx_value_regex' = 'SAP|ORACLE|SALESFORCE|CUSTOM');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotion_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|EXPIRED|PENDING');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'TPR|BOGO|MULTI_BUY|SCAN_DOWN|DISPLAY');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `promotional_price` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `price_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Price Scale Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `price_list_line_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `parent_price_scale_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `is_promotional` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `price_change_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approval Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `price_change_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approver');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `price_scale_description` SET TAGS ('dbx_business_glossary_term' = 'Price Scale Description');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `price_scale_status` SET TAGS ('dbx_business_glossary_term' = 'Price Scale Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `price_scale_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `scale_basis` SET TAGS ('dbx_business_glossary_term' = 'Scale Basis');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `scale_basis` SET TAGS ('dbx_value_regex' = 'quantity|weight|value');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `scale_code` SET TAGS ('dbx_business_glossary_term' = 'Price Scale Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `scale_name` SET TAGS ('dbx_business_glossary_term' = 'Price Scale Name');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `scale_type` SET TAGS ('dbx_business_glossary_term' = 'Scale Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `scale_type` SET TAGS ('dbx_value_regex' = 'graduated|from_value');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `tier_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Tiers');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_scale` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` SET TAGS ('dbx_subdomain' = 'governance_control');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `price_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Request ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID (APPR_ID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non Conformance Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `primary_price_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID (REQR_ID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `primary_price_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `primary_price_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `superseded_price_change_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel (CHANNEL)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct|online');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `competitive_rationale` SET TAGS ('dbx_business_glossary_term' = 'Competitive Rationale (COMP_RAT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `cost_plus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Plus Percentage (COST_PLUS_PCT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `current_price` SET TAGS ('dbx_business_glossary_term' = 'Current Price (CURRENT_PRC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `forecasted_margin_impact` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Margin Impact (FORECAST_MARGIN)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `forecasted_sales_impact` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Sales Impact (FORECAST_SALES)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `justification_text` SET TAGS ('dbx_business_glossary_term' = 'Business Justification (JUSTIF_TXT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `margin_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Impact Percent (MARGIN_IMP_PCT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (SEGMENT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'mass|premium|value|organic');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `price_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Price Ceiling (CEILING_PRC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `price_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount (CHANGE_AMT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `price_change_request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Lifecycle Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `price_change_request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `price_floor` SET TAGS ('dbx_business_glossary_term' = 'Price Floor (FLOOR_PRC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `proposed_price` SET TAGS ('dbx_business_glossary_term' = 'Proposed Price (PROPOSED_PRC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (REGION_CD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Price Change Request Number (REQ_NUM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Timestamp (REQ_TS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Price Change Type (TYPE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'new|increase|decrease|promotional');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `sku_count` SET TAGS ('dbx_business_glossary_term' = 'Affected SKU Count (SKU_CNT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `total_sku_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total SKU Quantity (SKU_QTY_TOT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` SET TAGS ('dbx_subdomain' = 'governance_control');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Price Approval ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Request Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `primary_price_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `primary_price_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `primary_price_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `escalated_from_price_approval_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `approval_deadline` SET TAGS ('dbx_business_glossary_term' = 'Approval Deadline Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role (Manager/Director/VP/CFO)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `approver_role` SET TAGS ('dbx_value_regex' = 'manager|director|vp|cfo');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Record ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel (Retail/Foodservice/DTC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|dtc');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Approver Comments');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|escalated');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `delegation_flag` SET TAGS ('dbx_business_glossary_term' = 'Delegation Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date of New Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `new_price` SET TAGS ('dbx_business_glossary_term' = 'New Price Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `previous_price` SET TAGS ('dbx_business_glossary_term' = 'Previous Price Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount (New - Previous)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_category` SET TAGS ('dbx_business_glossary_term' = 'Price Change Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_category` SET TAGS ('dbx_value_regex' = 'standard|special|seasonal');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Impact Currency Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Description of Impact Estimate');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact of Price Change');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_justification` SET TAGS ('dbx_business_glossary_term' = 'Justification for Price Change');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Price Change');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_type` SET TAGS ('dbx_business_glossary_term' = 'Price Change Type (Cost‑Plus/Promotional/Markdown/Clearance)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `price_change_type` SET TAGS ('dbx_value_regex' = 'cost_plus|promotional|markdown|clearance');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `request_source` SET TAGS ('dbx_value_regex' = 'system|manual|api');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Change Request Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` SET TAGS ('dbx_subdomain' = 'analytics_insight');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `pricing_price_history_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Price History ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Request ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `previous_pricing_price_history_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `change_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'cost_increase|promotion|competitor|regulatory|seasonal|other');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct_to_consumer|online|wholesale|partner');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `customer_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `customer_segment_code` SET TAGS ('dbx_value_regex' = 'consumer|foodservice|industrial|government|private_label|other');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `event_source` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Custom|Salesforce|JDA|MES');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'price_change');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `new_price` SET TAGS ('dbx_business_glossary_term' = 'New Price (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `previous_price` SET TAGS ('dbx_business_glossary_term' = 'Previous Price (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_change_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approval Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_change_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_change_category` SET TAGS ('dbx_business_glossary_term' = 'Price Change Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_change_category` SET TAGS ('dbx_value_regex' = 'cost_plus|margin_based|competitive|strategic|regulatory|other');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_change_method` SET TAGS ('dbx_business_glossary_term' = 'Price Change Method');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_change_method` SET TAGS ('dbx_value_regex' = 'manual|system|batch');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_change_notes` SET TAGS ('dbx_business_glossary_term' = 'Price Change Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_change_origin` SET TAGS ('dbx_business_glossary_term' = 'Price Change Origin');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_change_origin` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'regular|promotional|clearance|seasonal|contract|other');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` SET TAGS ('dbx_subdomain' = 'governance_control');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `customer_price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Price Agreement ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `renewed_customer_price_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'contract|blanket|spot|volume');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `customer_price_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `customer_price_agreement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|draft|terminated');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|amount|none');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_agreement_effective_quantity_max` SET TAGS ('dbx_business_glossary_term' = 'Effective Quantity Maximum');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_agreement_effective_quantity_min` SET TAGS ('dbx_business_glossary_term' = 'Effective Quantity Minimum');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_agreement_revision` SET TAGS ('dbx_business_glossary_term' = 'Agreement Revision');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_agreement_scope` SET TAGS ('dbx_business_glossary_term' = 'Agreement Scope');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_agreement_scope` SET TAGS ('dbx_value_regex' = 'global|regional|local');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_agreement_target_customer_type` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_agreement_target_customer_type` SET TAGS ('dbx_value_regex' = 'retailer|foodservice|distributor|other');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_agreement_version` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'cost_plus|market|list|custom');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Margin Percent');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_source_system` SET TAGS ('dbx_business_glossary_term' = 'Price Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Salesforce|Custom|Other');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_tax_included` SET TAGS ('dbx_business_glossary_term' = 'Price Tax Included Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Price Tax Rate');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_tier_description` SET TAGS ('dbx_business_glossary_term' = 'Price Tier Description');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_tier_level` SET TAGS ('dbx_business_glossary_term' = 'Price Tier Level');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_case|per_kg|per_liter');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_validity_status` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `price_validity_status` SET TAGS ('dbx_value_regex' = 'current|expired|upcoming');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` SET TAGS ('dbx_subdomain' = 'governance_control');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `price_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Price Exception Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (APP_ID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ORD_ID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Identifier (PL_ID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PROD_ID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (TXN_ID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `related_price_exception_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPR_DT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel (CHNL)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct_to_consumer');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMP_FLG)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRT_TS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CUR)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `exception_amount` SET TAGS ('dbx_business_glossary_term' = 'Exception Amount (AMT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `exception_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code (EXC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `exception_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exception Percentage (PCT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `exception_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code (REASON_CD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Event Timestamp (TS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type (TYPE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'below_floor|above_ceiling|outside_agreement');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag (MAN_OVR)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Exception Justification (JST)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes (NOTE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `price_exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status (STAT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `price_exception_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revoked');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` SET TAGS ('dbx_subdomain' = 'analytics_insight');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `competitor_price_id` SET TAGS ('dbx_business_glossary_term' = 'Competitor Price Record Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `previous_competitor_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `competitor_sku_code` SET TAGS ('dbx_business_glossary_term' = 'Competitor SKU Code (UPC/GTIN)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `data_capture_method` SET TAGS ('dbx_business_glossary_term' = 'Data Capture Method');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `data_capture_method` SET TAGS ('dbx_value_regex' = 'scan|manual|automated');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `geography_region` SET TAGS ('dbx_business_glossary_term' = 'Geography Region');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `is_promotion` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `observed_price` SET TAGS ('dbx_business_glossary_term' = 'Observed Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_per_volume` SET TAGS ('dbx_business_glossary_term' = 'Price Per Volume');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'Nielsen|IRI|Field|WebScrape');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_unit|per_oz|per_liter|per_kg|per_gallon');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'discount|bogo|bundle|clearance|none');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `promotional_price` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `retailer_channel` SET TAGS ('dbx_business_glossary_term' = 'Retailer Channel');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `retailer_channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|dtc|online|wholesale|other');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `retailer_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Name');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `shelf_price` SET TAGS ('dbx_business_glossary_term' = 'Shelf Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `store_city` SET TAGS ('dbx_business_glossary_term' = 'Store City');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `store_country` SET TAGS ('dbx_business_glossary_term' = 'Store Country Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `store_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `store_state` SET TAGS ('dbx_business_glossary_term' = 'Store State/Province');
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` SET TAGS ('dbx_subdomain' = 'price_execution');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `retail_shelf_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Shelf Price ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `promotional_price_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Account ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `previous_retail_shelf_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `actual_price` SET TAGS ('dbx_business_glossary_term' = 'Actual Shelf Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `competitor_price` SET TAGS ('dbx_business_glossary_term' = 'Competitor Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_date` SET TAGS ('dbx_business_glossary_term' = 'Price Observation Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_elasticity_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Elasticity Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_gap_to_competition` SET TAGS ('dbx_business_glossary_term' = 'Price Gap to Competition');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_per_oz` SET TAGS ('dbx_business_glossary_term' = 'Price Per Ounce');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'audit|third_party|system|manual');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'recommended|actual');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `recommended_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Retail Price (RRP)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` SET TAGS ('dbx_subdomain' = 'analytics_insight');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `price_elasticity_id` SET TAGS ('dbx_business_glossary_term' = 'Price Elasticity Record ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `previous_price_elasticity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `confidence_interval_high` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `confidence_interval_low` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `cross_competitor_sku` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Competitor SKU');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `cross_price_elasticity` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Price Elasticity Coefficient');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `elasticity_model_version` SET TAGS ('dbx_business_glossary_term' = 'Elasticity Model Version');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'econometric|ml|hybrid');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `own_price_elasticity` SET TAGS ('dbx_business_glossary_term' = 'Own‑Price Elasticity Coefficient');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `price_elasticity_status` SET TAGS ('dbx_business_glossary_term' = 'Elasticity Record Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `price_elasticity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `price_threshold` SET TAGS ('dbx_business_glossary_term' = 'Price Threshold');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_IBP|Oracle_ERP|Salesforce');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `surcharge_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rule Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `parent_surcharge_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Employee ID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'flat_fee|percentage|tiered');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `minimum_order_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rule Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `percent_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rate');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `responsible_owner` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner (Employee ID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rule Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rule Name');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `surcharge_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `surcharge_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `surcharge_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_value_regex' = 'fuel|small_order|cold_chain|minimum_order|dtc_fulfillment');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `tax_applicable` SET TAGS ('dbx_business_glossary_term' = 'Tax Applicable');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency Unit');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Tiered Structure Definition');
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `discount_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Rule Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `parent_discount_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `applicable_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Segment');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `applicable_product_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `applicable_product_sku` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product SKU');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'FDA|GFSI|USDA|EFSA|ISO22000|ISO9001');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `discount_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Discount Rule Description');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `discount_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Discount Rule Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `discount_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|per_case|tiered');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `discount_unit` SET TAGS ('dbx_business_glossary_term' = 'Discount Unit');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `discount_unit` SET TAGS ('dbx_value_regex' = 'percent|currency|per_case');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `maximum_discount_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Cap');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Discount Rule Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Rule Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Discount Rule Name');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `stack_order` SET TAGS ('dbx_business_glossary_term' = 'Stack Order');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `cost_plus_model_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Plus Model Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Entity ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `receiving_entity_company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Entity ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `superseded_transfer_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `cup_reference` SET TAGS ('dbx_business_glossary_term' = 'CUP Reference');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Documentation Reference');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `price_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'intercompany|internal|external');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `price_version` SET TAGS ('dbx_business_glossary_term' = 'Price Version');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Pricing Method');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `pricing_method` SET TAGS ('dbx_value_regex' = 'cost_plus|resale_minus|cup|tnmm');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `resale_minus_amount` SET TAGS ('dbx_business_glossary_term' = 'Resale‑Minus Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'SKU Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `tax_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `tax_authority_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `tnmm_reference` SET TAGS ('dbx_business_glossary_term' = 'TNMM Reference');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `transfer_price_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `transfer_price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|draft');
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` SET TAGS ('dbx_subdomain' = 'analytics_insight');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `price_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Price Simulation Identifier (PSI)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Identifier (OWNER_ID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `baseline_price_simulation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (APPROVED_BY)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVED_TS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `competitive_response_assumption` SET TAGS ('dbx_business_glossary_term' = 'Competitive Response Assumption (COMP_RESP_ASSUMP)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `cost_plus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Plus Percentage (COST_PLUS_PCT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (DATA_SRC_SYS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END_DATE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START_DATE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `estimated_margin` SET TAGS ('dbx_business_glossary_term' = 'Estimated Margin (EST_MARGIN)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue (EST_REVENUE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `estimated_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume (EST_VOLUME)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `forecasted_impact` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Impact Description (FORECASTED_IMPACT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DATE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Percent (MARGIN_PCT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason (PRICE_CHANGE_REASON)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `price_simulation_status` SET TAGS ('dbx_business_glossary_term' = 'Simulation Status (SIM_STATUS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `price_simulation_status` SET TAGS ('dbx_value_regex' = 'draft|reviewed|submitted|approved|rejected|archived');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `proposed_price` SET TAGS ('dbx_business_glossary_term' = 'Proposed Price (PROPOSED_PRICE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (REG_COMPL_FLAG)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Scenario Description (SCEN_DESC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name (SCEN_NAME)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `scenario_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason Description (STATUS_REASON)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `sensitivity_analysis_flag` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Analysis Performed Flag (SENS_ANALYSIS_FLAG)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `sensitivity_range_percent` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Range Percent (SENS_RANGE_PCT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `simulation_code` SET TAGS ('dbx_business_glossary_term' = 'Simulation Code (SIM_CODE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `simulation_date` SET TAGS ('dbx_business_glossary_term' = 'Simulation Date (SIM_DATE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `simulation_scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Simulation Scenario Type (SIM_SCEN_TYPE)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `simulation_scenario_type` SET TAGS ('dbx_value_regex' = 'what_if|price_optimization|cost_plus|promotion|other');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (UPDATED_BY)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (VOLUME_UOM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'cases|units|kg|liters|gallons|pounds');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CREATED_BY)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` SET TAGS ('dbx_subdomain' = 'price_execution');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `foodservice_price_id` SET TAGS ('dbx_business_glossary_term' = 'Foodservice Price ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `superseded_foodservice_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `broadline_price` SET TAGS ('dbx_business_glossary_term' = 'Broadline Distributor Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `broadline_price_uom` SET TAGS ('dbx_business_glossary_term' = 'Broadline Price Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `broadline_price_uom` SET TAGS ('dbx_value_regex' = 'case|unit|portion|split_case');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `case_price` SET TAGS ('dbx_business_glossary_term' = 'Case Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `case_price_uom` SET TAGS ('dbx_business_glossary_term' = 'Case Price Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `case_price_uom` SET TAGS ('dbx_value_regex' = 'case|unit|portion|split_case');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `contract_price` SET TAGS ('dbx_business_glossary_term' = 'Contract Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `contract_price_uom` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `contract_price_uom` SET TAGS ('dbx_value_regex' = 'case|unit|portion|split_case');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `cost_plus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost-Plus Percentage');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `distributor` SET TAGS ('dbx_business_glossary_term' = 'Distributor');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `foodservice_price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `foodservice_price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Percent');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `operator_segment` SET TAGS ('dbx_business_glossary_term' = 'Operator Segment');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `operator_segment` SET TAGS ('dbx_value_regex' = 'QSR|FSR|Healthcare|Education|Lodging|Vending');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `portion_price` SET TAGS ('dbx_business_glossary_term' = 'Portion Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `portion_price_uom` SET TAGS ('dbx_business_glossary_term' = 'Portion Price Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `portion_price_uom` SET TAGS ('dbx_value_regex' = 'case|unit|portion|split_case');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Price Calculation Method');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_calculation_method` SET TAGS ('dbx_value_regex' = 'cost_plus|margin|fixed|dynamic');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_category` SET TAGS ('dbx_business_glossary_term' = 'Price Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_category` SET TAGS ('dbx_value_regex' = 'standard|promotional|contract|special');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_ceiling_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Ceiling Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_floor_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Floor Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'distributor|operator|broadline|internal');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_source_system` SET TAGS ('dbx_business_glossary_term' = 'Price Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4|tier5');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'net|gross|contract|broadline|promotional');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `price_version` SET TAGS ('dbx_business_glossary_term' = 'Price Version');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `split_case_price` SET TAGS ('dbx_business_glossary_term' = 'Split-Case Price');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `split_case_price_uom` SET TAGS ('dbx_business_glossary_term' = 'Split-Case Price Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `split_case_price_uom` SET TAGS ('dbx_value_regex' = 'case|unit|portion|split_case');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'case|unit|portion|split_case');
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` SET TAGS ('dbx_subdomain' = 'price_execution');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `dtc_price_id` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer Price Record ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Rule ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `superseded_dtc_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `bundle_price` SET TAGS ('dbx_business_glossary_term' = 'Bundle Price (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `dtc_price_description` SET TAGS ('dbx_business_glossary_term' = 'Price Description');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `dynamic_pricing_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Pricing Algorithm');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `dynamic_pricing_algorithm` SET TAGS ('dbx_value_regex' = 'rule_based|ml|manual');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `is_dynamic` SET TAGS ('dbx_business_glossary_term' = 'Is Dynamic Pricing');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `margin_floor` SET TAGS ('dbx_business_glossary_term' = 'Margin Floor (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `member_price` SET TAGS ('dbx_business_glossary_term' = 'Member Price (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Price Approval Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_category` SET TAGS ('dbx_business_glossary_term' = 'Price Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_category` SET TAGS ('dbx_value_regex' = 'standard|promotional|clearance');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_ceiling_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Ceiling Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_code` SET TAGS ('dbx_business_glossary_term' = 'Price Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_effective_days` SET TAGS ('dbx_business_glossary_term' = 'Price Effective Days');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_effective_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Effective Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_floor_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Floor Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_review_date` SET TAGS ('dbx_business_glossary_term' = 'Price Review Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'sap|oracle|custom|manual');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'regular|member|subscriber|bundle');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_unit|per_kg|per_liter');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `price_version` SET TAGS ('dbx_business_glossary_term' = 'Price Version Number');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `regular_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Price (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `subscriber_price` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Price (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Identifier (PZID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `parent_zone_price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Zone Identifier (PZID)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `parent_price_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_business_glossary_term' = 'Applicable Channels (AC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct_to_consumer|online|wholesale');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag (CF)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes (ISO‑3)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO‑4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope (GS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'country|region|state|metro|nielsen_market');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level (HL)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Zone Indicator (DZI)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LRD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `maximum_price` SET TAGS ('dbx_business_glossary_term' = 'Maximum Price (MaxP)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `metro_area` SET TAGS ('dbx_business_glossary_term' = 'Metropolitan Area (MA)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `minimum_price` SET TAGS ('dbx_business_glossary_term' = 'Minimum Price (MinP)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `nielsen_market` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Market (NM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_change_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approval Required (PCAR)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_change_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approval Status (PCAS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_change_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_change_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approval Timestamp (PCAT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_change_approver` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approver (PCA)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_change_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Price Change Effective Date (PCED)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_change_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Change History Flag (PCHF)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_change_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Price Change Notice Days (PCND)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason (PCR)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Price Multiplier (PM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Code (PZC)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_description` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Description (PZD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_name` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Name (PZN)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_status` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Status (PZS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|retired');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_type` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Type (PZT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_type` SET TAGS ('dbx_value_regex' = 'geographic|demographic|channel_specific');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `pricing_authority` SET TAGS ('dbx_business_glossary_term' = 'Pricing Authority (PA)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region (REG)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (RCF)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months) (RCM)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province (ST)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VN)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CB)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` SET TAGS ('dbx_subdomain' = 'price_execution');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `price_waterfall_id` SET TAGS ('dbx_business_glossary_term' = 'Price Waterfall Record Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `reference_price_waterfall_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `amount_allowance` SET TAGS ('dbx_business_glossary_term' = 'Allowance Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `amount_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `amount_discount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `amount_discount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `amount_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `amount_net` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `amount_tax` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `amount_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `is_manual_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Manual Adjustment Indicator');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `price_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Change Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'system|manual|external');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|net|promo|contract');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `price_waterfall_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `price_waterfall_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|reversed|cancelled');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'price_change|promotion|contractual|error');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Salesforce|JDA|MES');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `step_category` SET TAGS ('dbx_business_glossary_term' = 'Step Category');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `step_category` SET TAGS ('dbx_value_regex' = 'gross|discount|allowance|tax|net');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `step_name` SET TAGS ('dbx_business_glossary_term' = 'Step Name');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Number');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` SET TAGS ('dbx_subdomain' = 'price_execution');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `revenue_realization_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Realization Record ID');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `prior_period_revenue_realization_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `allowance_flag` SET TAGS ('dbx_business_glossary_term' = 'Allowance Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `case_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Size Quantity');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `cost_plus_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Plus Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `discount_flag` SET TAGS ('dbx_business_glossary_term' = 'Discount Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `net_revenue_per_case` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Per Case (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `net_revenue_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Per Unit (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `period_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Period Date');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|promotional|cost_plus|trade_spend');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `pricing_version` SET TAGS ('dbx_business_glossary_term' = 'Pricing Version');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `return_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `revenue_realization_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Realization Status');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `revenue_realization_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Salesforce|JDA');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `total_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allowance Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `total_return_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Return Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `total_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Trade Spend Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `trade_spend_flag` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Flag');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` SET TAGS ('dbx_subdomain' = 'governance_control');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` SET TAGS ('dbx_association_edges' = 'distribution.distribution_center,pricing.price_list');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` ALTER COLUMN `price_list_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Assignment - Price List Assignment Id');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Assignment - Distribution Center Id');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Assignment - Price List Id');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Price List Assignment - Channel');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Price List Assignment - Effective From');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Price List Assignment - Effective Until');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Price List Assignment - Region');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_rule` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_rule` ALTER COLUMN `parent_price_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_group` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_group` ALTER COLUMN `price_group_id` SET TAGS ('dbx_business_glossary_term' = 'Price Group Identifier');
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_group` ALTER COLUMN `parent_price_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
