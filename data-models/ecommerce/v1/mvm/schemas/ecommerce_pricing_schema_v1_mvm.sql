-- Schema for Domain: pricing | Business: Ecommerce | Version: v1_mvm
-- Generated on: 2026-05-05 00:58:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`pricing` COMMENT 'SSOT for all pricing rules, promotional mechanics, and discount structures. Owns base price lists, dynamic pricing algorithms, markdown schedules, coupon and voucher management, promotional campaign pricing, competitive price intelligence, and A/B testing for pricing experiments. Tracks ASP, price elasticity, and GMV optimization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`pricing`.`price_list` (
    `price_list_id` BIGINT COMMENT 'System-generated unique identifier for the price list record.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Price lists with currency_code and region attributes must be scoped to a legal entity for intercompany transfer pricing, tax compliance, and financial consolidation in multi-entity e-commerce. Domain ',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: Price lists are frequently scoped to a specific marketplace (e.g., a price list valid only on a given marketplace). Marketplace-scoped price list management, activation, and reporting require this dir',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: REQUIRED: Segment‑based pricing; marketing analytics join price list to customer segment to evaluate segment‑specific discount performance.',
    `base_price` DECIMAL(18,2) COMMENT 'Core price value before any adjustments, expressed in the list currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code in which the prices are expressed.. Valid values are `^[A-Z]{3}$`',
    `discount_allowed_flag` BOOLEAN COMMENT 'True if additional discounts may be stacked on top of this price list.',
    `effective_end_date` DATE COMMENT 'Date on which the price list expires; null for open‑ended lists.',
    `effective_start_date` DATE COMMENT 'Date on which the price list becomes active for transactions.',
    `is_default` BOOLEAN COMMENT 'True if this list is the default for its scope when no other list matches.',
    `max_price` DECIMAL(18,2) COMMENT 'Ceiling price for the list; used to enforce pricing caps.',
    `max_quantity` STRING COMMENT 'Maximum quantity for which the price is valid; null for no upper bound.',
    `min_price` DECIMAL(18,2) COMMENT 'Floor price for the list; used to enforce pricing floors.',
    `min_quantity` STRING COMMENT 'Minimum quantity required for the price to apply.',
    `notes` STRING COMMENT 'Additional free‑form remarks or operational comments.',
    `price_calculation_method` STRING COMMENT 'Method used to derive the prices in this list.. Valid values are `fixed|formula|algorithm|machine_learning|rule_based|manual`',
    `price_elasticity` DECIMAL(18,2) COMMENT 'Historical elasticity metric used for dynamic pricing decisions.',
    `price_list_code` STRING COMMENT 'Unique business code used to reference the price list in external systems and contracts.',
    `price_list_description` STRING COMMENT 'Free‑form description providing context, purpose, and any special rules for the price list.',
    `price_list_name` STRING COMMENT 'Human‑readable name of the price list (e.g., "US Retail MSRP").',
    `price_list_status` STRING COMMENT 'Current lifecycle state of the price list.. Valid values are `active|inactive|archived|pending|draft|retired`',
    `price_precision` STRING COMMENT 'Number of decimal places used for price values in this list.',
    `price_rounding_rule` STRING COMMENT 'Rounding behavior applied to calculated prices.. Valid values are `up|down|nearest|none|bankers|ceil`',
    `price_source` STRING COMMENT 'Origin of the price data (e.g., manually entered, system‑generated, partner feed).. Valid values are `manual|system|partner|import|api|default`',
    `price_tier` STRING COMMENT 'Logical tier or band within the price list (e.g., "Gold", "Silver").',
    `price_type` STRING COMMENT 'Category of the price list indicating its purpose (e.g., base list, discount list, promotional list).. Valid values are `base|discount|promo|dynamic|tiered|custom`',
    `promotional_flag` BOOLEAN COMMENT 'True if the price list is part of a promotional campaign.',
    `region` STRING COMMENT 'Geographic region to which the price list applies.. Valid values are `^[A-Z]{3}$`',
    `tax_included_flag` BOOLEAN COMMENT 'Indicates whether taxes are already included in the listed prices.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price list record.',
    `version` STRING COMMENT 'Incremental version number for change tracking.',
    CONSTRAINT pk_price_list PRIMARY KEY(`price_list_id`)
) COMMENT 'Master record defining a named price list (e.g., MSRP, wholesale, member, regional) with effective date ranges, currency, applicable customer segments, and channel scope. Serves as the authoritative base price catalog from which all pricing rules derive. Owned by the Pricing domain as the SSOT for base price structures.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`pricing`.`price_list_item` (
    `price_list_item_id` BIGINT COMMENT 'Unique surrogate key for each price list item record.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Bundles require dedicated price list entries for bundle-level discount management (e.g., bundle price vs. sum-of-parts). A direct bundle_id FK on price_list_item enables bundle pricing management, bun',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Price list items are attributed to cost centers for P&L reporting and budget variance analysis. In e-commerce, each pricing tier must be owned by a business unit (cost center) to track margin impact. ',
    `price_list_id` BIGINT COMMENT 'Identifier of the parent price list to which this item belongs.',
    `sku_id` BIGINT COMMENT 'Internal identifier for the specific product variant when SKU alone is insufficient.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: REQUIRED: Enables seller‑specific SKU price overrides; pricing engine looks up seller_profile_id to apply custom base prices per seller.',
    `supplier_price_list_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_price_list. Business justification: Sell-side price list items are derived from supplier cost prices. Linking price_list_item to supplier_price_list enables real-time margin calculation, cost-plus pricing enforcement, and margin reporti',
    `warehouse_node_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_node. Business justification: Location-based price list items require warehouse node to apply inventory‑aware pricing per fulfillment center.',
    `audit_user_role` STRING COMMENT 'Role of the user who performed the last audit action (e.g., pricing_manager).',
    `base_price` DECIMAL(18,2) COMMENT 'Standard unit price before any tiered, volume, or promotional adjustments.',
    `bundle_component_skus` STRING COMMENT 'Comma‑separated list of SKUs that constitute the bundle.',
    `bundle_discount_percent` DECIMAL(18,2) COMMENT 'Discount applied to the total of bundled SKUs when price_type = bundle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list item record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the price.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date when this price becomes active.',
    `effective_until` DATE COMMENT 'Date when this price expires; null for open‑ended pricing.',
    `is_promotional` BOOLEAN COMMENT 'Indicates whether the price is part of a promotional campaign.',
    `last_price_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent price modification.',
    `min_order_quantity` STRING COMMENT 'Minimum quantity that must be ordered to qualify for this price.',
    `price_change_reason` STRING COMMENT 'Free‑text reason explaining why the price was changed.',
    `price_description` STRING COMMENT 'Human‑readable description of the pricing rule or context.',
    `price_elasticity_score` DECIMAL(18,2) COMMENT 'Calculated elasticity metric used for dynamic pricing decisions.',
    `price_list_item_status` STRING COMMENT 'Current lifecycle status of the price list item.. Valid values are `active|inactive|deprecated|pending`',
    `price_source` STRING COMMENT 'Origin of the price value (e.g., manually entered, generated by pricing algorithm, or imported from external feed).. Valid values are `manual|algorithmic|imported`',
    `price_type` STRING COMMENT 'Classification of the pricing structure applied to this item.. Valid values are `flat|tiered|volume|bundle`',
    `promotional_end_date` DATE COMMENT 'End date of the promotional pricing period.',
    `promotional_start_date` DATE COMMENT 'Start date of the promotional pricing period.',
    `tax_inclusive` BOOLEAN COMMENT 'True if the base_price already includes applicable taxes.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage; used when tax_inclusive = false.',
    `tier_price` DECIMAL(18,2) COMMENT 'Unit price applied when the ordered quantity meets the tier_quantity_threshold.',
    `tier_quantity_threshold` STRING COMMENT 'Quantity breakpoint for tiered pricing; applicable when price_type = tiered or volume.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the price (e.g., each, kg, liter).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price list item.',
    `version` STRING COMMENT 'Version number for optimistic concurrency control and change tracking.',
    `volume_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied for volume purchases; used when price_type = volume.',
    CONSTRAINT pk_price_list_item PRIMARY KEY(`price_list_item_id`)
) COMMENT 'Line-level entry within a price list associating a specific SKU or product variant to its base unit price, minimum order quantity (MOQ), unit of measure, and pricing structure type (flat, tiered, volume-based, bundle). For tiered/volume pricing, captures quantity thresholds and per-tier unit prices. For bundle pricing, captures constituent SKUs and bundle discount. Serves as the authoritative base price per SKU per price list supporting all pricing structure variants.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` (
    `dynamic_price_rule_id` BIGINT COMMENT 'System-generated unique identifier for the dynamic pricing rule.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Dynamic pricing rules in e-commerce are scoped to specific audience segments (e.g., loyalty tier members receive different floor/ceiling prices). This link enables audience-targeted dynamic repricing ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Dynamic pricing rules enforce brand-level MAP (Minimum Advertised Price) policies. brand_code is a denormalized text reference to product.brand; replacing with FK enables MAP compliance enforcement, b',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Dynamic pricing rules are scoped to product categories (e.g., margin-floor rules for Electronics). category_code is a denormalized text reference to product.category; replacing with FK enables the rep',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Dynamic pricing rules drive margin adjustments that must be budgeted and tracked per cost center. The rule_owner and scope fields indicate organizational ownership; cost center linkage enables financi',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Dynamic pricing rules with compliance_flag and is_global=false operate within specific legal entity boundaries for regulatory compliance. In multi-entity e-commerce, pricing algorithms must be legally',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: Dynamic price rules with global or marketplace-wide scope (is_global=true) must be anchored to a specific marketplace for rule execution and compliance auditing. The existing marketplace_listing_id co',
    `marketplace_listing_id` BIGINT COMMENT 'Identifier of the marketplace channel (e.g., third‑party marketplace) the rule applies to.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: dynamic_price_rule is defined for a specific price list; linking provides parent context',
    `promotional_campaign_id` BIGINT COMMENT 'Foreign key linking to pricing.promotional_campaign. Business justification: Dynamic pricing rules can be campaign-scoped — for example, a flash sale promotional campaign may activate specific dynamic pricing rules that adjust prices algorithmically during the campaign window.',
    `seller_profile_id` BIGINT COMMENT 'Unique identifier of the seller to which the rule is scoped (if seller‑specific).',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Inventory-level-triggered dynamic repricing (scarcity pricing when ATP is low, overstock discounting when on_hand_qty exceeds max) is a fundamental e-commerce revenue optimization process. This FK lin',
    `supplier_price_list_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_price_list. Business justification: Dynamic pricing rules enforce floor prices to protect margins. Linking to supplier_price_list allows the pricing engine to automatically set floor_price from live supplier costs, preventing below-cost',
    `activation_end` TIMESTAMP COMMENT 'Timestamp when the rule expires or is deactivated.',
    `activation_start` TIMESTAMP COMMENT 'Timestamp when the rule becomes effective.',
    `adjustment_type` STRING COMMENT 'Specifies whether the rule adjusts price by a percentage, a fixed amount, sets a floor, or sets a ceiling.. Valid values are `percentage|fixed|floor|ceiling`',
    `adjustment_unit` STRING COMMENT 'Unit of the adjustment value, matching the adjustment_type (percentage or currency).. Valid values are `percent|usd|eur|gbp|cad|aud`',
    `adjustment_value` DECIMAL(18,2) COMMENT 'Numeric value used with the adjustment_type (e.g., 5.0 for 5% or 2.50 for $2.50).',
    `applicable_sku_pattern` STRING COMMENT 'Wildcard or regex pattern that matches SKUs to which the rule applies.',
    `audit_notes` STRING COMMENT 'Free‑form notes from auditors or reviewers about the rule.',
    `ceiling_price` DECIMAL(18,2) COMMENT 'Maximum price that the rule will not allow the SKU to exceed.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the rule complies with MAP and other regulatory pricing constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for price adjustments.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `effective_from` DATE COMMENT 'Date when the rule becomes effective for reporting purposes.',
    `effective_until` DATE COMMENT 'Date when the rule expires; null if open‑ended.',
    `execution_count` BIGINT COMMENT 'Total number of times the rule has been applied to transactions.',
    `floor_price` DECIMAL(18,2) COMMENT 'Minimum price that the rule will not allow the SKU to drop below.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the rule is currently enabled for execution.',
    `is_experimental` BOOLEAN COMMENT 'Marks the rule as part of an A/B pricing experiment.',
    `is_global` BOOLEAN COMMENT 'True if the rule applies across all marketplaces and sellers.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of the rule.',
    `notes` STRING COMMENT 'Any supplemental information or comments about the rule.',
    `price_elasticity_score` DECIMAL(18,2) COMMENT 'Pre‑computed elasticity metric used by the rule engine to gauge demand sensitivity.',
    `priority` STRING COMMENT 'Numeric priority used to resolve conflicts when multiple rules apply; lower numbers indicate higher priority.',
    `rule_category` STRING COMMENT 'High‑level classification of the rules purpose.. Valid values are `discount|markdown|surge|promotion|clearance`',
    `rule_description` STRING COMMENT 'Detailed description of the rules purpose and logic.',
    `rule_name` STRING COMMENT 'Human‑readable name of the pricing rule for identification.',
    `rule_owner` STRING COMMENT 'Team or individual responsible for the rules lifecycle.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `draft|active|inactive|retired|pending_review`',
    `rule_type` STRING COMMENT 'Indicates whether the rule is calculated in real‑time (dynamic), pre‑computed (static), or a combination (hybrid).. Valid values are `dynamic|static|hybrid`',
    `scope` STRING COMMENT 'Defines the applicability level of the rule (entire platform, specific seller, product category, brand, or marketplace).. Valid values are `platform|seller|category|brand|marketplace`',
    `test_group` STRING COMMENT 'Indicates the A/B test group assignment for the rule.. Valid values are `control|treatment|none`',
    `trigger_condition` STRING COMMENT 'Serialized condition expression (e.g., JSON) that determines when the rule fires, based on demand, inventory, competitor price, etc.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule.',
    `version_number` STRING COMMENT 'Incremental version of the rule for change tracking.',
    `created_by` STRING COMMENT 'User or system account that created the rule.',
    CONSTRAINT pk_dynamic_price_rule PRIMARY KEY(`dynamic_price_rule_id`)
) COMMENT 'Defines algorithmic or rules-based dynamic pricing logic applied to SKUs, categories, or seller listings across platform-owned and marketplace channels. Includes trigger conditions (demand signals, inventory levels, competitor price thresholds, MAP violations, seller compliance triggers), adjustment type (percentage, fixed, floor/ceiling), rule scope (platform-wide, seller-specific, category-level, brand-level), priority rank, activation schedule, and enforcement actions. For marketplace-scoped rules: MAP enforcement thresholds, maximum price caps, commission-adjusted floor prices, seller-specific pricing agreements, and brand protection policies. Powers real-time price optimization, surge/markdown automation, MAP enforcement, marketplace pricing integrity, and seller pricing governance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` (
    `markdown_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the markdown schedule.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Markdown schedules in e-commerce are targeted to specific audience segments (e.g., loyalty members receive early markdown access). The customer_segment plain-text column denormalizes audience_segment.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Markdown schedules are often executed as part of a marketing campaign; linking enables campaign‑level markdown effectiveness analysis.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Markdown schedules are category-scoped (e.g., end-of-season clearance on Apparel). product_category is a denormalized text reference to product.category; replacing with FK enables the markdown engine ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Markdown budgets are allocated per cost center in e-commerce financial planning. Markdown schedules represent planned margin reductions requiring cost center attribution for budget variance reporting ',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Markdown accruals require direct GL posting for markdown reserves under retail accounting standards. In e-commerce, markdown schedules drive journal entries for inventory write-downs; a direct GL link',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: Markdown automation engines target specific marketplace listings for time-based price reductions. Operations teams need to know which listing a markdown schedule applies to for listing suppression, bu',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: markdown_schedule applies to a price list; linking ties schedule to its governing list',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: A markdown schedule applies to specific SKUs within a price list. The markdown_schedule currently stores product_sku as a free-text field, which is denormalized. Adding price_list_item_id creates a pr',
    `promotional_campaign_id` BIGINT COMMENT 'Foreign key linking to pricing.promotional_campaign. Business justification: A markdown schedule is a planned price reduction calendar that is frequently driven by a promotional campaign (e.g., a seasonal sale or flash sale campaign triggers a series of markdown schedules). Th',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Markdown schedules target specific customer segments (e.g., VIP-early-access markdowns). Linking to customer.segment enables segment-targeted markdown execution and markdown performance reporting by s',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: REQUIRED: Sellers create markdown schedules for their products; linking to seller_profile ties schedule ownership for audit and reporting.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Inventory-driven markdown scheduling is a core e-commerce clearance process: when a stock_position shows excess or aging inventory, a markdown_schedule is created to liquidate it. This FK enables the ',
    `warehouse_node_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_node. Business justification: Warehouse-level markdown schedule clears overstock by applying discounts specific to each fulfillment node.',
    `approved_by` STRING COMMENT 'Name or identifier of the user who approved the markdown schedule.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule received formal approval.',
    `channel` STRING COMMENT 'Channel(s) where the markdown is applied.. Valid values are `online|offline|both`',
    `compliance_notes` STRING COMMENT 'Regulatory or policy remarks associated with the markdown (e.g., price‑floor constraints).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the markdown schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the markdown amount (e.g., USD, EUR).',
    `effective_end_date` DATE COMMENT 'Calendar date when the markdown ceases to be applicable (nullable for open‑ended schedules).',
    `effective_start_date` DATE COMMENT 'Calendar date when the markdown becomes applicable.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether this schedule should block other overlapping markdowns for the same SKU.',
    `is_test` BOOLEAN COMMENT 'Indicates whether the schedule is a test (non‑production) run.',
    `last_modified_by` STRING COMMENT 'User identifier who last updated the schedule.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of the markdown schedule.',
    `markdown_schedule_status` STRING COMMENT 'Current lifecycle state of the schedule.. Valid values are `draft|active|inactive|completed|cancelled`',
    `markdown_type` STRING COMMENT 'Indicates whether the markdown is a percentage reduction or an absolute monetary amount.. Valid values are `percentage|absolute`',
    `markdown_value` DECIMAL(18,2) COMMENT 'The reduction amount: either a percentage (e.g., 0.15 for 15%) or a fixed currency amount, depending on markdown_type.',
    `market_region` STRING COMMENT 'Geographic market region for which the markdown is valid.. Valid values are `NA|EU|APAC|LATAM|MEA`',
    `max_quantity` STRING COMMENT 'Maximum purchase quantity for which the markdown is valid (optional).',
    `min_quantity` STRING COMMENT 'Minimum purchase quantity required for the markdown to apply.',
    `priority` STRING COMMENT 'Execution priority when multiple schedules overlap; lower numbers run first.',
    `reason` STRING COMMENT 'Business justification for the markdown (e.g., end‑of‑season, clearance, overstock).',
    `run_count` STRING COMMENT 'Number of times the schedule has been applied to orders.',
    `sales_channel` STRING COMMENT 'Specific sales channel where the markdown is offered.. Valid values are `web|mobile|store|marketplace`',
    `schedule_code` STRING COMMENT 'Business‑visible code used to reference the schedule in external systems.',
    `schedule_description` STRING COMMENT 'Extended free‑text description of the markdown schedule.',
    `schedule_name` STRING COMMENT 'Human‑readable name describing the markdown schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the schedule.',
    `version_number` STRING COMMENT 'Incremental version of the schedule for change tracking.',
    `created_by` STRING COMMENT 'User identifier who initially created the schedule.',
    CONSTRAINT pk_markdown_schedule PRIMARY KEY(`markdown_schedule_id`)
) COMMENT 'Planned markdown calendar for SKUs or product categories, specifying markdown percentage or absolute reduction, start and end dates, markdown reason (end-of-season, clearance, overstock), and approval status. Supports seasonal clearance cycles and inventory liquidation workflows.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` (
    `promotional_campaign_id` BIGINT COMMENT 'System-generated unique identifier for the promotional campaign.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Promotional campaigns target specific marketing audience segments for discount eligibility (e.g., VIP segment gets early-access sale). The target_audience plain-text column denormalizes audience_segme',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Promotional campaigns are scoped to product categories (e.g., Summer Sale — Outdoor category). product_category_scope is a denormalized text reference to product.category; replacing with FK enables ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Promotional campaigns have explicit budget_amount fields requiring cost center attribution for financial accountability. In e-commerce, campaign spend is tracked against cost centers for P&L reporting',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Campaign expenses and discount liabilities must be recorded in a specific GL account for expense reporting and audit compliance.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Promotional campaigns with geographic_scope, compliance_gdpr_flag, and compliance_sox_flag fields operate across legal entities in multi-jurisdiction e-commerce. Legal entity scoping is required for t',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Promotional campaigns target specific customer segments (e.g., Gold-tier-only flash sales). Linking enables segment-based campaign eligibility enforcement and campaign performance reporting by segment',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: REQUIRED: Campaign budgeting, performance dashboards, and compliance reports need to know which seller launched the campaign.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Vendor-funded promotions (trade promotions) are a major e-commerce revenue stream where suppliers co-fund discounts. Linking promotional_campaign to supplier enables vendor funding reconciliation, co-',
    `a_b_test_variant` STRING COMMENT 'Variant assignment for A/B test campaigns.. Valid values are `control|variant_a|variant_b`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Maximum monetary budget allocated for the campaign.',
    `budget_currency` STRING COMMENT 'Three‑letter ISO 4217 code of the budget currency.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `campaign_code` STRING COMMENT 'Business-facing unique code for the campaign used in reporting and external communications.',
    `campaign_type` STRING COMMENT 'Classification of the campaign based on its business purpose.. Valid values are `flash_sale|seasonal|loyalty|clearance|bundle|coupon`',
    `channel` STRING COMMENT 'Primary channel through which the campaign is delivered.. Valid values are `web|mobile|email|app|in_store`',
    `compliance_gdpr_flag` BOOLEAN COMMENT 'Indicates whether the campaign processes personal data subject to GDPR.',
    `compliance_pci_flag` BOOLEAN COMMENT 'Indicates whether the campaign involves payment card data subject to PCI DSS.',
    `compliance_sox_flag` BOOLEAN COMMENT 'Indicates whether the campaign impacts financial reporting subject to SOX.',
    `coupon_code` STRING COMMENT 'Alphanumeric code customers can enter to redeem the promotion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the system.',
    `discount_type` STRING COMMENT 'Mechanic used to calculate the discount.. Valid values are `percentage|fixed_amount|buy_one_get_one|free_shipping|tiered|bundle`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount (percentage or fixed amount).',
    `discount_value_unit` STRING COMMENT 'Unit of the discount value – either percent or currency.. Valid values are `percent|currency`',
    `eligibility_rule_description` STRING COMMENT 'Human‑readable description of the rules that determine customer eligibility.',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the campaign expires or is deactivated.',
    `geographic_scope` STRING COMMENT 'Geographic reach of the campaign.. Valid values are `global|regional|local`',
    `gmv_target` DECIMAL(18,2) COMMENT 'Target GMV the campaign aims to generate.',
    `gmv_target_currency` STRING COMMENT 'Currency of the GMV target.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `is_a_b_test` BOOLEAN COMMENT 'Flag indicating whether the campaign is part of an A/B testing experiment.',
    `is_test` BOOLEAN COMMENT 'Flag indicating whether the campaign is a test (non‑production) run.',
    `max_uses` BIGINT COMMENT 'Maximum number of times the campaign can be applied across all customers.',
    `owning_business_unit` STRING COMMENT 'Organizational unit responsible for the campaign (e.g., marketing, pricing).',
    `promotional_campaign_description` STRING COMMENT 'Detailed description of the campaign objectives, mechanics and any special notes.',
    `promotional_campaign_name` STRING COMMENT 'Human‑readable name of the promotional campaign.',
    `promotional_campaign_status` STRING COMMENT 'Current lifecycle state of the campaign.. Valid values are `draft|active|paused|completed|cancelled`',
    `redemption_limit_per_customer` BIGINT COMMENT 'Maximum number of times a single customer may redeem the campaign.',
    `redemption_total_limit` BIGINT COMMENT 'Overall cap on the number of redemptions across all customers.',
    `region_code` STRING COMMENT 'Three‑letter ISO 3166‑1 alpha‑3 code representing the region when geographic_scope is regional or local.',
    `sku_inclusion_criteria` STRING COMMENT 'Rule expression defining which SKUs are eligible for the promotion.',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the campaign becomes active for customers.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated the campaign record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign record.',
    `usage_count` BIGINT COMMENT 'Running total of how many times the campaign has been used.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the campaign record.',
    CONSTRAINT pk_promotional_campaign PRIMARY KEY(`promotional_campaign_id`)
) COMMENT 'Master record for a pricing-driven promotional campaign (e.g., flash sale, seasonal event, loyalty reward event), capturing campaign name, type, budget cap, GMV target, start/end timestamps, eligibility rules, and owning business unit. Acts as the parent entity for all promotional mechanics and discount structures within a campaign.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` (
    `promotion_rule_id` BIGINT COMMENT 'Unique system-generated identifier for the promotion rule.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Promotion rules are scoped to marketing audience segments (e.g., win-back segment gets 20% off). The existing customer_segment plain-text column is a denormalization of audience_segment. FK enables pr',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Brand-scoped promotions (e.g., Buy 2 Nike items, save 10%) are standard e-commerce mechanics. applies_to_brand is a denormalized text reference to product.brand; replacing with FK enables brand part',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Bundle promotions (e.g., Bundle deal: 15% off kit) are a core e-commerce mechanic. applies_to_bundle is a denormalized text reference to product.bundle; replacing with FK enables the promotion engin',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Promotion rules are category-scoped (e.g., 20% off all Footwear). applies_to_category is a denormalized text reference to product.category; replacing with FK enables the promotion engine to resolve ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Promotion rules are channel-specific in e-commerce (e.g., email-only 15% off, in-app exclusive discount). The channel plain-text column denormalizes marketing.channel. FK enables channel-scoped promot',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: A promotion rule can be scoped to a specific price list — for example, a BOGO rule may only apply to items in the MSRP price list, or a loyalty discount rule may only apply to the member price list. A',
    `promotional_campaign_id` BIGINT COMMENT 'Foreign key linking to pricing.promotional_campaign. Business justification: promotion_rule belongs to a promotional campaign; linking enables campaign-level rule management',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Promotion rules restrict eligibility to customer segments (e.g., B2B-only bulk discount rules). Linking to customer.segment enables rule engine to enforce segment eligibility programmatically and repl',
    `coupon_code` STRING COMMENT 'Alphanumeric code that customers must enter to trigger the rule, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion rule record was first created.',
    `discount_unit` STRING COMMENT 'Indicates whether discount_value is a percentage or a monetary amount.. Valid values are `percent|currency`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount; interpretation depends on discount_unit (e.g., 10.00 for $10 off or 15.0 for 15% off).',
    `effective_from` DATE COMMENT 'Date when the promotion rule becomes valid.',
    `effective_until` DATE COMMENT 'Date when the promotion rule expires (null for open‑ended).',
    `eligible_sku_criteria` STRING COMMENT 'Expression or list defining which SKUs qualify for the promotion (e.g., SKU prefixes, category codes).',
    `is_exclusive` BOOLEAN COMMENT 'If true, the rule cannot be combined with any other promotion.',
    `max_redemptions_per_customer` STRING COMMENT 'Maximum number of times a single customer can use the rule.',
    `max_redemptions_total` STRING COMMENT 'Maximum number of times the rule can be redeemed across all customers.',
    `minimum_cart_value` DECIMAL(18,2) COMMENT 'Minimum order subtotal required for the rule to apply.',
    `priority` STRING COMMENT 'Numeric priority used to resolve conflicts when multiple stackable rules apply (lower number = higher priority).',
    `promotion_rule_code` STRING COMMENT 'Business code or SKU‑like identifier that uniquely identifies the rule in external systems.',
    `promotion_rule_description` STRING COMMENT 'Detailed free‑text description of the promotion rule and its business intent.',
    `promotion_rule_name` STRING COMMENT 'Human‑readable name of the promotion rule used for display and reporting.',
    `promotion_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|draft|archived|pending`',
    `redemption_count` STRING COMMENT 'Current count of how many times the rule has been redeemed.',
    `rule_type` STRING COMMENT 'Classification of the discount mechanic (e.g., Buy‑One‑Get‑One, percentage off, fixed amount off, free shipping, bundle deal).. Valid values are `bogo|percentage|fixed_amount|free_shipping|bundle_deal`',
    `stackable` BOOLEAN COMMENT 'Indicates whether the rule can be combined with other promotions.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last modified the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the promotion rule.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the rule.',
    CONSTRAINT pk_promotion_rule PRIMARY KEY(`promotion_rule_id`)
) COMMENT 'Defines the specific discount mechanics within a promotional campaign, including rule type (BOGO, percentage off, fixed amount off, free shipping, bundle deal), qualifying conditions (minimum cart value, eligible SKUs, customer segment, channel), discount value, stacking priority, and maximum redemption limits.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`pricing`.`coupon` (
    `coupon_id` BIGINT COMMENT 'Unique surrogate key for each coupon record.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Coupons are distributed to specific marketing audience segments (e.g., lapsed-buyer segment receives reactivation coupon). The eligible_customer_segment plain-text column denormalizes audience_segment',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that generated or is associated with the coupon.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Coupons represent financial liabilities (discount_amount, total_redemption_cap) requiring GL accrual for deferred revenue and contra-revenue accounting under ASC 606/IFRS 15. In e-commerce, coupon lia',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: Coupons are marketplace-specific instruments — an Amazon coupon cannot be redeemed on eBay. Coupon issuance, redemption eligibility enforcement, and promotional reporting all require knowing which mar',
    `promotion_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.promotion_rule. Business justification: A coupon implements specific discount mechanics defined by a promotion rule (e.g., a BOGO rule, a percentage discount rule, or a minimum cart value rule). The promotion_rule table defines the discount',
    `promotional_campaign_id` BIGINT COMMENT 'Foreign key linking to pricing.promotional_campaign. Business justification: A coupon is issued as part of a pricing-driven promotional campaign. The coupon table already has campaign_id pointing to marketing.campaign (the marketing execution), but lacks a FK to pricing.promot',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Coupons are issued to specific customer segments (e.g., win-back coupons for lapsed customers). A FK to customer.segment enables automated eligibility validation at redemption and segment-level coupon',
    `coupon_code` STRING COMMENT 'Human‑readable alphanumeric identifier used by customers to redeem the discount.',
    `coupon_description` STRING COMMENT 'Human‑readable description of the coupon purpose and terms.',
    `coupon_status` STRING COMMENT 'Current lifecycle state of the coupon.. Valid values are `active|inactive|expired|revoked`',
    `coupon_type` STRING COMMENT 'Classification of the coupon instrument (e.g., public coupon, targeted voucher, batch‑issued code, gift card).. Valid values are `public_coupon|targeted_voucher|batch_issued|gift_card`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the coupon record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency identifier for monetary fields.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary value subtracted from the order total when discount_type is fixed_amount.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage value applied to the order total when discount_type is percentage.',
    `discount_type` STRING COMMENT 'Mechanism of the discount applied by the coupon.. Valid values are `percentage|fixed_amount|free_shipping`',
    `distribution_method` STRING COMMENT 'Channel through which the coupon code was delivered to the customer.. Valid values are `email|sms|in_app|print|api`',
    `eligible_category_scope` STRING COMMENT 'Comma‑separated list of product category identifiers for which the coupon is valid.',
    `eligible_product_scope` STRING COMMENT 'Comma‑separated list or pattern of product identifiers (SKU, ASIN, etc.) that the coupon can be applied to.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date‑time after which the coupon can no longer be redeemed.',
    `is_one_time_use` BOOLEAN COMMENT 'True if the coupon may be redeemed only once across all customers.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether the coupon can be combined with other promotions.',
    `issuance_channel` STRING COMMENT 'System or process that generated the coupon (e.g., campaign engine, manual upload).. Valid values are `email|sms|in_app|print|api`',
    `max_discount_amount` DECIMAL(18,2) COMMENT 'Upper cap on the monetary value that can be deducted by the coupon.',
    `min_order_amount` DECIMAL(18,2) COMMENT 'Minimum order subtotal required for the coupon to be applicable.',
    `notes` STRING COMMENT 'Free‑form field for internal comments or special handling instructions.',
    `redemption_count` STRING COMMENT 'Current count of how many times the coupon has been redeemed.',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the coupon becomes valid for redemption.',
    `total_redemption_cap` STRING COMMENT 'Overall maximum number of redemptions allowed across all customers.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the coupon record.',
    `usage_limit_per_customer` STRING COMMENT 'Maximum number of times a single customer may redeem this coupon.',
    CONSTRAINT pk_coupon PRIMARY KEY(`coupon_id`)
) COMMENT 'Master record for all discount code instruments including public promotional coupons, customer-specific vouchers, batch-issued codes, and gift card discount codes. Captures code identifier, code type (public coupon, targeted voucher, batch-issued, gift card), discount type (percentage, fixed amount, free shipping), discount value, minimum order threshold, maximum discount cap, eligible product/category scope, customer segment eligibility, distribution method, usage limit per customer, total redemption cap, expiry date, issuance channel, and linked campaign. For voucher-type codes: tracks individual issuance records with customer assignment, face value, issuance date, redemption status, and linked loyalty program. Serves as the SSOT for all discount code lifecycle management across all code types.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` (
    `coupon_redemption_id` BIGINT COMMENT 'Unique surrogate key for each coupon redemption event.',
    `coupon_id` BIGINT COMMENT 'Internal identifier of the coupon definition.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who redeemed the coupon.',
    `header_id` BIGINT COMMENT 'Identifier of the order associated with the coupon redemption.',
    `marketplace_promotion_id` BIGINT COMMENT 'Identifier of the promotional campaign linked to the coupon.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Coupon redemption tracking requires knowing the specific SKU discounted for fraud detection, promotion analytics, and financial reconciliation. applied_to_sku is a denormalized text reference to produ',
    `applied_quantity` STRING COMMENT 'Number of units of the SKU that the coupon discount covered.',
    `channel` STRING COMMENT 'Channel through which the coupon was redeemed (e.g., web, mobile app, in‑store, call center).. Valid values are `web|mobile|store|call_center`',
    `coupon_redemption_status` STRING COMMENT 'Outcome of the redemption attempt: success, failure, or partial.. Valid values are `success|failure|partial`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the redemption record was first inserted into the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the discount amount.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied by the coupon.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the redemption was flagged for potential fraud.',
    `notes` STRING COMMENT 'Free‑form text for any additional information or comments about the redemption.',
    `redemption_code` STRING COMMENT 'The coupon or voucher code that was redeemed.',
    `redemption_timestamp` TIMESTAMP COMMENT 'Exact date and time when the coupon was redeemed.',
    `redemption_type` STRING COMMENT 'Classification of how the coupon can be used: single‑use, multi‑use, or auto‑apply.. Valid values are `single_use|multi_use|auto_apply`',
    `source_system` STRING COMMENT 'Name of the upstream operational system that generated the redemption record (e.g., OMS, PIM).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the redemption record.',
    CONSTRAINT pk_coupon_redemption PRIMARY KEY(`coupon_redemption_id`)
) COMMENT 'Transactional record capturing each coupon or voucher redemption event, including the redeemed code, order reference, customer reference, discount amount applied, redemption timestamp, channel, and redemption outcome (success, failure, partial). Provides the audit trail for all discount code usage and supports fraud detection and budget tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`pricing`.`price_override` (
    `price_override_id` BIGINT COMMENT 'Unique system-generated identifier for the price override record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Price overrides with approval workflows and compliance_flag require cost center attribution for financial variance reporting. In e-commerce, approved overrides exceeding thresholds are charged to a co',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer for whom the override is scoped, if applicable.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Price overrides affect revenue; finance requires a GL posting to reflect adjusted sales amounts and maintain audit trail of overrides.',
    `header_id` BIGINT COMMENT 'Identifier of the order associated with the price override.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: SOX compliance and internal audit require price override audit trails at the line item level. CSR or system price overrides are applied to specific order lines; without this FK, override reports canno',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: Price overrides are applied to specific marketplace listings (e.g., manual price corrections on a listing). Marketplace compliance, buy-box audit trails, and override approval workflows require tracin',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: price_override overrides a specific price list item; linking eliminates redundant sku column',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Price overrides (e.g., CSR goodwill adjustments, competitive match) are applied to specific SKUs. A direct sku_id FK enables SKU-level override audit trails and compliance reporting; price_list_item_i',
    `applied_timestamp` TIMESTAMP COMMENT 'Date and time when the price override took effect.',
    `approval_status` STRING COMMENT 'Result of the approval workflow for the price override.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the override was approved by the designated approver.',
    `audit_note` STRING COMMENT 'Optional free‑text note added during audit actions.',
    `compliance_flag` STRING COMMENT 'Indicates whether the override complies with pricing governance policies.. Valid values are `compliant|non_compliant|review_needed`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the override record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price values.',
    `effective_from` DATE COMMENT 'Date when the overridden price becomes effective.',
    `effective_until` DATE COMMENT 'Date when the overridden price expires; null if indefinite.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the price override is currently active (true) or has been superseded/revoked (false).',
    `original_price` DECIMAL(18,2) COMMENT 'The price of the SKU before the override was applied.',
    `overridden_price` DECIMAL(18,2) COMMENT 'The new price after the override was applied.',
    `override_type` STRING COMMENT 'Indicates whether the price override was applied manually, by an automated system, or via a pricing rule.. Valid values are `manual|system|rule_based`',
    `price_change_amount` DECIMAL(18,2) COMMENT 'Absolute difference between overridden price and original price.',
    `price_change_percentage` DECIMAL(18,2) COMMENT 'Percentage change represented by the price override.',
    `price_override_status` STRING COMMENT 'Current lifecycle status of the price override.. Valid values are `pending|approved|rejected|revoked`',
    `reason_code` STRING COMMENT 'Standardized code describing why the price override was applied.. Valid values are `promotional|clearance|error_correction|price_match|custom|other`',
    `reason_description` STRING COMMENT 'Free‑text description providing additional context for the override reason.',
    `scope` STRING COMMENT 'Defines the granularity of the override – whether it applies to the whole order, a single line, a specific customer, or globally.. Valid values are `order_level|line_level|customer_specific|global`',
    `source_system` STRING COMMENT 'System of origin for the override record.. Valid values are `OMS|PIM|PricingEngine|ManualEntry`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the override record.',
    CONSTRAINT pk_price_override PRIMARY KEY(`price_override_id`)
) COMMENT 'Transactional record of a manual or system-initiated price override applied to a specific order line or SKU, capturing the original price, overridden price, override reason code, approving user, approval timestamp, and override scope (order-level, line-level, customer-specific). Supports exception pricing workflows and audit compliance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`pricing`.`price_history` (
    `price_history_id` BIGINT COMMENT 'System-generated unique identifier for each price change event.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Historical price changes are linked to GL for audit of revenue impact and compliance with financial reporting standards.',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: FTC and marketplace compliance require listing-level price change history (e.g., reference price substantiation). price_history has sku_id but not listing_id — multiple listings can share a SKU with d',
    `marketplace_promotion_id` BIGINT COMMENT 'Identifier of the promotion or coupon that triggered the price change, if applicable.',
    `price_list_id` BIGINT COMMENT 'Identifier of the price list (e.g., base, promotional, regional) that the price belongs to.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Price History records must be tied to a SKU to support price audit, margin analysis, and regulatory reporting.',
    `change_reason` STRING COMMENT 'Free‑text explanation or business justification for the price modification.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the price values.',
    `effective_timestamp` TIMESTAMP COMMENT 'Exact moment when the new price became effective in the marketplace.',
    `initiated_by_system` STRING COMMENT 'Name of the automated system or service (e.g., pricing engine, rule engine) that generated the change.',
    `is_manual_override` BOOLEAN COMMENT 'Indicates whether the price change was manually overridden (true) or system‑driven (false).',
    `price_after` DECIMAL(18,2) COMMENT 'Price value after the change was applied.',
    `price_before` DECIMAL(18,2) COMMENT 'Price value before the change was applied.',
    `price_change_amount` DECIMAL(18,2) COMMENT 'Numeric difference between new and previous price (price_after - price_before).',
    `price_change_type` STRING COMMENT 'Classification of the change mechanism that caused the price update.. Valid values are `base|markdown|promotion|experiment|adjustment|manual_override`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this price history record was first inserted into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record (e.g., correction of metadata).',
    CONSTRAINT pk_price_history PRIMARY KEY(`price_history_id`)
) COMMENT 'Immutable append-only log of all price changes for each SKU across all price lists, capturing previous price, new price, effective timestamp, change source (dynamic rule, manual override, markdown, promotion, experiment adoption), triggering entity reference, and the user or system that initiated the change. Supports price elasticity computation, regulatory compliance (price display laws, consumer protection), competitive analysis, rollback capability, and historical price auditing for dispute resolution.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`pricing`.`price_zone` (
    `price_zone_id` BIGINT COMMENT 'Unique identifier for the pricing zone.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Price zones are defined per marketing channel to support channel‑specific pricing; the link is required for channel pricing compliance reports.',
    `delivery_zone_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_zone. Business justification: Pricing zones are derived from delivery zones; the FK lets the Pricing engine fetch zone attributes (e.g., distance, surcharge) for accurate shipping cost calculations.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Price zones with geographic_boundary and currency_code must be scoped to a legal entity for transfer pricing compliance and tax jurisdiction assignment in multi-entity e-commerce operations. Domain ex',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: Price zones are scoped to specific marketplaces (e.g., Amazon US vs. Amazon EU have distinct price zones). Pricing engines and zone management reports require knowing which marketplace a price zone go',
    `parent_price_zone_id` BIGINT COMMENT 'Self-referencing FK on price_zone (parent_price_zone_id)',
    `price_list_id` BIGINT COMMENT 'Identifier of the base price list associated with this zone.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Price zones are defined by customer segment criteria (e.g., B2B vs B2C zones with different base prices). Linking to customer.segment enables proper zone-to-segment assignment for pricing engine looku',
    `channel` STRING COMMENT 'Sales channel(s) to which the zone applies.. Valid values are `online|mobile|store|omni`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was created.',
    `currency_code` STRING COMMENT 'Currency used for pricing within this zone.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date when the pricing zone becomes active.',
    `effective_until` DATE COMMENT 'Date when the pricing zone expires or is superseded.',
    `geographic_boundary` STRING COMMENT 'Geospatial definition of the zone boundaries in GeoJSON format.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this zone is the default fallback zone.',
    `is_experimental` BOOLEAN COMMENT 'Indicates if the zone is part of an experimental pricing strategy.',
    `notes` STRING COMMENT 'Free-form notes about the zone.',
    `price_elasticity_score` DECIMAL(18,2) COMMENT 'Score representing price sensitivity for the zone.',
    `price_zone_description` STRING COMMENT 'Detailed description of the pricing zone purpose and scope.',
    `price_zone_status` STRING COMMENT 'Current lifecycle status of the pricing zone.. Valid values are `active|inactive|pending|retired`',
    `priority` STRING COMMENT 'Integer indicating priority order when multiple zones match; lower number higher priority.',
    `region` STRING COMMENT 'Three-letter ISO country code representing the primary region of the zone.. Valid values are `USA|CAN|MEX|GBR|DEU|FRA`',
    `updated_by` STRING COMMENT 'User identifier who last updated the zone record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the zone record.',
    `zone_code` STRING COMMENT 'Alphanumeric code identifying the pricing zone.',
    `zone_name` STRING COMMENT 'Human readable name of the pricing zone.',
    `created_by` STRING COMMENT 'User identifier who created the zone record.',
    CONSTRAINT pk_price_zone PRIMARY KEY(`price_zone_id`)
) COMMENT 'Geographic or customer-segment-based pricing zone definitions that determine which price list applies to a given buyer. Captures zone code, zone name, geographic boundaries, customer segment criteria, and effective date ranges.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ADD CONSTRAINT `fk_pricing_promotion_rule_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ADD CONSTRAINT `fk_pricing_promotion_rule_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ADD CONSTRAINT `fk_pricing_coupon_promotion_rule_id` FOREIGN KEY (`promotion_rule_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotion_rule`(`promotion_rule_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ADD CONSTRAINT `fk_pricing_coupon_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ADD CONSTRAINT `fk_pricing_coupon_redemption_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `ecommerce_ecm`.`pricing`.`coupon`(`coupon_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ADD CONSTRAINT `fk_pricing_price_history_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_parent_price_zone_id` FOREIGN KEY (`parent_price_zone_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`pricing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `ecommerce_ecm`.`pricing` SET TAGS ('dbx_domain' = 'pricing');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `base_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `discount_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Discount Allowed Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Price List Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `max_price` SET TAGS ('dbx_business_glossary_term' = 'Maximum Price');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `max_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `max_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `min_price` SET TAGS ('dbx_business_glossary_term' = 'Minimum Price');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `min_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `min_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Price List Notes');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Price Calculation Method');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_calculation_method` SET TAGS ('dbx_value_regex' = 'fixed|formula|algorithm|machine_learning|rule_based|manual');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_elasticity` SET TAGS ('dbx_business_glossary_term' = 'Price Elasticity');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_elasticity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_code` SET TAGS ('dbx_business_glossary_term' = 'Price List Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_description` SET TAGS ('dbx_business_glossary_term' = 'Price List Description');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_name` SET TAGS ('dbx_business_glossary_term' = 'Price List Name');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Status');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending|draft|retired');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_precision` SET TAGS ('dbx_business_glossary_term' = 'Price Precision');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Price Rounding Rule');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_rounding_rule` SET TAGS ('dbx_value_regex' = 'up|down|nearest|none|bankers|ceil');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'manual|system|partner|import|api|default');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'base|discount|promo|dynamic|tiered|custom');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Price List Version');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Variant Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `supplier_price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `audit_user_role` SET TAGS ('dbx_business_glossary_term' = 'Audit User Role');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Price');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `bundle_component_skus` SET TAGS ('dbx_business_glossary_term' = 'Bundle Component SKUs');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `bundle_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Bundle Discount Percentage');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `is_promotional` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `last_price_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Price Change Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_description` SET TAGS ('dbx_business_glossary_term' = 'Price Description');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_elasticity_score` SET TAGS ('dbx_business_glossary_term' = 'Price Elasticity Score');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_list_item_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Status');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_list_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'manual|algorithmic|imported');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'flat|tiered|volume|bundle');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `promotional_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional End Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `promotional_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional Start Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `tax_inclusive` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `tier_price` SET TAGS ('dbx_business_glossary_term' = 'Tier Unit Price');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `tier_quantity_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier Quantity Threshold');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Version');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ALTER COLUMN `volume_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Percentage');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `dynamic_price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `supplier_price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `activation_end` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Activation End Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `activation_start` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Activation Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Adjustment Type');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed|floor|ceiling');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `adjustment_unit` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Adjustment Unit');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `adjustment_unit` SET TAGS ('dbx_value_regex' = 'percent|usd|eur|gbp|cad|aud');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `adjustment_value` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Adjustment Value');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `applicable_sku_pattern` SET TAGS ('dbx_business_glossary_term' = 'Applicable SKU Pattern');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Audit Notes');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `ceiling_price` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Ceiling Price');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Effective From Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `execution_count` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Execution Count');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `floor_price` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Floor Price');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Active Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `is_experimental` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Experimental Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `is_global` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Global Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `last_executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Last Executed Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Additional Notes');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `price_elasticity_score` SET TAGS ('dbx_business_glossary_term' = 'Price Elasticity Score');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Priority');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Category');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'discount|markdown|surge|promotion|clearance');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Description');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Name');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `rule_owner` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Owner');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Status');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired|pending_review');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Type');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'dynamic|static|hybrid');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Scope');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'platform|seller|category|brand|marketplace');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `test_group` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Test Group');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `test_group` SET TAGS ('dbx_value_regex' = 'control|treatment|none');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `trigger_condition` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Trigger Condition');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Last Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Version Number');
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Created By');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `markdown_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Schedule Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|offline|both');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Markdown Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `is_test` SET TAGS ('dbx_business_glossary_term' = 'Test Schedule Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `last_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Run Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `markdown_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Markdown Schedule Status');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `markdown_schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|completed|cancelled');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `markdown_type` SET TAGS ('dbx_business_glossary_term' = 'Markdown Type');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `markdown_type` SET TAGS ('dbx_value_regex' = 'percentage|absolute');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `markdown_value` SET TAGS ('dbx_business_glossary_term' = 'Markdown Value');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `market_region` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC|LATAM|MEA');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `max_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity Threshold');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `min_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity Threshold');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Markdown Priority');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Markdown Reason');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `run_count` SET TAGS ('dbx_business_glossary_term' = 'Run Count');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|store|marketplace');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Markdown Schedule Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Markdown Schedule Name');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` SET TAGS ('dbx_subdomain' = 'discount_promotions');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Gl Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `a_b_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `a_b_test_variant` SET TAGS ('dbx_value_regex' = 'control|variant_a|variant_b');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget Amount');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget Currency');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `budget_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Type');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'flash_sale|seasonal|loyalty|clearance|bundle|coupon');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Campaign Channel');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|email|app|in_store');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `compliance_gdpr_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `compliance_pci_flag` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `compliance_sox_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|buy_one_get_one|free_shipping|tiered|bundle');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `discount_value_unit` SET TAGS ('dbx_business_glossary_term' = 'Discount Value Unit');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `discount_value_unit` SET TAGS ('dbx_value_regex' = 'percent|currency');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `eligibility_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Description');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|local');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `gmv_target` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value Target');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `gmv_target_currency` SET TAGS ('dbx_business_glossary_term' = 'GMV Target Currency');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `gmv_target_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `is_a_b_test` SET TAGS ('dbx_business_glossary_term' = 'Is A/B Test Campaign');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `is_test` SET TAGS ('dbx_business_glossary_term' = 'Is Test Campaign');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `max_uses` SET TAGS ('dbx_business_glossary_term' = 'Maximum Uses');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `promotional_campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Description');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `promotional_campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Name');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `promotional_campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Status');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `promotional_campaign_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|cancelled');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `redemption_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Customer');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `redemption_total_limit` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Limit');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `sku_inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'SKU Inclusion Criteria');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Current Usage Count');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` SET TAGS ('dbx_subdomain' = 'discount_promotions');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `promotion_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rule Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code (Code)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `discount_unit` SET TAGS ('dbx_business_glossary_term' = 'Discount Unit (Unit)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `discount_unit` SET TAGS ('dbx_value_regex' = 'percent|currency');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value (Value)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `eligible_sku_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligible SKU Criteria (SKU Criteria)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Flag (Exclusive)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `max_redemptions_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemptions Per Customer (Max Per Cust)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `max_redemptions_total` SET TAGS ('dbx_business_glossary_term' = 'Maximum Total Redemptions (Max Total)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `minimum_cart_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Cart Value (Min Cart)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Stacking Priority (Priority)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `promotion_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rule Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `promotion_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rule Description');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `promotion_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rule Name');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `promotion_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rule Status (Status)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `promotion_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|pending');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count (Count)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rule Type (Rule Type)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'bogo|percentage|fixed_amount|free_shipping|bundle_deal');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `stackable` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag (Stackable)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (Updater)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (Creator)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` SET TAGS ('dbx_subdomain' = 'discount_promotions');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `promotion_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `coupon_description` SET TAGS ('dbx_business_glossary_term' = 'Coupon Description');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `coupon_status` SET TAGS ('dbx_business_glossary_term' = 'Coupon Status');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `coupon_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|revoked');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `coupon_type` SET TAGS ('dbx_business_glossary_term' = 'Coupon Type');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `coupon_type` SET TAGS ('dbx_value_regex' = 'public_coupon|targeted_voucher|batch_issued|gift_card');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (Fixed)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_shipping');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `distribution_method` SET TAGS ('dbx_value_regex' = 'email|sms|in_app|print|api');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `eligible_category_scope` SET TAGS ('dbx_business_glossary_term' = 'Eligible Category Scope');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `eligible_product_scope` SET TAGS ('dbx_business_glossary_term' = 'Eligible Product Scope');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coupon Expiry Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `is_one_time_use` SET TAGS ('dbx_business_glossary_term' = 'One‑Time Use Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `issuance_channel` SET TAGS ('dbx_business_glossary_term' = 'Issuance Channel');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `issuance_channel` SET TAGS ('dbx_value_regex' = 'email|sms|in_app|print|api');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `max_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `min_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Amount');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Coupon Notes');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coupon Effective Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `total_redemption_cap` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Cap');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ALTER COLUMN `usage_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Usage Limit Per Customer');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` SET TAGS ('dbx_subdomain' = 'discount_promotions');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `coupon_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon Redemption ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `marketplace_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `applied_quantity` SET TAGS ('dbx_business_glossary_term' = 'Applied Quantity (QTY)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel (CHANNEL)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|store|call_center');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `coupon_redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status (STATUS)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `coupon_redemption_status` SET TAGS ('dbx_value_regex' = 'success|failure|partial');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag (FRAUD)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Redemption Notes (NOTES)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `redemption_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Redemption Code (CODE)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp (TS)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `redemption_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Type (TYPE)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `redemption_type` SET TAGS ('dbx_value_regex' = 'single_use|multi_use|auto_apply');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `price_override_id` SET TAGS ('dbx_business_glossary_term' = 'Price Override Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Price Override Gl Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Applied Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `audit_note` SET TAGS ('dbx_business_glossary_term' = 'Audit Note');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|review_needed');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Price (USD)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `overridden_price` SET TAGS ('dbx_business_glossary_term' = 'Overridden Price (USD)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `override_type` SET TAGS ('dbx_business_glossary_term' = 'Override Type (MANUAL|SYSTEM|RULE_BASED)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `override_type` SET TAGS ('dbx_value_regex' = 'manual|system|rule_based');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `price_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `price_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `price_override_status` SET TAGS ('dbx_business_glossary_term' = 'Override Status');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `price_override_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revoked');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Override Reason Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'promotional|clearance|error_correction|price_match|custom|other');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Override Reason Description');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Override Scope');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'order_level|line_level|customer_specific|global');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'OMS|PIM|PricingEngine|ManualEntry');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `price_history_id` SET TAGS ('dbx_business_glossary_term' = 'Price History Record ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Price History Gl Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `marketplace_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `initiated_by_system` SET TAGS ('dbx_business_glossary_term' = 'Initiating System');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `price_after` SET TAGS ('dbx_business_glossary_term' = 'New Price');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `price_before` SET TAGS ('dbx_business_glossary_term' = 'Previous Price');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `price_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `price_change_type` SET TAGS ('dbx_business_glossary_term' = 'Price Change Type');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `price_change_type` SET TAGS ('dbx_value_regex' = 'base|markdown|promotion|experiment|adjustment|manual_override');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `parent_price_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|mobile|store|omni');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `geographic_boundary` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary (GeoJSON)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Zone Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `is_experimental` SET TAGS ('dbx_business_glossary_term' = 'Experimental Flag');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_elasticity_score` SET TAGS ('dbx_business_glossary_term' = 'Price Elasticity Score');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_description` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Description');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Zone Status');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Zone Priority');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|DEU|FRA');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Code (PZC)');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Name');
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
