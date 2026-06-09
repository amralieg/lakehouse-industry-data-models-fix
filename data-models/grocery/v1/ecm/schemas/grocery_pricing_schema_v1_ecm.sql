-- Schema for Domain: pricing | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:34:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`pricing` COMMENT 'Price management across all channels including SRP, competitive pricing, zone pricing, markdown strategies, and dynamic fuel pricing. Manages price changes, promotional pricing linkages, ASP analytics, and price optimization algorithms. Supports competitive intelligence integration and ensures FTC pricing compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`retail_price` (
    `retail_price_id` BIGINT COMMENT 'Unique identifier for the retail price record. Primary key for the retail price entity.',
    `associate_id` BIGINT COMMENT 'Identifier of the user who approved this retail price. Supports audit trails and SOX compliance for pricing governance.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Category‑Level Price Optimization report requires linking each retail_price to its category for margin analysis and pricing strategy.',
    `order_channel_id` BIGINT COMMENT 'Identifier for the sales channel (in-store, online, mobile app, curbside pickup) where this price applies. Enables omnichannel pricing differentiation.',
    `price_zone_id` BIGINT COMMENT 'Identifier for the geographic or market-based price zone where this retail price is effective. Supports zone-based pricing strategies.',
    `sku_id` BIGINT COMMENT 'Identifier for the SKU to which this retail price applies. Links to the product master.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Business process: Supplier Suggested Retail Price (SRP) is used as a baseline in retail_price; linking SRP to supplier supports price‑setting and supplier performance analysis.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this retail price was approved for activation. Part of the pricing workflow audit trail.',
    `competitor_price_reference` DECIMAL(18,2) COMMENT 'The most recent competitive price benchmark for this SKU from competitive intelligence sources. Used for price positioning and competitive response strategies.',
    `cost_basis_amount` DECIMAL(18,2) COMMENT 'The unit cost of goods sold (COGS) used to calculate margin for this SKU. Confidential business data used for GMROI and profitability analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this retail price record was first created in the system. Part of the audit trail for price lifecycle management.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the retail price amount (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date when this retail price becomes active and available for sale transactions. Part of the price lifecycle management.',
    `expiration_date` DATE COMMENT 'The date when this retail price is no longer valid and must be replaced. Nullable for open-ended pricing. Supports automated price change workflows.',
    `external_price_code` STRING COMMENT 'The unique price identifier from the source system of record (e.g., Oracle Retail price ID, SAP condition record number). Used for cross-system reconciliation and EDI integration.',
    `last_price_change_date` DATE COMMENT 'The date of the most recent price change for this SKU in this zone and channel. Used for price volatility analysis and change frequency tracking.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this retail price record was most recently modified. Supports change tracking and audit compliance.',
    `loyalty_member_price` DECIMAL(18,2) COMMENT 'The special retail price available exclusively to loyalty program members. Nullable if no loyalty pricing exists. Supports customer loyalty and personalized pricing strategies.',
    `margin_percentage` DECIMAL(18,2) COMMENT 'The gross margin percentage calculated as (SRP - Cost) / SRP * 100. Confidential metric used for category management and pricing optimization.',
    `minimum_advertised_price` DECIMAL(18,2) COMMENT 'The minimum price at which this SKU can be advertised, as stipulated by the vendor or manufacturer. Nullable if no MAP restriction exists. Ensures vendor compliance.',
    `multi_buy_price` DECIMAL(18,2) COMMENT 'The total price for the multi-buy quantity (e.g., $5.00 for 3-for-$5). Nullable if not a multi-buy price. Used in POS promotional pricing calculations.',
    `multi_buy_quantity` STRING COMMENT 'The quantity threshold for multi-buy pricing (e.g., 2 for Buy One Get One, 3 for 3-for-$5 deals). Nullable if not a multi-buy price. Supports promotional pricing logic.',
    `price_change_count` STRING COMMENT 'The cumulative number of price changes for this SKU in this zone and channel since initial pricing. Supports price stability metrics.',
    `price_change_reason_code` STRING COMMENT 'The business reason code for the most recent price change. Supports audit trails and price change analytics. [ENUM-REF-CANDIDATE: cost_increase|competitive_response|markdown|promotion_end|seasonal_adjustment|new_item|clearance|vendor_funded — 8 candidates stripped; promote to reference product]',
    `price_display_text` STRING COMMENT 'The formatted text string for displaying the price on shelf tags, digital signage, and e-commerce (e.g., $3.99 ea, 2 for $5, $1.99/lb). Supports omnichannel price presentation consistency.',
    `price_ending_convention` STRING COMMENT 'The two-digit ending convention applied to the price (e.g., 99, 95, 49, 00). Used for psychological pricing strategies and brand positioning.. Valid values are `^d{2}$`',
    `price_lock_expiration_date` DATE COMMENT 'The date when the price lock expires and normal pricing governance resumes. Nullable if no lock is in place.',
    `price_lock_flag` BOOLEAN COMMENT 'Indicates whether this price is locked and cannot be changed without executive approval. Used for contract pricing, vendor agreements, and strategic items.',
    `price_optimization_flag` BOOLEAN COMMENT 'Indicates whether this price was set by an automated price optimization algorithm (true) or manually by a pricing analyst (false). Supports AI/ML pricing governance.',
    `price_status` STRING COMMENT 'Current lifecycle status of the retail price record. Active prices are used in POS transactions; pending prices await activation; expired prices are historical.. Valid values are `active|pending|expired|suspended|archived`',
    `price_tier` STRING COMMENT 'Classification of the pricing strategy tier for this SKU (e.g., standard, premium, value, promotional, clearance, everyday low price). Supports price positioning and markdown analytics.. Valid values are `standard|premium|value|promotional|clearance|everyday_low`',
    `price_type_code` STRING COMMENT 'Classification of the price type distinguishing base prices from temporary price reductions (TPR), promotional prices, clearance prices, and dynamic prices. Critical for price hierarchy and promotional linkage.. Valid values are `base|temporary|promotional|clearance|contract|dynamic`',
    `rounding_rule_code` STRING COMMENT 'The rounding rule applied to the calculated price (e.g., round to nearest nickel, dime, dollar, or no rounding). Supports cash handling and price presentation standards.. Valid values are `none|nearest_nickel|nearest_dime|nearest_dollar|up|down`',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is eligible for purchase using SNAP/EBT benefits. Required for government assistance program compliance and POS transaction processing.',
    `source_system_code` STRING COMMENT 'The operational system or process that originated this retail price record (e.g., Oracle Retail Price Management, SAP Retail, manual entry, price optimization engine). Supports data lineage and reconciliation.. Valid values are `oracle_retail|sap_retail|manual_entry|price_optimization_engine|vendor_file`',
    `srp_amount` DECIMAL(18,2) COMMENT 'The base shelf price for the SKU in this zone and channel, excluding any promotional or temporary price reductions. This is the single source of truth for item-level retail pricing.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for which the retail price is defined (e.g., each, pound, kilogram). Critical for produce and bulk items sold by weight. [ENUM-REF-CANDIDATE: each|pound|kilogram|ounce|liter|gallon|case|pack|dozen — 9 candidates stripped; promote to reference product]',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is eligible for purchase using WIC benefits. Required for government assistance program compliance and POS transaction processing.',
    CONSTRAINT pk_retail_price PRIMARY KEY(`retail_price_id`)
) COMMENT 'Authoritative master record of the current shelf price (SRP) for every SKU within a specific price zone and channel. Captures base retail price, effective and expiration dates, price zone assignment, unit of measure, price tier, and price-ending convention. Serves as the single source of truth for item-level retail pricing and the foundation for all price change, markdown, TPR, and promotional pricing workflows.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`price_zone` (
    `price_zone_id` BIGINT COMMENT 'Primary key for price_zone',
    `competitive_intensity` STRING COMMENT 'Assessment of competitive pressure within this zone based on number and strength of competitors. Drives pricing aggressiveness.. Valid values are `low|medium|high|very_high`',
    `competitive_price_match_policy` STRING COMMENT 'Policy for matching competitor prices in this zone: none (no matching), manual (case-by-case approval), automated (system-driven matching), or selective (specific categories only).. Valid values are `none|manual|automated|selective`',
    `cost_index` DECIMAL(18,2) COMMENT 'Relative cost index for this zone compared to a baseline (e.g., 1.00 = baseline, 1.15 = 15% higher costs). Reflects distribution, labor, and occupancy cost differences.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this price zone record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this price zone ceases to be active. Null for open-ended zones.',
    `effective_start_date` DATE COMMENT 'Date when this price zone becomes active and begins to govern pricing for assigned stores.',
    `fuel_pricing_enabled` BOOLEAN COMMENT 'Indicates whether this price zone applies to fuel center pricing. True if zone governs fuel prices; false if zone is retail-only.',
    `income_profile` STRING COMMENT 'Predominant household income level within the zone, used to calibrate price sensitivity and product mix.. Valid values are `low|medium|high|mixed`',
    `last_review_date` DATE COMMENT 'Date when this price zone configuration was last reviewed and validated by pricing management. Used to ensure zones remain aligned with market conditions.',
    `markdown_strategy` STRING COMMENT 'Approach to markdown and clearance pricing within this zone: aggressive (deep discounts), moderate (standard clearance), conservative (minimal markdowns), or none (no markdowns allowed).. Valid values are `aggressive|moderate|conservative|none`',
    `market_segment` STRING COMMENT 'Geographic market segment classification for the zone, used to align pricing with local market characteristics.. Valid values are `urban|suburban|rural|metro|exurban|mixed`',
    `modified_by` STRING COMMENT 'User ID or name of the pricing analyst or system that last modified this price zone record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this price zone record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this price zone. Ensures periodic reassessment of zone boundaries and strategies.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or context about this price zone. Used by pricing analysts for documentation.',
    `pharmacy_pricing_enabled` BOOLEAN COMMENT 'Indicates whether this price zone applies to pharmacy prescription pricing. True if zone governs pharmacy prices; false if zone is retail-only.',
    `price_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to base prices to derive zone-specific retail prices. For example, 1.0500 means 5% uplift over base.',
    `price_change_approval_required` BOOLEAN COMMENT 'Indicates whether price changes in this zone require managerial approval before execution. True if approval workflow is enforced; false if automated.',
    `price_optimization_enabled` BOOLEAN COMMENT 'Indicates whether algorithmic price optimization is active for this zone. True if AI/ML pricing algorithms are used; false if manual pricing rules apply.',
    `pricing_strategy` STRING COMMENT 'The overarching pricing strategy applied to this zone: everyday_low (EDLP), high_low (frequent promotions), premium (higher margin), discount (low margin high volume), market_match (competitive parity), or penetration (aggressive entry pricing).. Valid values are `everyday_low|high_low|premium|discount|market_match|penetration`',
    `private_label_strategy` STRING COMMENT 'Pricing approach for private-label (store-owned brand) products in this zone: standard (parity with national brands), premium (higher margin), value (aggressive discount), or mixed (varies by category).. Valid values are `standard|premium|value|mixed`',
    `promotional_frequency` STRING COMMENT 'Typical cadence of promotional pricing events in this zone, aligned with ad circular schedules and competitive response.. Valid values are `weekly|biweekly|monthly|seasonal|event_driven`',
    `region_code` STRING COMMENT 'Code representing the broader geographic region or division that this price zone belongs to, for hierarchical rollup and reporting.. Valid values are `^[A-Z]{2,5}$`',
    `snap_ebt_volume_pct` DECIMAL(18,2) COMMENT 'Percentage of transaction volume in this zone paid via SNAP/EBT benefits. Influences pricing sensitivity and product mix decisions.',
    `store_count` STRING COMMENT 'Number of stores currently assigned to this price zone. Updated as stores are added or removed.',
    `zone_code` STRING COMMENT 'Business identifier code for the price zone, used in pricing systems and reports. Typically alphanumeric and unique across the enterprise.. Valid values are `^[A-Z0-9]{2,10}$`',
    `zone_description` STRING COMMENT 'Detailed description of the price zone, including the rationale for grouping stores (e.g., competitive environment, demographics, cost structure).',
    `zone_name` STRING COMMENT 'Human-readable name of the price zone, such as Metro East, Rural Southwest, or High Competition Urban.',
    `zone_status` STRING COMMENT 'Current lifecycle status of the price zone. Active zones are in use for pricing; inactive zones are temporarily disabled; pending zones are under review; archived zones are historical.. Valid values are `active|inactive|pending|archived`',
    `zone_type` STRING COMMENT 'Classification of the price zone strategy: competitive (based on competitor density), geographic (regional boundaries), demographic (customer income/profile), cost_based (distribution cost), hybrid (multiple factors), or promotional (special event-driven).. Valid values are `competitive|geographic|demographic|cost_based|hybrid|promotional`',
    `created_by` STRING COMMENT 'User ID or name of the pricing analyst or system that created this price zone record.',
    CONSTRAINT pk_price_zone PRIMARY KEY(`price_zone_id`)
) COMMENT 'Defines geographic or competitive pricing zones used to differentiate retail prices across store clusters. Each zone groups stores with similar competitive environments, cost structures, or market demographics. Supports zone-based pricing strategies where the same SKU carries different shelf prices in different zones. Referenced by retail_price, price_change, and competitive_price records as the geographic pricing boundary.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`price_change` (
    `price_change_id` BIGINT COMMENT 'Unique identifier for the price change event. Primary key.',
    `associate_id` BIGINT COMMENT 'Identifier of the manager or pricing authority who approved the price change.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Price Change Impact Dashboard aggregates changes by category to assess competitive response and margin effect.',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Price changes often depend on the underlying cost basis; linking to cost_price captures the cost record driving the price change and provides a direct relationship.',
    `price_batch_id` BIGINT COMMENT 'Reference identifier for the batch or group of price changes processed together, used for bulk price updates.',
    `price_zone_id` BIGINT COMMENT 'Identifier of the geographic or competitive price zone where this price change applies.',
    `primary_price_associate_id` BIGINT COMMENT 'Identifier of the buyer or category manager who initiated the price change request.',
    `promo_offer_id` BIGINT COMMENT 'Identifier linking this price change to a promotional campaign if the change is promotion-driven. Nullable for non-promotional changes.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU for which the price is being changed.',
    `store_location_id` BIGINT COMMENT 'Identifier of the specific store location if this price change applies to a single store rather than a zone. Nullable for zone-level changes.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier associated with this price change, particularly for vendor-funded price reductions or cost-driven increases.',
    `activated_timestamp` TIMESTAMP COMMENT 'The date and time when the price change was activated and became effective in Point of Sale (POS) systems.',
    `amount` DECIMAL(18,2) COMMENT 'The absolute difference between new price and old price (new_price minus old_price). Positive for increases, negative for decreases.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the price change request.. Valid values are `pending|approved|rejected|cancelled`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the price change was approved by the pricing authority.',
    `change_number` STRING COMMENT 'Business-readable unique identifier for the price change event, often used in approval workflows and audit trails.',
    `change_reason_code` STRING COMMENT 'Categorical code indicating the business reason for the price change: cost increase, competitive response, seasonal adjustment, vendor-funded promotion, markdown, or clearance.. Valid values are `cost_increase|competitive_response|seasonal|vendor_funded|markdown|clearance`',
    `change_type` STRING COMMENT 'Classification of the price change: regular price adjustment, promotional pricing, temporary price reduction (TPR), permanent price change, or markdown.. Valid values are `regular|promotional|temporary|permanent|markdown`',
    `channel` STRING COMMENT 'The sales channel to which this price change applies: in-store, online eCommerce, mobile app, curbside pickup, or home delivery.. Valid values are `store|online|mobile|pickup|delivery`',
    `competitive_price_reference` DECIMAL(18,2) COMMENT 'The competitor price that influenced this change, captured from competitive intelligence systems.',
    `competitor_name` STRING COMMENT 'Name of the competitor whose pricing influenced this change, used for competitive response tracking.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance considerations, regulatory review outcomes, or audit trail details for FTC pricing compliance.',
    `compliance_review_flag` BOOLEAN COMMENT 'Indicates whether this price change required Federal Trade Commission (FTC) pricing compliance review due to regulatory sensitivity (True) or was routine (False).',
    `cost_change_amount` DECIMAL(18,2) COMMENT 'The change in product cost from the vendor that triggered this retail price change. Used for margin analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this price change record was first created in the lakehouse silver layer.',
    `effective_date` DATE COMMENT 'The date when the new price becomes active and is applied at Point of Sale (POS).',
    `elasticity_coefficient` DECIMAL(18,2) COMMENT 'The price elasticity of demand coefficient used in the pricing decision, representing the expected percentage change in quantity demanded for a 1% price change.',
    `expiration_date` DATE COMMENT 'The date when this price change expires and reverts or transitions to another price. Nullable for permanent changes.',
    `forecasted_revenue_impact` DECIMAL(18,2) COMMENT 'The projected change in revenue resulting from this price change, calculated from volume and price elasticity models.',
    `forecasted_volume_impact` DECIMAL(18,2) COMMENT 'The projected change in sales volume (units) resulting from this price change, based on demand forecasting models.',
    `margin_impact_percent` DECIMAL(18,2) COMMENT 'The projected impact on Gross Margin Return on Investment (GMROI) resulting from this price change, expressed as a percentage.',
    `new_price` DECIMAL(18,2) COMMENT 'The new retail price effective after this change event.',
    `old_price` DECIMAL(18,2) COMMENT 'The previous retail price before this change event.',
    `percent` DECIMAL(18,2) COMMENT 'The percentage change in price calculated as ((new_price - old_price) / old_price) * 100.',
    `price_optimization_flag` BOOLEAN COMMENT 'Indicates whether this price change was generated by an automated price optimization algorithm (True) or manually initiated (False).',
    `source_system` STRING COMMENT 'The name of the operational system that originated this price change record (e.g., Oracle Retail Price Management, SAP Retail SD).',
    `submitted_timestamp` TIMESTAMP COMMENT 'The date and time when the price change request was submitted into the pricing system.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this price change record was last modified in the lakehouse silver layer.',
    CONSTRAINT pk_price_change PRIMARY KEY(`price_change_id`)
) COMMENT 'Transactional record of every approved retail price change event for a SKU in a given price zone. Captures old price, new price, effective date, expiration date, change reason code (cost increase, competitive response, seasonal, vendor-funded), initiating buyer, approval status, and batch reference. Supports FTC pricing compliance audit trails, comp-sales impact analysis, and price change velocity reporting.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`markdown` (
    `markdown_id` BIGINT COMMENT 'Unique identifier for the markdown event. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Markdown Planning process uses category to set markdown thresholds and evaluate sell‑through per category.',
    `associate_id` BIGINT COMMENT 'The pricing team member or manager who approved this markdown. Null if not yet approved or if auto-approved by system rules.',
    `markdown_associate_id` BIGINT COMMENT 'The category manager who proposed or authorized this markdown event.',
    `price_rule_id` BIGINT COMMENT 'The identifier of the automated markdown rule that triggered this event. Null if manually created.',
    `price_zone_id` BIGINT COMMENT 'The pricing zone to which this markdown applies. Null if markdown is store-specific or enterprise-wide.',
    `sku_id` BIGINT COMMENT 'The SKU subject to this markdown event.',
    `store_location_id` BIGINT COMMENT 'The store where this markdown is applied. Null if markdown applies to a zone or all stores.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Business process: Supplier‑funded markdowns (allowances) are tracked per markdown record; linking to supplier captures funding source for margin and compliance reporting.',
    `actual_margin_impact` DECIMAL(18,2) COMMENT 'The actual gross margin impact realized from this markdown event, calculated after completion.',
    `actual_revenue_impact` DECIMAL(18,2) COMMENT 'The actual revenue impact realized from this markdown event, calculated after completion by comparing markdown revenue to baseline revenue projection.',
    `actual_units_sold` STRING COMMENT 'The actual number of units sold during the markdown period. Populated after markdown completion for performance analysis.',
    `ad_circular_featured` BOOLEAN COMMENT 'Indicates whether this markdown is featured in the weekly ad circular or promotional flyer (True) or is an in-store-only markdown (False).',
    `amount` DECIMAL(18,2) COMMENT 'The absolute dollar amount by which the price is reduced. Null if markdown is expressed as a percentage.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this markdown was approved by the pricing team.',
    `cancellation_reason` STRING COMMENT 'The reason this markdown was cancelled before activation (e.g., inventory sold out, pricing error, vendor credit received, competitive intelligence changed). Null if not cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this markdown record was first created in the system.',
    `days_on_shelf_threshold` STRING COMMENT 'The number of days an item has been on the shelf that triggered this markdown (e.g., 30 days for slow movers). Null if not applicable to this markdown type.',
    `days_to_expiration_threshold` STRING COMMENT 'The number of days remaining until product expiration that triggered this markdown for perishables. Null if not applicable.',
    `effective_end_date` DATE COMMENT 'The date when the markdown expires and pricing reverts to the original or a new price. Null for permanent markdowns.',
    `effective_start_date` DATE COMMENT 'The date when the markdown becomes active and the reduced price takes effect.',
    `estimated_margin_impact` DECIMAL(18,2) COMMENT 'The estimated gross margin impact (in dollars) from this markdown, calculated at planning time using COGS and markdown price.',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'The estimated revenue loss or gain from this markdown event, calculated at planning time. Negative values indicate revenue reduction; positive values indicate incremental revenue from volume lift.',
    `ftc_compliance_notes` STRING COMMENT 'Free-text field capturing any FTC pricing compliance considerations for this markdown, such as comparative pricing claims, former price disclosures, or advertising restrictions.',
    `inventory_units_threshold` STRING COMMENT 'The inventory unit count threshold that triggered this markdown due to overstock. Null if not applicable.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether this markdown was triggered automatically by a system rule (True) or manually created by a category manager (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this markdown record was last updated.',
    `markdown_number` STRING COMMENT 'Business-facing unique identifier for the markdown event, used in reporting and communication with category managers.. Valid values are `^MD-[0-9]{8,12}$`',
    `markdown_status` STRING COMMENT 'Current lifecycle status of the markdown event: planned (proposed by category manager), approved (authorized by pricing team), active (currently in effect), completed (end date reached), cancelled (revoked before activation).. Valid values are `planned|approved|active|completed|cancelled`',
    `markdown_type` STRING COMMENT 'Classification of the markdown: permanent (ongoing price reduction), temporary (time-bound markdown), clearance (end-of-life inventory liquidation), seasonal (seasonal rotation), or perishable (shrink reduction for fresh items nearing expiration).. Valid values are `permanent|temporary|clearance|seasonal|perishable`',
    `notes` STRING COMMENT 'Free-text notes from the category manager or pricing analyst providing additional context, rationale, or instructions for this markdown event.',
    `original_price` DECIMAL(18,2) COMMENT 'The regular retail price (SRP) before the markdown is applied, in local currency.',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the original price (e.g., 25.00 for 25% off). Null if markdown is expressed as an absolute amount.',
    `planned_units_to_clear` STRING COMMENT 'The target number of inventory units the category manager intends to sell through with this markdown. Used for clearance and overstock scenarios.',
    `pos_signage_required` BOOLEAN COMMENT 'Indicates whether in-store signage or shelf tags must be updated to reflect the markdown price (True) or if the price change is system-only (False).',
    `price` DECIMAL(18,2) COMMENT 'The final retail price after the markdown is applied, in local currency.',
    `reason` STRING COMMENT 'The business reason triggering the markdown: slow_mover (low sell-through rate), overstock (excess inventory), damage (product quality issue), expiration (approaching best-by date), seasonal_rotation (end of season), discontinued (product phase-out).. Valid values are `slow_mover|overstock|damage|expiration|seasonal_rotation|discontinued`',
    `sell_through_rate_threshold` DECIMAL(18,2) COMMENT 'The sell-through rate percentage threshold that triggered this markdown (e.g., 15.00 for 15%). Null if not applicable.',
    `triggering_condition` STRING COMMENT 'The business rule or threshold that triggered this markdown event (e.g., days on shelf > 30, sell-through rate < 20%, inventory units > 500, days to expiration < 7). Free-text field capturing the logic used by the category manager or automated system.',
    CONSTRAINT pk_markdown PRIMARY KEY(`markdown_id`)
) COMMENT 'Records planned and executed markdown events for clearance, seasonal rotation, or perishable shrink reduction. Captures markdown type (permanent, temporary, clearance), markdown percentage or absolute amount, start and end dates, triggering condition (e.g., days-on-shelf threshold, sell-through rate), and store or zone scope. Distinct from TPR promotional pricing — markdowns are inventory-driven price reductions managed by category managers.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`tpr` (
    `tpr_id` BIGINT COMMENT 'Unique identifier for the temporary price reduction record.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Temporary Price Reduction analysis reports performance by category, requiring a FK from tpr to category.',
    `price_zone_id` BIGINT COMMENT 'Identifier of the geographic pricing zone for the TPR. Null if store‑specific.',
    `sku_id` BIGINT COMMENT 'Identifier of the stock keeping unit to which the TPR applies.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store where the TPR is scoped. Null if the TPR is zone‑wide.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor providing funding for the TPR, if applicable.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price values.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute monetary discount applied (regular_price - tpr_price).',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount relative to the regular price.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the temporary price reduction expires.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or justification of the TPR.',
    `price` DECIMAL(18,2) COMMENT 'Shelf price of the SKU during the TPR period.',
    `price_source` STRING COMMENT 'Origin of the TPR price entry: system‑generated, manually entered, or supplied by vendor.. Valid values are `system|manual|vendor`',
    `price_type` STRING COMMENT 'Classification of the price change; for this entity it will be tpr.. Valid values are `tpr|markdown|promotion`',
    `reason_code` STRING COMMENT 'Code representing the business reason for the temporary price reduction (e.g., competitor match, inventory clearance).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the TPR record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the TPR record.',
    `regular_price` DECIMAL(18,2) COMMENT 'Standard shelf price of the SKU before any temporary reduction.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the temporary price reduction becomes effective.',
    `tpr_number` STRING COMMENT 'Business identifier assigned to the TPR event, often used in reporting and audit trails.',
    `tpr_status` STRING COMMENT 'Current lifecycle status of the TPR record.. Valid values are `active|inactive|expired|cancelled`',
    `vendor_funded_flag` BOOLEAN COMMENT 'Indicates whether the discount is subsidized by the vendor (True) or absorbed by the retailer (False).',
    CONSTRAINT pk_tpr PRIMARY KEY(`tpr_id`)
) COMMENT 'Temporary Price Reduction (TPR) record linking a SKU to a short-term shelf price reduction that is NOT tied to a formal promotion campaign. Captures the TPR price, regular price, discount amount, start and end dates, store or zone scope, and vendor funding flag (indicating whether a CPG vendor is subsidizing the reduction via a trade deal). Distinct from markdown (clearance) and from promotion-driven pricing.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`competitive_price` (
    `competitive_price_id` BIGINT COMMENT 'System-generated unique identifier for each competitive price observation record.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Competitive price observations are zone‑specific; linking to price_zone provides a canonical zone reference and removes redundant store_zone and region columns.',
    `store_location_id` BIGINT COMMENT 'Unique identifier of the specific competitor store where the price was observed.',
    `competitive_price_status` STRING COMMENT 'Current lifecycle status of the observation record.. Valid values are `active|inactive|archived`',
    `competitor_name` STRING COMMENT 'Name of the competing retailer or chain providing the price observation.',
    `confidence_score` DOUBLE COMMENT 'System‑generated confidence level (0‑1) indicating reliability of the observation.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the observed price.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Origin of the price observation data.. Valid values are `numerator|datasembly|manual|webscrape`',
    `observation_method` STRING COMMENT 'Method used to capture the price (e.g., in‑store scan, manual entry, API feed).. Valid values are `scan|manual|api`',
    `observation_timestamp` TIMESTAMP COMMENT 'Date and time when the competitor price was observed or recorded.',
    `observed_price` DECIMAL(18,2) COMMENT 'Price quoted by the competitor for the SKU at the observation time.',
    `our_price` DECIMAL(18,2) COMMENT 'Current shelf price of the same SKU at Grocery stores.',
    `plu` STRING COMMENT 'Code used primarily for fresh produce items to identify pricing.',
    `price_change_flag` BOOLEAN COMMENT 'Indicates whether the observed price differs from the previous observation for the same SKU and competitor.',
    `price_gap` DECIMAL(18,2) COMMENT 'Difference between competitor price and Grocerys price (competitor - ours).',
    `price_gap_percentage` DOUBLE COMMENT 'Relative price gap expressed as a percentage of Grocerys price.',
    `price_type` STRING COMMENT 'Classification of the observed price (e.g., regular shelf, promotional, clearance).. Valid values are `regular|sale|clearance|promo|discount`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this competitive price record was first loaded into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this competitive price record.',
    `sku` STRING COMMENT 'Internal SKU of the product for which the competitive price is captured.',
    `upc` STRING COMMENT 'Standardized 12‑digit barcode identifier for the product.',
    CONSTRAINT pk_competitive_price PRIMARY KEY(`competitive_price_id`)
) COMMENT 'Stores competitive intelligence price observations for key SKUs and PLUs captured from competitor stores, third-party price intelligence feeds (e.g., Numerator, Datasembly), or manual audits. Captures competitor store identifier, competitor chain name, observed price, observed date, data source, and price gap versus Grocerys current shelf price. Feeds competitive pricing response workflows and price optimization algorithms.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`price_rule` (
    `price_rule_id` BIGINT COMMENT 'Unique identifier for the pricing rule.',
    `associate_id` BIGINT COMMENT 'Identifier of the user who approved the rule.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Pricing rules are often scoped to specific categories; linking enables rule‑to‑category enforcement and audit.',
    `price_zone_id` BIGINT COMMENT 'Geographic or store zone identifier where the rule applies.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Pricing rules are scoped to profit centers to enable profit‑center profitability analysis and budgeting.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Price rule activation tied to promotion campaigns for automated price adjustments during campaign periods.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Price rule may be triggered by specific promo offers, enabling dynamic pricing based on offer conditions.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Business process: Supplier‑specific pricing rules (margin floors, discounts) are defined in price_rule for price optimization. Retail‑grocery pricing teams need to link each rule to its supplier.',
    `applicable_category_code` STRING COMMENT 'Category (e.g., grocery, produce) to which the rule applies.',
    `applicable_department_code` STRING COMMENT 'Department identifier (e.g., dairy, pharmacy) for rule scope.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule was approved.',
    `competitive_index_cap` DECIMAL(18,2) COMMENT 'Maximum allowed price relative to a competitive index.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was created.',
    `effective_end_date` DATE COMMENT 'Date when the rule expires; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the rule becomes effective.',
    `gmroi_threshold` DECIMAL(18,2) COMMENT 'Minimum GMROI value required for rule applicability.',
    `is_system_rule` BOOLEAN COMMENT 'True if the rule is system‑defined; false if user‑defined.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule.',
    `margin_floor_percent` DECIMAL(18,2) COMMENT 'Minimum gross margin percentage required by the rule.',
    `notes` STRING COMMENT 'Free‑text comments or rationale for the rule.',
    `price_ceiling` DECIMAL(18,2) COMMENT 'Maximum allowable price for items governed by this rule.',
    `price_ending_convention` STRING COMMENT 'Standard price ending pattern (e.g., .99, .95).. Valid values are `99|95|00|49`',
    `price_floor` DECIMAL(18,2) COMMENT 'Minimum allowable price for items governed by this rule.',
    `price_rule_name` STRING COMMENT 'Human readable name of the pricing rule.',
    `price_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|draft|retired`',
    `priority` STRING COMMENT 'Integer indicating rule precedence; lower numbers have higher priority.',
    `rule_type` STRING COMMENT 'Classification of the rule indicating its purpose and calculation method.. Valid values are `margin_floor|competitive_cap|edlp_flag|price_ending|markdown|dynamic_fuel`',
    CONSTRAINT pk_price_rule PRIMARY KEY(`price_rule_id`)
) COMMENT 'Business-managed pricing rules and guardrails that govern automated and manual price-setting decisions. Captures rule type (margin floor, competitive index cap, EDLP vs. Hi-Lo strategy flag, price-ending convention), applicable category or department, minimum and maximum price bounds, GMROI threshold, and rule priority. Used by price optimization algorithms and CAO systems to constrain price recommendations within acceptable business parameters.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`cost_price` (
    `cost_price_id` BIGINT COMMENT 'Unique surrogate identifier for each cost price record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Cost of Goods Sold reporting: each SKU cost record must be charged to a cost center for internal accounting.',
    `sku_id` BIGINT COMMENT 'Identifier of the product (SKU) to which this cost applies.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor supplying the product.',
    `allowance_cost` DECIMAL(18,2) COMMENT 'Cost reductions such as trade discounts, promotional allowances, or rebates.',
    `base_cost` DECIMAL(18,2) COMMENT 'Core purchase price before any allowances, freight, or other adjustments.',
    `buyer_acknowledged` BOOLEAN COMMENT 'Indicates whether the purchasing buyer has reviewed and accepted the cost change.',
    `compliance_notes` STRING COMMENT 'Comments related to FTC pricing compliance or other regulatory considerations.',
    `cost_allocation_method` STRING COMMENT 'Algorithm used to allocate cost when multiple cost layers exist.. Valid values are `weighted_average|fifo|lifo|standard_cost`',
    `cost_category` STRING COMMENT 'Logical grouping of the cost (e.g., raw material, packaging, duty).',
    `cost_change_approval_status` STRING COMMENT 'Current approval state of the cost change request.. Valid values are `approved|rejected|pending`',
    `cost_change_effective_date` DATE COMMENT 'Date on which the cost change takes effect; mirrors effective_start_date for reporting.',
    `cost_change_reason` STRING COMMENT 'Explanation for why the cost was adjusted (e.g., commodity index, tariff, packaging change).',
    `cost_change_source` STRING COMMENT 'Source that initiated the cost change: vendor‑initiated, internal procurement, or system‑generated.. Valid values are `vendor|internal|system`',
    `cost_reference` STRING COMMENT 'Business‑visible reference number for the cost price record.',
    `cost_status` STRING COMMENT 'Operational status indicating if the cost is active, pending approval, or archived.. Valid values are `active|inactive|pending|archived`',
    `cost_type` STRING COMMENT 'Classification of the cost (e.g., standard, actual, replacement, forward‑buy).. Valid values are `standard|actual|replacement|forward_buy`',
    `cost_version_number` STRING COMMENT 'Sequential version identifier for audit and trend analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the cost record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter code representing the currency of the cost values.. Valid values are `[A-Z]{3}`',
    `effective_end_date` DATE COMMENT 'Date after which the cost is no longer applicable.',
    `effective_start_date` DATE COMMENT 'First date the cost is valid for pricing and margin calculations.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert foreign‑currency cost components to the base reporting currency.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation cost incurred to move the product from vendor to distribution center.',
    `gl_account_code` STRING COMMENT 'GL account number to which the cost is posted for financial reporting.',
    `is_freight_included` BOOLEAN COMMENT 'True if freight cost is already rolled into the total cost.',
    `is_tax_included` BOOLEAN COMMENT 'True if applicable taxes are included in the total cost.',
    `landed_cost` DECIMAL(18,2) COMMENT 'Total cost after adding freight, duties, taxes, and other landed‑cost items.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or process that last updated the cost record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the cost record.',
    `margin_impact_flag` BOOLEAN COMMENT 'True if the cost change is expected to affect gross margin reporting.',
    `notes` STRING COMMENT 'Additional comments or observations about the cost record.',
    `original_cost` DECIMAL(18,2) COMMENT 'Cost value prior to the most recent change, retained for audit trail.',
    `price_optimization_flag` BOOLEAN COMMENT 'True if this cost record should be considered by automated price‑optimization algorithms.',
    `retail_price_action_flag` BOOLEAN COMMENT 'True if the cost change triggers an automatic retail price update.',
    `source_document_date` DATE COMMENT 'Date of the vendor invoice or contract that provided the cost data.',
    `source_document_number` STRING COMMENT 'Reference number of the vendor invoice or contract supporting the cost.',
    `total_cost` DECIMAL(18,2) COMMENT 'Aggregated cost (base + allowances + freight + landed) that serves as the cost basis for GMROI and margin analysis.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the cost record.',
    CONSTRAINT pk_cost_price PRIMARY KEY(`cost_price_id`)
) COMMENT 'Authoritative record of the vendor invoice cost (COGS basis) for each SKU, including base cost, allowances, deal costs, freight, and landed cost components. Captures effective date, expiration date, vendor agreement reference, cost type (standard, actual, replacement, forward-buy), and currency code supporting multi-currency operations. Includes vendor-initiated cost change tracking with old cost, new cost, change effective date, vendor justification (commodity index, freight surcharge, tariff, packaging), buyer acknowledgment status, and resulting retail price action flag. Serves as the cost basis for margin calculation, GMROI analysis, price change justification, and gross profit reporting. Temporal versioning maintains full cost history for audit and trend analysis.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`optimization_run` (
    `optimization_run_id` BIGINT COMMENT 'Unique identifier for each price optimization execution.',
    `automation_rule_id` BIGINT COMMENT 'Identifier of the automation rule that scheduled the run.',
    `constraint_set_id` BIGINT COMMENT 'Identifier of the price rule set applied to constrain the optimization.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Optimization runs are evaluated against a fiscal period for budgeting, performance measurement, and variance analysis.',
    `associate_id` BIGINT COMMENT 'Identifier of the employee who reviewed the runs recommendations.',
    `acceptance_rate` DECIMAL(18,2) COMMENT 'Percentage of recommended price changes that were accepted by reviewers.',
    `accepted_recommendations_count` STRING COMMENT 'Number of recommendations that were accepted by reviewers.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the run was formally approved for execution.',
    `confidence_interval_high` DECIMAL(18,2) COMMENT 'Upper bound of the confidence interval for the models impact estimates.',
    `confidence_interval_low` DECIMAL(18,2) COMMENT 'Lower bound of the confidence interval for the models impact estimates.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Overall confidence level (0‑100) assigned by the model to the runs recommendations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the optimization run record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency used for monetary estimates.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `data_source` STRING COMMENT 'Source system(s) that supplied input data for the run.. Valid values are `POS|eCommerce|WMS|ERP`',
    `estimated_margin_impact` DECIMAL(18,2) COMMENT 'Projected incremental gross margin (in currency) from the runs recommendations.',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'Projected incremental revenue (in currency) resulting from the runs recommendations.',
    `estimated_units_change` DECIMAL(18,2) COMMENT 'Projected change in units sold as a result of the price recommendations.',
    `estimated_velocity_change` DECIMAL(18,2) COMMENT 'Projected change in sales velocity (units per day) due to the recommendations.',
    `ftc_compliance_notes` STRING COMMENT 'Notes related to Federal Trade Commission pricing compliance for the run.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the run was triggered automatically by a schedule.',
    `model_execution_time_ms` STRING COMMENT 'Time taken by the pricing model to compute recommendations, in milliseconds.',
    `model_input_data_version` STRING COMMENT 'Version identifier of the input data snapshot used for the run.',
    `model_output_data_version` STRING COMMENT 'Version identifier of the output data generated by the model.',
    `model_version` STRING COMMENT 'Version identifier of the pricing algorithm used in the run.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the run.',
    `overridden_recommendations_count` STRING COMMENT 'Number of recommendations that were manually overridden.',
    `override_reason` STRING COMMENT 'Reason provided when a recommendation is manually overridden.',
    `pricing_strategy` STRING COMMENT 'Primary pricing strategy applied in the optimization.. Valid values are `SRP|markdown|dynamic|zone|competitive`',
    `recommendation_status` STRING COMMENT 'Aggregated status of the runs SKU‑level recommendations.. Valid values are `pending|accepted|rejected|overridden`',
    `rejected_recommendations_count` STRING COMMENT 'Number of recommendations that were rejected by reviewers.',
    `reviewer_comments` STRING COMMENT 'Free‑form comments entered by the reviewer during evaluation.',
    `run_code` STRING COMMENT 'Human‑readable code assigned to the optimization run for tracking.',
    `run_duration_seconds` STRING COMMENT 'Total execution time of the run measured in seconds.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the optimization algorithm finished execution.',
    `run_scope` STRING COMMENT 'Business scope of the run – which segment of the assortment the optimization covered.. Valid values are `department|category|zone|store`',
    `run_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the optimization algorithm began execution.',
    `run_status` STRING COMMENT 'Current lifecycle status of the optimization run.. Valid values are `draft|running|completed|failed|cancelled`',
    `sku_evaluated_count` STRING COMMENT 'Count of distinct SKUs that were evaluated in this run.',
    `total_sku_recommendations` STRING COMMENT 'Total number of price recommendations generated by the run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the run record.',
    CONSTRAINT pk_optimization_run PRIMARY KEY(`optimization_run_id`)
) COMMENT 'Operational record of each price optimization algorithm execution, its configuration, and its resulting SKU-level price recommendations. Captures run date, model version, category or department scope, constraint set applied (referencing price_rule), number of SKUs evaluated, acceptance rate, estimated revenue and margin impact, and run status. Contains line-item recommendations per SKU including recommended price, current price, expected margin impact, expected unit velocity change, confidence score, recommendation status (pending, accepted, rejected, overridden), reviewer ID, and override reason. Supports governance, auditability, and performance tracking of algorithmic pricing decisions. Bridges algorithmic output with buyer review and approval workflows through the recommendation lifecycle within each run.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` (
    `pricing_recommendation_id` BIGINT COMMENT 'Unique identifier for each price recommendation generated by the optimization engine.',
    `associate_id` BIGINT COMMENT 'Internal user or system that reviewed and acted on the recommendation.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Price recommendation engine outputs suggestions per category for merchandising planning.',
    `optimization_run_id` BIGINT COMMENT 'Batch identifier linking the recommendation to a specific execution of the price optimization engine.',
    `price_zone_id` BIGINT COMMENT 'Identifier of the pricing zone (e.g., regional, market, or store cluster) that governs the recommendation.',
    `sku_id` BIGINT COMMENT 'Internal identifier of the product (SKU) to which the recommendation applies.',
    `store_location_id` BIGINT COMMENT 'Identifier of the retail location for which the price recommendation is generated.',
    `algorithm_version` STRING COMMENT 'Identifier of the pricing optimization model or rule set that generated the recommendation.',
    `confidence_score` DOUBLE COMMENT 'Statistical confidence (0‑1) that the recommendation will achieve the projected outcomes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the recommendation record was first inserted into the lakehouse.',
    `current_price` DECIMAL(18,2) COMMENT 'Existing price of the SKU in the store/zone before the recommendation is applied.',
    `effective_end_date` DATE COMMENT 'Last calendar date the recommended price is valid; after this date a new recommendation is required.',
    `effective_start_date` DATE COMMENT 'First calendar date the recommended price may be applied.',
    `expected_margin_impact` DECIMAL(18,2) COMMENT 'Estimated change in gross margin percentage if the recommended price is adopted.',
    `expected_unit_velocity_change` DECIMAL(18,2) COMMENT 'Estimated percentage increase or decrease in units sold per period resulting from the recommendation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the recommendation record.',
    `notes` STRING COMMENT 'Additional comments, observations, or constraints associated with the recommendation.',
    `override_reason` STRING COMMENT 'Free‑text explanation for why a recommendation was manually changed or rejected.',
    `price_change_reason` STRING COMMENT 'Business driver for the recommendation (e.g., markdown, competitive match, seasonal demand, margin recovery).',
    `recommendation_status` STRING COMMENT 'Current state of the recommendation in the review workflow.. Valid values are `pending|accepted|rejected|overridden`',
    `recommendation_timestamp` TIMESTAMP COMMENT 'Exact date‑time the price optimization engine produced the recommendation.',
    `recommended_price` DECIMAL(18,2) COMMENT 'Proposed selling price for the SKU in the given store/zone, expressed in US dollars.',
    CONSTRAINT pk_pricing_recommendation PRIMARY KEY(`pricing_recommendation_id`)
) COMMENT 'Individual SKU-level price recommendation generated by the price optimization engine during a price_optimization_run. Captures recommended price, current price, expected margin impact, expected unit velocity change, confidence score, recommendation status (pending, accepted, rejected, overridden), reviewer ID, and override reason. Bridges algorithmic output with buyer review and approval workflows.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`channel_price` (
    `channel_price_id` BIGINT COMMENT 'System-generated unique identifier for the channel price record.',
    `associate_id` BIGINT COMMENT 'Identifier of the employee or manager who approved the price change.',
    `price_rule_id` BIGINT COMMENT 'Identifier of the pricing rule or algorithm that generated the price change, if applicable.',
    `sku_id` BIGINT COMMENT 'Unique identifier of the product SKU to which this channel price applies.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the price change was approved.',
    `channel_price` DECIMAL(18,2) COMMENT 'The price charged to the customer for the SKU in the specified channel, expressed in the applicable currency.',
    `channel_type` STRING COMMENT 'The sales channel for which the price override is defined (e.g., in‑store, e‑commerce, curbside pickup, delivery, third‑party marketplace).. Valid values are `in_store|ecommerce|curbside|delivery|third_party_marketplace`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the channel price record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the channel price (e.g., USD, CAD).',
    `effective_end_date` DATE COMMENT 'Date on which the channel price expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date on which the channel price becomes active.',
    `is_price_override` BOOLEAN COMMENT 'Indicates whether this price is an override to the default shelf price (true) or inherits the base price (false).',
    `price_change_justification` STRING COMMENT 'Free‑form text explaining the justification for the price change.',
    `price_change_reason` STRING COMMENT 'Business reason for the price adjustment (e.g., delivery surcharge, marketplace fee pass‑through).. Valid values are `delivery_surcharge|marketplace_fee|competitive_pricing|promotional|cost_increase`',
    `price_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the price value was last modified (distinct from record update timestamp).',
    `price_change_type` STRING COMMENT 'Method by which the price was changed: manual entry, automated rule, or algorithmic optimization.. Valid values are `manual|automated_rule|algorithmic`',
    `price_comment` STRING COMMENT 'Additional notes or comments related to the channel price.',
    `price_differential` DECIMAL(18,2) COMMENT 'Numeric difference between the channel price and the base shelf price (positive for surcharge, negative for discount).',
    `price_source_system` STRING COMMENT 'Originating system that supplied the channel price record.. Valid values are `oracle_pricing|sap_sd|salesforce|custom`',
    `price_status` STRING COMMENT 'Current lifecycle status of the channel price record.. Valid values are `active|inactive|scheduled|expired`',
    `price_version` STRING COMMENT 'Sequential version number for the channel price record to support change tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the channel price record.',
    CONSTRAINT pk_channel_price PRIMARY KEY(`channel_price_id`)
) COMMENT 'Defines channel-specific price overrides for SKUs sold through digital commerce, delivery, or pickup channels where pricing may differ from in-store shelf price. Captures channel type (in-store, eCommerce, curbside pickup, third-party delivery marketplace), channel price, currency code for multi-currency support, price differential versus shelf price, effective dates, and business justification (delivery surcharge, marketplace fee pass-through, competitive digital pricing). Supports omnichannel pricing consistency governance and regulatory compliance for price representation across channels.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`promo_price_link` (
    `promo_price_link_id` BIGINT COMMENT 'System-generated unique identifier for each promotional price link record.',
    `associate_id` BIGINT COMMENT 'Identifier of the user who approved the promotional price link.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Promotional pricing reports track promo effectiveness by category, needing a direct FK.',
    `order_channel_id` BIGINT COMMENT 'Identifier of the sales channel (e.g., in‑store, online, mobile) for which the promotion applies (optional).',
    `price_zone_id` BIGINT COMMENT 'Identifier of the geographic or market zone for zone‑based pricing (optional).',
    `promo_offer_id` BIGINT COMMENT 'Identifier of the promotion that this price link is associated with.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU (product) to which the promotional price applies.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store where the promotional price is effective (optional, null if not store‑specific).',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the promotional price link was approved.',
    `automation_rule_code` BIGINT COMMENT 'Identifier of the pricing automation rule that created this promotional price link.',
    `competitor_price_reference` STRING COMMENT 'Reference code or identifier for the competitor price used in competitive pricing analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the promotional price link record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the promotional price (e.g., USD, CAD).',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount subtracted from the regular price when discount_type is dollar.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage reduction applied to the regular price when discount_type is percent.',
    `discount_type` STRING COMMENT 'Mechanism of the discount (percentage off, dollar amount off, buy‑one‑get‑one, multi‑buy, or buy‑X‑get‑Y).. Valid values are `percent|dollar|bogo|multi_buy|buy_x_get_y`',
    `effective_end_date` DATE COMMENT 'Date when the promotional price expires.',
    `effective_start_date` DATE COMMENT 'Date when the promotional price becomes active.',
    `external_promo_price_link_code` STRING COMMENT 'Identifier used by external systems or partners for this promotional price link.',
    `ftc_compliance_notes` STRING COMMENT 'Notes documenting compliance with Federal Trade Commission pricing regulations.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the promotional price was generated automatically by pricing rules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the promotional price link record.',
    `minimum_advertised_price_flag` BOOLEAN COMMENT 'True if the promotion must respect a manufacturer‑set minimum advertised price.',
    `multi_buy_quantity` STRING COMMENT 'Quantity threshold for multi‑buy promotions (e.g., buy 3 for price of 2).',
    `notes` STRING COMMENT 'Additional remarks, comments, or audit notes related to the promotional price link.',
    `price_change_reason_code` STRING COMMENT 'Standardized code describing why the promotional price was created or changed.',
    `price_floor` DECIMAL(18,2) COMMENT 'Minimum allowable price for the SKU under any promotion to protect margin.',
    `price_lock_expiration_date` DATE COMMENT 'Date when a locked promotional price becomes editable again.',
    `price_lock_flag` BOOLEAN COMMENT 'True if the promotional price is locked from further changes until expiration.',
    `price_optimization_flag` BOOLEAN COMMENT 'Indicates whether the promotional price was generated by a price‑optimization algorithm.',
    `price_tier` STRING COMMENT 'Tier or segment classification for the promotional price (e.g., premium, economy).',
    `promo_price_link_description` STRING COMMENT 'Free‑form text describing the purpose or special conditions of the promotional price link.',
    `promo_price_link_status` STRING COMMENT 'Current lifecycle status of the promotional price link.. Valid values are `active|inactive|expired|pending`',
    `promotional_price` DECIMAL(18,2) COMMENT 'Final price of the SKU after applying the promotion, expressed in the transaction currency.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether the promotional price is eligible for Supplemental Nutrition Assistance Program transactions.',
    `source_system_code` STRING COMMENT 'Code identifying the source system that originated the promotional price link (e.g., ORACLE_PRICING, SAP_SD).',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this promotion can be stacked with other promotions such as TPRs.',
    `supersede_flag` BOOLEAN COMMENT 'Indicates whether this promotional price overrides any existing price (true) or co‑exists (false).',
    `tpr_flag` BOOLEAN COMMENT 'True if the promotion is a temporary price reduction (TPR) rather than a standard promotion.',
    `unit_of_measure` STRING COMMENT 'Unit in which the promotional price is expressed (e.g., each, lb, oz).',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether the promotional price is eligible for Women, Infants, and Children program transactions.',
    CONSTRAINT pk_promo_price_link PRIMARY KEY(`promo_price_link_id`)
) COMMENT 'Association entity linking a promotional offer (from the promotion domain) to its corresponding price effect on a SKU within the pricing domain. Captures the promotional price, discount type (BOGO, percent-off, dollar-off, multi-buy), price floor, effective dates, and whether the promotional price supersedes or stacks with a TPR. Ensures the pricing domain maintains a complete view of all active price-affecting events without duplicating promotion master data.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`price_batch` (
    `price_batch_id` BIGINT COMMENT 'System-generated unique identifier for the price batch record.',
    `associate_id` BIGINT COMMENT 'Identifier of the employee who approved the price batch.',
    `price_zone_id` BIGINT COMMENT 'Identifier of the pricing zone to which the batch applies.',
    `primary_price_associate_id` BIGINT COMMENT 'Identifier of the employee or system user who created and submitted the price batch.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Business process: Price change batches are often driven by supplier agreements; linking batch to supplier enables audit, compliance, and attribution of price changes to contracts.',
    `actual_run_timestamp` TIMESTAMP COMMENT 'Actual date‑time when the batch was executed.',
    `approval_status` STRING COMMENT 'Current approval state of the batch.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the batch was approved or rejected.',
    `batch_code` STRING COMMENT 'Human‑readable code or number assigned to the batch for tracking and reference.',
    `batch_owner_department` STRING COMMENT 'Business department responsible for the batch (e.g., Merchandising, Pricing Operations).',
    `batch_source_code` STRING COMMENT 'Code representing the originating system or process that generated the batch.',
    `batch_status` STRING COMMENT 'Overall processing state of the batch.. Valid values are `draft|submitted|in_review|approved|executed|cancelled`',
    `batch_type` STRING COMMENT 'Indicates the nature of the batch such as regular update, ad circular load, emergency price change, or scheduled price update.. Valid values are `regular|ad_circular|emergency|price_update`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary amounts in the batch.',
    `effective_date` DATE COMMENT 'Calendar date on which the price changes in the batch become active in stores and channels.',
    `ftc_compliance_notes` STRING COMMENT 'Notes related to Federal Trade Commission pricing compliance for the batch.',
    `is_emergency` BOOLEAN COMMENT 'True if the batch was created to address an emergency price change.',
    `is_rollback_enabled` BOOLEAN COMMENT 'Indicates whether the batch can be rolled back after execution.',
    `is_test_batch` BOOLEAN COMMENT 'Indicates whether the batch is a test run and not intended for live stores.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the batch record.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the batch.',
    `price_batch_description` STRING COMMENT 'Detailed description of the purpose and scope of the price batch.',
    `price_change_count` STRING COMMENT 'Number of individual price change records contained in the batch.',
    `priority_level` STRING COMMENT 'Priority assigned to the batch for processing order.. Valid values are `low|medium|high`',
    `rollback_timestamp` TIMESTAMP COMMENT 'Date‑time when a rollback of the batch was performed, if applicable.',
    `scheduled_run_timestamp` TIMESTAMP COMMENT 'Planned date‑time when the batch will be executed in the pricing engine.',
    `source_system` STRING COMMENT 'Originating system that generated the batch (e.g., SAP Retail, Oracle Merchandising).',
    `submission_timestamp` TIMESTAMP COMMENT 'Date‑time when the batch was submitted for processing.',
    `total_price_change_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary impact of all price changes in the batch.',
    `total_sku_count` STRING COMMENT 'Number of distinct SKUs included in the batch.',
    CONSTRAINT pk_price_batch PRIMARY KEY(`price_batch_id`)
) COMMENT 'Operational batch record grouping multiple price changes submitted together for a scheduled price update cycle (e.g., weekly ad price load, quarterly SRP review). Captures batch submission date, effective date, submitting buyer or category manager, approval status, total SKU count, batch source system, and batch type (regular, ad circular, emergency). Supports price change workflow management and rollback capabilities.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`compliance_audit` (
    `compliance_audit_id` BIGINT COMMENT 'Primary key for compliance_audit',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: FTC price compliance audits must be reported per legal entity for regulatory filing and audit trails.',
    `associate_id` BIGINT COMMENT 'Identifier of the employee or third‑party who performed the audit.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store where the audit was conducted.',
    `advertised_price_match_flag` BOOLEAN COMMENT 'True if advertised shelf price matches the regulated price.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the audit was formally approved.',
    `audit_category` STRING COMMENT 'High‑level category of the audit focus.. Valid values are `price|label|weight`',
    `audit_date` DATE COMMENT 'Calendar date of the audit (date component of audit_timestamp).',
    `audit_method` STRING COMMENT 'Indicates whether the audit was performed manually or by an automated system.. Valid values are `manual|automated`',
    `audit_number` STRING COMMENT 'Business identifier assigned to the audit for external reference and tracking.',
    `audit_result` STRING COMMENT 'Overall outcome of the audit.. Valid values are `pass|fail|partial`',
    `audit_scope` STRING COMMENT 'Scope of the audit (e.g., store, region, chain).',
    `audit_source_system` STRING COMMENT 'System of record that generated the audit (e.g., SAP Retail, Oracle Retail).',
    `audit_timestamp` TIMESTAMP COMMENT 'Exact date and time when the compliance audit was performed.',
    `audit_type` STRING COMMENT 'Specific type of pricing compliance audit.',
    `audit_version` STRING COMMENT 'Version number for the audit record to support re‑audits or updates.',
    `check_type` STRING COMMENT 'Category of compliance check performed.. Valid values are `scanner_accuracy|advertised_price|unit_pricing_label|weights_measures`',
    `compliance_audit_status` STRING COMMENT 'Current lifecycle status of the compliance audit.. Valid values are `pending|in_progress|completed|failed`',
    `compliance_notes` STRING COMMENT 'Additional observations or comments from the auditor.',
    `compliance_review_flag` BOOLEAN COMMENT 'Indicates whether the audit requires further compliance review.',
    `corrective_action_deadline` DATE COMMENT 'Target date by which corrective action must be completed.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action.. Valid values are `pending|completed|not_applicable`',
    `corrective_action_taken` STRING COMMENT 'Action performed to remediate the identified violation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for fine_amount (e.g., USD).',
    `documentation_url` STRING COMMENT 'Link to supporting documentation or evidence files.',
    `fine_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed for the violation, if any.',
    `is_critical` BOOLEAN COMMENT 'True if the violation is deemed critical to compliance risk.',
    `jurisdiction` STRING COMMENT 'State or local jurisdiction code (e.g., CA, NY) where the audit applies.',
    `regulatory_body` STRING COMMENT 'Governing authority whose pricing rules are being audited.. Valid values are `FTC|State|Local|EPA|FDA`',
    `related_regulation_code` STRING COMMENT 'Reference code of the specific regulation or statute being audited.',
    `remarks` STRING COMMENT 'Free‑form comments from the auditor or reviewer.',
    `resolution_date` DATE COMMENT 'Date when the corrective action was completed and the issue resolved.',
    `scanner_accuracy_flag` BOOLEAN COMMENT 'Indicates whether barcode scanner pricing matched system price (true=accurate).',
    `sku_count_audited` STRING COMMENT 'Number of distinct SKUs examined during the audit.',
    `unit_pricing_label_flag` BOOLEAN COMMENT 'True if unit‑price label complies with legal requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    `violation_count` STRING COMMENT 'Total number of pricing or labeling violations identified.',
    `violation_description` STRING COMMENT 'Narrative description of each violation discovered.',
    `weights_measures_inspection_flag` BOOLEAN COMMENT 'True if weight/measure labeling passes inspection.',
    CONSTRAINT pk_compliance_audit PRIMARY KEY(`compliance_audit_id`)
) COMMENT 'Operational compliance record tracking pricing regulation adherence across all applicable jurisdictions for advertised prices, scanner accuracy, and price representation. Captures compliance check type (scanner accuracy audit, advertised price verification, unit pricing label check, weights-and-measures inspection), check date, store location, SKU count audited, violation count, violation description, corrective action taken, resolution date, and regulatory body reference. Supports federal, state, and local regulatory reporting including FTC pricing rules, state consumer protection statutes, and weights-and-measures audit responses. Jurisdiction-neutral design accommodates multi-state and international regulatory requirements.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`price_override` (
    `price_override_id` BIGINT COMMENT 'System-generated unique identifier for each price override event.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Price overrides affect revenue postings; linking to a GL account enables proper accounting of override adjustments.',
    `payment_transaction_id` BIGINT COMMENT 'Identifier of the POS transaction to which this price override belongs.',
    `price_zone_id` BIGINT COMMENT 'Identifier of the pricing zone (e.g., geographic or channel zone) applicable to the transaction.',
    `associate_id` BIGINT COMMENT 'Identifier of the associate (cashier, manager, or self‑checkout system) who authorized the price override.',
    `sku_id` BIGINT COMMENT 'Unique identifier of the stock keeping unit (SKU) whose price was overridden.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the override occurred.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the override was approved by a manager or system.',
    `associate_role` STRING COMMENT 'Role of the associate who performed the override.. Valid values are `cashier|manager|self_checkout`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price override record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the price values.',
    `ftc_compliance_flag` BOOLEAN COMMENT 'Indicates whether the override complies with FTC scanner‑accuracy regulations (true = compliant).',
    `is_manual_override` BOOLEAN COMMENT 'True if the override was entered manually by an associate rather than automatically by a system rule.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price override record.',
    `line_sequence` STRING COMMENT 'Sequential order of the override line within the transaction.',
    `notes` STRING COMMENT 'Additional free‑form comments captured at the time of override.',
    `original_price` DECIMAL(18,2) COMMENT 'Registered shelf price of the SKU before the override, expressed in the stores currency.',
    `override_price` DECIMAL(18,2) COMMENT 'Price entered at the point of sale after the override, expressed in the stores currency.',
    `override_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the price override was entered at the POS.',
    `override_type` STRING COMMENT 'Category describing why the price was overridden.. Valid values are `manager|price_match|damaged_goods|customer_dispute|rain_check`',
    `price_difference` DECIMAL(18,2) COMMENT 'Calculated difference between override_price and original_price (override_price - original_price).',
    `price_override_status` STRING COMMENT 'Current processing state of the override record.. Valid values are `pending|approved|rejected|applied`',
    `quantity_override` STRING COMMENT 'Number of units of the SKU affected by the price override.',
    `reason_code` STRING COMMENT 'Internal code representing the specific reason for the override (e.g., R001 for damaged goods).',
    `reason_description` STRING COMMENT 'Free‑text description providing additional context for the override reason.',
    `shrink_indicator` BOOLEAN COMMENT 'True if the override is linked to a shrink investigation (e.g., damaged or missing inventory).',
    `source_system` STRING COMMENT 'Name of the operational system that originated the override (e.g., NCR POS, Oracle Retail).',
    CONSTRAINT pk_price_override PRIMARY KEY(`price_override_id`)
) COMMENT 'Records point-of-sale price overrides where a cashier, store manager, or self-checkout system applied a price different from the registered shelf price. Captures override type (manager override, price match, damaged goods, customer dispute, rain check), original price, override price, reason code, authorizing associate, store location, and POS transaction reference. Critical for FTC scanner accuracy compliance, shrink analysis, and cashier accountability.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`constraint_set` (
    `constraint_set_id` BIGINT COMMENT 'Primary key for constraint_set',
    `parent_constraint_set_id` BIGINT COMMENT 'Self-referencing FK on constraint_set (parent_constraint_set_id)',
    `applicability_scope` STRING COMMENT 'Scope level to which the constraint set applies (e.g., specific store, geographic region, sales channel, or SKU).',
    `constraint_set_code` STRING COMMENT 'Short alphanumeric code used in pricing rules and external integrations.',
    `constraint_set_name` STRING COMMENT 'Human‑readable name describing the purpose of the constraint set.',
    `constraint_set_type` STRING COMMENT 'Category of constraint, indicating the pricing logic it governs.',
    `constraint_value` DECIMAL(18,2) COMMENT 'Numeric threshold or factor applied by the constraint (e.g., minimum price, discount percent).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the constraint set record was first created in the system.',
    `constraint_set_description` STRING COMMENT 'Detailed free‑text description of the constraint sets business purpose and rules.',
    `effective_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the constraint set expires or is deactivated.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the constraint set becomes active for pricing calculations.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this constraint set is the default for its type when no specific set is assigned.',
    `notes` STRING COMMENT 'Additional free‑form comments or audit information entered by data stewards.',
    `priority` STRING COMMENT 'Integer indicating precedence when multiple constraint sets apply; lower numbers have higher priority.',
    `rule_expression` STRING COMMENT 'Serialized expression or script defining the logical rule of the constraint (e.g., SQL‑like or DSL).',
    `constraint_set_status` STRING COMMENT 'Current lifecycle state of the constraint set.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the constraint set record.',
    CONSTRAINT pk_constraint_set PRIMARY KEY(`constraint_set_id`)
) COMMENT 'Master reference table for constraint_set. Referenced by constraint_set_id.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`automation_rule` (
    `automation_rule_id` BIGINT COMMENT 'Primary key for automation_rule',
    `superseded_automation_rule_id` BIGINT COMMENT 'Self-referencing FK on automation_rule (superseded_automation_rule_id)',
    `action_expression` STRING COMMENT 'Expression that defines the pricing change or action applied when the condition is true.',
    `condition_expression` STRING COMMENT 'Logical expression evaluated to determine if the rule should fire.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule record was first created in the system.',
    `automation_rule_description` STRING COMMENT 'Detailed description of the rule purpose, logic and scope.',
    `effective_end_date` DATE COMMENT 'Calendar date on which the rule expires; null indicates an open‑ended rule.',
    `effective_start_date` DATE COMMENT 'Calendar date on which the rule becomes active.',
    `execution_count` BIGINT COMMENT 'Total number of times the rule has been executed.',
    `ftc_compliant` BOOLEAN COMMENT 'Indicates whether the rule adheres to FTC pricing compliance requirements.',
    `is_system_rule` BOOLEAN COMMENT 'True if the rule is maintained by the pricing engine; false if defined by business users.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule was last evaluated and applied.',
    `last_execution_result` STRING COMMENT 'Outcome of the most recent rule execution.',
    `automation_rule_name` STRING COMMENT 'Human‑readable name of the pricing automation rule.',
    `notes` STRING COMMENT 'Free‑form comments or operational notes about the rule.',
    `priority` STRING COMMENT 'Integer priority used to resolve conflicts when multiple rules are eligible; lower numbers indicate higher priority.',
    `rule_category` STRING COMMENT 'Higher‑level grouping of the rule (e.g., pricing, promotion, fuel).',
    `rule_owner_department` STRING COMMENT 'Business department responsible for the rules lifecycle.',
    `rule_type` STRING COMMENT 'Category of rule defining the pricing action it performs.',
    `rule_version` STRING COMMENT 'Semantic version identifier for the rule definition.',
    `automation_rule_status` STRING COMMENT 'Current lifecycle status of the rule.',
    `trigger_event` STRING COMMENT 'Event or condition that initiates rule evaluation.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that last modified the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the rule record.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the rule.',
    CONSTRAINT pk_automation_rule PRIMARY KEY(`automation_rule_id`)
) COMMENT 'Master reference table for automation_rule. Referenced by automation_rule_id.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`price_book` (
    `price_book_id` BIGINT COMMENT 'Primary key for price_book',
    `parent_price_book_id` BIGINT COMMENT 'Self-referencing FK on price_book (parent_price_book_id)',
    `channel` STRING COMMENT 'Sales channel(s) to which the price book applies.',
    `price_book_code` STRING COMMENT 'Business identifier code used to reference the price book in external systems.',
    `compliance_flag` BOOLEAN COMMENT 'True if the price book has been validated for FTC pricing compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price book record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code used for prices in this price book.',
    `price_book_description` STRING COMMENT 'Free‑form description providing context or notes about the price book.',
    `effective_end_date` DATE COMMENT 'Date when the price book expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the price book becomes effective for pricing calculations.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this price book is the default for its scope.',
    `price_book_name` STRING COMMENT 'Human‑readable name of the price book.',
    `notes` STRING COMMENT 'Supplemental free‑text notes or comments about the price book.',
    `price_book_owner` STRING COMMENT 'Business unit or team responsible for maintaining the price book.',
    `price_book_version` STRING COMMENT 'Incremental version number of the price book for change tracking.',
    `price_strategy` STRING COMMENT 'Algorithmic or rule‑based approach applied to calculate prices within the book.',
    `region` STRING COMMENT 'Geographic region scope for the price book.',
    `price_book_status` STRING COMMENT 'Current lifecycle status of the price book.',
    `store_type` STRING COMMENT 'Type of store or location where the price book is applicable.',
    `price_book_type` STRING COMMENT 'Classification of the price book indicating its pricing strategy category.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price book record.',
    CONSTRAINT pk_price_book PRIMARY KEY(`price_book_id`)
) COMMENT 'Master reference table for price_book. Referenced by price_book_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_price_batch_id` FOREIGN KEY (`price_batch_id`) REFERENCES `grocery_ecm`.`pricing`.`price_batch`(`price_batch_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ADD CONSTRAINT `fk_pricing_competitive_price_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ADD CONSTRAINT `fk_pricing_optimization_run_automation_rule_id` FOREIGN KEY (`automation_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`automation_rule`(`automation_rule_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ADD CONSTRAINT `fk_pricing_optimization_run_constraint_set_id` FOREIGN KEY (`constraint_set_id`) REFERENCES `grocery_ecm`.`pricing`.`constraint_set`(`constraint_set_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ADD CONSTRAINT `fk_pricing_pricing_recommendation_optimization_run_id` FOREIGN KEY (`optimization_run_id`) REFERENCES `grocery_ecm`.`pricing`.`optimization_run`(`optimization_run_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ADD CONSTRAINT `fk_pricing_pricing_recommendation_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ADD CONSTRAINT `fk_pricing_promo_price_link_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ADD CONSTRAINT `fk_pricing_price_batch_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`constraint_set` ADD CONSTRAINT `fk_pricing_constraint_set_parent_constraint_set_id` FOREIGN KEY (`parent_constraint_set_id`) REFERENCES `grocery_ecm`.`pricing`.`constraint_set`(`constraint_set_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`automation_rule` ADD CONSTRAINT `fk_pricing_automation_rule_superseded_automation_rule_id` FOREIGN KEY (`superseded_automation_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`automation_rule`(`automation_rule_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_book` ADD CONSTRAINT `fk_pricing_price_book_parent_price_book_id` FOREIGN KEY (`parent_price_book_id`) REFERENCES `grocery_ecm`.`pricing`.`price_book`(`price_book_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`pricing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `grocery_ecm`.`pricing` SET TAGS ('dbx_domain' = 'pricing');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` SET TAGS ('dbx_subdomain' = 'price_governance');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price ID');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `order_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone ID');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `competitor_price_reference` SET TAGS ('dbx_business_glossary_term' = 'Competitor Price Reference');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `competitor_price_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `cost_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Amount');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `cost_basis_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `external_price_code` SET TAGS ('dbx_business_glossary_term' = 'External Price ID');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `last_price_change_date` SET TAGS ('dbx_business_glossary_term' = 'Last Price Change Date');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `loyalty_member_price` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Price');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `minimum_advertised_price` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advertised Price (MAP)');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `multi_buy_price` SET TAGS ('dbx_business_glossary_term' = 'Multi-Buy Price');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `multi_buy_quantity` SET TAGS ('dbx_business_glossary_term' = 'Multi-Buy Quantity');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_change_count` SET TAGS ('dbx_business_glossary_term' = 'Price Change Count');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason Code');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_display_text` SET TAGS ('dbx_business_glossary_term' = 'Price Display Text');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_ending_convention` SET TAGS ('dbx_business_glossary_term' = 'Price Ending Convention');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_ending_convention` SET TAGS ('dbx_value_regex' = '^d{2}$');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_lock_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Expiration Date');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_optimization_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Optimization Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|archived');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|value|promotional|clearance|everyday_low');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_type_code` SET TAGS ('dbx_business_glossary_term' = 'Price Type Code');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_type_code` SET TAGS ('dbx_value_regex' = 'base|temporary|promotional|clearance|contract|dynamic');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `rounding_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rounding Rule Code');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `rounding_rule_code` SET TAGS ('dbx_value_regex' = 'none|nearest_nickel|nearest_dime|nearest_dollar|up|down');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'oracle_retail|sap_retail|manual_entry|price_optimization_engine|vendor_file');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `srp_amount` SET TAGS ('dbx_business_glossary_term' = 'Suggested Retail Price (SRP) Amount');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` SET TAGS ('dbx_subdomain' = 'cost_accounting');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `competitive_intensity` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intensity');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `competitive_intensity` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `competitive_price_match_policy` SET TAGS ('dbx_business_glossary_term' = 'Competitive Price Match Policy');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `competitive_price_match_policy` SET TAGS ('dbx_value_regex' = 'none|manual|automated|selective');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `cost_index` SET TAGS ('dbx_business_glossary_term' = 'Cost Index');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `fuel_pricing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Fuel Pricing Enabled');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `income_profile` SET TAGS ('dbx_business_glossary_term' = 'Income Profile');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `income_profile` SET TAGS ('dbx_value_regex' = 'low|medium|high|mixed');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `markdown_strategy` SET TAGS ('dbx_business_glossary_term' = 'Markdown Strategy');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `markdown_strategy` SET TAGS ('dbx_value_regex' = 'aggressive|moderate|conservative|none');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|metro|exurban|mixed');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `pharmacy_pricing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Pricing Enabled');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Factor');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_change_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approval Required');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_optimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Price Optimization Enabled');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'everyday_low|high_low|premium|discount|market_match|penetration');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `private_label_strategy` SET TAGS ('dbx_business_glossary_term' = 'Private Label Strategy');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `private_label_strategy` SET TAGS ('dbx_value_regex' = 'standard|premium|value|mixed');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `promotional_frequency` SET TAGS ('dbx_business_glossary_term' = 'Promotional Frequency');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `promotional_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|seasonal|event_driven');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `snap_ebt_volume_pct` SET TAGS ('dbx_business_glossary_term' = 'SNAP (Supplemental Nutrition Assistance Program) / EBT (Electronic Benefits Transfer) Volume Percentage');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `store_count` SET TAGS ('dbx_business_glossary_term' = 'Store Count');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `zone_description` SET TAGS ('dbx_business_glossary_term' = 'Zone Description');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Zone Status');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'competitive|geographic|demographic|cost_based|hybrid|promotional');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` SET TAGS ('dbx_subdomain' = 'price_governance');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `price_change_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `price_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Batch ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `primary_price_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Buyer ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Price Change Number');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason Code');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'cost_increase|competitive_response|seasonal|vendor_funded|markdown|clearance');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Price Change Type');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'regular|promotional|temporary|permanent|markdown');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'store|online|mobile|pickup|delivery');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `competitive_price_reference` SET TAGS ('dbx_business_glossary_term' = 'Competitive Price Reference');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `competitive_price_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `competitor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `compliance_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `cost_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Change Amount');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `cost_change_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `elasticity_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Price Elasticity Coefficient');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `elasticity_coefficient` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `forecasted_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Revenue Impact');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `forecasted_revenue_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `forecasted_volume_impact` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Volume Impact');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `forecasted_volume_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `margin_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Impact Percentage');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `margin_impact_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `new_price` SET TAGS ('dbx_business_glossary_term' = 'New Retail Price');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `old_price` SET TAGS ('dbx_business_glossary_term' = 'Old Retail Price');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `percent` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `price_optimization_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Optimization Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` SET TAGS ('dbx_subdomain' = 'price_governance');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `markdown_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `markdown_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Category Manager Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Rule Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Zone Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `actual_margin_impact` SET TAGS ('dbx_business_glossary_term' = 'Actual Gross Margin Impact');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `actual_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Actual Revenue Impact');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `actual_units_sold` SET TAGS ('dbx_business_glossary_term' = 'Actual Units Sold During Markdown');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `ad_circular_featured` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular Featured Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Markdown Absolute Amount');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Markdown Approval Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Markdown Cancellation Reason');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `days_on_shelf_threshold` SET TAGS ('dbx_business_glossary_term' = 'Days on Shelf Threshold');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `days_to_expiration_threshold` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiration Threshold');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Markdown Effective End Date');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Markdown Effective Start Date');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `estimated_margin_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Margin Impact');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `ftc_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Compliance Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `inventory_units_threshold` SET TAGS ('dbx_business_glossary_term' = 'Inventory Units Threshold');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Markdown Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `markdown_number` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Number');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `markdown_number` SET TAGS ('dbx_value_regex' = '^MD-[0-9]{8,12}$');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `markdown_status` SET TAGS ('dbx_business_glossary_term' = 'Markdown Status');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `markdown_status` SET TAGS ('dbx_value_regex' = 'planned|approved|active|completed|cancelled');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `markdown_type` SET TAGS ('dbx_business_glossary_term' = 'Markdown Type');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `markdown_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|clearance|seasonal|perishable');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Markdown Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Retail Price');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Markdown Percentage');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `planned_units_to_clear` SET TAGS ('dbx_business_glossary_term' = 'Planned Units to Clear');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `pos_signage_required` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Signage Required Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Markdown Retail Price');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Markdown Reason Code');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `reason` SET TAGS ('dbx_value_regex' = 'slow_mover|overstock|damage|expiration|seasonal_rotation|discontinued');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `sell_through_rate_threshold` SET TAGS ('dbx_business_glossary_term' = 'Sell-Through Rate Threshold Percentage');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `triggering_condition` SET TAGS ('dbx_business_glossary_term' = 'Markdown Triggering Condition');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` SET TAGS ('dbx_subdomain' = 'optimization_engine');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `tpr_id` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction ID');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Zone Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'TPR End Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'TPR Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction Price');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'system|manual|vendor');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'tpr|markdown|promotion');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'TPR Reason Code');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `regular_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Shelf Price');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'TPR Start Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `tpr_number` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction Number');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `tpr_status` SET TAGS ('dbx_business_glossary_term' = 'TPR Status');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `tpr_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|cancelled');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `vendor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` SET TAGS ('dbx_subdomain' = 'price_governance');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `competitive_price_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Price Record ID');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Competitor Store Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `competitive_price_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `competitive_price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Chain Name');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'numerator|datasembly|manual|webscrape');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `observation_method` SET TAGS ('dbx_business_glossary_term' = 'Observation Method');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `observation_method` SET TAGS ('dbx_value_regex' = 'scan|manual|api');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `observed_price` SET TAGS ('dbx_business_glossary_term' = 'Observed Competitor Price');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `our_price` SET TAGS ('dbx_business_glossary_term' = 'Grocery Shelf Price');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `plu` SET TAGS ('dbx_business_glossary_term' = 'Price Look‑Up Code (PLU)');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Change Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_gap` SET TAGS ('dbx_business_glossary_term' = 'Price Gap Amount');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_gap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Gap Percentage');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'regular|sale|clearance|promo|discount');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` SET TAGS ('dbx_subdomain' = 'cost_accounting');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Zone ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `applicable_category_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Category Code');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `applicable_department_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Department Code');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `competitive_index_cap` SET TAGS ('dbx_business_glossary_term' = 'Competitive Index Cap');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `gmroi_threshold` SET TAGS ('dbx_business_glossary_term' = 'GMROI Threshold');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `is_system_rule` SET TAGS ('dbx_business_glossary_term' = 'System Rule Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `margin_floor_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Floor Percentage');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rule Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Maximum Price (Ceiling)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_ending_convention` SET TAGS ('dbx_business_glossary_term' = 'Price Ending Convention');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_ending_convention` SET TAGS ('dbx_value_regex' = '99|95|00|49');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_floor` SET TAGS ('dbx_business_glossary_term' = 'Minimum Price (Floor)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Name');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Status');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Type');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'margin_floor|competitive_cap|edlp_flag|price_ending|markdown|dynamic_fuel');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` SET TAGS ('dbx_subdomain' = 'cost_accounting');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price ID');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `allowance_cost` SET TAGS ('dbx_business_glossary_term' = 'Allowance Cost (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `allowance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `base_cost` SET TAGS ('dbx_business_glossary_term' = 'Base Cost (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `base_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `buyer_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Buyer Acknowledged Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'weighted_average|fifo|lifo|standard_cost');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_change_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Change Approval Status');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_change_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_change_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Change Effective Date');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Cost Change Reason');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_change_source` SET TAGS ('dbx_business_glossary_term' = 'Cost Change Source');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_change_source` SET TAGS ('dbx_value_regex' = 'vendor|internal|system');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_reference` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Reference');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Status');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'standard|actual|replacement|forward_buy');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_version_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Version Number');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `is_freight_included` SET TAGS ('dbx_business_glossary_term' = 'Freight Included Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `is_tax_included` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `landed_cost` SET TAGS ('dbx_business_glossary_term' = 'Landed Cost (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `landed_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `margin_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Margin Impact Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `original_cost` SET TAGS ('dbx_business_glossary_term' = 'Original Cost (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `original_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `price_optimization_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Optimization Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `retail_price_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Action Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `source_document_date` SET TAGS ('dbx_business_glossary_term' = 'Source Document Date');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `source_document_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` SET TAGS ('dbx_subdomain' = 'optimization_engine');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `optimization_run_id` SET TAGS ('dbx_business_glossary_term' = 'Optimization Run ID');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `automation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Rule Identifier (AUTOMATION_RULE_ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `constraint_set_id` SET TAGS ('dbx_business_glossary_term' = 'Constraint Set Identifier (CS_ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (REVIEWER_ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `acceptance_rate` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Rate Percentage (ACC_RATE)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `accepted_recommendations_count` SET TAGS ('dbx_business_glossary_term' = 'Accepted Recommendations Count (ACC_RECS)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Approval Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `confidence_interval_high` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval High (CI_HIGH)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `confidence_interval_low` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Low (CI_LOW)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score (CONF_SCORE)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source for Optimization (DATA_SRC)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'POS|eCommerce|WMS|ERP');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `estimated_margin_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Margin Impact (EST_MRG_IMPACT)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact (EST_REV_IMPACT)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `estimated_units_change` SET TAGS ('dbx_business_glossary_term' = 'Estimated Units Change (EST_UNITS_CHG)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `estimated_velocity_change` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Velocity Change (EST_VEL_CHG)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `ftc_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'FTC Compliance Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `model_execution_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Model Execution Time Milliseconds (EXEC_TIME_MS)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `model_input_data_version` SET TAGS ('dbx_business_glossary_term' = 'Model Input Data Version (INPUT_VER)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `model_output_data_version` SET TAGS ('dbx_business_glossary_term' = 'Model Output Data Version (OUTPUT_VER)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Version (VER)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `overridden_recommendations_count` SET TAGS ('dbx_business_glossary_term' = 'Overridden Recommendations Count (OVR_RECS)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Type (STRATEGY_TYPE)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'SRP|markdown|dynamic|zone|competitive');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `recommendation_status` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Status');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `recommendation_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|overridden');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `rejected_recommendations_count` SET TAGS ('dbx_business_glossary_term' = 'Rejected Recommendations Count (REJ_RECS)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `run_code` SET TAGS ('dbx_business_glossary_term' = 'Run Code');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration Seconds (DURATION_SEC)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `run_scope` SET TAGS ('dbx_business_glossary_term' = 'Run Scope (e.g., Department, Category, Zone)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `run_scope` SET TAGS ('dbx_value_regex' = 'department|category|zone|store');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'draft|running|completed|failed|cancelled');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `sku_evaluated_count` SET TAGS ('dbx_business_glossary_term' = 'Number of SKUs Evaluated (SKU_COUNT)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `total_sku_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Total SKU Recommendations (TOTAL_RECS)');
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` SET TAGS ('dbx_subdomain' = 'optimization_engine');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `pricing_recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation ID');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `optimization_run_id` SET TAGS ('dbx_business_glossary_term' = 'Price Optimization Run ID');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Zone Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Version');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `current_price` SET TAGS ('dbx_business_glossary_term' = 'Current Price (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `expected_margin_impact` SET TAGS ('dbx_business_glossary_term' = 'Expected Margin Impact (Pct)');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `expected_unit_velocity_change` SET TAGS ('dbx_business_glossary_term' = 'Expected Unit Velocity Change (Pct)');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `recommendation_status` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Status');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `recommendation_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|overridden');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `recommendation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Generation Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ALTER COLUMN `recommended_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Price (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` SET TAGS ('dbx_subdomain' = 'price_governance');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_price_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Price ID');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Rule Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_price` SET TAGS ('dbx_business_glossary_term' = 'Channel Price Amount');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'in_store|ecommerce|curbside|delivery|third_party_marketplace');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `is_price_override` SET TAGS ('dbx_business_glossary_term' = 'Is Price Override Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_change_justification` SET TAGS ('dbx_business_glossary_term' = 'Price Change Justification');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_value_regex' = 'delivery_surcharge|marketplace_fee|competitive_pricing|promotional|cost_increase');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Change Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_change_type` SET TAGS ('dbx_business_glossary_term' = 'Price Change Type');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_change_type` SET TAGS ('dbx_value_regex' = 'manual|automated_rule|algorithmic');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_comment` SET TAGS ('dbx_business_glossary_term' = 'Price Comment');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_source_system` SET TAGS ('dbx_business_glossary_term' = 'Price Source System');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_source_system` SET TAGS ('dbx_value_regex' = 'oracle_pricing|sap_sd|salesforce|custom');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|scheduled|expired');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_version` SET TAGS ('dbx_business_glossary_term' = 'Price Version Number');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` SET TAGS ('dbx_subdomain' = 'price_governance');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `promo_price_link_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Link Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `order_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `automation_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Automation Rule Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `competitor_price_reference` SET TAGS ('dbx_business_glossary_term' = 'Competitor Price Reference');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percent|dollar|bogo|multi_buy|buy_x_get_y');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective End Date');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective Start Date');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `external_promo_price_link_code` SET TAGS ('dbx_business_glossary_term' = 'External Promotional Price Link Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `ftc_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'FTC Compliance Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automation Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `minimum_advertised_price_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advertised Price Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `multi_buy_quantity` SET TAGS ('dbx_business_glossary_term' = 'Multi‑Buy Quantity');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Link Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `price_change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason Code');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `price_floor` SET TAGS ('dbx_business_glossary_term' = 'Price Floor');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `price_lock_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Expiration Date');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `price_lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `price_optimization_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Optimization Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `promo_price_link_description` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Link Description');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `promo_price_link_status` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Link Status');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `promo_price_link_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `promotional_price` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'SNAP Eligibility Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `supersede_flag` SET TAGS ('dbx_business_glossary_term' = 'Supersede Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `tpr_flag` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'WIC Eligibility Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` SET TAGS ('dbx_subdomain' = 'compliance_audit');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `price_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Price Batch Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Approver Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `primary_price_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Submitter Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `actual_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Run Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Approval Status');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Approval Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `batch_code` SET TAGS ('dbx_business_glossary_term' = 'Price Batch Code');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `batch_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Batch Owner Department');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `batch_source_code` SET TAGS ('dbx_business_glossary_term' = 'Batch Source Code');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Lifecycle Status');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|in_review|approved|executed|cancelled');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Price Batch Type');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'regular|ad_circular|emergency|price_update');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Effective Date');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `ftc_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'FTC Compliance Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Batch Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `is_rollback_enabled` SET TAGS ('dbx_business_glossary_term' = 'Rollback Enabled Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `is_test_batch` SET TAGS ('dbx_business_glossary_term' = 'Test Batch Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Batch Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `price_batch_description` SET TAGS ('dbx_business_glossary_term' = 'Batch Description');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `price_change_count` SET TAGS ('dbx_business_glossary_term' = 'Price Change Count');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Batch Priority Level');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `rollback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rollback Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `scheduled_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Run Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Submission Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `total_price_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Price Change Amount');
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ALTER COLUMN `total_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Total SKU Count');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` SET TAGS ('dbx_subdomain' = 'compliance_audit');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `compliance_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID (AUDITOR_ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID (STORE_ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `advertised_price_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Advertised Price Match Flag (AD_PRICE_OK)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category (AUDIT_CAT)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'price|label|weight');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date (AUDIT_DATE)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method (AUDIT_METHOD)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_value_regex' = 'manual|automated');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result (AUDIT_RESULT)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope (AUDIT_SCOPE)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Audit Source System (SOURCE_SYS)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Timestamp (AUDIT_TS)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `audit_version` SET TAGS ('dbx_business_glossary_term' = 'Audit Version (AUDIT_VER)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `check_type` SET TAGS ('dbx_business_glossary_term' = 'Check Type (CHECK_TYPE)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `check_type` SET TAGS ('dbx_value_regex' = 'scanner_accuracy|advertised_price|unit_pricing_label|weights_measures');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (STATUS)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (COMPLIANCE_NOTES)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `compliance_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Flag (REVIEW_FLAG)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline (DEADLINE_DATE)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (ACTION_STATUS)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_applicable');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken (CORR_ACTION)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (DOC_URL)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `fine_amount` SET TAGS ('dbx_business_glossary_term' = 'Fine Amount (FINE_AMT)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Violation Flag (CRITICAL_FLAG)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JURISDICTION)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FTC|State|Local|EPA|FDA');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `related_regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Related Regulation Code (REG_CODE)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks (REMARKS)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date (RESOLUTION_DATE)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `scanner_accuracy_flag` SET TAGS ('dbx_business_glossary_term' = 'Scanner Accuracy Flag (SCANNER_OK)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `sku_count_audited` SET TAGS ('dbx_business_glossary_term' = 'SKU Count Audited (SKU_COUNT)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `unit_pricing_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Unit Pricing Label Flag (UNIT_LABEL_OK)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count (VIOL_COUNT)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description (VIOL_DESC)');
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ALTER COLUMN `weights_measures_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Weights & Measures Inspection Flag (WGT_MEAS_OK)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` SET TAGS ('dbx_subdomain' = 'compliance_audit');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `price_override_id` SET TAGS ('dbx_business_glossary_term' = 'Price Override ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Associate ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `associate_role` SET TAGS ('dbx_business_glossary_term' = 'Associate Role');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `associate_role` SET TAGS ('dbx_value_regex' = 'cashier|manager|self_checkout');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `ftc_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'FTC Compliance Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Indicator');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Override Notes');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Shelf Price (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `override_price` SET TAGS ('dbx_business_glossary_term' = 'Override Price (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `override_type` SET TAGS ('dbx_business_glossary_term' = 'Override Type');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `override_type` SET TAGS ('dbx_value_regex' = 'manager|price_match|damaged_goods|customer_dispute|rain_check');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `price_difference` SET TAGS ('dbx_business_glossary_term' = 'Price Difference (USD)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `price_override_status` SET TAGS ('dbx_business_glossary_term' = 'Override Status');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `price_override_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|applied');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `quantity_override` SET TAGS ('dbx_business_glossary_term' = 'Quantity Override');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `shrink_indicator` SET TAGS ('dbx_business_glossary_term' = 'Shrink Indicator');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`pricing`.`constraint_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pricing`.`constraint_set` SET TAGS ('dbx_subdomain' = 'reference_catalog');
ALTER TABLE `grocery_ecm`.`pricing`.`constraint_set` ALTER COLUMN `constraint_set_id` SET TAGS ('dbx_business_glossary_term' = 'Constraint Set Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`constraint_set` ALTER COLUMN `parent_constraint_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`automation_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pricing`.`automation_rule` SET TAGS ('dbx_subdomain' = 'reference_catalog');
ALTER TABLE `grocery_ecm`.`pricing`.`automation_rule` ALTER COLUMN `automation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Rule Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`automation_rule` ALTER COLUMN `superseded_automation_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`pricing`.`price_book` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pricing`.`price_book` SET TAGS ('dbx_subdomain' = 'reference_catalog');
ALTER TABLE `grocery_ecm`.`pricing`.`price_book` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`price_book` ALTER COLUMN `parent_price_book_id` SET TAGS ('dbx_self_ref_fk' = 'true');
