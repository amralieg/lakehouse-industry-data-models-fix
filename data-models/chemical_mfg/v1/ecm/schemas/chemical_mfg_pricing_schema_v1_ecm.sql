-- Schema for Domain: pricing | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`pricing` COMMENT 'Centralized pricing management including price lists, pricing strategies, cost-plus calculations, market-based pricing, volume discounts, surcharges (energy, raw material index), and transfer pricing for chemical products across all channels and geographies.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`price_list` (
    `price_list_id` BIGINT COMMENT 'Unique identifier for the price list record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Account‑specific negotiated price list assignment used in sales contracts and pricing approvals.',
    `horizon_id` BIGINT COMMENT 'Foreign key linking to planning.planning_horizon. Business justification: Price lists are created for a specific planning horizon to align pricing with budget cycles and forecast periods.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Price List Ownership Report requires linking each price list to the responsible org unit/plant for accountability and compliance.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: A price list is governed by a single pricing strategy; linking price_list to pricing_strategy enables direct lookup of strategy parameters and eliminates the need to infer strategy through multiple do',
    `superseded_price_list_id` BIGINT COMMENT 'Self-referencing FK on price_list (superseded_price_list_id)',
    `activation_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list was activated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the price list.. Valid values are `[A-Z]{3}`',
    `currency_rate` DECIMAL(18,2) COMMENT 'Exchange rate to base currency at the time of price list creation.',
    `customer_group_code` STRING COMMENT 'Customer group identifier for price list targeting.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list was deactivated, if applicable.',
    `default_margin_percent` DECIMAL(18,2) COMMENT 'Default margin percentage applied when no specific margin is defined.',
    `discount_type` STRING COMMENT 'Type of discount or surcharge applied in the price list.. Valid values are `volume|tier|rebate|surcharge|none`',
    `distribution_channel_code` STRING COMMENT 'Code of the distribution channel for which the price list is valid.',
    `effective_from` DATE COMMENT 'Date when the price list becomes effective.',
    `effective_to` DATE COMMENT 'Date when the price list expires (null if open‑ended).',
    `is_default` BOOLEAN COMMENT 'Indicates if this price list is the default for its scope.',
    `is_global` BOOLEAN COMMENT 'Indicates if the price list applies globally across all sales orgs and regions.',
    `material_group_code` STRING COMMENT 'Material group identifier for price list applicability.',
    `notes` STRING COMMENT 'Free‑form notes regarding the price list.',
    `owner` STRING COMMENT 'Owner or responsible department for the price list.',
    `plant_code` STRING COMMENT 'Plant identifier where the price list is applicable.',
    `price_list_category` STRING COMMENT 'Higher‑level categorization of the price list.. Valid values are `standard|promotional|contract|customer_specific|regional|global`',
    `price_list_code` STRING COMMENT 'Unique business code identifying the price list.',
    `price_list_description` STRING COMMENT 'Longer textual description of the price list purpose and scope.',
    `price_list_name` STRING COMMENT 'Descriptive name of the price list.',
    `price_list_status` STRING COMMENT 'Current lifecycle status of the price list.. Valid values are `active|inactive|draft|pending|archived`',
    `price_list_type` STRING COMMENT 'Classification of the price list indicating its purpose.. Valid values are `standard|promotional|contract|customer_specific`',
    `pricing_method` STRING COMMENT 'Methodology used to calculate prices in the list.. Valid values are `cost_plus|market_based|fixed|tiered|volume|surcharge`',
    `region_code` STRING COMMENT 'Geographic region code for price list applicability.',
    `sales_org_code` STRING COMMENT 'Identifier of the sales organization to which the price list applies.',
    `tax_included_flag` BOOLEAN COMMENT 'Indicates whether taxes are included in the listed prices.',
    `updated_by` STRING COMMENT 'User identifier who last updated the price list.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price list record.',
    `version_number` STRING COMMENT 'Sequential version number of the price list.',
    `created_by` STRING COMMENT 'User identifier who created the price list.',
    CONSTRAINT pk_price_list PRIMARY KEY(`price_list_id`)
) COMMENT 'Master record for published standard price lists defining baseline list prices for chemical products, grades, and SKUs by currency, sales organization, and distribution channel. Manages price list versioning, validity periods, and activation status. Serves as the foundational pricing reference for all customer-facing price calculations in SAP SD condition technique. Distinct from sales.price_list which is the commercial/sales-facing view — this is the authoritative pricing master owned by the pricing domain.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` (
    `price_list_item_id` BIGINT COMMENT 'System-generated unique identifier for the price list line item.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Price list generation report requires each price list item to reference the master chemical product for cost, compliance, and margin calculations.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Formulation‑based pricing: pricing team uses experimental formulation data to calculate SKU cost and set list price.',
    `forecast_version_id` BIGINT COMMENT 'Foreign key linking to planning.forecast_version. Business justification: Price list items are derived from a particular demand forecast version used in pricing simulations.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Price list items must reference the exact formula version to ensure compliance with versioned specifications and traceability.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Price List Management requires each price list item to reference the specific raw material it prices; linking enables accurate material‑wise pricing reports.',
    `price_list_id` BIGINT COMMENT 'Identifier of the parent price list that this line belongs to.',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Pricing team sets list item prices based on specific quality specifications; required for Specification‑Based Pricing report.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Site‑level pricing items for customers with multiple sites, required for site‑specific price calculations.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU‑level pricing is defined per price‑list item; linking to the SKU master enables correct packaging, hazard, and unit‑of‑measure handling.',
    `superseded_price_list_item_id` BIGINT COMMENT 'Self-referencing FK on price_list_item (superseded_price_list_item_id)',
    `approval_status` STRING COMMENT 'Current approval state of the price line.. Valid values are `approved|rejected|pending`',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the price.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the price complies with REACH, GHS, or other regulations.',
    `compliance_notes` STRING COMMENT 'Additional notes on regulatory compliance considerations.',
    `cost_basis_amount` DECIMAL(18,2) COMMENT 'Underlying cost used for cost‑plus pricing calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the price list item record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price amount.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Business segment for which the price is defined.. Valid values are `industrial|consumer|government|research|distributor`',
    `effective_from` DATE COMMENT 'Date when the price becomes valid.',
    `effective_until` DATE COMMENT 'Date when the price expires (null for open‑ended).',
    `energy_surcharge_amount` DECIMAL(18,2) COMMENT 'Additional charge reflecting energy cost fluctuations.',
    `is_default_price` BOOLEAN COMMENT 'True if this line represents the default price for the product.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who performed the latest update.',
    `last_modified_reason` STRING COMMENT 'Reason or comment for the most recent change.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the price list.',
    `margin_percent` DECIMAL(18,2) COMMENT 'Target profit margin expressed as a percentage.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered at this price.',
    `price_amount` DECIMAL(18,2) COMMENT 'Base price amount for one unit of the product.',
    `price_category` STRING COMMENT 'Classification of the product for pricing purposes.. Valid values are `raw_material|intermediate|finished|specialty|custom`',
    `price_change_timestamp` TIMESTAMP COMMENT 'Date‑time when the price amount was last changed.',
    `price_description` STRING COMMENT 'Free‑form notes describing the pricing context or conditions.',
    `price_list_item_status` STRING COMMENT 'Current lifecycle status of the price line.. Valid values are `active|inactive|pending|expired|draft`',
    `price_source` STRING COMMENT 'Origin of the price data (e.g., SAP, manual entry).. Valid values are `SAP|ERP|Manual|External|PricingEngine`',
    `price_type` STRING COMMENT 'Classification of the pricing methodology.. Valid values are `list|cost_plus|market|promotional|contract|special`',
    `price_uom_factor` DECIMAL(18,2) COMMENT 'Factor to convert between base UOM and pricing UOM.',
    `price_validity_reason` STRING COMMENT 'Reason for the prices validity period (e.g., promotion, cost change).',
    `price_version` STRING COMMENT 'Version identifier for price changes over time.',
    `raw_material_index_factor` DECIMAL(18,2) COMMENT 'Multiplier based on raw‑material price index for dynamic pricing.',
    `region_code` STRING COMMENT 'Geographic region to which the price applies.. Valid values are `^[A-Z]{3}$`',
    `surcharge_flag` BOOLEAN COMMENT 'Indicates whether a surcharge (e.g., energy, raw‑material index) is applied.',
    `tax_included_flag` BOOLEAN COMMENT 'True if taxes are already included in the price amount.',
    `unit_of_measure` STRING COMMENT 'Measurement unit in which the price is expressed (e.g., kg, L, ton).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the record.',
    `volume_discount_tier` STRING COMMENT 'Discount tier based on ordered volume.. Valid values are `tier1|tier2|tier3|tier4|tier5|tier6`',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_price_list_item PRIMARY KEY(`price_list_item_id`)
) COMMENT 'Individual line-level price record within a price list, defining the unit price for a specific chemical product SKU, grade, or material in a given currency and unit of measure. Captures list price amount, pricing UOM, minimum order quantity, and validity dates. Supports multi-currency pricing and regional price differentiation for chemical products across global markets.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`condition` (
    `condition_id` BIGINT COMMENT 'System-generated unique identifier for the pricing condition record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Carrier‑specific pricing conditions for freight surcharges used in product pricing calculations.',
    `parameter_id` BIGINT COMMENT 'Foreign key linking to planning.planning_parameter. Business justification: Many pricing conditions (e.g., safety stock, lot size) reference planning parameters defined in MRP settings.',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Pricing conditions (discounts/surcharges) are applied when a product meets a particular quality specification, used in the Specification‑Based Discount policy.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Pricing condition belongs to a pricing strategy; adds strategic context',
    `parent_condition_id` BIGINT COMMENT 'Self-referencing FK on condition (parent_condition_id)',
    `access_sequence` STRING COMMENT 'Sequence number that determines the order of condition evaluation.',
    `amount` DECIMAL(18,2) COMMENT 'Default monetary amount or percentage associated with the condition.',
    `applicable_customer_group` STRING COMMENT 'Customer group code to which the condition applies.',
    `applicable_material_group` STRING COMMENT 'Material group code for which the condition is relevant.',
    `applicable_region` STRING COMMENT 'Geographic region code (ISO 3166‑1 alpha‑3) where the condition is valid.',
    `calculation_type` STRING COMMENT 'Method used to calculate the condition value.. Valid values are `percentage|fixed_amount|formula`',
    `condition_category` STRING COMMENT 'Business area where the condition is applied.. Valid values are `sales|procurement|logistics`',
    `condition_class` STRING COMMENT 'Broad classification of the condition (price, discount, surcharge, tax, freight).. Valid values are `price|discount|surcharge|tax|freight`',
    `condition_description` STRING COMMENT 'Free‑form text describing the purpose and usage of the condition.',
    `condition_group` STRING COMMENT 'Logical grouping identifier for related conditions.',
    `condition_name` STRING COMMENT 'Human‑readable name or description of the pricing condition.',
    `condition_status` STRING COMMENT 'Current lifecycle status of the condition.. Valid values are `active|inactive|deleted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the condition record was first created.',
    `currency` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `discount_indicator` STRING COMMENT 'Indicates if the condition represents a discount.. Valid values are `yes|no`',
    `is_derived` BOOLEAN COMMENT 'True if the condition value is derived from other conditions or formulas.',
    `is_exclusive` BOOLEAN COMMENT 'True if the condition is exclusive and prevents other conditions of the same class.',
    `is_manual` BOOLEAN COMMENT 'True if the condition is entered manually rather than generated by a system.',
    `pricing_procedure` STRING COMMENT 'Name of the pricing procedure to which this condition belongs.',
    `priority` STRING COMMENT 'Priority of the condition within the same access sequence.',
    `scale_basis` STRING COMMENT 'Basis for scaling the condition (e.g., per quantity, per value).. Valid values are `quantity|value|weight|volume`',
    `surcharge_indicator` STRING COMMENT 'Indicates if the condition represents a surcharge.. Valid values are `yes|no`',
    `tax_indicator` STRING COMMENT 'Flag indicating whether the condition is subject to tax.. Valid values are `taxable|non_taxable`',
    `type_code` STRING COMMENT 'Alphanumeric code that identifies the pricing condition type as defined in SAP SD.',
    `unit_of_measure` STRING COMMENT 'Unit of measure applicable to the condition (e.g., KG, L, TON).',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the condition record.',
    `validity_end_date` DATE COMMENT 'Date after which the condition is no longer valid (null for open‑ended).',
    `validity_start_date` DATE COMMENT 'Date from which the condition becomes effective.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the record.',
    CONSTRAINT pk_condition PRIMARY KEY(`condition_id`)
) COMMENT 'Master record for SAP SD pricing condition types used in chemical manufacturing pricing — including base prices (PR00), surcharges (ZSU1), discounts (K004), freight conditions, and tax conditions. Defines condition class, calculation type, condition category, scale basis, and access sequence. The authoritative configuration record governing how each pricing element is calculated and applied in the condition technique.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` (
    `condition_record_id` BIGINT COMMENT 'Unique surrogate key for the pricing condition record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer to which the condition applies.',
    `condition_id` BIGINT COMMENT 'Foreign key linking to pricing.condition. Business justification: Condition records belong to a master condition; adding condition_id FK enables lookup of condition metadata and prevents a silo.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material (chemical product) the condition references.',
    `product_order_id` BIGINT COMMENT 'Identifier of the sales order header to which this condition belongs.',
    `superseded_condition_record_id` BIGINT COMMENT 'Self-referencing FK on condition_record (superseded_condition_record_id)',
    `condition_application_rule` STRING COMMENT 'Rule that determines how the condition is applied during pricing.. Valid values are `standard|special|promotional`',
    `condition_change_reason` STRING COMMENT 'Free‑text reason for the most recent change to the condition.',
    `condition_currency` STRING COMMENT 'Three‑letter ISO currency code for monetary condition values.',
    `condition_description` STRING COMMENT 'Free‑text description of the condition purpose or rule.',
    `condition_exclusion_flag` BOOLEAN COMMENT 'True if the condition should be excluded from automatic pricing runs.',
    `condition_manual_flag` BOOLEAN COMMENT 'True if the condition was entered manually by a user.',
    `condition_origin` STRING COMMENT 'Indicates whether the condition was generated by the system or entered manually.. Valid values are `system|manual`',
    `condition_price_group` STRING COMMENT 'Price group identifier used for grouping similar conditions.',
    `condition_priority` STRING COMMENT 'Priority order used when multiple conditions apply; lower numbers have higher priority.',
    `condition_quantity` DECIMAL(18,2) COMMENT 'Scale quantity that triggers the condition (e.g., buy‑X‑get‑Y).',
    `condition_record_number` STRING COMMENT 'Business‑visible identifier for the condition record (e.g., 00012345).',
    `condition_record_status` STRING COMMENT 'Current lifecycle status of the condition record.. Valid values are `active|inactive|expired|pending|blocked`',
    `condition_release_date` DATE COMMENT 'Date when the condition was released for use.',
    `condition_scale_quantity` DECIMAL(18,2) COMMENT 'Quantity threshold for scaled pricing (e.g., tiered discounts).',
    `condition_scale_uom` STRING COMMENT 'UOM for condition_scale_quantity.',
    `condition_source_system` STRING COMMENT 'Name of the source system that created the condition (e.g., SAP, external pricing engine).',
    `condition_tax_code` STRING COMMENT 'Tax code associated with the condition, if applicable.',
    `condition_type` STRING COMMENT 'Category of the pricing condition (e.g., price, discount, surcharge).. Valid values are `price|discount|surcharge|freight|tax|rebate`',
    `condition_uom` STRING COMMENT 'Unit of measure for condition_quantity (e.g., KG, L, TON).',
    `condition_value` DECIMAL(18,2) COMMENT 'Numeric value of the condition – amount or percentage depending on condition_value_type.',
    `condition_value_type` STRING COMMENT 'Indicates whether condition_value is a fixed amount or a percentage.. Valid values are `amount|percentage`',
    `condition_version` STRING COMMENT 'Version number of the condition record for change tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the condition record was created in the system.',
    `distribution_channel` STRING COMMENT 'Distribution channel code for the condition applicability.',
    `line_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material on the sales order line to which the condition applies.',
    `line_sequence` STRING COMMENT 'Sequential number of the condition line within the sales order.',
    `pricing_procedure` STRING COMMENT 'Identifier of the pricing procedure that applied this condition.',
    `release_status` STRING COMMENT 'Indicates whether the condition is released for use or still in draft.. Valid values are `released|draft|blocked|pending`',
    `sales_organization` STRING COMMENT 'Sales organization code to which the condition belongs.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the condition record.',
    `validity_end_date` DATE COMMENT 'Last date the condition remains valid; null for open‑ended.',
    `validity_start_date` DATE COMMENT 'First date the condition is valid for pricing.',
    CONSTRAINT pk_condition_record PRIMARY KEY(`condition_record_id`)
) COMMENT 'Transactional pricing condition record capturing a specific pricing condition value (price, discount, surcharge, freight) applicable to a defined combination of customer, material, sales organization, and distribution channel. Represents the resolved pricing condition instance used in order pricing. Tracks condition amount or percentage, scale quantity, validity period, and release status. Core to SAP SD condition technique execution for chemical product pricing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`strategy` (
    `strategy_id` BIGINT COMMENT 'System-generated unique identifier for the pricing strategy record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pricing strategy budgeting requires assignment to a finance cost center for expense allocation and reporting.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Pricing Strategy Governance is scoped to a specific business unit; linking to org_unit enables strategy approval and audit by the owning unit.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Pricing strategy is defined per R&D project to align margin targets with product development goals.',
    `parent_strategy_id` BIGINT COMMENT 'Self-referencing FK on strategy (parent_strategy_id)',
    `applicable_customer_segment_code` STRING COMMENT 'Code representing the customer segment (e.g., industrial, OEM, distributor) for which the strategy is valid.',
    `applicable_geography_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the geography where the strategy applies. [ENUM-REF-CANDIDATE: USA|CAN|MEX|CHN|IND|BRA|RUS|JPN|DEU|FRA — promote to reference product]',
    `applicable_product_line_code` STRING COMMENT 'Code of the product line to which the pricing strategy is scoped.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the pricing strategy received formal approval.',
    `approved_by_user` STRING COMMENT 'User identifier of the employee who approved the pricing strategy.',
    `cost_component_basis` STRING COMMENT 'Primary cost elements used to calculate the price under cost‑plus methods.. Valid values are `raw_material|energy|labor|overhead|transport|all_inclusive`',
    `created_by_user` STRING COMMENT 'User identifier of the employee who created the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the pricing strategy record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the strategy.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `effective_from` DATE COMMENT 'Date on which the pricing strategy becomes active.',
    `effective_until` DATE COMMENT 'Date on which the pricing strategy expires or is superseded; null if open‑ended.',
    `is_transfer_pricing` BOOLEAN COMMENT 'Indicates whether the strategy is used for inter‑company transfer pricing.',
    `market_index_reference` STRING COMMENT 'External market index (e.g., NYMEX WTI) used for market‑based pricing.',
    `market_index_update_frequency` STRING COMMENT 'How often the market index value is refreshed for pricing calculations.. Valid values are `daily|weekly|monthly`',
    `notes` STRING COMMENT 'Free‑form field for additional comments, exceptions, or audit remarks.',
    `pricing_authority_level` STRING COMMENT 'Organizational level authorized to approve changes to the strategy.. Valid values are `global|regional|site|customer|product_line`',
    `rationale` STRING COMMENT 'Business justification and strategic intent behind the pricing approach.',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory reviews of the strategy.',
    `strategy_code` STRING COMMENT 'Business code used to reference the pricing strategy in ERP and reporting systems.',
    `strategy_name` STRING COMMENT 'Human‑readable name of the pricing strategy.',
    `strategy_status` STRING COMMENT 'Current lifecycle status of the pricing strategy.. Valid values are `active|inactive|draft|retired|pending_review`',
    `strategy_type` STRING COMMENT 'Classification of the pricing methodology applied by the strategy.. Valid values are `cost_plus|market_based|value_based|competitive_index|custom`',
    `surcharge_energy_index` DECIMAL(18,2) COMMENT 'Additional percentage added to price based on energy cost index fluctuations.',
    `surcharge_raw_material_index` DECIMAL(18,2) COMMENT 'Additional percentage added to price based on raw material cost index changes.',
    `target_margin_percent` DECIMAL(18,2) COMMENT 'Desired profit margin expressed as a percentage of net sales.',
    `updated_by_user` STRING COMMENT 'User identifier of the employee who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the pricing strategy.',
    `volume_discount_tier_1_discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage applied when the minimum quantity of tier 1 is met.',
    `volume_discount_tier_1_min_qty` BIGINT COMMENT 'Minimum purchase quantity to qualify for the first discount tier.',
    `volume_discount_tier_2_discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage applied for tier 2 volume thresholds.',
    `volume_discount_tier_2_min_qty` BIGINT COMMENT 'Minimum purchase quantity to qualify for the second discount tier.',
    `volume_discount_tier_3_discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage applied for tier 3 volume thresholds.',
    `volume_discount_tier_3_min_qty` BIGINT COMMENT 'Minimum purchase quantity to qualify for the third discount tier.',
    CONSTRAINT pk_strategy PRIMARY KEY(`strategy_id`)
) COMMENT 'Master record defining the overarching pricing strategy applied to a product line, market segment, geography, or customer tier. Captures strategy type (cost-plus, market-based, value-based, competitive index), target margin band, pricing authority level, review frequency, and strategic rationale. Links pricing decisions to commercial strategy for specialty chemicals, commodity chemicals, and performance materials. Enables governance of pricing methodology across the portfolio.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` (
    `cost_plus_model_id` BIGINT COMMENT 'System-generated unique identifier for each cost-plus pricing model record.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Cost‑plus model calculates cost using the BOM of a specific formula version; linking ensures accurate cost inputs.',
    `freight_rate_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_rate. Business justification: Cost‑plus pricing model incorporates freight rate per carrier to compute product cost.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Cost‑plus models are defined per plant; the org unit link supports cost allocation reporting and regulatory cost‑basis documentation.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Project‑specific cost‑plus model: finance builds cost‑plus pricing per R&D project for new product launches.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Cost‑plus model is defined per pricing strategy',
    `superseded_cost_plus_model_id` BIGINT COMMENT 'Self-referencing FK on cost_plus_model (superseded_cost_plus_model_id)',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the model.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the model received formal approval.',
    `ceiling_price` DECIMAL(18,2) COMMENT 'Maximum price that may be set under the model, often used for price caps.',
    `compliance_status` STRING COMMENT 'Indicates whether the model complies with relevant pricing regulations (e.g., REACH, GHS).. Valid values are `compliant|non_compliant`',
    `cost_center_code` STRING COMMENT 'Internal cost‑center to which the models costs are allocated.',
    `cost_plus_model_description` STRING COMMENT 'Detailed narrative explaining the purpose, assumptions, and scope of the model.',
    `cost_plus_model_status` STRING COMMENT 'Current lifecycle status of the pricing model.. Valid values are `active|inactive|draft|retired`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the model record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency in which prices are expressed.',
    `effective_from` DATE COMMENT 'First date on which the pricing model is valid for use.',
    `effective_until` DATE COMMENT 'Last date on which the pricing model remains valid; null indicates open‑ended validity.',
    `energy_index_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the base energy cost component.',
    `fixed_cost_contribution` DECIMAL(18,2) COMMENT 'Portion of fixed manufacturing costs attributed to the product in the model.',
    `floor_price` DECIMAL(18,2) COMMENT 'Minimum acceptable selling price derived from the cost‑plus calculation.',
    `is_energy_surcharge_applicable` BOOLEAN COMMENT 'True if the model includes an energy surcharge component.',
    `is_transfer_pricing` BOOLEAN COMMENT 'Indicates whether the model is used for inter‑company transfer pricing calculations.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent model review.',
    `last_reviewed_by` STRING COMMENT 'Identifier of the person who performed the latest review.',
    `model_code` STRING COMMENT 'Business code used to reference the model in pricing applications and documentation.',
    `model_name` STRING COMMENT 'Human‑readable name describing the pricing model.',
    `model_type` STRING COMMENT 'Classification of the costing methodology applied by the model.. Valid values are `full_absorption|marginal|contribution`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the model.',
    `overhead_rate` DECIMAL(18,2) COMMENT 'Percentage of overhead costs allocated to the product within the model.',
    `product_family` STRING COMMENT 'Higher‑level product grouping to which the model is associated.',
    `raw_material_index_factor` DECIMAL(18,2) COMMENT 'Multiplier reflecting raw material price index adjustments.',
    `region_code` STRING COMMENT 'Geographic region identifier (e.g., NA, EU, APAC) where the model applies.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation or guideline governing the model (e.g., "EPA 40 CFR Part 180").',
    `scenario_name` STRING COMMENT 'Descriptive name of the costing scenario (e.g., "Base Case", "High Energy Price").',
    `standard_cost` DECIMAL(18,2) COMMENT 'Base cost of the chemical product as calculated by standard costing rules.',
    `target_margin_pct` DECIMAL(18,2) COMMENT 'Desired profit margin expressed as a percentage of the standard cost.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the model record.',
    `variable_cost_breakdown` STRING COMMENT 'JSON‑encoded detail of individual variable cost elements (e.g., energy surcharge, raw material index).',
    `variable_cost_total` DECIMAL(18,2) COMMENT 'Aggregated variable cost components (e.g., energy, raw material index) for the product.',
    `version_number` STRING COMMENT 'Sequential version identifier for change management.',
    CONSTRAINT pk_cost_plus_model PRIMARY KEY(`cost_plus_model_id`)
) COMMENT 'Cost-plus pricing model record defining the structured calculation of a chemical products selling price from its standard cost base. Captures standard cost input, target margin percentage, overhead allocation rate, fixed cost contribution, variable cost components, and resulting floor price. Supports multiple costing scenarios (full absorption, marginal, contribution margin). Used by pricing analysts to set minimum acceptable prices and validate commercial pricing decisions against cost recovery requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` (
    `market_price_index_id` BIGINT COMMENT 'Unique identifier for the market price index record.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: Market price indices are published per chemical substance (CAS); linking to CAS registry provides authoritative identification for compliance and pricing calculations.',
    `compound_registry_id` BIGINT COMMENT 'Foreign key linking to research.compound_registry. Business justification: Market price index tracks commodity price for a specific chemical; linking to compound registry provides CAS‑based identification.',
    `parent_market_price_index_id` BIGINT COMMENT 'Self-referencing FK on market_price_index (parent_market_price_index_id)',
    `commodity_name` STRING COMMENT 'Name of the chemical commodity or substance the index tracks.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence rating (0‑100) assigned by the data governance team.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the index record was first loaded into the lakehouse.',
    `data_quality_flag` STRING COMMENT 'Indicator of the overall data quality for the index record.. Valid values are `good|questionable|bad`',
    `effective_date` DATE COMMENT 'Date from which the index value is considered effective for pricing calculations.',
    `expiry_date` DATE COMMENT 'Date after which the index value is no longer valid (nullable for open‑ended indices).',
    `frequency` STRING COMMENT 'How often the index is updated by the source.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `geographic_region` STRING COMMENT 'Country or region code to which the index applies.. Valid values are `^[A-Z]{3}$`',
    `index_category` STRING COMMENT 'Broad classification of the index type.. Valid values are `commodity|chemical|energy|raw_material`',
    `index_code` STRING COMMENT 'Business identifier or code used to reference the index in external systems.. Valid values are `^[A-Z0-9_-]+$`',
    `index_name` STRING COMMENT 'Human‑readable name of the price index.',
    `index_version` STRING COMMENT 'Version identifier for the index release (e.g., v2023Q1).',
    `market_price_index_description` STRING COMMENT 'Free‑form description of the index purpose and methodology.',
    `market_price_index_status` STRING COMMENT 'Current lifecycle status of the index record.. Valid values are `active|inactive|deprecated`',
    `market_segment` STRING COMMENT 'Business segment to which the index is most relevant.. Valid values are `industrial|consumer|pharma|agricultural`',
    `price_currency` STRING COMMENT 'Three‑letter ISO currency code of the price value.. Valid values are `^[A-Z]{3}$`',
    `price_type` STRING COMMENT 'Classification of the price value type.. Valid values are `spot|future|average`',
    `price_value` DECIMAL(18,2) COMMENT 'Numeric price value reported by the index source.',
    `publication_date` DATE COMMENT 'Date the index value was published by the source.',
    `source_publication` STRING COMMENT 'Name of the external publication (e.g., ICIS, Platts) providing the index.',
    `source_url` STRING COMMENT 'Web address where the index data can be accessed or verified.',
    `unit_of_measure` STRING COMMENT 'Unit in which the price is expressed (e.g., USD per metric ton).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the index record.',
    CONSTRAINT pk_market_price_index PRIMARY KEY(`market_price_index_id`)
) COMMENT 'External market price index record tracking published commodity chemical price benchmarks from industry sources (ICIS, Platts, CMA, IHS Markit). Captures index name, commodity or chemical substance, publication date, index value, currency, unit of measure, source publication, and geographic region. Used as reference inputs for market-based pricing, raw material surcharge calculations, and competitive price positioning for commodity and semi-commodity chemical products.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` (
    `index_price_point_id` BIGINT COMMENT 'System-generated unique identifier for the price point record.',
    `market_price_index_id` BIGINT COMMENT 'Identifier of the market index this price point belongs to.',
    `prior_index_price_point_id` BIGINT COMMENT 'Self-referencing FK on index_price_point (prior_index_price_point_id)',
    `confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence level (0‑100) assigned by the source to the price data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price point record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price value.. Valid values are `^[A-Z]{3}$`',
    `data_provider` STRING COMMENT 'Name of the external organization supplying the price data (e.g., Bloomberg, Reuters).',
    `data_quality_flag` STRING COMMENT 'Indicator of the reliability of the price data.. Valid values are `good|questionable|estimated|missing`',
    `effective_end_date` DATE COMMENT 'Date until which the price value remains effective; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date from which the price value is considered effective.',
    `index_price_point_status` STRING COMMENT 'Current lifecycle status of the price point record.. Valid values are `active|inactive|archived`',
    `index_type` STRING COMMENT 'Category of the index indicating the commodity family.. Valid values are `commodity|energy|raw_material|chemical`',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Date‑time when the record was loaded into the lakehouse.',
    `is_estimated` BOOLEAN COMMENT 'True if the price value is an estimate rather than a directly observed market price.',
    `market` STRING COMMENT 'Broad market classification (e.g., US, EU, APAC) for the index.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the price point.',
    `percent_change` DECIMAL(18,2) COMMENT 'Percentage change between the current price and the prior period price.',
    `period_change` DECIMAL(18,2) COMMENT 'Absolute difference between the current price and the prior period price.',
    `price_date` DATE COMMENT 'Calendar date of the price observation (derived from price_timestamp).',
    `price_source_code` STRING COMMENT 'Unique identifier assigned by the external data provider for this price observation.',
    `price_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the price value was observed or published.',
    `price_value` DECIMAL(18,2) COMMENT 'Published market price for the index expressed in the specified unit of measure.',
    `prior_price_value` DECIMAL(18,2) COMMENT 'Price value from the immediately preceding period used for change calculations.',
    `region` STRING COMMENT 'Three‑letter code representing the geographic region of the price index.. Valid values are `^[A-Z]{3}$`',
    `source_system` STRING COMMENT 'Name of the upstream system that supplied the price (e.g., Aveva PI, Bloomberg).',
    `source_timestamp` TIMESTAMP COMMENT 'Date‑time when the source system recorded the price.',
    `unit_of_measure` STRING COMMENT 'Unit in which the price is expressed (e.g., USD_per_barrel, EUR_per_tonne).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price point record.',
    `version_number` STRING COMMENT 'Incremental version of the record for change tracking.',
    CONSTRAINT pk_index_price_point PRIMARY KEY(`index_price_point_id`)
) COMMENT 'Time-series data point record capturing a specific published value for a market price index at a given date. Stores the actual index value, prior period value, period-over-period change, percentage change, and data quality flag. Enables trend analysis and formula-based pricing calculations that reference rolling averages or index movements for chemical feedstock-linked pricing contracts.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` (
    `surcharge_id` BIGINT COMMENT 'System-generated unique identifier for the surcharge record.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: A surcharge is defined as part of a pricing strategy; linking surcharge to pricing_strategy provides the missing inbound relationship and enables hierarchy of pricing rules.',
    `parent_surcharge_id` BIGINT COMMENT 'Self-referencing FK on surcharge (parent_surcharge_id)',
    `amount_value` DECIMAL(18,2) COMMENT 'Fixed monetary amount applied when calculation_basis = fixed_amount.',
    `applicable_product_category` STRING COMMENT 'Product category (or line) to which the surcharge may be applied.',
    `applicable_region` STRING COMMENT 'Three‑letter country code indicating geographic scope of the surcharge.. Valid values are `^[A-Z]{3}$`',
    `approval_status` STRING COMMENT 'Current approval workflow state of the surcharge.. Valid values are `approved|rejected|pending|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the user who approved the surcharge.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the surcharge was approved.',
    `calculation_basis` STRING COMMENT 'Method used to calculate the surcharge amount.. Valid values are `fixed_amount|percentage|formula`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Customer segment for which the surcharge is applicable.. Valid values are `retail|wholesale|distributor|internal`',
    `effective_from` DATE COMMENT 'Date when the surcharge becomes valid.',
    `effective_until` DATE COMMENT 'Date when the surcharge expires; null for open‑ended.',
    `formula_expression` STRING COMMENT 'Mathematical expression used when calculation_basis = formula (e.g., "base_price * 0.03 + 5").',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the surcharge amount is subject to sales tax.',
    `min_order_quantity` STRING COMMENT 'Minimum quantity of product units for the surcharge to apply.',
    `percentage_value` DECIMAL(18,2) COMMENT 'Percentage applied to the base price when calculation_basis = percentage.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the surcharge record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the surcharge record.',
    `surcharge_code` STRING COMMENT 'Business code used to reference the surcharge in pricing contracts and ERP systems.',
    `surcharge_description` STRING COMMENT 'Detailed free‑text description of the surcharge purpose and calculation logic.',
    `surcharge_name` STRING COMMENT 'Human‑readable name describing the surcharge (e.g., "Natural Gas Energy Surcharge").',
    `surcharge_status` STRING COMMENT 'Current lifecycle status of the surcharge.. Valid values are `active|inactive|pending|retired`',
    `surcharge_type` STRING COMMENT 'Category of the surcharge indicating the cost component it recovers.. Valid values are `energy|raw_material|freight|hazmat|small_order`',
    `version_number` STRING COMMENT 'Incremental version of the surcharge definition for change management.',
    CONSTRAINT pk_surcharge PRIMARY KEY(`surcharge_id`)
) COMMENT 'Master record defining a pricing surcharge applied to chemical product prices to recover specific cost components. Covers energy surcharges (natural gas, electricity index-linked), raw material index surcharges (ethylene, propylene, benzene derivatives), freight surcharges, hazmat handling surcharges, and small-order surcharges. Captures surcharge type, calculation basis (fixed amount, percentage, formula-linked), applicability rules, effective dates, and approval status. Critical for chemical manufacturers managing volatile feedstock and energy cost pass-through.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` (
    `surcharge_rate_id` BIGINT COMMENT 'Unique surrogate key for each surcharge rate record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the surcharge rate.',
    `surcharge_id` BIGINT COMMENT 'Foreign key linking to pricing.surcharge. Business justification: Surcharge rates are specific to a surcharge definition',
    `superseded_surcharge_rate_id` BIGINT COMMENT 'Self-referencing FK on surcharge_rate (superseded_surcharge_rate_id)',
    `applicable_to_all_products` BOOLEAN COMMENT 'True if the surcharge rate applies universally across product lines; false if limited to specific categories.',
    `approval_date` DATE COMMENT 'Date when the surcharge rate was approved.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the surcharge rate.. Valid values are `approved|rejected|pending`',
    `calculation_method` STRING COMMENT 'Method used to calculate the surcharge (fixed amount, index‑based, or formula).. Valid values are `fixed|index_based|formula`',
    `communication_date` DATE COMMENT 'Date the approved surcharge rate was communicated to customers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the surcharge rate record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary surcharge rates.. Valid values are `[A-Z]{3}`',
    `effective_from` DATE COMMENT 'Date when the surcharge rate becomes effective.',
    `effective_until` DATE COMMENT 'Date when the surcharge rate expires; null if open‑ended.',
    `index_name` STRING COMMENT 'Name of the external index (e.g., Energy Index, Raw Material Index) used when calculation_method is index_based.',
    `index_value_at_effective` DECIMAL(18,2) COMMENT 'Recorded value of the referenced index on the effective_from date.',
    `is_percentage` BOOLEAN COMMENT 'True if rate_value is expressed as a percentage; false if expressed as a fixed monetary amount.',
    `notes` STRING COMMENT 'Free‑form comments or business rationale for the surcharge rate.',
    `product_category` STRING COMMENT 'Category of chemical products affected by the surcharge.. Valid values are `chemical|intermediate|additive|solvent|specialty`',
    `rate_code` STRING COMMENT 'External code or identifier used in pricing contracts and systems.',
    `rate_name` STRING COMMENT 'Human‑readable name identifying the surcharge rate.',
    `rate_unit` STRING COMMENT 'Unit of the rate value (percent, currency amount, or basis points).. Valid values are `percent|currency|basis_point`',
    `rate_value` DECIMAL(18,2) COMMENT 'Numeric value of the surcharge (percentage or monetary amount).',
    `region_code` STRING COMMENT 'Three‑letter code of the geographic region to which the surcharge applies.. Valid values are `[A-Z]{3}`',
    `surcharge_rate_status` STRING COMMENT 'Current lifecycle status of the surcharge rate.. Valid values are `active|inactive|pending|retired`',
    `surcharge_type` STRING COMMENT 'Category of surcharge applied to chemical products (e.g., energy index, raw‑material cost).. Valid values are `energy|raw_material|logistics|environmental|tax|custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the surcharge rate record.',
    `volume_discount_rate` DECIMAL(18,2) COMMENT 'Discount rate applied to the surcharge when the volume threshold is met.',
    `volume_discount_threshold` DECIMAL(18,2) COMMENT 'Minimum purchase volume (in metric tons) required to trigger a volume‑based discount on the surcharge.',
    CONSTRAINT pk_surcharge_rate PRIMARY KEY(`surcharge_rate_id`)
) COMMENT 'Transactional record capturing the effective surcharge rate for a specific surcharge type during a defined validity period. Stores the calculated or approved surcharge amount or percentage, the triggering index value or cost basis, calculation date, approval workflow status, and communication date to customers. Enables periodic surcharge adjustments (monthly, quarterly) based on energy or raw material index movements for chemical product pricing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` (
    `volume_discount_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the volume discount schedule record.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Volume discount schedules are scoped by pricing strategy',
    `superseded_volume_discount_schedule_id` BIGINT COMMENT 'Self-referencing FK on volume_discount_schedule (superseded_volume_discount_schedule_id)',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary discounts.',
    `customer_scope_code` STRING COMMENT 'Identifier of the customer group or specific account the discount targets.',
    `customer_scope_type` STRING COMMENT 'Defines whether the discount is global, group‑based, or for a specific account.. Valid values are `all_customers|customer_group|specific_account`',
    `discount_type` STRING COMMENT 'Method used to calculate the discount: percentage of list price, absolute monetary amount, or a fixed price per unit.. Valid values are `percentage|absolute|fixed_price`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount as defined by discount_type.',
    `effective_from` DATE COMMENT 'Date on which the discount schedule becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the discount schedule expires; null for open‑ended schedules.',
    `is_cumulative` BOOLEAN COMMENT 'Indicates if discounts accumulate across multiple orders within the validity period.',
    `notes` STRING COMMENT 'Additional internal comments or remarks about the schedule.',
    `product_scope_code` STRING COMMENT 'Identifier of the product, product line, or hierarchy to which the discount applies.',
    `product_scope_type` STRING COMMENT 'Defines the granularity of products the discount applies to.. Valid values are `product|product_line|product_hierarchy|all_products`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the discount schedule record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the discount schedule record.',
    `schedule_code` STRING COMMENT 'Business code used to reference the discount schedule in pricing and sales systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name or title for the discount schedule.',
    `schedule_type` STRING COMMENT 'Indicates whether the discount is applied per order quantity or based on cumulative annual volume.. Valid values are `order_quantity_based|annual_cumulative`',
    `tier_quantity_break` DECIMAL(18,2) COMMENT 'Minimum quantity required to qualify for this discount tier.',
    `tier_quantity_unit` STRING COMMENT 'Unit of measure for the tier quantity breakpoint.. Valid values are `kg|lb|ton|liter|gallon|m3`',
    `tier_sequence` STRING COMMENT 'Ordinal position of the tier within the schedule.',
    `updated_by` STRING COMMENT 'System user identifier who last modified the discount schedule.',
    `volume_discount_schedule_description` STRING COMMENT 'Free‑form text describing the purpose or special conditions of the schedule.',
    `volume_discount_schedule_status` STRING COMMENT 'Current lifecycle status of the discount schedule.. Valid values are `active|inactive|draft|expired`',
    `created_by` STRING COMMENT 'System user identifier who created the discount schedule.',
    CONSTRAINT pk_volume_discount_schedule PRIMARY KEY(`volume_discount_schedule_id`)
) COMMENT 'Master record defining tiered volume discount structures for chemical products. Captures discount scale tiers (quantity breakpoints), discount type (percentage, absolute amount, fixed price per tier), applicable product scope (product, product line, product hierarchy), customer scope (all customers, customer group, specific account), and validity period. Supports both order-quantity-based and cumulative annual volume discount programs common in chemical B2B commercial agreements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` (
    `transfer_price_id` BIGINT COMMENT 'Unique identifier for the transfer price record.',
    `compound_registry_id` BIGINT COMMENT 'Foreign key linking to research.compound_registry. Business justification: Internal transfer price for a material is based on the specific chemical compound recorded in the compound registry.',
    `cost_center_id` BIGINT COMMENT 'Internal cost center used for allocating the transfer price expense.',
    `market_price_index_id` BIGINT COMMENT 'Identifier of the external price index (e.g., commodity index) when index_price is used.',
    `material_master_id` BIGINT COMMENT 'Identifier of the chemical material or intermediate being transferred.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity that supplies the material.',
    `superseded_transfer_price_id` BIGINT COMMENT 'Self-referencing FK on transfer_price (superseded_transfer_price_id)',
    `agreement_number` STRING COMMENT 'External reference number for the intercompany transfer pricing agreement.',
    `amount` DECIMAL(18,2) COMMENT 'Calculated monetary amount for the transfer price.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer price agreement was approved for use.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework governing the transfer price (e.g., OECD guidelines).. Valid values are `OECD|US_Tax|EU_Tax|Local`',
    `cost_component_amount` DECIMAL(18,2) COMMENT 'Base cost component used in cost‑plus calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the transfer price amount.. Valid values are `[A-Z]{3}`',
    `documentation_reference` STRING COMMENT 'Reference to the supporting documentation required for OECD compliance.',
    `effective_from` DATE COMMENT 'Date when the transfer price becomes effective.',
    `effective_until` DATE COMMENT 'Date when the transfer price expires; null if open‑ended.',
    `margin_percent` DECIMAL(18,2) COMMENT 'Profit margin percentage applied in cost‑plus pricing.',
    `notes` STRING COMMENT 'Free‑form comments or special conditions for the transfer price.',
    `price_basis` STRING COMMENT 'Basis used for price calculation (standard cost, market price, or index price).. Valid values are `standard_cost|market_price|index_price`',
    `price_index_value` DECIMAL(18,2) COMMENT 'Numeric value of the selected price index at the effective date.',
    `receiving_entity_code` BIGINT COMMENT 'Identifier of the legal entity that receives the material.',
    `region_code` STRING COMMENT 'Three‑letter ISO 3166‑1 alpha‑3 code of the region applicable to the pricing.. Valid values are `[A-Z]{3}`',
    `surcharge_energy_amount` DECIMAL(18,2) COMMENT 'Additional surcharge reflecting energy cost fluctuations.',
    `surcharge_raw_material_amount` DECIMAL(18,2) COMMENT 'Additional surcharge reflecting raw material index changes.',
    `tax_included_flag` BOOLEAN COMMENT 'Indicates whether tax is included in the transfer price amount.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage when tax is not included.',
    `transfer_price_method` STRING COMMENT 'Method used to calculate the transfer price (e.g., cost-plus, resale minus, TNMM, CUP, market based).. Valid values are `cost_plus|resale_minus|tnmm|cup|market_based`',
    `transfer_price_status` STRING COMMENT 'Current lifecycle status of the transfer price record.. Valid values are `active|inactive|expired|draft|pending`',
    `transfer_price_type` STRING COMMENT 'Indicates whether the price is for intercompany or external transactions.. Valid values are `intercompany|external`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `volume_discount_tier` STRING COMMENT 'Discount tier based on transaction volume.. Valid values are `tier1|tier2|tier3|tier4`',
    CONSTRAINT pk_transfer_price PRIMARY KEY(`transfer_price_id`)
) COMMENT 'Intercompany transfer pricing record defining the price at which chemical products, intermediates, or raw materials are transferred between legal entities within the Chemical Mfg corporate group. Captures sending entity, receiving entity, material, transfer price method (cost-plus, resale minus, TNMM, CUP), transfer price amount, currency, validity period, and arms-length documentation reference. Supports OECD transfer pricing compliance and intercompany billing reconciliation.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` (
    `transfer_price_study_id` BIGINT COMMENT 'Unique system-generated identifier for the transfer price study record.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Transfer price studies support a pricing strategy',
    `prior_transfer_price_study_id` BIGINT COMMENT 'Self-referencing FK on transfer_price_study (prior_transfer_price_study_id)',
    `approval_date` DATE COMMENT 'Date on which the study was formally approved by tax authority sign‑off.',
    `approved_by` STRING COMMENT 'Name of the internal stakeholder who approved the study.',
    `arm_length_range_lower` DECIMAL(18,2) COMMENT 'Lower bound of the arms‑length price range derived from comparables.',
    `arm_length_range_upper` DECIMAL(18,2) COMMENT 'Upper bound of the arms‑length price range derived from comparables.',
    `benchmark_methodology` STRING COMMENT 'Specific benchmarking approach (e.g., TNMM, CUP) used to identify comparables.',
    `comparable_transaction_count` STRING COMMENT 'Number of external comparable transactions identified for the study.',
    `confidentiality_level` STRING COMMENT 'Data classification indicating how the study may be shared.. Valid values are `public|internal|confidential|restricted`',
    `counterparty_legal_entity_code` BIGINT COMMENT 'Identifier of the related legal entity (e.g., the purchasing entity) covered by the study.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the study record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary amounts in the study.. Valid values are `[A-Z]{3}`',
    `data_source_system` STRING COMMENT 'Source system(s) that supplied the underlying data (e.g., SAP S/4HANA, custom).',
    `documentation_reference` STRING COMMENT 'Reference (e.g., file path, URL, or document ID) to the full study documentation.',
    `effective_date` DATE COMMENT 'Date on which the studys conclusions become effective for tax reporting.',
    `expiration_date` DATE COMMENT 'Date after which the study is no longer considered valid (nullable).',
    `external_advisor_firm` STRING COMMENT 'Organization employing the external advisor.',
    `external_advisor_name` STRING COMMENT 'Name of the external tax or transfer‑pricing advisor who prepared or reviewed the study.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the study record.',
    `lead_legal_entity_code` BIGINT COMMENT 'Identifier of the primary legal entity (e.g., the selling entity) covered by the study.',
    `method_description` STRING COMMENT 'Narrative description of how the selected method is applied.',
    `regulatory_reporting_requirement` STRING COMMENT 'Regulatory framework(s) for which the study provides documentation.. Valid values are `OECD_BEPS|US_Tax|EU_TransferPricing|Other`',
    `risk_assessment_flag` BOOLEAN COMMENT 'Indicates whether the study identified a material transfer‑pricing risk (true) or not (false).',
    `study_name` STRING COMMENT 'Descriptive name given to the study for easy identification.',
    `study_notes` STRING COMMENT 'Free‑form comments or observations captured by the analyst.',
    `study_status` STRING COMMENT 'Current lifecycle status of the study.. Valid values are `draft|in_review|approved|rejected|archived`',
    `study_type` STRING COMMENT 'Category of the study indicating the analytical approach used.. Valid values are `benchmarking|functional_analysis|comparables_search`',
    `tax_year` STRING COMMENT 'Fiscal year to which the transfer pricing analysis applies.',
    `transfer_pricing_method` STRING COMMENT 'Methodology selected for the transfer pricing calculation.. Valid values are `cost_plus|resale|tnmm|profit_split|transactional_net_margin|other`',
    `version_number` STRING COMMENT 'Incremental version of the study document.',
    CONSTRAINT pk_transfer_price_study PRIMARY KEY(`transfer_price_study_id`)
) COMMENT 'Transfer pricing study and documentation record supporting OECD BEPS compliance for intercompany chemical product transactions. Captures study type (benchmarking, functional analysis, comparables search), tax year, legal entities covered, transfer pricing method selected, comparable transactions identified, arms-length range established, and external advisor reference. Provides the audit trail required by tax authorities for intercompany pricing of chemical products across jurisdictions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Unique system-generated identifier for the pricing proposal record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer or account to which the pricing proposal applies.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pricing proposals are evaluated against a cost center to track proposal costs in financial systems.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Pricing proposal cost calculations reference the experimental formulation that defines ingredient ratios and scale‑up feasibility.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Pricing proposals are generated for a specific formula version during product launch, linking proposal to formulation cost base.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue from approved proposals is posted to a specific GL account for financial consolidation.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Pricing proposals are generated for a specific sales opportunity to support win‑loss analysis.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Pricing proposal may be tied to a specific price list',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Proposals must be linked to a profit center to calculate expected margin and report profitability.',
    `employee_id` BIGINT COMMENT 'System user who initially created the pricing proposal record.',
    `proposal_employee_id` BIGINT COMMENT 'User identifier of the person responsible for approving or rejecting the proposal.',
    `proposal_last_modified_by_user_employee_id` BIGINT COMMENT 'System user who performed the most recent update to the record.',
    `sop_cycle_id` BIGINT COMMENT 'Foreign key linking to planning.sop_cycle. Business justification: Pricing proposals are reviewed and approved within the SOP (Sales & Operations Planning) cycle.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Pricing proposal should reference the strategy via FK; remove redundant string column',
    `revised_proposal_id` BIGINT COMMENT 'Self-referencing FK on proposal (revised_proposal_id)',
    `approval_status` STRING COMMENT 'Current status of the approval workflow.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the proposal was approved or rejected.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp of when the record was first persisted for audit purposes.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `comments` STRING COMMENT 'Free‑form field for any supplemental information or remarks.',
    `competitive_price_reference` STRING COMMENT 'External benchmark price or competitor reference used in the proposal analysis.',
    `cost_basis_amount` DECIMAL(18,2) COMMENT 'Underlying cost of the product(s) that the proposal is built upon.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the pricing proposal was initially created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of the proposal amounts.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Proposed monetary discount to be subtracted from the gross amount.',
    `effective_from` DATE COMMENT 'Date on which the proposed pricing becomes effective if approved.',
    `effective_until` DATE COMMENT 'Date on which the proposed pricing expires or is superseded; null for open‑ended.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before any discounts, surcharges, or taxes are applied.',
    `margin_actual_percent` DECIMAL(18,2) COMMENT 'Calculated margin based on cost and net amount; used for analysis after approval.',
    `margin_target_percent` DECIMAL(18,2) COMMENT 'Desired profit margin percentage that the proposal aims to achieve.',
    `net_amount` DECIMAL(18,2) COMMENT 'Resulting amount after discount and before tax; the amount to be invoiced if approved.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Proposed price for a single unit of the product, expressed in the selected currency.',
    `price_validity_end` DATE COMMENT 'Last date on which the proposed price may be applied; null if indefinite.',
    `price_validity_start` DATE COMMENT 'First date on which the proposed price may be applied.',
    `product_category_code` STRING COMMENT 'Classification code of the product(s) covered by the proposal.',
    `proposal_number` STRING COMMENT 'Human‑readable reference number assigned to the proposal for tracking and communication.',
    `proposal_status` STRING COMMENT 'Current lifecycle state of the proposal within the pricing governance workflow.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `proposal_type` STRING COMMENT 'Classification of the proposal purpose (e.g., new product launch, price increase, discount request).. Valid values are `new_product|price_increase|discount|surcharge|transfer_pricing`',
    `rationale` STRING COMMENT 'Narrative explaining the business reasoning behind the proposed pricing.',
    `region_code` STRING COMMENT 'Three‑letter code indicating the geographic market for which the proposal is intended.',
    `surcharge_index_value` DECIMAL(18,2) COMMENT 'Numeric index (e.g., raw‑material price index) used to calculate the surcharge amount.',
    `surcharge_type` STRING COMMENT 'Category of any additional surcharge applied to the proposal.. Valid values are `none|energy|raw_material|logistics`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax calculated from the net amount and tax rate.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage of the net amount.',
    `unit_of_measure` STRING COMMENT 'Unit in which the price per unit is expressed.. Valid values are `per_kg|per_liter|per_ton|per_gallon`',
    `volume_discount_tier` STRING COMMENT 'Discount tier based on purchase volume thresholds.. Valid values are `none|tier1|tier2|tier3`',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Pricing proposal record capturing a formal internal pricing recommendation submitted for approval before communicating prices to customers or updating price lists. Captures proposed price or discount, product scope, customer or segment scope, pricing rationale, margin impact analysis, competitive context, and approval workflow status. Supports the pricing governance process for new product launches, annual price increases, and special pricing requests in chemical manufacturing commercial operations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`approval` (
    `approval_id` BIGINT COMMENT 'System-generated unique identifier for the pricing approval record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee to whom approval authority was delegated.',
    `approval_employee_id` BIGINT COMMENT 'Unique identifier of the employee who performed the approval action.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the chemical product or SKU the pricing applies to.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pricing approvals record the responsible cost center for audit and cost‑center level control.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Pricing approval must be tied to the exact formula version so margin targets align with the formulations cost structure.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pricing approval adjustments are recorded against a GL account to reflect accounting impact.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Pricing approvals are tied to the opportunity they affect; needed for audit and compliance reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Approvals need profit‑center association for profit‑center level pricing governance.',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_proposal. Business justification: Pricing approval records the proposal it approves',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Pricing approvals for new products are tied to the originating R&D project to ensure compliance and cost recovery.',
    `requester_employee_id` BIGINT COMMENT 'Unique identifier of the employee who submitted the pricing proposal.',
    `escalated_approval_id` BIGINT COMMENT 'Self-referencing FK on approval (escalated_approval_id)',
    `approval_level` STRING COMMENT 'Organizational level required to approve the pricing request.. Valid values are `regional_manager|vp_commercial|cfo|director`',
    `approval_number` STRING COMMENT 'Human‑readable business identifier for the approval request, often used in communications and audit trails.',
    `approval_status` STRING COMMENT 'Current lifecycle state of the pricing approval.. Valid values are `pending|approved|rejected|escalated`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the approval decision (approve/reject/escalate) was recorded.',
    `approved_price` DECIMAL(18,2) COMMENT 'Final price amount authorized by the approver.',
    `business_unit` STRING COMMENT 'Organizational unit responsible for the product line.',
    `comments` STRING COMMENT 'Free‑form text entered by the approver explaining the decision.',
    `compliance_check_passed` BOOLEAN COMMENT 'Result of internal compliance validation for the pricing proposal.',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'When the compliance check was performed.',
    `condition` STRING COMMENT 'Any contractual or operational conditions tied to the approved price.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the approval record was first created in the lakehouse.',
    `delegation_expiration` TIMESTAMP COMMENT 'Date‑time when the delegated approval authority expires.',
    `delegation_flag` BOOLEAN COMMENT 'Indicates whether the approval authority was delegated to another employee.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the proposed price, if any.',
    `effective_end_date` DATE COMMENT 'Date when the approved price expires; null for open‑ended pricing.',
    `effective_start_date` DATE COMMENT 'Date when the approved price becomes effective for sales orders.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether the approved price is treated as confidential information.',
    `price_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the price values.. Valid values are `USD|EUR|JPY|GBP|CNY|CAD`',
    `price_type` STRING COMMENT 'Methodology used to calculate the price.. Valid values are `cost_plus|market_based|volume_discount|surcharge|transfer`',
    `product_sku` STRING COMMENT 'SKU or catalogue code of the product.',
    `proposed_price` DECIMAL(18,2) COMMENT 'Price amount requested in the proposal before any approval adjustments.',
    `reason` STRING COMMENT 'Business justification for requesting special or non‑standard pricing.',
    `region_code` STRING COMMENT 'Three‑letter ISO country or region code where the pricing is applicable.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates if external regulatory sign‑off is needed for this pricing.',
    `regulatory_approval_status` STRING COMMENT 'Current status of the required regulatory approval.. Valid values are `pending|approved|rejected`',
    `regulatory_approval_timestamp` TIMESTAMP COMMENT 'Date‑time when regulatory approval was granted or denied.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the pricing proposal was submitted for approval.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Additional charge (e.g., energy index, raw‑material surcharge) added to the proposed price.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the approval record.',
    CONSTRAINT pk_approval PRIMARY KEY(`approval_id`)
) COMMENT 'Approval workflow record for pricing proposals requiring authorization above standard pricing authority thresholds. Captures approver identity, approval level (regional manager, VP commercial, CFO), approval decision (approved, rejected, escalated), approval date, conditions or comments, and delegation records. Enforces pricing governance controls for special pricing, below-floor pricing, and large-volume contract pricing in chemical manufacturing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` (
    `special_price_request_id` BIGINT COMMENT 'System-generated unique identifier for the special price request record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer for whom the special price is being requested.',
    `employee_id` BIGINT COMMENT 'Identifier of the person who approved or rejected the request.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the chemical product or material subject to the special pricing request.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Special price requests arise from a sales opportunity; linking enables request tracking per opportunity.',
    `price_list_id` BIGINT COMMENT 'Identifier of the price list from which the standard price is derived.',
    `primary_special_employee_id` BIGINT COMMENT 'Identifier of the sales representative who originated the special price request.',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_proposal. Business justification: Special price request may be based on a pricing proposal',
    `resubmitted_special_price_request_id` BIGINT COMMENT 'Self-referencing FK on special_price_request (resubmitted_special_price_request_id)',
    `approval_status` STRING COMMENT 'Current approval workflow state of the special price request.. Valid values are `pending|approved|rejected|escalated`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the request was approved or rejected.',
    `channel_code` STRING COMMENT 'Code indicating the sales channel through which the request originated.. Valid values are `DISTR|DIRECT|ONLINE|PARTNER`',
    `competitive_pressure` STRING COMMENT 'Information about competitor pricing or market conditions influencing the request.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier associated with the request for accounting allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the request record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the pricing amounts (e.g., USD, EUR).',
    `discount_percent` DECIMAL(18,2) COMMENT 'Proposed discount expressed as a percentage of the standard price.',
    `effective_from_date` DATE COMMENT 'Start date when the approved special price becomes valid.',
    `effective_to_date` DATE COMMENT 'End date when the special price expires; null if open‑ended.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the request contains confidential pricing information.',
    `justification` STRING COMMENT 'Narrative explanation why the special price is needed (e.g., strategic win, market pressure).',
    `notes` STRING COMMENT 'Free‑form comments or observations added by the sales rep or approver.',
    `price_type` STRING COMMENT 'Pricing strategy applied to calculate the requested price.. Valid values are `cost_plus|market_based|contractual|promotional`',
    `product_grade` STRING COMMENT 'Specific grade or specification of the product (e.g., purity level, viscosity class).',
    `region_code` STRING COMMENT 'Three‑letter code representing the sales region applicable to the request. [ENUM-REF-CANDIDATE: USA|CAN|MEX|CHN|DEU|FRA|GBR|IND|BRA|JPN — 10 candidates stripped; promote to reference product]',
    `request_number` STRING COMMENT 'Human‑readable request number assigned by the pricing system for tracking.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the sales representative submitted the special price request.',
    `requested_price` DECIMAL(18,2) COMMENT 'Price the sales rep proposes for the product, expressed in the transaction currency.',
    `special_price_request_status` STRING COMMENT 'Lifecycle status of the special price request record.. Valid values are `draft|submitted|under_review|approved|rejected|closed`',
    `standard_price` DECIMAL(18,2) COMMENT 'Current price from the applicable price list before any special discount.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any applicable surcharge added to the requested price.',
    `surcharge_flag` BOOLEAN COMMENT 'Indicates whether a surcharge (e.g., energy index) is applied to the request.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the request record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the request record.',
    `volume_commitment` DECIMAL(18,2) COMMENT 'Quantity the customer commits to purchase under the special price, in the unit defined by volume_uom.',
    `volume_uom` STRING COMMENT 'Unit of measure for the volume commitment (e.g., kilogram, ton).. Valid values are `kg|ton|lb|gal|L|m3`',
    `created_by` STRING COMMENT 'User identifier of the person who initially created the request record.',
    CONSTRAINT pk_special_price_request PRIMARY KEY(`special_price_request_id`)
) COMMENT 'Special pricing request (SPR) record capturing a sales representatives request for a customer-specific or deal-specific price deviation from the standard price list. Captures requesting sales rep, customer account, product and grade, requested price, standard list price, requested discount percentage, deal justification, competitive pressure details, volume commitment, and approval status. Core to the chemical industrys deal desk and special pricing management process.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` (
    `formula_price_id` BIGINT COMMENT 'System-generated unique identifier for the pricing formula record.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Formula price calculations use experimental formulation parameters (ratios, ingredients) to derive price components.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Formula‑based price definitions are tied to a pricing strategy',
    `superseded_formula_price_id` BIGINT COMMENT 'Self-referencing FK on formula_price (superseded_formula_price_id)',
    `applicable_plant_code` STRING COMMENT 'Production plant to which the formula applies.',
    `applicable_region_code` STRING COMMENT 'Geographic region where the formula is valid.. Valid values are `^[A-Z]{3}$`',
    `approval_status` STRING COMMENT 'Current approval state of the formula.. Valid values are `approved|rejected|under_review`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the formula was approved or rejected.',
    `base_price` DECIMAL(18,2) COMMENT 'Static component of the price before index adjustments.',
    `ceiling_price` DECIMAL(18,2) COMMENT 'Highest allowable price for the formula.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) governing the formula. [ENUM-REF-CANDIDATE: REACH|GHS|EPA|OSHA|ISO9001|ISO14001|ISO45001 — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the formula record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date when the formula becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the formula expires; null for open‑ended.',
    `floor_price` DECIMAL(18,2) COMMENT 'Lowest allowable price for the formula.',
    `formula_expression` STRING COMMENT 'Textual representation of the calculation logic.',
    `formula_price_code` STRING COMMENT 'Business code used to reference the formula in contracts and systems.',
    `formula_price_description` STRING COMMENT 'Detailed textual description of the pricing logic.',
    `formula_price_name` STRING COMMENT 'Human‑readable name of the pricing formula.',
    `formula_price_status` STRING COMMENT 'Current lifecycle state of the formula.. Valid values are `active|inactive|deprecated|pending`',
    `formula_price_type` STRING COMMENT 'Category of pricing calculation method.. Valid values are `cost_plus|market_index|fixed|tiered`',
    `index_1_code` STRING COMMENT 'Identifier of the first external market index used in the formula.',
    `index_1_coefficient` DECIMAL(18,2) COMMENT 'Multiplier applied to the primary index value.',
    `index_1_lag_days` STRING COMMENT 'Number of days the index value is lagged.',
    `index_2_code` STRING COMMENT 'Identifier of an optional second market index.',
    `index_2_coefficient` DECIMAL(18,2) COMMENT 'Multiplier for the secondary index.',
    `index_2_lag_days` STRING COMMENT 'Lag in days for the secondary index.',
    `is_default` BOOLEAN COMMENT 'True if this formula is the default for its product line.',
    `minimum_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity required for the formula to apply.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions.',
    `reset_frequency` STRING COMMENT 'How often the formula is recalculated (e.g., monthly).. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `surcharge_coefficient` DECIMAL(18,2) COMMENT 'Multiplier for the selected surcharge type.',
    `surcharge_type` STRING COMMENT 'Category of any additional surcharge applied.. Valid values are `energy|raw_material|logistics|none`',
    `unit_of_measure` STRING COMMENT 'Unit in which the price is expressed (e.g., USD_per_ton).',
    `updated_by` STRING COMMENT 'User identifier who last updated the formula.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification.',
    `version_number` STRING COMMENT 'Sequential version of the formula for change management.',
    `volume_discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied when order volume exceeds thresholds.',
    `created_by` STRING COMMENT 'User identifier who created the formula.',
    CONSTRAINT pk_formula_price PRIMARY KEY(`formula_price_id`)
) COMMENT 'Formula-based pricing record defining a price calculation formula that links a chemical products selling price to one or more external market indices, feedstock costs, or energy indices. Captures formula expression (e.g., base price + ethylene index × coefficient + energy surcharge), index references, weighting factors, lag period, floor price, ceiling price, and reset frequency. Common in long-term chemical supply contracts where prices float with feedstock markets.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` (
    `formula_price_calculation_id` BIGINT COMMENT 'Unique surrogate key for each formula price calculation record.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the chemical product whose price is being calculated.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Each formula price calculation records which experimental formulation was used for traceability and audit.',
    `formula_price_id` BIGINT COMMENT 'Reference to the master formula price record that this calculation applies to.',
    `prior_formula_price_calculation_id` BIGINT COMMENT 'Self-referencing FK on formula_price_calculation (prior_formula_price_calculation_id)',
    `calculated_price` DECIMAL(18,2) COMMENT 'Resulting price after applying formula and indexes.',
    `calculation_code` STRING COMMENT 'Business identifier code for the price calculation event.',
    `calculation_status` STRING COMMENT 'Current lifecycle status of the price calculation.. Valid values are `pending|completed|failed|reversed`',
    `calculation_timestamp` TIMESTAMP COMMENT 'Date and time when the price calculation was executed.',
    `ceiling_price` DECIMAL(18,2) COMMENT 'Maximum allowable price for the product.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calculation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the price values.. Valid values are `^[A-Z]{3}$`',
    `effective_price` DECIMAL(18,2) COMMENT 'Final price applied after floor/ceiling checks and any surcharges.',
    `floor_ceiling_breach_flag` BOOLEAN COMMENT 'Indicates whether the calculated price violated floor or ceiling limits.',
    `floor_price` DECIMAL(18,2) COMMENT 'Minimum allowable price for the product.',
    `index_energy` DECIMAL(18,2) COMMENT 'Index value for energy cost used in the calculation.',
    `index_raw_material` DECIMAL(18,2) COMMENT 'Index value for raw material cost used in the calculation.',
    `notes` STRING COMMENT 'Free‑form text for any supplemental information about the calculation.',
    `plant_code` STRING COMMENT 'Code of the manufacturing plant where the price calculation is applied.',
    `price_change_amount` DECIMAL(18,2) COMMENT 'Absolute difference between calculated price and prior price.',
    `price_change_percent` DECIMAL(18,2) COMMENT 'Percentage change between calculated price and prior price.',
    `price_change_reason` STRING COMMENT 'Narrative explanation for the price change (e.g., index movement, contract clause).',
    `price_valid_from` DATE COMMENT 'Date from which the calculated price becomes effective.',
    `price_valid_to` DATE COMMENT 'Date until which the calculated price remains effective; null if open‑ended.',
    `prior_price` DECIMAL(18,2) COMMENT 'Price from the previous calculation period for comparison.',
    `region_code` STRING COMMENT 'Geographic region code relevant to the pricing calculation.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the calculation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the calculation record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the calculation record.',
    CONSTRAINT pk_formula_price_calculation PRIMARY KEY(`formula_price_calculation_id`)
) COMMENT 'Transactional record capturing the periodic execution of a formula-based price calculation for a specific formula price record. Stores calculation date, input index values used, calculated price result, prior period price, price change amount and percentage, floor/ceiling breach flag, and resulting effective price. Provides the audit trail for formula price resets and supports customer notification of price changes under index-linked chemical supply contracts.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` (
    `channel_price_id` BIGINT COMMENT 'System-generated unique identifier for each channel price record.',
    `chemical_product_id` BIGINT COMMENT 'Unique identifier of the chemical product to which the channel price relates.',
    `price_list_id` BIGINT COMMENT 'Reference to the price list to which this channel price belongs.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: Channel‑specific pricing is derived from a particular price list line item; adding price_list_item_id to channel_price creates the correct child‑to‑parent relationship without forming a cycle.',
    `strategy_id` BIGINT COMMENT 'Reference to the pricing strategy that governs this channel price.',
    `superseded_channel_price_id` BIGINT COMMENT 'Self-referencing FK on channel_price (superseded_channel_price_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the channel price was approved.',
    `approved_by_user` STRING COMMENT 'User who approved the channel price for activation.',
    `channel_name` STRING COMMENT 'Human‑readable name of the sales channel.',
    `channel_price_status` STRING COMMENT 'Current lifecycle status of the channel price record.. Valid values are `active|inactive|expired|pending`',
    `channel_type` STRING COMMENT 'Classification of the distribution channel for which the price applies (e.g., direct, distributor, e‑commerce, export, OEM).. Valid values are `direct|distributor|ecommerce|export|oem`',
    `created_by_user` STRING COMMENT 'User identifier of the person who created the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the channel price record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which price_amount is expressed.',
    `customer_segment_code` STRING COMMENT 'Code identifying the customer segment (e.g., industrial, OEM, distributor) for which the price is defined.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base price for the channel.',
    `effective_from` DATE COMMENT 'Start date when the channel price becomes valid.',
    `effective_to` DATE COMMENT 'End date when the channel price expires (null for open‑ended).',
    `geographic_region_code` STRING COMMENT 'Three‑letter code representing the geographic region to which the price applies.',
    `is_transfer_pricing` BOOLEAN COMMENT 'Flag indicating whether the price is subject to transfer pricing rules.',
    `margin_target_percent` DECIMAL(18,2) COMMENT 'Desired gross margin percentage the channel price aims to achieve.',
    `notes` STRING COMMENT 'Free‑form comments or rationale for the channel price.',
    `price_amount` DECIMAL(18,2) COMMENT 'Base price amount charged to the channel before discounts or surcharges.',
    `price_source` STRING COMMENT 'Origin of the price value (e.g., internal calculation, external market feed, system generated).. Valid values are `internal|external|system_generated`',
    `price_type` STRING COMMENT 'Category of the price component (list price, discount, surcharge, margin).. Valid values are `list|discount|surcharge|margin`',
    `price_version` STRING COMMENT 'Sequential version number for the channel price record.',
    `surcharge_energy_index` DECIMAL(18,2) COMMENT 'Monetary surcharge derived from an energy cost index, applied to the channel price.',
    `surcharge_raw_material_index` DECIMAL(18,2) COMMENT 'Monetary surcharge based on a raw material cost index, applied to the channel price.',
    `updated_by_user` STRING COMMENT 'User identifier of the person who performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the channel price record.',
    `volume_discount_tier` STRING COMMENT 'Identifier of the volume discount tier applicable to the channel price.',
    CONSTRAINT pk_channel_price PRIMARY KEY(`channel_price_id`)
) COMMENT 'Channel-specific pricing record defining differentiated prices for chemical products sold through distinct distribution channels — direct industrial sales, distributor channel, e-commerce, export/international, and OEM supply. Captures channel type, product or product line scope, channel price or discount from list, channel margin target, and validity period. Enables channel pricing strategy management to prevent channel conflict and optimize margin across the chemical distribution network.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` (
    `regional_price_id` BIGINT COMMENT 'System generated unique identifier for each regional price record.',
    `chemical_product_id` BIGINT COMMENT 'Unique identifier of the chemical product to which this regional price applies.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Regional price adjustments are scoped by pricing strategy',
    `superseded_regional_price_id` BIGINT COMMENT 'Self-referencing FK on regional_price (superseded_regional_price_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the price record was initially created.',
    `differential_type` STRING COMMENT 'Specifies whether the price differential is an absolute amount or a percentage.. Valid values are `absolute|percentage`',
    `differential_value` DECIMAL(18,2) COMMENT 'Numeric value of the price differential (absolute amount or percent).',
    `ex_works_flag` BOOLEAN COMMENT 'True if the price is quoted on an ex‑works basis (excluding freight).',
    `freight_included_flag` BOOLEAN COMMENT 'True if freight costs are included in the price.',
    `import_duty_included_flag` BOOLEAN COMMENT 'True if applicable import duties are baked into the price.',
    `min_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered to qualify for this regional price.',
    `notes` STRING COMMENT 'Free‑form comments or business rationale for the price record.',
    `price_amount` DECIMAL(18,2) COMMENT 'Numeric value of the price expressed in the specified currency.',
    `price_basis` STRING COMMENT 'Methodology used to calculate the price (e.g., cost‑plus, market‑based).. Valid values are `cost_plus|market|contract|custom`',
    `price_category` STRING COMMENT 'Business classification of the price (e.g., standard, promotional, clearance).. Valid values are `standard|promotional|clearance`',
    `price_code` STRING COMMENT 'Business code used to reference the price record in pricing procedures and contracts.',
    `price_currency_code` STRING COMMENT 'Three‑letter currency code for the price amount.. Valid values are `^[A-Z]{3}$`',
    `price_effective_from` DATE COMMENT 'First calendar date on which the price becomes valid.',
    `price_effective_to` DATE COMMENT 'Last calendar date on which the price remains valid (null for open‑ended).',
    `price_label` STRING COMMENT 'Human‑readable name describing the price record (e.g., "EU West Chemical A Price").',
    `price_override_flag` BOOLEAN COMMENT 'True if this price overrides a default or global price.',
    `price_region_hierarchy_code` STRING COMMENT 'Code representing the regions position in the geographic hierarchy (e.g., continent > country > sub‑region).',
    `price_regulatory_code` STRING COMMENT 'Code referencing the specific regulatory rule or exemption applied to the price.. Valid values are `^[A-Z0-9]{4,10}$`',
    `price_regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the price complies with applicable regulations (e.g., REACH, GHS).',
    `price_source_system` STRING COMMENT 'Originating system that supplied the price data.. Valid values are `SAP|Oracle|Custom`',
    `price_status` STRING COMMENT 'Current lifecycle status of the price record.. Valid values are `active|inactive|pending|expired`',
    `price_tax_included_flag` BOOLEAN COMMENT 'True if taxes are already included in the price amount.',
    `price_tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (percentage) when tax is not included.',
    `price_type` STRING COMMENT 'Indicates whether the record is a base list price, a discount, or a surcharge.. Valid values are `list|discount|surcharge`',
    `price_uom` STRING COMMENT 'Unit of measure for which the price applies (e.g., per kilogram).. Valid values are `per_kg|per_liter|per_ton`',
    `price_uom_conversion_factor` DECIMAL(18,2) COMMENT 'Factor to convert the price to alternative units of measure.',
    `price_validity_reason` STRING COMMENT 'Explanation for why a price is active, expired, or pending (e.g., contract renewal, market shift).',
    `price_version` STRING COMMENT 'Version number of the price record for change management.',
    `region_code` STRING COMMENT 'Three‑letter ISO country or region code to which the price adjustment applies.. Valid values are `^[A-Z]{3}$`',
    `region_name` STRING COMMENT 'Descriptive name of the geographic region (e.g., "Western Europe").',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the price record.',
    `volume_discount_tier` STRING COMMENT 'Tier identifier for volume‑based discount structures (e.g., 1, 2, 3).',
    CONSTRAINT pk_regional_price PRIMARY KEY(`regional_price_id`)
) COMMENT 'Regional or geographic pricing record defining price adjustments or differentials applied to chemical products in specific geographic markets or sales regions. Captures region or country, product scope, price differential (absolute or percentage from global list), local currency price, freight-included vs. ex-works basis, import duty considerations, and validity period. Supports geographic price differentiation for chemical products across domestic and international markets.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` (
    `price_change_event_id` BIGINT COMMENT 'System-generated unique identifier for the immutable price change event record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer (if the price change is customer‑specific).',
    `condition_record_id` BIGINT COMMENT 'Identifier of the pricing condition record impacted by the change.',
    `employee_id` BIGINT COMMENT 'System identifier of the user who executed the price change.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: OOS inspection lots trigger price change events to adjust batch pricing; required for OOS‑Driven Price Adjustment workflow.',
    `material_master_id` BIGINT COMMENT 'Identifier of the chemical material or product whose price is changed.',
    `price_list_id` BIGINT COMMENT 'Identifier of the price list to which the change applies.',
    `supply_plan_id` BIGINT COMMENT 'Foreign key linking to planning.supply_plan. Business justification: Price changes are often triggered by adjustments in the supply plan to reflect material availability.',
    `reversal_price_change_event_id` BIGINT COMMENT 'Self-referencing FK on price_change_event (reversal_price_change_event_id)',
    `approval_reference` STRING COMMENT 'Reference number of the approval document or workflow instance.',
    `approval_status` STRING COMMENT 'Current status of the price change approval process.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the price change was approved (or rejected).',
    `change_amount` DECIMAL(18,2) COMMENT 'Numeric difference between new_price and old_price (new_price - old_price).',
    `change_percent` DECIMAL(18,2) COMMENT 'Percentage change calculated as (change_amount / old_price) * 100.',
    `change_reason_code` STRING COMMENT 'Standard code indicating why the price was changed.. Valid values are `annual_increase|feedstock_cost_change|competitive_response|contract_renewal|regulatory_adjustment|promotion`',
    `change_reason_description` STRING COMMENT 'Free‑text explanation of the business rationale behind the price change.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price change event record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which prices are expressed.. Valid values are `[A-Z]{3}`',
    `effective_date` DATE COMMENT 'Calendar date on which the new price becomes legally effective.',
    `event_payload` STRING COMMENT 'Serialized JSON payload containing the full set of price change details for downstream processing.',
    `event_source_reference` STRING COMMENT 'Identifier of the source system that generated the price change event.. Valid values are `SAP_S4HANA|Custom`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the price change event was recorded in the system.',
    `event_type` STRING COMMENT 'Classification of the event; for this product it is always a price change.. Valid values are `price_change`',
    `initiating_user_name` STRING COMMENT 'Display name of the user who performed the price change.',
    `is_approved` BOOLEAN COMMENT 'True when the price change has passed all required approvals.',
    `is_manual_change` BOOLEAN COMMENT 'True if the price change was entered manually; false if system‑generated.',
    `new_price` DECIMAL(18,2) COMMENT 'Price amount after the change, expressed in the transaction currency.',
    `notes` STRING COMMENT 'Optional free‑form comments or audit notes related to the price change.',
    `old_price` DECIMAL(18,2) COMMENT 'Price amount before the change, expressed in the transaction currency.',
    `price_change_type` STRING COMMENT 'Indicates whether the change applies to a price‑list item, a condition record, or a customer‑specific price.. Valid values are `price_list_item|condition_record|customer_specific`',
    `record_status` STRING COMMENT 'Lifecycle status of the price change record.. Valid values are `active|inactive|archived`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price change event record.',
    CONSTRAINT pk_price_change_event PRIMARY KEY(`price_change_event_id`)
) COMMENT 'Immutable event record capturing every price change applied to a price list item, condition record, or customer-specific price. Records old price, new price, change amount, change percentage, effective date, change reason code (annual increase, feedstock cost change, competitive response, contract renewal), initiating user, and approval reference. Provides the complete audit trail for pricing decisions and supports regulatory and commercial dispute resolution for chemical product pricing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` (
    `competitor_price_id` BIGINT COMMENT 'Unique identifier for the competitor price observation record.',
    `chemical_product_id` BIGINT COMMENT 'Internal identifier of the competing product or grade.',
    `competitor_id` BIGINT COMMENT 'Internal identifier of the competing company providing the price.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Competitor price records are used to benchmark against internal price lists; linking each competitor_price to the relevant price_list provides a direct relationship and eliminates the siloed status of',
    `prior_competitor_price_id` BIGINT COMMENT 'Self-referencing FK on competitor_price (prior_competitor_price_id)',
    `confidence_level` STRING COMMENT 'Confidence rating assigned to the price observation.. Valid values are `high|medium|low`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the observed price.. Valid values are `^[A-Z]{3}$`',
    `geographic_market` STRING COMMENT 'Three‑letter country code of the market where the price applies.. Valid values are `^[A-Z]{3}$`',
    `grade` STRING COMMENT 'Specific grade or purity level of the competing product.',
    `observation_timestamp` TIMESTAMP COMMENT 'Date and time when the competitor price was observed or recorded.',
    `price_amount` DECIMAL(18,2) COMMENT 'Observed price value for the competing product.',
    `price_basis` STRING COMMENT 'Basis on which the price is quoted (e.g., list price, net price, delivered price).. Valid values are `list|net|delivered|contract|spot`',
    `price_index_reference` STRING COMMENT 'Reference name of any market index used in the price calculation (e.g., raw material index).',
    `price_index_value` DECIMAL(18,2) COMMENT 'Value of the referenced market index at the time of observation.',
    `price_type` STRING COMMENT 'Incoterm defining the delivery terms associated with the price.. Valid values are `FOB|CIF|DAP|DDP|EXW`',
    `price_uom` STRING COMMENT 'Unit of measure for the price (e.g., kg, ton, liter).',
    `price_valid_from` DATE COMMENT 'Start date of the price validity period, if applicable.',
    `price_valid_until` DATE COMMENT 'End date of the price validity period, if applicable.',
    `product_cas_number` STRING COMMENT 'Standard CAS registry number identifying the chemical substance.. Valid values are `^d{2,7}-d{2}-d$`',
    `product_name` STRING COMMENT 'Descriptive name of the competing product or grade.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this competitor price record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `source_detail` STRING COMMENT 'Free‑text description of the specific source or report.',
    `source_type` STRING COMMENT 'Category of source providing the price intelligence.. Valid values are `customer_feedback|distributor_report|public_tender|market_research|internal_estimate`',
    CONSTRAINT pk_competitor_price PRIMARY KEY(`competitor_price_id`)
) COMMENT 'Competitor market price intelligence record capturing observed or reported prices for competing chemical products in the market. Stores competitor identity, competing product or grade, observed price, price basis (list, net, delivered), source of intelligence (customer feedback, distributor report, public tender, market research), observation date, geographic market, and confidence level. Feeds competitive pricing analysis and market-based pricing decisions for chemical product portfolio management.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` (
    `price_simulation_id` BIGINT COMMENT 'System-generated unique identifier for each price simulation record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: The price simulation tool runs scenarios on a specific chemical product to forecast revenue, margin, and regulatory impact.',
    `employee_id` BIGINT COMMENT 'Identifier of the pricing analyst or commercial manager who created or owns the simulation.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Price simulations are run against a particular formula version to forecast pricing impact of formulation changes.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Price simulation scenarios are run against a pricing strategy',
    `baseline_price_simulation_id` BIGINT COMMENT 'Self-referencing FK on price_simulation (baseline_price_simulation_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the simulation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the simulated price.. Valid values are `^[A-Z]{3}$`',
    `customer_scope_code` STRING COMMENT 'Identifier of the customer or customer segment affected by the simulation.',
    `customer_scope_type` STRING COMMENT 'Defines whether the simulation targets an individual customer, segment, or all customers.',
    `effective_from` DATE COMMENT 'Start date from which the simulated pricing would be applicable if approved.',
    `effective_to` DATE COMMENT 'End date after which the simulated pricing would no longer be applicable.',
    `estimated_margin_impact` DECIMAL(18,2) COMMENT 'Projected change in gross margin (currency) resulting from the simulation.',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'Projected change in revenue (currency) attributable to the simulation.',
    `estimated_volume_impact` DECIMAL(18,2) COMMENT 'Projected change in sales volume (units) resulting from the simulated price change.',
    `notes` STRING COMMENT 'Any supplemental information, comments, or audit trail remarks related to the simulation.',
    `price_simulation_status` STRING COMMENT 'Current lifecycle state of the simulation record.. Valid values are `draft|active|completed|cancelled`',
    `product_scope_code` STRING COMMENT 'Identifier (e.g., SKU or product line code) of the product(s) covered by the simulation.',
    `product_scope_type` STRING COMMENT 'Indicates whether the simulation applies to a single SKU, product line, or entire portfolio.',
    `scenario_type` STRING COMMENT 'Category of what‑if analysis performed (e.g., price increase impact, margin optimization, volume‑price trade‑off).. Valid values are `price_increase|margin_optimization|volume_price_tradeoff|cost_plus|market_based`',
    `simulated_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied in the simulation scenario.',
    `simulated_margin_percent` DECIMAL(18,2) COMMENT 'Projected gross margin percent derived from simulated price and cost.',
    `simulated_price` DECIMAL(18,2) COMMENT 'Projected unit price resulting from the simulation (before discounts).',
    `simulation_code` STRING COMMENT 'Business-friendly code used to reference the simulation in reports and communications.',
    `simulation_description` STRING COMMENT 'Free‑form text describing assumptions, methodology, and any special notes for the simulation.',
    `simulation_name` STRING COMMENT 'Descriptive name of the simulation scenario for easy identification by analysts.',
    `simulation_timestamp` TIMESTAMP COMMENT 'Date‑time when the simulation was executed or last refreshed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the simulation record.',
    CONSTRAINT pk_price_simulation PRIMARY KEY(`price_simulation_id`)
) COMMENT 'Price simulation record capturing a what-if pricing scenario analysis performed by pricing analysts or commercial managers. Stores simulation name, scenario type (price increase impact, margin optimization, volume-price trade-off), product scope, customer scope, simulated price or discount, estimated volume impact, estimated revenue impact, estimated margin impact, and simulation status. Supports pricing decision-making for annual price reviews, contract negotiations, and new product launches in chemical manufacturing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` (
    `authority_matrix_id` BIGINT COMMENT 'System-generated unique identifier for each pricing authority matrix record.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Pricing approval authority is often limited to a specific org unit; the FK enables the Pricing Authority Matrix report per unit.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Authority matrix defines limits per pricing strategy',
    `parent_authority_matrix_id` BIGINT COMMENT 'Self-referencing FK on authority_matrix (parent_authority_matrix_id)',
    `applicable_currency` STRING COMMENT 'ISO 4217 three‑letter currency code for which the authority thresholds apply.. Valid values are `^[A-Z]{3}$`',
    `approval_hierarchy` STRING COMMENT 'Textual representation of the hierarchical chain for escalations beyond this authority.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the authority matrix entry was approved.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the authority matrix entry.',
    `authority_code` STRING COMMENT 'Unique alphanumeric code used to reference the authority role within pricing systems.',
    `authority_level` STRING COMMENT 'Numeric level indicating hierarchy of the authority (higher number = higher authority).',
    `authority_matrix_status` STRING COMMENT 'Current lifecycle status of the authority matrix record.. Valid values are `active|inactive|pending|retired`',
    `authority_role` STRING COMMENT 'Name of the role or position that holds pricing authority (e.g., Regional Sales Manager, Global Pricing Director).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the authority matrix record was first created.',
    `customer_tier_scope` STRING COMMENT 'Customer segmentation (e.g., Tier 1, Tier 2) for which this authority level is valid.',
    `effective_from` DATE COMMENT 'Date when the authority matrix becomes effective.',
    `effective_until` DATE COMMENT 'Date when the authority matrix expires (null for open‑ended).',
    `escalation_path` STRING COMMENT 'Textual description of the escalation process when a request exceeds this authoritys limits.',
    `geographic_scope` STRING COMMENT 'Region or country codes where the authority matrix is effective.',
    `is_below_margin_allowed` BOOLEAN COMMENT 'Flag indicating if the role may approve pricing below the defined margin floor.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this matrix is the default for its scope when no specific matrix matches.',
    `is_transfer_pricing_allowed` BOOLEAN COMMENT 'Indicates whether the role can approve transfer‑pricing decisions without further escalation.',
    `max_discount_amount` DECIMAL(18,2) COMMENT 'Maximum absolute discount amount (currency) this role may approve.',
    `max_discount_percent` DECIMAL(18,2) COMMENT 'Maximum discount percentage this role may approve on standard pricing.',
    `min_margin_percent` DECIMAL(18,2) COMMENT 'Minimum profit margin percentage that must be maintained for approvals by this role.',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding special conditions or rationale.',
    `price_floor_percent` DECIMAL(18,2) COMMENT 'Minimum margin floor percentage that must be respected for approvals by this role.',
    `product_line_scope` STRING COMMENT 'Comma‑separated list or code indicating which product lines the authority applies to.',
    `surcharge_allowed` BOOLEAN COMMENT 'Indicates whether the role may approve surcharges (e.g., energy, raw‑material index) without escalation.',
    `surcharge_type_allowed` STRING COMMENT 'Enumerated list of surcharge categories the authority can approve.. Valid values are `energy|raw_material|other`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the authority matrix record.',
    `version_number` STRING COMMENT 'Incremental version of the authority matrix record for change tracking.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_authority_matrix PRIMARY KEY(`authority_matrix_id`)
) COMMENT 'Reference master defining the pricing authority levels and approval thresholds for pricing decisions across the Chemical Mfg organization. Captures role or position, maximum discount authority (percentage or absolute), minimum margin floor authority, product line scope, customer tier scope, and escalation path. Governs who can approve standard pricing, special price requests, below-floor pricing, and transfer pricing decisions without escalation.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` (
    `currency_exchange_rate_id` BIGINT COMMENT 'System-generated unique identifier for each currency exchange rate record.',
    `strategy_id` BIGINT COMMENT 'Auto-generated FK linking siloed currency_exchange_rate to strategy',
    `prior_currency_exchange_rate_id` BIGINT COMMENT 'Self-referencing FK on currency_exchange_rate (prior_currency_exchange_rate_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exchange rate record was first created in the system.',
    `currency_base` STRING COMMENT 'ISO 4217 code of the source (base) currency in the pair.. Valid values are `^[A-Z]{3}$`',
    `currency_exchange_rate_status` STRING COMMENT 'Current lifecycle status of the rate record.. Valid values are `active|inactive|deprecated`',
    `currency_pair` STRING COMMENT 'Concatenated ISO 4217 codes representing the source and target currencies (e.g., USD/EUR).. Valid values are `^[A-Z]{3}/[A-Z]{3}$`',
    `currency_target` STRING COMMENT 'ISO 4217 code of the target (quote) currency in the pair.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date on which the exchange rate becomes valid for pricing calculations.',
    `effective_to` DATE COMMENT 'Date on which the exchange rate ceases to be valid (nullable for open‑ended rates).',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the rate (e.g., special market conditions).',
    `rate_code` STRING COMMENT 'External reference code for the rate, often used in finance or pricing systems.',
    `rate_type` STRING COMMENT 'Classification of the rate (e.g., spot, average, planning, hedge, mid, custom).. Valid values are `spot|average|planning|hedge|mid|custom`',
    `rate_value` DECIMAL(18,2) COMMENT 'Numeric exchange rate value representing how many units of the target currency equal one unit of the base currency.',
    `source` STRING COMMENT 'Origin of the rate data (e.g., ECB, internal treasury, SAP FI).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the exchange rate record.',
    `version_number` BIGINT COMMENT 'Monotonically increasing version number for audit and change tracking.',
    CONSTRAINT pk_currency_exchange_rate PRIMARY KEY(`currency_exchange_rate_id`)
) COMMENT 'Currency exchange rate record used in multi-currency pricing for chemical products sold across international markets. Captures currency pair, exchange rate type (spot, average, planning, hedge rate), rate value, valid-from date, and source (ECB, internal treasury, SAP FI). Distinct from any finance domain FX exposure records — this is the pricing-specific rate master used to convert list prices and condition records into local currency for customer invoicing and price list publication.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` (
    `price_floor_id` BIGINT COMMENT 'System-generated unique identifier for the price floor record.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Price floor definitions are linked to a pricing strategy',
    `superseded_price_floor_id` BIGINT COMMENT 'Self-referencing FK on price_floor (superseded_price_floor_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the floor was approved.',
    `approving_authority` STRING COMMENT 'Name or role of the executive who approved the floor.',
    `calculation_methodology` STRING COMMENT 'Narrative description of how the floor amount is derived.',
    `cost_basis` STRING COMMENT 'Primary cost component used for the floor calculation.. Valid values are `material|energy|labor|overhead|total`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price floor record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the floor amount.. Valid values are `[A-Z]{3}`',
    `effective_from` DATE COMMENT 'Date from which the floor becomes enforceable.',
    `effective_until` DATE COMMENT 'Date after which the floor is no longer valid (null for open‑ended).',
    `floor_amount` DECIMAL(18,2) COMMENT 'Minimum acceptable selling price amount before discounts or surcharges.',
    `floor_type` STRING COMMENT 'Category of floor calculation basis (e.g., variable cost, contribution margin, full cost).. Valid values are `variable_cost|contribution_margin|full_cost|custom`',
    `margin_percent` DECIMAL(18,2) COMMENT 'Desired contribution margin percent that the floor aims to protect.',
    `market_code` STRING COMMENT 'Identifier of the market, region, or sales channel the floor applies to.',
    `notes` STRING COMMENT 'Free‑form comments or rationale for the floor.',
    `price_floor_code` STRING COMMENT 'Unique alphanumeric code used in pricing systems to reference the floor.',
    `price_floor_name` STRING COMMENT 'Human‑readable name describing the price floor (e.g., "Base Chemical Floor").',
    `price_floor_status` STRING COMMENT 'Current lifecycle state of the price floor.. Valid values are `active|inactive|pending|retired`',
    `product_grade` STRING COMMENT 'Specific grade or specification of the chemical product (e.g., "Technical Grade").',
    `product_sku` STRING COMMENT 'Stock Keeping Unit of the chemical product to which the floor applies.',
    `raw_material_index_factor` DECIMAL(18,2) COMMENT 'Multiplier based on raw material price index used in floor calculation.',
    `regulatory_reporting_requirement` STRING COMMENT 'Regulation or standard (e.g., EPA, REACH) that mandates the floors existence or documentation.',
    `review_date` DATE COMMENT 'Date when the floor price is scheduled for review.',
    `surcharge_energy_index` DECIMAL(18,2) COMMENT 'Factor reflecting energy cost adjustments applied to the floor.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the price floor record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_price_floor PRIMARY KEY(`price_floor_id`)
) COMMENT 'Price floor record defining the minimum acceptable selling price for a chemical product, grade, or SKU below which sales are not authorized without executive approval. Captures floor price basis (variable cost floor, contribution margin floor, full cost floor), floor price amount, currency, applicable market or channel, calculation methodology, review date, and approving authority. Protects margin integrity and prevents below-cost selling in chemical manufacturing commercial operations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`pricing`.`calendar` (
    `calendar_id` BIGINT COMMENT 'System-generated unique identifier for each pricing calendar record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the pricing manager responsible for this calendar.',
    `calendar_pricing_manager_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Pricing calendars are plant‑specific; linking to org_unit allows schedule management and compliance tracking per facility.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Pricing calendar is associated with a pricing strategy for review cycles',
    `prior_pricing_calendar_id` BIGINT COMMENT 'Self-referencing FK on calendar (prior_pricing_calendar_id)',
    `approval_status` STRING COMMENT 'Current approval state of the pricing calendar.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing calendar received final approval.',
    `approved_by` STRING COMMENT 'User identifier who approved the pricing calendar.',
    `calendar_code` STRING COMMENT 'Human‑readable code used to reference the pricing calendar in business processes.',
    `calendar_name` STRING COMMENT 'Descriptive name of the pricing calendar (e.g., "2025 Annual Review").',
    `calendar_status` STRING COMMENT 'Current lifecycle state of the pricing calendar.. Valid values are `active|inactive|draft|retired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing calendar record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary values in the calendar.',
    `customer_notification_deadline` DATE COMMENT 'Latest date to notify customers of upcoming price changes.',
    `customer_segment_code` STRING COMMENT 'Code representing the customer segment (e.g., industrial, OEM, distributor).',
    `effective_from` DATE COMMENT 'Date when the pricing calendar becomes effective.',
    `effective_until` DATE COMMENT 'Date when the pricing calendar expires or is superseded (nullable for open‑ended).',
    `energy_index_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to base price based on an energy cost index.',
    `is_energy_surcharge_applicable` BOOLEAN COMMENT 'True when energy‑based surcharges are part of the pricing strategy.',
    `is_transfer_pricing` BOOLEAN COMMENT 'True if the calendar includes transfer‑pricing rules for inter‑company transactions.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the calendar.',
    `price_change_effective_date` DATE COMMENT 'Date when the new pricing becomes legally binding for customers.',
    `product_line_code` STRING COMMENT 'Code identifying the product line or segment covered by the calendar.',
    `raw_material_index_factor` DECIMAL(18,2) COMMENT 'Multiplier derived from a raw‑material cost index used in cost‑plus calculations.',
    `region_code` STRING COMMENT 'Three‑letter ISO code representing the geographic region the calendar applies to.',
    `review_cycle_type` STRING COMMENT 'Defines the frequency of the pricing review cycle.. Valid values are `annual|semi-annual|quarterly|monthly|index_reset`',
    `review_frequency_days` STRING COMMENT 'Number of days between successive reviews when not using a named cycle type.',
    `review_start_date` DATE COMMENT 'Date when the scheduled pricing review period begins.',
    `surcharge_notification_deadline` DATE COMMENT 'Deadline for communicating surcharge adjustments to affected parties.',
    `updated_by` STRING COMMENT 'User identifier who performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the pricing calendar.',
    `version_number` STRING COMMENT 'Sequential version of the pricing calendar for change control.',
    `created_by` STRING COMMENT 'User identifier who initially created the pricing calendar.',
    CONSTRAINT pk_calendar PRIMARY KEY(`calendar_id`)
) COMMENT 'Pricing calendar master record defining the scheduled pricing review cycles, price change effective dates, surcharge notification deadlines, and annual price increase timelines for chemical product portfolios. Captures review cycle type (annual, semi-annual, quarterly, monthly index reset), product line or segment scope, review start date, customer notification deadline, effective date, and responsible pricing manager. Coordinates pricing operations across commercial, finance, and customer service teams.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_superseded_price_list_id` FOREIGN KEY (`superseded_price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_superseded_price_list_item_id` FOREIGN KEY (`superseded_price_list_item_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ADD CONSTRAINT `fk_pricing_condition_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ADD CONSTRAINT `fk_pricing_condition_parent_condition_id` FOREIGN KEY (`parent_condition_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`condition`(`condition_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ADD CONSTRAINT `fk_pricing_condition_record_condition_id` FOREIGN KEY (`condition_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`condition`(`condition_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ADD CONSTRAINT `fk_pricing_condition_record_superseded_condition_record_id` FOREIGN KEY (`superseded_condition_record_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`condition_record`(`condition_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ADD CONSTRAINT `fk_pricing_strategy_parent_strategy_id` FOREIGN KEY (`parent_strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ADD CONSTRAINT `fk_pricing_cost_plus_model_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ADD CONSTRAINT `fk_pricing_cost_plus_model_superseded_cost_plus_model_id` FOREIGN KEY (`superseded_cost_plus_model_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`cost_plus_model`(`cost_plus_model_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ADD CONSTRAINT `fk_pricing_market_price_index_parent_market_price_index_id` FOREIGN KEY (`parent_market_price_index_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`market_price_index`(`market_price_index_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ADD CONSTRAINT `fk_pricing_index_price_point_market_price_index_id` FOREIGN KEY (`market_price_index_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`market_price_index`(`market_price_index_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ADD CONSTRAINT `fk_pricing_index_price_point_prior_index_price_point_id` FOREIGN KEY (`prior_index_price_point_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`index_price_point`(`index_price_point_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ADD CONSTRAINT `fk_pricing_surcharge_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ADD CONSTRAINT `fk_pricing_surcharge_parent_surcharge_id` FOREIGN KEY (`parent_surcharge_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ADD CONSTRAINT `fk_pricing_surcharge_rate_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ADD CONSTRAINT `fk_pricing_surcharge_rate_superseded_surcharge_rate_id` FOREIGN KEY (`superseded_surcharge_rate_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`surcharge_rate`(`surcharge_rate_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ADD CONSTRAINT `fk_pricing_volume_discount_schedule_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ADD CONSTRAINT `fk_pricing_volume_discount_schedule_superseded_volume_discount_schedule_id` FOREIGN KEY (`superseded_volume_discount_schedule_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule`(`volume_discount_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ADD CONSTRAINT `fk_pricing_transfer_price_market_price_index_id` FOREIGN KEY (`market_price_index_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`market_price_index`(`market_price_index_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ADD CONSTRAINT `fk_pricing_transfer_price_superseded_transfer_price_id` FOREIGN KEY (`superseded_transfer_price_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ADD CONSTRAINT `fk_pricing_transfer_price_study_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ADD CONSTRAINT `fk_pricing_transfer_price_study_prior_transfer_price_study_id` FOREIGN KEY (`prior_transfer_price_study_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`transfer_price_study`(`transfer_price_study_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ADD CONSTRAINT `fk_pricing_proposal_revised_proposal_id` FOREIGN KEY (`revised_proposal_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`proposal`(`proposal_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`proposal`(`proposal_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ADD CONSTRAINT `fk_pricing_approval_escalated_approval_id` FOREIGN KEY (`escalated_approval_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`approval`(`approval_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ADD CONSTRAINT `fk_pricing_special_price_request_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ADD CONSTRAINT `fk_pricing_special_price_request_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`proposal`(`proposal_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ADD CONSTRAINT `fk_pricing_special_price_request_resubmitted_special_price_request_id` FOREIGN KEY (`resubmitted_special_price_request_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`special_price_request`(`special_price_request_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ADD CONSTRAINT `fk_pricing_formula_price_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ADD CONSTRAINT `fk_pricing_formula_price_superseded_formula_price_id` FOREIGN KEY (`superseded_formula_price_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`formula_price`(`formula_price_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ADD CONSTRAINT `fk_pricing_formula_price_calculation_formula_price_id` FOREIGN KEY (`formula_price_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`formula_price`(`formula_price_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ADD CONSTRAINT `fk_pricing_formula_price_calculation_prior_formula_price_calculation_id` FOREIGN KEY (`prior_formula_price_calculation_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`formula_price_calculation`(`formula_price_calculation_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_superseded_channel_price_id` FOREIGN KEY (`superseded_channel_price_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`channel_price`(`channel_price_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ADD CONSTRAINT `fk_pricing_regional_price_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ADD CONSTRAINT `fk_pricing_regional_price_superseded_regional_price_id` FOREIGN KEY (`superseded_regional_price_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`regional_price`(`regional_price_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ADD CONSTRAINT `fk_pricing_price_change_event_condition_record_id` FOREIGN KEY (`condition_record_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`condition_record`(`condition_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ADD CONSTRAINT `fk_pricing_price_change_event_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ADD CONSTRAINT `fk_pricing_price_change_event_reversal_price_change_event_id` FOREIGN KEY (`reversal_price_change_event_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_change_event`(`price_change_event_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ADD CONSTRAINT `fk_pricing_competitor_price_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ADD CONSTRAINT `fk_pricing_competitor_price_prior_competitor_price_id` FOREIGN KEY (`prior_competitor_price_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`competitor_price`(`competitor_price_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_baseline_price_simulation_id` FOREIGN KEY (`baseline_price_simulation_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_simulation`(`price_simulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ADD CONSTRAINT `fk_pricing_authority_matrix_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ADD CONSTRAINT `fk_pricing_authority_matrix_parent_authority_matrix_id` FOREIGN KEY (`parent_authority_matrix_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`authority_matrix`(`authority_matrix_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ADD CONSTRAINT `fk_pricing_currency_exchange_rate_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ADD CONSTRAINT `fk_pricing_currency_exchange_rate_prior_currency_exchange_rate_id` FOREIGN KEY (`prior_currency_exchange_rate_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate`(`currency_exchange_rate_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ADD CONSTRAINT `fk_pricing_price_floor_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ADD CONSTRAINT `fk_pricing_price_floor_superseded_price_floor_id` FOREIGN KEY (`superseded_price_floor_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`price_floor`(`price_floor_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ADD CONSTRAINT `fk_pricing_calendar_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`strategy`(`strategy_id`);
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ADD CONSTRAINT `fk_pricing_calendar_prior_pricing_calendar_id` FOREIGN KEY (`prior_pricing_calendar_id`) REFERENCES `chemical_mfg_ecm`.`pricing`.`calendar`(`calendar_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`pricing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `chemical_mfg_ecm`.`pricing` SET TAGS ('dbx_domain' = 'pricing');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` SET TAGS ('dbx_subdomain' = 'price_list');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `horizon_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `superseded_price_list_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `currency_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `customer_group_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Group Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `default_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Default Margin Percent');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'volume|tier|rebate|surcharge|none');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Price List Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `is_global` SET TAGS ('dbx_business_glossary_term' = 'Global Price List Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Price List Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Price List Owner');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_category` SET TAGS ('dbx_business_glossary_term' = 'Price List Category');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_category` SET TAGS ('dbx_value_regex' = 'standard|promotional|contract|customer_specific|regional|global');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_code` SET TAGS ('dbx_business_glossary_term' = 'Price List Code (PL)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_description` SET TAGS ('dbx_business_glossary_term' = 'Price List Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_name` SET TAGS ('dbx_business_glossary_term' = 'Price List Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|pending|archived');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_type` SET TAGS ('dbx_business_glossary_term' = 'Price List Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_type` SET TAGS ('dbx_value_regex' = 'standard|promotional|contract|customer_specific');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Pricing Method');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `pricing_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_based|fixed|tiered|volume|surcharge');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `sales_org_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` SET TAGS ('dbx_subdomain' = 'price_list');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `superseded_price_list_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `cost_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Amount');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'industrial|consumer|government|research|distributor');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `energy_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Energy Surcharge Amount');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `is_default_price` SET TAGS ('dbx_business_glossary_term' = 'Default Price Indicator');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `last_modified_reason` SET TAGS ('dbx_business_glossary_term' = 'Last Modification Reason');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'List Price Amount');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_category` SET TAGS ('dbx_business_glossary_term' = 'Price Category');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_category` SET TAGS ('dbx_value_regex' = 'raw_material|intermediate|finished|specialty|custom');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Change Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_description` SET TAGS ('dbx_business_glossary_term' = 'Price Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_list_item_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_list_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|draft');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source System');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'SAP|ERP|Manual|External|PricingEngine');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|cost_plus|market|promotional|contract|special');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_uom_factor` SET TAGS ('dbx_business_glossary_term' = 'UOM Conversion Factor');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_validity_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Reason');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_version` SET TAGS ('dbx_business_glossary_term' = 'Price Version Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `raw_material_index_factor` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Index Factor');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `surcharge_flag` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `volume_discount_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `volume_discount_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4|tier5|tier6');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_list_item` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` SET TAGS ('dbx_subdomain' = 'condition_management');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `condition_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Parameter Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `parent_condition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `access_sequence` SET TAGS ('dbx_business_glossary_term' = 'Access Sequence');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Condition Amount');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `applicable_customer_group` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Group');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `applicable_material_group` SET TAGS ('dbx_business_glossary_term' = 'Applicable Material Group');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `calculation_type` SET TAGS ('dbx_business_glossary_term' = 'Calculation Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `calculation_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|formula');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `condition_category` SET TAGS ('dbx_business_glossary_term' = 'Condition Category');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `condition_category` SET TAGS ('dbx_value_regex' = 'sales|procurement|logistics');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `condition_class` SET TAGS ('dbx_business_glossary_term' = 'Condition Class');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `condition_class` SET TAGS ('dbx_value_regex' = 'price|discount|surcharge|tax|freight');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `condition_group` SET TAGS ('dbx_business_glossary_term' = 'Condition Group');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `condition_name` SET TAGS ('dbx_business_glossary_term' = 'Condition Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `discount_indicator` SET TAGS ('dbx_business_glossary_term' = 'Discount Indicator');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `discount_indicator` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `is_derived` SET TAGS ('dbx_business_glossary_term' = 'Derived Condition Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Condition Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Manual Condition Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `pricing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Condition Priority');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `scale_basis` SET TAGS ('dbx_business_glossary_term' = 'Scale Basis');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `scale_basis` SET TAGS ('dbx_value_regex' = 'quantity|value|weight|volume');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `surcharge_indicator` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Indicator');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `surcharge_indicator` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Indicator');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `tax_indicator` SET TAGS ('dbx_value_regex' = 'taxable|non_taxable');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Type Code (e.g., PR00, ZSU1)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` SET TAGS ('dbx_subdomain' = 'condition_management');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_record_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Record ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID (MAT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID (SO_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `superseded_condition_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_application_rule` SET TAGS ('dbx_business_glossary_term' = 'Condition Application Rule (CAR)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_application_rule` SET TAGS ('dbx_value_regex' = 'standard|special|promotional');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Condition Change Reason (CCR)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_currency` SET TAGS ('dbx_business_glossary_term' = 'Condition Currency (CCY)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description (CD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Condition Exclusion Flag (CEF)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_manual_flag` SET TAGS ('dbx_business_glossary_term' = 'Condition Manual Flag (CMF)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_origin` SET TAGS ('dbx_business_glossary_term' = 'Condition Origin (CO)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_origin` SET TAGS ('dbx_value_regex' = 'system|manual');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_price_group` SET TAGS ('dbx_business_glossary_term' = 'Condition Price Group (CPG)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_priority` SET TAGS ('dbx_business_glossary_term' = 'Condition Priority (CP)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_quantity` SET TAGS ('dbx_business_glossary_term' = 'Condition Quantity (CQ)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_record_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Record Number (CRN)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_record_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status (CS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending|blocked');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_release_date` SET TAGS ('dbx_business_glossary_term' = 'Condition Release Date (CRD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_scale_quantity` SET TAGS ('dbx_business_glossary_term' = 'Condition Scale Quantity (CSQ)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_scale_uom` SET TAGS ('dbx_business_glossary_term' = 'Condition Scale Unit of Measure (CSUOM)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_source_system` SET TAGS ('dbx_business_glossary_term' = 'Condition Source System (CSS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Tax Code (CTC)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type (CT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_type` SET TAGS ('dbx_value_regex' = 'price|discount|surcharge|freight|tax|rebate');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_uom` SET TAGS ('dbx_business_glossary_term' = 'Condition Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_value` SET TAGS ('dbx_business_glossary_term' = 'Condition Value (CV)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_value_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Value Type (CVT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_value_type` SET TAGS ('dbx_value_regex' = 'amount|percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `condition_version` SET TAGS ('dbx_business_glossary_term' = 'Condition Version (CVR)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel (DC)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `line_quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity (LQ)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number (LSN)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `pricing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure (PP)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status (RS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'released|draft|blocked|pending');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization (SO)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (VED)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`condition_record` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (VSD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` SET TAGS ('dbx_subdomain' = 'strategy_planning');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `parent_strategy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `applicable_customer_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Segment Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `applicable_geography_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Geography Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `applicable_product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Line Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `cost_component_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Component Basis');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `cost_component_basis` SET TAGS ('dbx_value_regex' = 'raw_material|energy|labor|overhead|transport|all_inclusive');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `is_transfer_pricing` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `market_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Market Index Reference');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `market_index_update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Market Index Update Frequency');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `market_index_update_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `pricing_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Pricing Authority Level');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `pricing_authority_level` SET TAGS ('dbx_value_regex' = 'global|regional|site|customer|product_line');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Rationale');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `strategy_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `strategy_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `strategy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired|pending_review');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_value_regex' = 'cost_plus|market_based|value_based|competitive_index|custom');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `surcharge_energy_index` SET TAGS ('dbx_business_glossary_term' = 'Energy Index Surcharge Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `surcharge_raw_material_index` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Index Surcharge Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `volume_discount_tier_1_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 1 Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `volume_discount_tier_1_min_qty` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 1 Minimum Quantity');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `volume_discount_tier_2_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 2 Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `volume_discount_tier_2_min_qty` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 2 Minimum Quantity');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `volume_discount_tier_3_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 3 Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`strategy` ALTER COLUMN `volume_discount_tier_3_min_qty` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 3 Minimum Quantity');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` SET TAGS ('dbx_subdomain' = 'strategy_planning');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_plus_model_id` SET TAGS ('dbx_business_glossary_term' = 'Cost-Plus Model Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `superseded_cost_plus_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `ceiling_price` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Price (USD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `ceiling_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_plus_model_description` SET TAGS ('dbx_business_glossary_term' = 'Cost-Plus Model Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_plus_model_status` SET TAGS ('dbx_business_glossary_term' = 'Cost-Plus Model Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `cost_plus_model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `energy_index_factor` SET TAGS ('dbx_business_glossary_term' = 'Energy Index Factor');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `energy_index_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `fixed_cost_contribution` SET TAGS ('dbx_business_glossary_term' = 'Fixed Cost Contribution (USD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `fixed_cost_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `floor_price` SET TAGS ('dbx_business_glossary_term' = 'Floor Price (USD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `floor_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `is_energy_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Energy Surcharge Applicability');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `is_transfer_pricing` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Cost-Plus Model Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Cost-Plus Model Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Cost-Plus Model Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'full_absorption|marginal|contribution');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Model Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `overhead_rate` SET TAGS ('dbx_business_glossary_term' = 'Overhead Allocation Rate');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `overhead_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `raw_material_index_factor` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Index Factor');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `raw_material_index_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Costing Scenario Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost (USD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `target_margin_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `target_margin_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `variable_cost_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Variable Cost Breakdown');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `variable_cost_breakdown` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `variable_cost_total` SET TAGS ('dbx_business_glossary_term' = 'Total Variable Cost (USD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `variable_cost_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`cost_plus_model` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Model Version Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` SET TAGS ('dbx_subdomain' = 'market_index');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `market_price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Market Price Index ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `parent_market_price_index_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `commodity_name` SET TAGS ('dbx_business_glossary_term' = 'Commodity Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score of Index Data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Publication Frequency');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (ISO 3166-1 Alpha-3 Country Code)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `index_category` SET TAGS ('dbx_business_glossary_term' = 'Index Category (e.g., Commodity, Chemical, Energy)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `index_category` SET TAGS ('dbx_value_regex' = 'commodity|chemical|energy|raw_material');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `index_code` SET TAGS ('dbx_business_glossary_term' = 'Index Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `index_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]+$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `index_name` SET TAGS ('dbx_business_glossary_term' = 'Index Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `index_version` SET TAGS ('dbx_business_glossary_term' = 'Index Version Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `market_price_index_description` SET TAGS ('dbx_business_glossary_term' = 'Index Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `market_price_index_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `market_price_index_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (Industrial, Consumer, Pharma, Agricultural)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'industrial|consumer|pharma|agricultural');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency (ISO 4217 Code)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type (Spot, Future, Average)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'spot|future|average');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `price_value` SET TAGS ('dbx_business_glossary_term' = 'Index Price Value');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `source_publication` SET TAGS ('dbx_business_glossary_term' = 'Source Publication Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Source Publication URL');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure for Price');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`market_price_index` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` SET TAGS ('dbx_subdomain' = 'market_index');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `index_price_point_id` SET TAGS ('dbx_business_glossary_term' = 'Index Price Point ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `market_price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Index ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `prior_index_price_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `data_provider` SET TAGS ('dbx_business_glossary_term' = 'Data Provider');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|estimated|missing');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `index_price_point_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `index_price_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `index_type` SET TAGS ('dbx_business_glossary_term' = 'Index Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `index_type` SET TAGS ('dbx_value_regex' = 'commodity|energy|raw_material|chemical');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `percent_change` SET TAGS ('dbx_business_glossary_term' = 'Percent Change');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `period_change` SET TAGS ('dbx_business_glossary_term' = 'Period‑over‑Period Change');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `price_date` SET TAGS ('dbx_business_glossary_term' = 'Price Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `price_source_code` SET TAGS ('dbx_business_glossary_term' = 'Price Source Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `price_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `price_value` SET TAGS ('dbx_business_glossary_term' = 'Price Value');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `prior_price_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Price Value');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `source_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`index_price_point` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` SET TAGS ('dbx_subdomain' = 'condition_management');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `parent_surcharge_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `amount_value` SET TAGS ('dbx_business_glossary_term' = 'Fixed Amount Value');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `applicable_product_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `applicable_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending|under_review');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'fixed_amount|percentage|formula');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'retail|wholesale|distributor|internal');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `formula_expression` SET TAGS ('dbx_business_glossary_term' = 'Formula Expression');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `percentage_value` SET TAGS ('dbx_business_glossary_term' = 'Percentage Value');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_code` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_description` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_name` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_status` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_value_regex' = 'energy|raw_material|freight|hazmat|small_order');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` SET TAGS ('dbx_subdomain' = 'condition_management');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `surcharge_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rate ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `superseded_surcharge_rate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `applicable_to_all_products` SET TAGS ('dbx_business_glossary_term' = 'Applicable to All Products Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'fixed|index_based|formula');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `communication_date` SET TAGS ('dbx_business_glossary_term' = 'Communication Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `index_name` SET TAGS ('dbx_business_glossary_term' = 'Index Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `index_value_at_effective` SET TAGS ('dbx_business_glossary_term' = 'Index Value at Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `is_percentage` SET TAGS ('dbx_business_glossary_term' = 'Is Percentage Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'chemical|intermediate|additive|solvent|specialty');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rate Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rate Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rate Unit');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'percent|currency|basis_point');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rate Value');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `surcharge_rate_status` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rate Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `surcharge_rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_value_regex' = 'energy|raw_material|logistics|environmental|tax|custom');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `volume_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Rate');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`surcharge_rate` ALTER COLUMN `volume_discount_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Threshold');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` SET TAGS ('dbx_subdomain' = 'strategy_planning');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `volume_discount_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Schedule Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `superseded_volume_discount_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `customer_scope_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Scope Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `customer_scope_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Scope Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `customer_scope_type` SET TAGS ('dbx_value_regex' = 'all_customers|customer_group|specific_account');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|absolute|fixed_price');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `is_cumulative` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Discount Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `product_scope_code` SET TAGS ('dbx_business_glossary_term' = 'Product Scope Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `product_scope_type` SET TAGS ('dbx_business_glossary_term' = 'Product Scope Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `product_scope_type` SET TAGS ('dbx_value_regex' = 'product|product_line|product_hierarchy|all_products');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Schedule Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Schedule Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Schedule Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'order_quantity_based|annual_cumulative');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `tier_quantity_break` SET TAGS ('dbx_business_glossary_term' = 'Tier Quantity Breakpoint');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `tier_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Tier Quantity Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `tier_quantity_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|liter|gallon|m3');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `tier_sequence` SET TAGS ('dbx_business_glossary_term' = 'Tier Sequence Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `volume_discount_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Discount Schedule Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `volume_discount_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Discount Schedule Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `volume_discount_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|expired');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`volume_discount_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` SET TAGS ('dbx_subdomain' = 'pricing_operations');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Record ID (TP_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (COST_CENTER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `market_price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Identifier (IDX_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (MAT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Legal Entity Identifier (SEND_ENT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `superseded_transfer_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Agreement Number (TP_AGMT_NO)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Amount (TP_AMOUNT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Approval Timestamp (APPROVED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation (COMPLIANCE_REG)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'OECD|US_Tax|EU_Tax|Local');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `cost_component_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Component Amount (COST_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Arms‑Length Documentation Reference (DOC_REF)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_FROM)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_UNTIL)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage (MARGIN_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis (PRICE_BASIS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'standard_cost|market_price|index_price');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `price_index_value` SET TAGS ('dbx_business_glossary_term' = 'Price Index Value (IDX_VAL)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `receiving_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Legal Entity Identifier (RCV_ENT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code (REGION_CD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `surcharge_energy_amount` SET TAGS ('dbx_business_glossary_term' = 'Energy Surcharge Amount (SURCH_ENERGY_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `surcharge_raw_material_amount` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Surcharge Amount (SURCH_RM_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag (TAX_INCLUDED)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage (TAX_RATE_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `transfer_price_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method (TP_METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `transfer_price_method` SET TAGS ('dbx_value_regex' = 'cost_plus|resale_minus|tnmm|cup|market_based');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `transfer_price_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Record Status (TP_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `transfer_price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|draft|pending');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `transfer_price_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Type (TP_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `transfer_price_type` SET TAGS ('dbx_value_regex' = 'intercompany|external');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `volume_discount_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier (VOL_DISCOUNT_TIER)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price` ALTER COLUMN `volume_discount_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` SET TAGS ('dbx_subdomain' = 'pricing_operations');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `transfer_price_study_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Study Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `prior_transfer_price_study_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `arm_length_range_lower` SET TAGS ('dbx_business_glossary_term' = 'Arms Length Range Lower Bound');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `arm_length_range_upper` SET TAGS ('dbx_business_glossary_term' = 'Arms Length Range Upper Bound');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `benchmark_methodology` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Methodology');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `comparable_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Comparable Transaction Count');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `counterparty_legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Legal Entity Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Documentation Reference');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `external_advisor_firm` SET TAGS ('dbx_business_glossary_term' = 'External Advisor Firm');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `external_advisor_name` SET TAGS ('dbx_business_glossary_term' = 'External Advisor Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `lead_legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Lead Legal Entity Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `method_description` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `regulatory_reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Requirement');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `regulatory_reporting_requirement` SET TAGS ('dbx_value_regex' = 'OECD_BEPS|US_Tax|EU_TransferPricing|Other');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `risk_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Study Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `study_notes` SET TAGS ('dbx_business_glossary_term' = 'Study Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Study Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|archived');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Study Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'benchmarking|functional_analysis|comparables_search');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'cost_plus|resale|tnmm|profit_split|transactional_net_margin|other');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`transfer_price_study` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` SET TAGS ('dbx_subdomain' = 'pricing_operations');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Proposal Identifier (PPID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `revised_proposal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments or Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `competitive_price_reference` SET TAGS ('dbx_business_glossary_term' = 'Competitive Price Reference');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `cost_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Amount (Currency)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pricing Proposal Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (Currency)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Proposed Amount (Currency)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `margin_actual_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Margin Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `margin_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Proposed Amount (Currency)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit (Currency per Unit)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `price_validity_end` SET TAGS ('dbx_business_glossary_term' = 'Price Validity End Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `price_validity_start` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Start Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code (BOM/Item Category)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Pricing Proposal Number (PPN)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Proposal Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Proposal Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'new_product|price_increase|discount|surcharge|transfer_pricing');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Pricing Rationale Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `surcharge_index_value` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Index Value');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_value_regex' = 'none|energy|raw_material|logistics');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (Currency)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure for Price');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'per_kg|per_liter|per_ton|per_gallon');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `volume_discount_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`proposal` ALTER COLUMN `volume_discount_tier` SET TAGS ('dbx_value_regex' = 'none|tier1|tier2|tier3');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` SET TAGS ('dbx_subdomain' = 'pricing_operations');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Approval Identifier (PA_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated Approver Employee Identifier (DELEGATED_TO_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `approval_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (APPROVER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `approval_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `approval_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PRODUCT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Proposal Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee Identifier (REQUESTER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `escalated_approval_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level (APPROVAL_LEVEL)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'regional_manager|vp_commercial|cfo|director');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Pricing Approval Number (PA_NO)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pricing Approval Decision Timestamp (APPROVAL_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `approved_price` SET TAGS ('dbx_business_glossary_term' = 'Approved Price Amount (APPROVED_PRICE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Name (BUS_UNIT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments and Rationale (APPROVAL_COMMENTS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed Indicator (COMPLIANCE_PASSED)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp (COMPLIANCE_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Conditions Attached to Approval (APPROVAL_CONDITION)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `delegation_expiration` SET TAGS ('dbx_business_glossary_term' = 'Delegation Expiration Timestamp (DELEGATION_EXPIRY_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `delegation_flag` SET TAGS ('dbx_business_glossary_term' = 'Delegation Indicator (IS_DELEGATED)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount Applied (DISCOUNT_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Price Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Price Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Pricing Indicator (IS_CONFIDENTIAL)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code (PRICE_CURR)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CNY|CAD');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Type (PRICE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'cost_plus|market_based|volume_discount|surcharge|transfer');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (PRODUCT_SKU)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `proposed_price` SET TAGS ('dbx_business_glossary_term' = 'Proposed Price Amount (PROPOSED_PRICE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Pricing Approval (APPROVAL_REASON)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code (REGION_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag (REG_APPROVAL_REQ)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REG_APPROVAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `regulatory_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Timestamp (REG_APPROVAL_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pricing Request Timestamp (REQ_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount Applied (SURCHARGE_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`approval` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` SET TAGS ('dbx_subdomain' = 'pricing_operations');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `special_price_request_id` SET TAGS ('dbx_business_glossary_term' = 'Special Price Request ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `primary_special_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `primary_special_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `primary_special_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Proposal Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `resubmitted_special_price_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'DISTR|DIRECT|ONLINE|PARTNER');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `competitive_pressure` SET TAGS ('dbx_business_glossary_term' = 'Competitive Pressure Details');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Deal Justification');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'cost_plus|market_based|contractual|promotional');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Special Price Request Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `requested_price` SET TAGS ('dbx_business_glossary_term' = 'Requested Price');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `special_price_request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `special_price_request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|closed');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard List Price');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `surcharge_flag` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'kg|ton|lb|gal|L|m3');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`special_price_request` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` SET TAGS ('dbx_subdomain' = 'strategy_planning');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `formula_price_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Price Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `superseded_formula_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `applicable_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `applicable_region_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `applicable_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Formula Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|under_review');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price Amount');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `ceiling_price` SET TAGS ('dbx_business_glossary_term' = 'Maximum Price (Ceiling)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Compliance Regulation');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `floor_price` SET TAGS ('dbx_business_glossary_term' = 'Minimum Price (Floor)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `formula_expression` SET TAGS ('dbx_business_glossary_term' = 'Formula Expression');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `formula_price_code` SET TAGS ('dbx_business_glossary_term' = 'Formula Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `formula_price_description` SET TAGS ('dbx_business_glossary_term' = 'Formula Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `formula_price_name` SET TAGS ('dbx_business_glossary_term' = 'Formula Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `formula_price_status` SET TAGS ('dbx_business_glossary_term' = 'Formula Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `formula_price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `formula_price_type` SET TAGS ('dbx_business_glossary_term' = 'Formula Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `formula_price_type` SET TAGS ('dbx_value_regex' = 'cost_plus|market_index|fixed|tiered');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `index_1_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Market Index Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `index_1_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Primary Index Coefficient');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `index_1_lag_days` SET TAGS ('dbx_business_glossary_term' = 'Primary Index Lag (Days)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `index_2_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Market Index Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `index_2_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Secondary Index Coefficient');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `index_2_lag_days` SET TAGS ('dbx_business_glossary_term' = 'Secondary Index Lag (Days)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Formula Indicator');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `minimum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Formula Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `reset_frequency` SET TAGS ('dbx_business_glossary_term' = 'Formula Reset Frequency');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `reset_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `surcharge_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Coefficient');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Category');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_value_regex' = 'energy|raw_material|logistics|none');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `volume_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` SET TAGS ('dbx_subdomain' = 'strategy_planning');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `formula_price_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Price Calculation Identifier (FPC_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PRODUCT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `formula_price_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Price Record Identifier (FPR_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `prior_formula_price_calculation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `calculated_price` SET TAGS ('dbx_business_glossary_term' = 'Calculated Price (CALC_PRICE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `calculation_code` SET TAGS ('dbx_business_glossary_term' = 'Calculation Code (CALC_CD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status (CALC_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `calculation_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|reversed');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp (CALC_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `ceiling_price` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Price Threshold (CEILING_PRICE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `effective_price` SET TAGS ('dbx_business_glossary_term' = 'Effective Price After Adjustments (EFF_PRICE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `floor_ceiling_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Floor/Ceiling Breach Flag (BREACH_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `floor_price` SET TAGS ('dbx_business_glossary_term' = 'Floor Price Threshold (FLOOR_PRICE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `index_energy` SET TAGS ('dbx_business_glossary_term' = 'Energy Index Value (ENERGY_IDX)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `index_raw_material` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Index Value (RAW_MAT_IDX)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT_CD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `price_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount (PRICE_CHG_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `price_change_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage (PRICE_CHG_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason Description (PRICE_CHG_REASON)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `price_valid_from` SET TAGS ('dbx_business_glossary_term' = 'Price Effective Start Date (PRICE_FROM)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `price_valid_to` SET TAGS ('dbx_business_glossary_term' = 'Price Effective End Date (PRICE_TO)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `prior_price` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Price (PRIOR_PRICE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (REGION_CD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (UPDATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`formula_price_calculation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CREATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` SET TAGS ('dbx_subdomain' = 'pricing_operations');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_price_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Price Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `superseded_channel_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_price_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Price Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'direct|distributor|ecommerce|export|oem');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `customer_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `is_transfer_pricing` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Indicator');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `margin_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Channel Price Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Channel Price Amount');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'internal|external|system_generated');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|discount|surcharge|margin');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_version` SET TAGS ('dbx_business_glossary_term' = 'Price Version Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `surcharge_energy_index` SET TAGS ('dbx_business_glossary_term' = 'Energy Index Surcharge');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `surcharge_raw_material_index` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Index Surcharge');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`channel_price` ALTER COLUMN `volume_discount_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` SET TAGS ('dbx_subdomain' = 'pricing_operations');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `regional_price_id` SET TAGS ('dbx_business_glossary_term' = 'Regional Price Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `superseded_regional_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `differential_type` SET TAGS ('dbx_business_glossary_term' = 'Differential Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `differential_type` SET TAGS ('dbx_value_regex' = 'absolute|percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `differential_value` SET TAGS ('dbx_business_glossary_term' = 'Differential Value');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `ex_works_flag` SET TAGS ('dbx_business_glossary_term' = 'Ex‑Works Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `freight_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Freight Included Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `import_duty_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Import Duty Included Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Amount');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'cost_plus|market|contract|custom');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_category` SET TAGS ('dbx_business_glossary_term' = 'Price Category');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_category` SET TAGS ('dbx_value_regex' = 'standard|promotional|clearance');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_code` SET TAGS ('dbx_business_glossary_term' = 'Price Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Price Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_effective_to` SET TAGS ('dbx_business_glossary_term' = 'Price Effective To Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_label` SET TAGS ('dbx_business_glossary_term' = 'Price Label');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Override Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_region_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Region Hierarchy Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_regulatory_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_regulatory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_source_system` SET TAGS ('dbx_business_glossary_term' = 'Price Source System');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Custom');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|discount|surcharge');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_kg|per_liter|per_ton');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_uom_conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'UOM Conversion Factor');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_validity_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Reason');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `price_version` SET TAGS ('dbx_business_glossary_term' = 'Price Version');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Region Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`regional_price` ALTER COLUMN `volume_discount_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` SET TAGS ('dbx_subdomain' = 'price_list');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `price_change_event_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Event ID (PC_EID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `condition_record_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Record ID (CR_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating User ID (INIT_USER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID (MAT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID (PL_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `reversal_price_change_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number (APPROVAL_REF)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount (CHANGE_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `change_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `change_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage (CHANGE_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `change_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code (REASON_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'annual_increase|feedstock_cost_change|competitive_response|contract_renewal|regulatory_adjustment|promotion');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description (REASON_DESC)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date of New Price (EFFECTIVE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `event_payload` SET TAGS ('dbx_business_glossary_term' = 'Event Payload (EVENT_PAYLOAD)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `event_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Event Source System Reference (EVENT_SRC)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `event_source_reference` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|Custom');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp (EVENT_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type (EVENT_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'price_change');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `initiating_user_name` SET TAGS ('dbx_business_glossary_term' = 'Initiating User Name (INIT_USER_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `initiating_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `initiating_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `is_approved` SET TAGS ('dbx_business_glossary_term' = 'Is Approved Flag (APPROVED_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `is_manual_change` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Change Flag (MANUAL_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `new_price` SET TAGS ('dbx_business_glossary_term' = 'New Price Amount (NEW_PRICE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `new_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `old_price` SET TAGS ('dbx_business_glossary_term' = 'Old Price Amount (OLD_PRICE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `old_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `price_change_type` SET TAGS ('dbx_business_glossary_term' = 'Price Change Type (CHANGE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `price_change_type` SET TAGS ('dbx_value_regex' = 'price_list_item|condition_record|customer_specific');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (RECORD_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_change_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` SET TAGS ('dbx_subdomain' = 'pricing_operations');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `competitor_price_id` SET TAGS ('dbx_business_glossary_term' = 'Competitor Price Record ID (CPRID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PROD_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `competitor_id` SET TAGS ('dbx_business_glossary_term' = 'Competitor Identifier (COMP_ID)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `prior_competitor_price_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level of Observation (CONF_LEVEL)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market (ISO 3166-1 Alpha-3) (GEO_MKT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `geographic_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade (GRADE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp (OBS_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Observed Price Amount (PRICE_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis (PRICE_BASIS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'list|net|delivered|contract|spot');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Market Index Reference (IDX_REF)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_index_value` SET TAGS ('dbx_business_glossary_term' = 'Market Index Value (IDX_VAL)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type (Incoterm) (PRICE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'FOB|CIF|DAP|DDP|EXW');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_valid_from` SET TAGS ('dbx_business_glossary_term' = 'Price Valid From Date (PRICE_VALID_FROM)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `price_valid_until` SET TAGS ('dbx_business_glossary_term' = 'Price Valid Until Date (PRICE_VALID_UNTIL)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `product_cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number (CAS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `product_cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name (PROD_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `source_detail` SET TAGS ('dbx_business_glossary_term' = 'Source Detail Description (SRC_DETAIL)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type of Intelligence (SRC_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`competitor_price` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'customer_feedback|distributor_report|public_tender|market_research|internal_estimate');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` SET TAGS ('dbx_subdomain' = 'pricing_operations');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `price_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Price Simulation Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `baseline_price_simulation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `customer_scope_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Scope Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `customer_scope_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Scope Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `estimated_margin_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Margin Impact');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `estimated_volume_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume Impact');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `price_simulation_status` SET TAGS ('dbx_business_glossary_term' = 'Simulation Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `price_simulation_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `product_scope_code` SET TAGS ('dbx_business_glossary_term' = 'Product Scope Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `product_scope_type` SET TAGS ('dbx_business_glossary_term' = 'Product Scope Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `scenario_type` SET TAGS ('dbx_value_regex' = 'price_increase|margin_optimization|volume_price_tradeoff|cost_plus|market_based');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `simulated_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Simulated Discount Percent');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `simulated_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Simulated Margin Percent');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `simulated_price` SET TAGS ('dbx_business_glossary_term' = 'Simulated Price');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `simulation_code` SET TAGS ('dbx_business_glossary_term' = 'Price Simulation Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `simulation_description` SET TAGS ('dbx_business_glossary_term' = 'Simulation Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `simulation_name` SET TAGS ('dbx_business_glossary_term' = 'Price Simulation Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `simulation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Simulation Execution Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_simulation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` SET TAGS ('dbx_subdomain' = 'pricing_operations');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `authority_matrix_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Authority Matrix Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `parent_authority_matrix_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `applicable_currency` SET TAGS ('dbx_business_glossary_term' = 'Applicable Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `applicable_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `approval_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Approval Hierarchy Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `authority_code` SET TAGS ('dbx_business_glossary_term' = 'Authority Role Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `authority_level` SET TAGS ('dbx_business_glossary_term' = 'Authority Level');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `authority_matrix_status` SET TAGS ('dbx_business_glossary_term' = 'Authority Matrix Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `authority_matrix_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `authority_role` SET TAGS ('dbx_business_glossary_term' = 'Authority Role (Position)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `customer_tier_scope` SET TAGS ('dbx_business_glossary_term' = 'Customer Tier Scope');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `escalation_path` SET TAGS ('dbx_business_glossary_term' = 'Escalation Path Description');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `is_below_margin_allowed` SET TAGS ('dbx_business_glossary_term' = 'Below‑Margin Approval Permission');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Matrix Indicator');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `is_transfer_pricing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Permission');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `max_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `max_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `min_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Margin Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authority Matrix Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `price_floor_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Floor Percentage');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `product_line_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Line Scope');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `surcharge_allowed` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Permission');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `surcharge_type_allowed` SET TAGS ('dbx_business_glossary_term' = 'Allowed Surcharge Types');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `surcharge_type_allowed` SET TAGS ('dbx_value_regex' = 'energy|raw_material|other');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`authority_matrix` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` SET TAGS ('dbx_subdomain' = 'pricing_operations');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `currency_exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate ID');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to strategy');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `prior_currency_exchange_rate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `currency_base` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `currency_base` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `currency_exchange_rate_status` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `currency_exchange_rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `currency_pair` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `currency_pair` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}/[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `currency_target` SET TAGS ('dbx_business_glossary_term' = 'Target Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `currency_target` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'spot|average|planning|hedge|mid|custom');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Value');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`currency_exchange_rate` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` SET TAGS ('dbx_subdomain' = 'price_list');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `price_floor_id` SET TAGS ('dbx_business_glossary_term' = 'Price Floor Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `superseded_price_floor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `cost_basis` SET TAGS ('dbx_value_regex' = 'material|energy|labor|overhead|total');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `floor_amount` SET TAGS ('dbx_business_glossary_term' = 'Floor Amount');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `floor_type` SET TAGS ('dbx_business_glossary_term' = 'Price Floor Type');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `floor_type` SET TAGS ('dbx_value_regex' = 'variable_cost|contribution_margin|full_cost|custom');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percent');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market or Channel Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `price_floor_code` SET TAGS ('dbx_business_glossary_term' = 'Price Floor Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `price_floor_name` SET TAGS ('dbx_business_glossary_term' = 'Price Floor Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `price_floor_status` SET TAGS ('dbx_business_glossary_term' = 'Price Floor Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `price_floor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product SKU');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `raw_material_index_factor` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Index Factor');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `regulatory_reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Requirement');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Floor Review Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `surcharge_energy_index` SET TAGS ('dbx_business_glossary_term' = 'Energy Surcharge Index');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`price_floor` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` SET TAGS ('dbx_subdomain' = 'price_list');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Calendar Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Manager Identifier');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `calendar_pricing_manager_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `prior_pricing_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Calendar Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Calendar Name');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Calendar Status');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `customer_notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Deadline');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `customer_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `energy_index_factor` SET TAGS ('dbx_business_glossary_term' = 'Energy Index Factor (EIF)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `is_energy_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Energy Surcharge Applicability');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `is_transfer_pricing` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Indicator');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pricing Calendar Notes');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `price_change_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Price Change Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `raw_material_index_factor` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Index Factor (RMIF)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Type (RC)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|monthly|index_reset');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `surcharge_notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Notification Deadline');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`pricing`.`calendar` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
