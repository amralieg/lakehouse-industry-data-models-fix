-- Schema for Domain: pricing | Business: Grocery | Version: v1_mvm
-- Generated on: 2026-05-04 20:42:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`pricing` COMMENT 'Price management across all channels including SRP, competitive pricing, zone pricing, markdown strategies, and dynamic fuel pricing. Manages price changes, promotional pricing linkages, ASP analytics, and price optimization algorithms. Supports competitive intelligence integration and ensures FTC pricing compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`retail_price` (
    `retail_price_id` BIGINT COMMENT 'Unique identifier for the retail price record. Primary key for the retail price entity.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Category‑Level Price Optimization report requires linking each retail_price to its category for margin analysis and pricing strategy.',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: retail_price.cost_basis_amount is a denormalized copy of the vendor invoice cost used for margin calculation. cost_price is the authoritative COGS record per SKU. Adding cost_price_id FK allows retail',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Retail prices are associated with revenue GL accounts for sales financial reporting and margin analysis. In retail-grocery, each price point maps to a revenue account (grocery, produce, pharmacy) enab',
    `new_item_intro_id` BIGINT COMMENT 'Foreign key linking to assortment.new_item_intro. Business justification: New item introductions require initial retail price setup — the suggested_retail_price on new_item_intro drives the first retail_price record created. Pricing teams reference the new item intro record',
    `price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.price_rule. Business justification: retail_price has rounding_rule_code and price_ending_convention which are pricing rule attributes defined on price_rule. Adding price_rule_id FK links the SRP record to the governing business rule tha',
    `price_zone_id` BIGINT COMMENT 'Identifier for the geographic or market-based price zone where this retail price is effective. Supports zone-based pricing strategies.',
    `sku_id` BIGINT COMMENT 'Identifier for the SKU to which this retail price applies. Links to the product master.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Business process: Supplier Suggested Retail Price (SRP) is used as a baseline in retail_price; linking SRP to supplier supports price‑setting and supplier performance analysis.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this retail price was approved for activation. Part of the pricing workflow audit trail.',
    `competitor_price_reference` DECIMAL(18,2) COMMENT 'The most recent competitive price benchmark for this SKU from competitive intelligence sources. Used for price positioning and competitive response strategies.',
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
    `price_lock_expiration_date` DATE COMMENT 'The date when the price lock expires and normal pricing governance resumes. Nullable if no lock is in place.',
    `price_lock_flag` BOOLEAN COMMENT 'Indicates whether this price is locked and cannot be changed without executive approval. Used for contract pricing, vendor agreements, and strategic items.',
    `price_optimization_flag` BOOLEAN COMMENT 'Indicates whether this price was set by an automated price optimization algorithm (true) or manually by a pricing analyst (false). Supports AI/ML pricing governance.',
    `price_status` STRING COMMENT 'Current lifecycle status of the retail price record. Active prices are used in POS transactions; pending prices await activation; expired prices are historical.. Valid values are `active|pending|expired|suspended|archived`',
    `price_tier` STRING COMMENT 'Classification of the pricing strategy tier for this SKU (e.g., standard, premium, value, promotional, clearance, everyday low price). Supports price positioning and markdown analytics.. Valid values are `standard|premium|value|promotional|clearance|everyday_low`',
    `price_type_code` STRING COMMENT 'Classification of the price type distinguishing base prices from temporary price reductions (TPR), promotional prices, clearance prices, and dynamic prices. Critical for price hierarchy and promotional linkage.. Valid values are `base|temporary|promotional|clearance|contract|dynamic`',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is eligible for purchase using SNAP/EBT benefits. Required for government assistance program compliance and POS transaction processing.',
    `source_system_code` STRING COMMENT 'The operational system or process that originated this retail price record (e.g., Oracle Retail Price Management, SAP Retail, manual entry, price optimization engine). Supports data lineage and reconciliation.. Valid values are `oracle_retail|sap_retail|manual_entry|price_optimization_engine|vendor_file`',
    `srp_amount` DECIMAL(18,2) COMMENT 'The base shelf price for the SKU in this zone and channel, excluding any promotional or temporary price reductions. This is the single source of truth for item-level retail pricing.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for which the retail price is defined (e.g., each, pound, kilogram). Critical for produce and bulk items sold by weight. [ENUM-REF-CANDIDATE: each|pound|kilogram|ounce|liter|gallon|case|pack|dozen — 9 candidates stripped; promote to reference product]',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is eligible for purchase using WIC benefits. Required for government assistance program compliance and POS transaction processing.',
    CONSTRAINT pk_retail_price PRIMARY KEY(`retail_price_id`)
) COMMENT 'Authoritative master record of the current shelf price (SRP) for every SKU within a specific price zone and channel. Captures base retail price, effective and expiration dates, price zone assignment, unit of measure, price tier, and price-ending convention. Serves as the single source of truth for item-level retail pricing and the foundation for all price change, markdown, TPR, and promotional pricing workflows.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`price_zone` (
    `price_zone_id` BIGINT COMMENT 'Primary key for price_zone',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Price zones in retail-grocery align with profit centers for financial performance reporting by market/region. Zone-level pricing strategy decisions are evaluated against profit center P&L results, req',
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
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Price Change Impact Dashboard aggregates changes by category to assess competitive response and margin effect.',
    `competitive_price_id` BIGINT COMMENT 'Foreign key linking to pricing.competitive_price. Business justification: price_change has competitive_price_reference (DECIMAL) and competitor_name (STRING) — denormalized competitive intelligence data. Many price changes are triggered by competitive observations. Adding c',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Price changes often depend on the underlying cost basis; linking to cost_price captures the cost record driving the price change and provides a direct relationship.',
    `new_item_intro_id` BIGINT COMMENT 'Foreign key linking to assortment.new_item_intro. Business justification: New item introductions generate the first price change record for a SKU — the initial price activation is a price_change event tied to the new_item_intro approval. Grocery pricing teams track new item',
    `planogram_id` BIGINT COMMENT 'Foreign key linking to assortment.planogram. Business justification: Planogram resets are a primary trigger for price changes in grocery — new planogram activations prompt competitive repricing and shelf-tag updates. Price change records need to reference the planogram',
    `price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.price_rule. Business justification: price_change records approved price change events. Each price change should be traceable to the governing price_rule that authorized or triggered it (e.g., cost-driven rule, competitive rule, margin r',
    `price_zone_id` BIGINT COMMENT 'Identifier of the geographic or competitive price zone where this price change applies.',
    `promo_offer_id` BIGINT COMMENT 'Identifier linking this price change to a promotional campaign if the change is promotion-driven. Nullable for non-promotional changes.',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: price_change is a transactional record of an approved price change event that modifies the SRP for a SKU in a price zone. retail_price is the master SRP record being changed. price_change is a child o',
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
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: markdown records planned and executed markdown events with estimated and actual margin impact fields. To accurately calculate margin impact, markdown needs the authoritative COGS basis from cost_price',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Markdown accruals and actual margin impacts are reported by fiscal period for financial close in retail-grocery. Period-end markdown reserve calculations and variance reporting require linking markdow',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Markdowns generate markdown expense postings to specific GL accounts (shrink, markdown reserve, clearance expense). Retail-grocery finance teams require GL account assignment on markdowns for P&L impa',
    `planogram_id` BIGINT COMMENT 'Foreign key linking to assortment.planogram. Business justification: Planogram resets trigger markdown clearance events in grocery — discontinued items identified during planogram changes require markdown execution. Markdown managers need to link clearance activity to ',
    `price_rule_id` BIGINT COMMENT 'The identifier of the automated markdown rule that triggered this event. Null if manually created.',
    `price_zone_id` BIGINT COMMENT 'The pricing zone to which this markdown applies. Null if markdown is store-specific or enterprise-wide.',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: markdown records a planned or executed markdown event that reduces the price of a SKU. retail_price is the master SRP record being marked down. markdown is a child of retail_price — it operates on a s',
    `sku_id` BIGINT COMMENT 'The SKU subject to this markdown event.',
    `store_location_id` BIGINT COMMENT 'The store where this markdown is applied. Null if markdown applies to a zone or all stores.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Business process: Supplier‑funded markdowns (allowances) are tracked per markdown record; linking to supplier captures funding source for margin and compliance reporting.',
    `trade_allowance_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_allowance. Business justification: Vendor-funded markdowns (clearance support, seasonal markdown allowances) must be traceable to the specific trade_allowance funding them. This supports vendor markdown accrual accounting and settlemen',
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
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: tpr has vendor_funded_flag indicating some TPRs are funded by vendor allowances. cost_price contains allowance_cost and base_cost for the SKU. Adding cost_price_id to tpr links each TPR event to the a',
    `price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.price_rule. Business justification: TPR events are governed by business pricing rules that define guardrails such as minimum margin floors, price ceilings, and competitive index caps. Adding price_rule_id to tpr links each TPR event to ',
    `price_zone_id` BIGINT COMMENT 'Identifier of the geographic pricing zone for the TPR. Null if store‑specific.',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: tpr (Temporary Price Reduction) is a short-term shelf price reduction applied to a SKU. retail_price is the master SRP record being temporarily reduced. tpr is a child of retail_price — it temporarily',
    `sku_id` BIGINT COMMENT 'Identifier of the stock keeping unit to which the TPR applies.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store where the TPR is scoped. Null if the TPR is zone‑wide.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor providing funding for the TPR, if applicable.',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: TPRs are negotiated at the vendor item level (specific GTIN/pack size). Linking tpr to vendor_item enables vendor TPR reconciliation — validating that the discounted item matches the vendor item terms',
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
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: competitive_price stores competitor price observations for key SKUs in price zones. our_price on competitive_price is a denormalized snapshot of our current SRP for price gap calculation. Adding retai',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Competitive price gap analysis by SKU is a core grocery pricing process. competitive_price has plain-text sku, upc, plu columns — denormalized references to product.sku. A retail pricing analyst expec',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: Competitive price intelligence is organized and analyzed at the store cluster level in grocery — clusters define the competitive market unit. Pricing analysts aggregate competitive observations by clu',
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
    `price_change_flag` BOOLEAN COMMENT 'Indicates whether the observed price differs from the previous observation for the same SKU and competitor.',
    `price_gap` DECIMAL(18,2) COMMENT 'Difference between competitor price and Grocerys price (competitor - ours).',
    `price_gap_percentage` DOUBLE COMMENT 'Relative price gap expressed as a percentage of Grocerys price.',
    `price_type` STRING COMMENT 'Classification of the observed price (e.g., regular shelf, promotional, clearance).. Valid values are `regular|sale|clearance|promo|discount`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this competitive price record was first loaded into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this competitive price record.',
    CONSTRAINT pk_competitive_price PRIMARY KEY(`competitive_price_id`)
) COMMENT 'Stores competitive intelligence price observations for key SKUs and PLUs captured from competitor stores, third-party price intelligence feeds (e.g., Numerator, Datasembly), or manual audits. Captures competitor store identifier, competitor chain name, observed price, observed date, data source, and price gap versus Grocerys current shelf price. Feeds competitive pricing response workflows and price optimization algorithms.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`price_rule` (
    `price_rule_id` BIGINT COMMENT 'Unique identifier for the pricing rule.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Pricing rules are often scoped to specific categories; linking enables rule‑to‑category enforcement and audit.',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Grocery price rules are scoped to item hierarchy nodes (e.g., margin floor for entire Produce department). applicable_category_code and applicable_department_code are denormalized hierarchy references',
    `price_zone_id` BIGINT COMMENT 'Geographic or store zone identifier where the rule applies.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Pricing rules are scoped to profit centers to enable profit‑center profitability analysis and budgeting.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Price rule activation tied to promotion campaigns for automated price adjustments during campaign periods.',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: Price rules in grocery retail are defined at the store cluster level — clusters with different competitive intensities require distinct pricing rules. Pricing analysts scope rules by cluster for clust',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Business process: Supplier‑specific pricing rules (margin floors, discounts) are defined in price_rule for price optimization. Retail‑grocery pricing teams need to link each rule to its supplier.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Trade agreements with MAP (minimum advertised price) or SRP compliance requirements directly constrain price rules. Linking price_rule to trade_agreement enables MAP compliance enforcement and SRP rul',
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
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Cost prices must be mapped to COGS GL accounts for financial reporting and cost accounting. In retail-grocery, every cost record posts to a specific GL account for P&L and inventory valuation. gl_acco',
    `sku_id` BIGINT COMMENT 'Identifier of the product (SKU) to which this cost applies.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor supplying the product.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier_site. Business justification: Cost prices vary by supplier site due to site-specific freight costs and landed cost calculations (cost_price has freight_cost, landed_cost). Linking cost_price to supplier_site enables DSD vs. wareho',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Trade agreements define cost terms (payment terms, rebates, MOQ) that govern cost_price records. Linking cost_price to trade_agreement enables contract compliance reporting and cost audit trails — nam',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: cost_price records are sourced from specific vendor_item records (GTIN, pack size, case cost). Linking cost_price to vendor_item enables cost audit trails and vendor cost dispute resolution — named pr',
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

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`channel_price` (
    `channel_price_id` BIGINT COMMENT 'System-generated unique identifier for the channel price record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Omnichannel revenue recognition in retail-grocery requires channel-specific GL account mapping (in-store vs. delivery vs. pickup post to different revenue accounts). channel_price.gl_account_id enable',
    `price_rule_id` BIGINT COMMENT 'Identifier of the pricing rule or algorithm that generated the price change, if applicable.',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: channel_price defines channel-specific price overrides (digital, delivery, pickup) for SKUs. retail_price is the base SRP from which channel prices deviate. channel_price is a child of retail_price — ',
    `sku_id` BIGINT COMMENT 'Unique identifier of the product SKU to which this channel price applies.',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: Omnichannel grocery pricing varies by store cluster — delivery and pickup price differentials are set at the cluster level based on competitive intensity and demographic profile. channel_price has no ',
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

CREATE OR REPLACE TABLE `grocery_ecm`.`pricing`.`price_override` (
    `price_override_id` BIGINT COMMENT 'System-generated unique identifier for each price override event.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Price overrides affect revenue postings; linking to a GL account enables proper accounting of override adjustments.',
    `price_zone_id` BIGINT COMMENT 'Identifier of the pricing zone (e.g., geographic or channel zone) applicable to the transaction.',
    `product_order_line_id` BIGINT COMMENT 'Foreign key linking to product.product_order_line. Business justification: Loss-prevention and shrink-control reporting requires linking manual price overrides to the specific order line where the override was applied. price_override.shrink_indicator confirms this audit need',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: price_override records POS price overrides where a cashier or manager overrides the shelf price. retail_price is the authoritative SRP being overridden. price_override is a child of retail_price — it ',
    `sku_id` BIGINT COMMENT 'Unique identifier of the stock keeping unit (SKU) whose price was overridden.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the override occurred.',
    `transaction_id` BIGINT COMMENT 'Identifier of the POS transaction to which this price override belongs.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_competitive_price_id` FOREIGN KEY (`competitive_price_id`) REFERENCES `grocery_ecm`.`pricing`.`competitive_price`(`competitive_price_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ADD CONSTRAINT `fk_pricing_competitive_price_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ADD CONSTRAINT `fk_pricing_competitive_price_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`pricing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `grocery_ecm`.`pricing` SET TAGS ('dbx_domain' = 'pricing');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price ID');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `new_item_intro_id` SET TAGS ('dbx_business_glossary_term' = 'New Item Intro Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone ID');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `competitor_price_reference` SET TAGS ('dbx_business_glossary_term' = 'Competitor Price Reference');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `competitor_price_reference` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_lock_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Expiration Date');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_optimization_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Optimization Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|archived');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|value|promotional|clearance|everyday_low');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_type_code` SET TAGS ('dbx_business_glossary_term' = 'Price Type Code');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `price_type_code` SET TAGS ('dbx_value_regex' = 'base|temporary|promotional|clearance|contract|dynamic');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'oracle_retail|sap_retail|manual_entry|price_optimization_engine|vendor_file');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `srp_amount` SET TAGS ('dbx_business_glossary_term' = 'Suggested Retail Price (SRP) Amount');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` SET TAGS ('dbx_subdomain' = 'competitive_intelligence');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `price_change_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `competitive_price_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `new_item_intro_id` SET TAGS ('dbx_business_glossary_term' = 'New Item Intro Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` SET TAGS ('dbx_subdomain' = 'competitive_intelligence');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `markdown_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Rule Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Zone Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier (ID)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ALTER COLUMN `trade_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Allowance Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` SET TAGS ('dbx_subdomain' = 'competitive_intelligence');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `tpr_id` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction ID');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Zone Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` SET TAGS ('dbx_subdomain' = 'competitive_intelligence');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `competitive_price_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Price Record ID');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Change Flag');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_gap` SET TAGS ('dbx_business_glossary_term' = 'Price Gap Amount');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_gap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Gap Percentage');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'regular|sale|clearance|promo|discount');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Zone ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price ID');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` SET TAGS ('dbx_subdomain' = 'price_management');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `channel_price_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Price ID');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Rule Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` SET TAGS ('dbx_subdomain' = 'competitive_intelligence');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `price_override_id` SET TAGS ('dbx_business_glossary_term' = 'Price Override ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Order Line Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
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
