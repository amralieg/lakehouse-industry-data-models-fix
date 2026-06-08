-- Schema for Domain: promotion | Business: Consumer Goods | Version: v1_mvm
-- Generated on: 2026-05-05 11:04:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `consumer_goods_ecm`.`promotion` COMMENT 'Owns trade promotion planning, execution, and optimization (TPM/TPO). Manages promotional calendars, trade spend allocation, retailer funding agreements, promotional pricing (Hi-Lo, EDLP), accruals, deductions, post-event analysis, promotional lift measurement, ROI/GMROI analysis, and retailer rebate settlements. Integrates with Salesforce TPM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` (
    `trade_promotion_id` BIGINT COMMENT 'Unique identifier for the trade promotion program. Primary key for the trade promotion entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: In CPG integrated commercial planning, trade promotions are created in direct support of marketing campaigns (e.g., new product launch, seasonal campaign). Linking trade_promotion to campaign enables ',
    `category_id` BIGINT COMMENT 'Identifier of the product category covered by this trade promotion. Links to the product category master entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Trade promotions are executed within a specific legal entity (company code) for financial reporting, intercompany settlement, and statutory compliance. Multinational Consumer Goods companies require c',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Trade promotion approval requires linking to the specific compliance obligation that governs the promoted product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Trade promotion budgets are allocated to cost centers for P&L reporting and trade spend management. Consumer Goods finance teams track authorized_budget_amount and accrual_amount by cost center. Domai',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Trade promotions are planned and approved against finance budgets. Budget vs. actual trade spend reporting is a core Consumer Goods finance control. authorized_budget_amount on trade_promotion must re',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Trade promotion accruals post to specific GL accounts (trade spend accrual, variable trade expense). Consumer Goods finance requires this link for accrual posting, period-end close, and audit trail fr',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Trade promotions must comply with jurisdiction-specific promotional regulations (e.g., US Robinson-Patman Act, EU pricing disclosure rules). Compliance teams validate each promotion against the govern',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.pricing_agreement. Business justification: Trade promotions are authorized under pricing agreements that define promotional allowance rates and contracted net prices. TPM analysts must trace each trade promotion to the governing pricing agreem',
    `product_brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Trade promotions in consumer goods are planned and budgeted at the product brand level — brand P&L owners own trade spend. This link enables brand-level trade promotion planning, spend reporting, and ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Trade promotions are tracked against profit centers for brand and channel P&L reporting. Consumer Goods companies allocate trade spend to profit centers to measure net revenue by brand/channel. Essent',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: REQUIRED: Supplier‑funded trade promotions need a link for budgeting and compliance; experts expect a sponsor supplier on each promotion.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Trade promotions in consumer goods are scoped to specific sales territories for territory-level trade spend reporting, quota alignment, and sales rep commission calculations. The geographic_scope text',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retail trade account (customer) participating in this promotion. Links to the trade account master entity.',
    `trade_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_calendar. Business justification: A trade promotion program is planned and executed within a specific trade calendar cycle (annual or periodic). The trade_calendar is the master planning container for all promotional activity for a br',
    `accrual_amount` DECIMAL(18,2) COMMENT 'Total accrued trade spend liability for this promotion, representing funds reserved or committed but not yet paid to the retailer.',
    `approval_date` DATE COMMENT 'Date when the trade promotion was formally approved by authorized business stakeholders and authorized for execution.',
    `authorized_budget_amount` DECIMAL(18,2) COMMENT 'Total authorized trade spend budget allocated for this promotion, including all funding mechanisms (off-invoice, scan-back, display allowances, etc.). Expressed in the companys reporting currency.',
    `baseline_volume_units` DECIMAL(18,2) COMMENT 'Expected sales volume in units without the promotion, used as the baseline for calculating incremental lift and ROI.',
    `channel_type` STRING COMMENT 'Retail channel classification where this promotion is executed. Grocery (supermarkets), mass merchandiser (Walmart/Target), drug (pharmacy chains), convenience (c-stores), club (warehouse clubs), ecommerce (online retail).. Valid values are `grocery|mass_merchandiser|drug|convenience|club|ecommerce`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where this promotion is executed.. Valid values are `^[A-Z]{3}$`',
    `coupon_flag` BOOLEAN COMMENT 'Indicates whether this promotion includes manufacturer or retailer coupons (print, digital, or mobile). True if coupons are part of the promotion, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade promotion record was first created in the system. Represents the business event time of promotion planning initiation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this promotion record.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Total deductions taken by the retailer against invoices for this promotion. Used for reconciliation and settlement tracking.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered to the retailer or consumer as part of this promotion. Expressed as a percentage (e.g., 15.00 for 15% off).',
    `display_type` STRING COMMENT 'Type of in-store merchandising display associated with this promotion. End-cap (end of aisle), free-standing (floor display), shelf-talker (shelf signage), pallet (bulk display), cooler (refrigerated display), none (no special display).. Valid values are `end_cap|free_standing|shelf_talker|pallet|cooler|none`',
    `end_date` DATE COMMENT 'The date when the trade promotion concludes and promotional pricing/terms expire at retail.',
    `expected_roi_percentage` DECIMAL(18,2) COMMENT 'Expected return on investment for this promotion, calculated as (incremental profit / trade spend) * 100. Used for pre-event planning and approval.',
    `feature_ad_flag` BOOLEAN COMMENT 'Indicates whether this promotion includes feature advertising in retailer circulars, flyers, or digital media. True if featured, false otherwise.',
    `funding_type` STRING COMMENT 'Mechanism by which trade funds are provided to the retailer. Off-invoice (deducted at purchase), scan-back (reimbursed based on POS sales), bill-back (invoiced after event), lump-sum (fixed payment), accrual (reserved funds).. Valid values are `off_invoice|scan_back|bill_back|lump_sum|accrual`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade promotion record was last updated. Used for change tracking and audit trail purposes.',
    `maximum_purchase_quantity` STRING COMMENT 'Maximum number of units a consumer can purchase at the promotional price. Null if no maximum limit applies.',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum number of units a consumer must purchase to qualify for the promotional offer. Null if no minimum applies.',
    `notes` STRING COMMENT 'Free-text field for additional business context, special terms, execution notes, or post-event observations related to this trade promotion.',
    `pricing_strategy` STRING COMMENT 'Retailer pricing strategy context for this promotion. Hi-Lo (high-low promotional pricing with deep discounts), EDLP (everyday low price with minimal promotions), hybrid (combination approach).. Valid values are `hi_lo|edlp|hybrid`',
    `promotion_name` STRING COMMENT 'Descriptive name of the trade promotion program for business user identification and reporting purposes.',
    `promotion_number` STRING COMMENT 'Business-facing unique identifier for the trade promotion program, typically generated by the TPM system. Format: TPM-YYYYNNNN where YYYY is year and NNNN is sequence.. Valid values are `^TPM-[0-9]{8}$`',
    `promotion_objective` STRING COMMENT 'Primary business objective driving the trade promotion strategy. Volume growth (increase unit sales), market share gain (capture competitor share), new product launch (trial generation), competitive defense (respond to competitor activity), inventory clearance (reduce excess stock), seasonal event (holiday/event-driven).. Valid values are `volume_growth|market_share_gain|new_product_launch|competitive_defense|inventory_clearance|seasonal_event`',
    `promotion_status` STRING COMMENT 'Current lifecycle status of the trade promotion. Planned (in design), approved (authorized for execution), active (currently running), closed (completed with results finalized), cancelled (terminated before completion), on-hold (temporarily suspended).. Valid values are `planned|approved|active|closed|cancelled|on_hold`',
    `promotion_type` STRING COMMENT 'Classification of the trade promotion mechanism. Temporary price reduction (Hi-Lo), feature ad (retailer circular), display (end-cap/shelf), BOGO (buy-one-get-one), multi-buy (quantity discount), scan-back (post-sale rebate). [ENUM-REF-CANDIDATE: temporary_price_reduction|feature_ad|display|bogo|multi_buy|scan_back|off_invoice|coupon|loyalty_reward|edlp|slotting_allowance|markdown_allowance — promote to reference product]. Valid values are `temporary_price_reduction|feature_ad|display|bogo|multi_buy|scan_back`',
    `settlement_status` STRING COMMENT 'Status of financial settlement and reconciliation for trade promotion deductions and accruals. Pending (awaiting settlement), in-progress (reconciliation underway), settled (fully reconciled and paid), disputed (discrepancies under review).. Valid values are `pending|in_progress|settled|disputed`',
    `start_date` DATE COMMENT 'The date when the trade promotion becomes active and promotional pricing/terms take effect at retail.',
    `target_volume_units` DECIMAL(18,2) COMMENT 'Target sales volume in units expected to be achieved during the promotion period, including baseline and incremental lift.',
    `tpm_system_reference_code` STRING COMMENT 'External reference identifier from the source Trade Promotion Management system (e.g., Salesforce Consumer Goods Cloud TPM module). Used for system integration and traceability.',
    CONSTRAINT pk_trade_promotion PRIMARY KEY(`trade_promotion_id`)
) COMMENT 'Core master entity for trade promotion programs. Captures the full definition of a trade promotion including name, type (Hi-Lo, EDLP, display, coupon, scan-back, off-invoice), promotional period, owning brand/category, status (planned, active, closed, cancelled), total authorized trade spend budget, promotion objectives, promotion type classification (temporary price reduction, feature ad, display, BOGO, multi-buy, scan-back, coupon, loyalty reward), applicable channels, and integration reference to Salesforce TPM. Serves as the SSOT for all trade promotion definitions and the parent entity for all promotion events, spend allocations, and post-event analyses.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`event` (
    `event_id` BIGINT COMMENT 'Unique identifier for the promotion event. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for integrated ROI reporting: each trade promotion event is executed as part of a marketing campaign, enabling campaign‑level performance analysis.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: CPG promotion events are designed to target specific consumer segments (e.g., a feature ad targeting millennial health-conscious buyers). Linking promotion_event to marketing-defined consumer segments',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for promotion spend accounting reports linking each event to the responsible cost center for budgeting and variance analysis.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Promotion events consume trade spend budget. Budget vs. actual at event level (planned_trade_spend_amount vs. actual_trade_spend_amount) is a core Consumer Goods finance control. Events must be tracea',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Promotion events generate trade spend accruals that post to specific GL accounts. Consumer Goods finance requires this link to trace actual_trade_spend_amount and accrual_amount on promotion events to',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables profit‑center level reporting of promotion performance and ROI, a standard finance requirement.',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store, distribution center, or ship-to location where the promotional event is executed.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: REQUIRED: Promotion events are often sponsored by a specific supplier; linking enables event‑level spend tracking and audit.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or distributor account participating in this promotional event.',
    `trade_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_calendar. Business justification: A promotion event is scheduled within a specific trade calendar period. The trade_calendar governs the planning cycle (fiscal year, planning cycle, effective dates) under which events are executed. Th',
    `trade_promotion_id` BIGINT COMMENT 'Reference to the parent trade promotion program under which this event is executed. A single program may have multiple events across different retailers or time windows.',
    `accrual_amount` DECIMAL(18,2) COMMENT 'The financial accrual amount reserved for this promotional event, representing the estimated liability for trade promotion obligations.',
    `actual_trade_spend_amount` DECIMAL(18,2) COMMENT 'The realized trade spend for this promotional event, representing the total investment actually incurred by the manufacturer.',
    `actual_volume_units` DECIMAL(18,2) COMMENT 'The realized sales volume in units achieved during the promotional event, used for post-event analysis and lift measurement.',
    `approval_date` DATE COMMENT 'The date when this promotional event was approved for execution by the authorized business stakeholder.',
    `baseline_volume_units` DECIMAL(18,2) COMMENT 'The expected sales volume in units without promotional activity, used as the baseline for calculating promotional lift.',
    `cancellation_date` DATE COMMENT 'The date when this promotional event was cancelled, if applicable.',
    `cancellation_reason` STRING COMMENT 'Textual explanation for why this promotional event was cancelled, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this promotional event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this promotional event record.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'The total deductions claimed by the retailer against invoices for this promotional event, representing retailer-initiated trade spend recovery.',
    `end_date` DATE COMMENT 'The date when the promotional event concludes execution at retail or distribution level.',
    `event_description` STRING COMMENT 'Detailed textual description of the promotional event, including objectives, mechanics, and special conditions.',
    `event_name` STRING COMMENT 'Descriptive name of the promotional event for business user identification and reporting.',
    `event_number` STRING COMMENT 'Business-facing unique identifier for the promotion event, used for external communication and reporting.. Valid values are `^[A-Z0-9]{8,20}$`',
    `event_status` STRING COMMENT 'Current lifecycle status of the promotional event. Planned: event scheduled but not yet approved; Approved: event approved for execution; In Execution: event currently active; Completed: event finished; Cancelled: event terminated before completion.. Valid values are `planned|approved|in_execution|completed|cancelled`',
    `event_type` STRING COMMENT 'Classification of the promotional event mechanism. Feature Ad: product featured in retailer circular; Display: in-store display placement; Temporary Price Reduction (TPR): short-term price discount; BOGO: Buy One Get One offer; Scan-Back: post-sale rebate based on scanned sales; Coupon: manufacturer or retailer coupon redemption.. Valid values are `feature_ad|display|temporary_price_reduction|bogo|scan_back|coupon`',
    `funding_source` STRING COMMENT 'The primary source of funding for this promotional event. Manufacturer: fully funded by manufacturer; Retailer: fully funded by retailer; Cooperative: jointly funded by both parties.. Valid values are `manufacturer|retailer|cooperative`',
    `geography_code` STRING COMMENT 'Three-letter ISO country code representing the geographic market where the event is executed.. Valid values are `^[A-Z]{3}$`',
    `gmroi_ratio` DECIMAL(18,2) COMMENT 'The gross margin return on investment for this promotional event, calculated as Gross Margin / Average Inventory Investment, measuring profitability efficiency.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this promotional event record was last modified in the system.',
    `planned_trade_spend_amount` DECIMAL(18,2) COMMENT 'The budgeted trade spend allocation for this promotional event, representing the total investment planned by the manufacturer.',
    `planned_volume_units` DECIMAL(18,2) COMMENT 'The forecasted sales volume in units expected during the promotional event, used for planning and ROI estimation.',
    `post_event_analysis_completed_flag` BOOLEAN COMMENT 'Boolean indicator of whether post-event analysis has been completed for this promotional event, including lift measurement and ROI calculation.',
    `post_event_analysis_date` DATE COMMENT 'The date when post-event analysis was completed for this promotional event.',
    `pricing_strategy` STRING COMMENT 'The pricing approach applied during this event. Hi-Lo: high-low promotional pricing with deep temporary discounts; EDLP: Everyday Low Price with minimal promotional variation; Hybrid: combination of both strategies.. Valid values are `hi_lo|edlp|hybrid`',
    `promotional_lift_percentage` DECIMAL(18,2) COMMENT 'The percentage increase in sales volume attributable to the promotional event, calculated as (Actual Volume - Baseline Volume) / Baseline Volume * 100.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'The total rebate amount paid to the retailer for this promotional event, typically calculated post-event based on performance metrics.',
    `roi_percentage` DECIMAL(18,2) COMMENT 'The return on investment for this promotional event, calculated as (Incremental Profit - Trade Spend) / Trade Spend * 100, measuring promotional effectiveness.',
    `salesforce_tpm_event_code` STRING COMMENT 'The unique identifier from Salesforce Consumer Goods Cloud Trade Promotion Management system for this event record, used for system integration and data lineage.. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `settlement_date` DATE COMMENT 'The date when financial settlement for this promotional event was completed and all trade spend obligations were resolved.',
    `settlement_status` STRING COMMENT 'The current status of financial settlement for this promotional event. Pending: settlement not yet initiated; In Progress: settlement calculations underway; Settled: all financial obligations resolved; Disputed: settlement under dispute resolution.. Valid values are `pending|in_progress|settled|disputed`',
    `start_date` DATE COMMENT 'The date when the promotional event begins execution at retail or distribution level.',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Represents a discrete promotional execution event tied to a trade promotion program. A single trade promotion may have multiple events across different retailers, geographies, or time windows. Captures event-level details: event type (feature ad, display, temporary price reduction, BOGO, scan-back), event start/end dates, retailer account, ship-to location, participating SKUs, planned vs. actual event status, and event-level trade spend allocation. Integrates with Salesforce TPM event records.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`event_sku` (
    `event_sku_id` BIGINT COMMENT 'Unique identifier for the promotion event SKU association record. Primary key for this entity.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.creative_asset. Business justification: In CPG trade promotion execution, specific SKUs featured in a promotion event are associated with approved creative assets (display creative, feature ad). This link supports creative compliance checki',
    `event_id` BIGINT COMMENT 'Reference to the parent promotion event to which this SKU is associated.',
    `label_version_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_version. Business justification: Promotion pricing must reference the latest approved label version for each SKU to meet labeling regulations.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to sales.price_list_item. Business justification: Each event_sku tracks promoted price vs regular shelf price for ROI calculation. The price_list_item is the authoritative source for list_price and cost_price per SKU. Linking enables promotional ROI ',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to inventory.recall_event. Business justification: SKUs actively featured in promotion events may be subject to recall events, requiring immediate suspension of promotional activity. Linking event_sku to recall_event enables rapid identification of pr',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Compliance team validates each promoted SKU against its registration before launch; direct FK enables automated compliance checks.',
    `funding_agreement_id` BIGINT COMMENT 'Reference to the retailer funding agreement or trade contract governing the promotional terms for this SKU.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU participating in this promotion event.',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Event SKU profitability analysis requires standard cost to calculate promotional margin per SKU. Consumer Goods trade teams use standard cost to evaluate promotional_gmroi and promotional_roi_percent ',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade account for which this promotional SKU pricing applies.',
    `accrual_amount` DECIMAL(18,2) COMMENT 'Accrued trade spend liability for this promotional SKU. Represents the estimated financial obligation based on planned volume and discount.',
    `actual_promotional_volume_cases` DECIMAL(18,2) COMMENT 'Actual volume of cases sold during the promotion period for this SKU. Captured post-event from POS or shipment data.',
    `actual_promotional_volume_units` DECIMAL(18,2) COMMENT 'Actual volume of consumer units sold during the promotion period for this SKU. Used for promotional lift and ROI analysis.',
    `baseline_volume_estimate_units` DECIMAL(18,2) COMMENT 'Estimated volume of units that would have been sold without the promotion. Used to calculate incremental lift. Typically derived from historical sales trends.',
    `compliance_check_status` STRING COMMENT 'Status of promotional pricing compliance verification for this SKU. Ensures promotional pricing was executed as agreed with the retailer.. Valid values are `Not Checked|Compliant|Non-Compliant|Under Review`',
    `compliance_verified_date` DATE COMMENT 'Date when promotional pricing compliance was verified for this SKU through retail execution audits or POS data validation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this promotion event SKU record was first created in the system.',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Actual deduction amount claimed by the retailer for this promotional SKU. Used for trade spend reconciliation and settlement.',
    `display_location_type` STRING COMMENT 'Type of in-store display location where this promotional SKU is merchandised. Impacts visibility and promotional lift. [ENUM-REF-CANDIDATE: Shelf|End Cap|Free Standing Display|Pallet|Cooler|Checkout|Secondary Placement — 7 candidates stripped; promote to reference product]',
    `feature_type` STRING COMMENT 'Type of promotional feature or advertising support provided for this SKU during the promotion event. [ENUM-REF-CANDIDATE: Circular Ad|Digital Ad|In-Store Signage|Shelf Talker|Coupon|Loyalty Offer|None — 7 candidates stripped; promote to reference product]',
    `gtin` STRING COMMENT 'Global Trade Item Number uniquely identifying the product SKU in the promotion. Supports EAN-8, EAN-13, UPC-A, UPC-E, and GTIN-14 formats.. Valid values are `^[0-9]{8,14}$`',
    `incremental_lift_percent` DECIMAL(18,2) COMMENT 'Percentage lift in volume due to the promotion. Calculated as (incremental_lift_volume_units / baseline_volume_estimate_units) * 100.',
    `incremental_lift_volume_units` DECIMAL(18,2) COMMENT 'Incremental volume of units sold above baseline due to the promotion. Calculated as actual_promotional_volume_units - baseline_volume_estimate_units.',
    `is_featured_sku` BOOLEAN COMMENT 'Indicates whether this SKU is a featured hero product in the promotion event. Featured SKUs typically receive premium merchandising and advertising support.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this promotion event SKU record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this promotion event SKU record was last modified.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this promotional SKU.',
    `planned_promotional_volume_cases` DECIMAL(18,2) COMMENT 'Forecasted volume of cases expected to be sold during the promotion period for this SKU. Used for trade spend budgeting and supply planning.',
    `planned_promotional_volume_units` DECIMAL(18,2) COMMENT 'Forecasted volume of consumer units expected to be sold during the promotion period for this SKU.',
    `price_reduction_depth_percent` DECIMAL(18,2) COMMENT 'Percentage discount from regular shelf price to promoted price. Calculated as ((regular_shelf_price - promoted_price) / regular_shelf_price) * 100.',
    `pricing_approval_status` STRING COMMENT 'Current approval status of the promotional pricing for this SKU. Tracks the workflow state from draft through execution to completion. [ENUM-REF-CANDIDATE: Draft|Pending Approval|Approved|Rejected|Active|Completed|Cancelled — 7 candidates stripped; promote to reference product]',
    `pricing_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the promotional pricing for this SKU was approved.',
    `promoted_price` DECIMAL(18,2) COMMENT 'The temporary promotional price offered to consumers during the promotion event. Expressed in the base currency of the business.',
    `promoted_price_type` STRING COMMENT 'Type of promotional pricing mechanism applied to this SKU. Hi-Lo: temporary price reduction; EDLP: everyday low price; Multi-Buy: quantity discount; BOGO: buy-one-get-one; Scan-Back: retailer scanned rebate; Off-Invoice: deduction at invoice; Bill-Back: post-event settlement. [ENUM-REF-CANDIDATE: Hi-Lo|EDLP|Multi-Buy|BOGO|Scan-Back|Off-Invoice|Bill-Back — 7 candidates stripped; promote to reference product]',
    `promotion_effective_end_date` DATE COMMENT 'The date when the promotional pricing for this SKU expires and regular pricing resumes.',
    `promotion_effective_start_date` DATE COMMENT 'The date when the promotional pricing for this SKU becomes effective at retail.',
    `promotional_discount_per_unit` DECIMAL(18,2) COMMENT 'Absolute discount amount per unit (regular_shelf_price - promoted_price). Represents the per-unit trade spend investment.',
    `promotional_gmroi` DECIMAL(18,2) COMMENT 'Gross margin return on investment for this promotional SKU. Calculated as incremental_gross_margin / total_trade_spend_amount.',
    `promotional_roi_percent` DECIMAL(18,2) COMMENT 'Return on investment for this promotional SKU. Calculated as (incremental_gross_profit - total_trade_spend_amount) / total_trade_spend_amount * 100.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Rebate amount paid to the retailer for this promotional SKU. Typically settled post-event based on actual sales performance.',
    `regular_shelf_price` DECIMAL(18,2) COMMENT 'The standard everyday shelf price (RSP/MSRP) for this SKU before promotional discount. Used to calculate price reduction depth.',
    `settlement_date` DATE COMMENT 'Date when the financial settlement for this promotional SKU was completed with the retailer.',
    `settlement_status` STRING COMMENT 'Current status of the financial settlement process for this promotional SKU with the retailer.. Valid values are `Not Started|In Progress|Reconciled|Settled|Disputed`',
    `total_trade_spend_amount` DECIMAL(18,2) COMMENT 'Total trade spend investment for this SKU in this promotion event. Calculated as promotional_discount_per_unit * actual_promotional_volume_units.',
    `upc` STRING COMMENT 'Universal Product Code for the SKU participating in the promotion event. Standard 12-digit UPC-A format.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_event_sku PRIMARY KEY(`event_sku_id`)
) COMMENT 'Association entity linking individual SKUs (GTINs/UPCs) to a specific promotion event with full promotional pricing authority. Captures SKU-level promotional details including promoted price, promoted price type (Hi-Lo temporary price reduction, EDLP, multi-buy, BOGO, scan-back, off-invoice, bill-back), price reduction depth (%), regular shelf price (RSP/MSRP), effective date range, planned promotional volume (cases/units), actual promotional volume, baseline volume estimate, incremental lift volume, promotional discount amount per unit, retailer account, channel, and pricing approval status. Serves as the SSOT for SKU-level promotional pricing within trade events — distinct from standard list pricing owned by the product domain. Enables SKU-level trade spend, lift analysis, and promotional price compliance per event.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` (
    `trade_calendar_id` BIGINT COMMENT 'Primary key for trade_calendar',
    `category_id` BIGINT COMMENT 'Identifier of the product category this promotional calendar covers. Links to the product category entity.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Trade calendars are aligned with finance budget cycles (fiscal_year, planning_cycle on trade_calendar). Consumer Goods annual trade planning links the trade calendar to the approved finance budget for',
    `parent_calendar_trade_calendar_id` BIGINT COMMENT 'Identifier of the parent promotional calendar if this is a sub-calendar or regional variant. Links to another promotional calendar entity.',
    `product_brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Annual trade calendars in consumer goods are organized by product brand — brand teams plan promotional windows and seasonal events by brand. This link enables brand-level trade calendar management and',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retailer or trade account this promotional calendar is scoped to. Links to the trade account entity.',
    `actual_event_count` STRING COMMENT 'The actual number of promotional events executed or in-flight within this calendar period.',
    `approval_date` DATE COMMENT 'The date when this promotional calendar was formally approved by management or finance.',
    `calendar_code` STRING COMMENT 'Short alphanumeric code for the promotional calendar used in reporting and system integration (e.g., FY24Q1-RET, CAL-2024-BRX).',
    `calendar_name` STRING COMMENT 'Business name of the promotional calendar (e.g., FY2024 Q1 Retail Promo Calendar, Annual Brand X Trade Plan).',
    `calendar_status` STRING COMMENT 'Current lifecycle status of the promotional calendar (draft, submitted, approved, locked, active, closed).. Valid values are `draft|submitted|approved|locked|active|closed`',
    `closed_date` DATE COMMENT 'The date when this promotional calendar was closed after all events completed and post-event analysis was finalized.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where this promotional calendar is executed (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional calendar record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the planned trade spend (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date when this promotional calendar ends and no further promotional events are planned under this calendar.',
    `effective_start_date` DATE COMMENT 'The date when this promotional calendar becomes effective and promotional events can begin execution.',
    `fiscal_year` STRING COMMENT 'The fiscal year this promotional calendar covers (e.g., 2024, 2025).',
    `is_baseline_calendar` BOOLEAN COMMENT 'Flag indicating whether this is the baseline or master promotional calendar for the fiscal year (true) or a variant/supplemental calendar (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional calendar record was last updated or modified.',
    `locked_date` DATE COMMENT 'The date when this promotional calendar was locked to prevent further changes, typically after approval and before execution.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this promotional calendar for internal reference.',
    `planned_event_count` STRING COMMENT 'The total number of promotional events planned within this calendar period.',
    `planning_cycle` STRING COMMENT 'The planning frequency or cycle for this promotional calendar (annual, semi-annual, quarterly, monthly).. Valid values are `annual|semi-annual|quarterly|monthly`',
    `pricing_strategy` STRING COMMENT 'The primary pricing strategy employed in this promotional calendar: Hi-Lo (High-Low Pricing Strategy), EDLP (Everyday Low Price), hybrid, promotional, or premium.. Valid values are `hi-lo|edlp|hybrid|promotional|premium`',
    `region_code` STRING COMMENT 'Geographic region or market code this promotional calendar applies to (e.g., NA-EAST, EU-WEST, APAC).',
    `total_planned_trade_spend` DECIMAL(18,2) COMMENT 'The total budgeted trade spend envelope allocated for all promotional events within this calendar, in the base currency.',
    `tpm_system_code` STRING COMMENT 'External system identifier from the Trade Promotion Management (TPM) or Trade Promotion Optimization (TPO) system (e.g., Salesforce TPM, TradeEdge).',
    `trade_calendar_description` STRING COMMENT 'Detailed business description or purpose of this promotional calendar, including strategic objectives and key initiatives.',
    `version_number` STRING COMMENT 'Version number of this promotional calendar, incremented with each major revision or replan cycle.',
    CONSTRAINT pk_trade_calendar PRIMARY KEY(`trade_calendar_id`)
) COMMENT 'Master entity representing the annual or periodic trade promotional calendar for a brand, category, or retailer account. Captures calendar name, fiscal year, planning cycle, owning brand/category manager, retailer account scope, calendar status (draft, approved, locked), total planned trade spend envelope, and number of planned promotion events. Serves as the planning container for all trade promotion events within a given period and account relationship.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` (
    `trade_spend_allocation_id` BIGINT COMMENT 'Unique identifier for the trade spend allocation record. Primary key for this transactional entity capturing budget allocation to promotion events.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Needed to allocate trade spend per marketing campaign, supporting budgeting, spend efficiency tracking, and campaign‑level spend reconciliation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: trade_spend_allocation carries cost_center_code as a denormalized plain text attribute. A proper FK to finance.cost_center is required for trade spend reporting by cost center, budget vs. actual analy',
    `event_id` BIGINT COMMENT 'Reference to the specific promotion event or campaign to which this trade spend is allocated. Links to the promotion master record in TPM system.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Trade spend allocations are made against approved finance budgets. Budget vs. actual trade spend at allocation level is a core Consumer Goods finance control process. allocated_amount and committed_am',
    `funding_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.funding_agreement. Business justification: Trade spend allocations are governed by retailer funding agreements (RFAs/JBPs). The funding_agreement defines the total committed amount, payment terms, and accrual method under which spend is alloca',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: trade_spend_allocation carries gl_account_code as a denormalized plain text attribute. A proper FK to finance.gl_account is required for accrual posting, settlement reconciliation, and audit trail fro',
    `product_brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Trade spend allocations in consumer goods are managed against brand budgets — brand P&L owners track allocated vs. actual trade spend by brand for financial close and variance reporting. marketing_bra',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: trade_spend_allocation carries profit_center_code as a denormalized plain text attribute. A proper FK to finance.profit_center is required for brand/channel P&L reporting and net revenue management, w',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Trade spend budget classification: consumer goods finance teams classify trade spend allocations by procurement spend category (e.g., personal care, household) for budget vs. actual reporting and cate',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or distributor account receiving the trade spend funding. Identifies the counterparty in the promotional agreement.',
    `accrual_amount` DECIMAL(18,2) COMMENT 'The amount accrued for this trade spend allocation in the financial period. Used for matching expenses to the period in which the promotional activity occurs, per accrual accounting principles.',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual amount of trade spend executed or paid out. Populated post-event for variance analysis and reconciliation with accounts payable.',
    `actual_volume` DECIMAL(18,2) COMMENT 'The actual sales volume achieved during the promotion period. Populated post-event from POS or shipment data for lift analysis and ROI calculation.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary amount of trade spend allocated to this promotion event, account, brand, or SKU group. Represents the planned or budgeted spend.',
    `allocation_date` DATE COMMENT 'The business date when the trade spend allocation was created or committed. Principal business event timestamp for this transaction.',
    `allocation_number` STRING COMMENT 'Business-readable unique identifier for the trade spend allocation. Used for external communication, audit trails, and reconciliation with finance systems.. Valid values are `^TSA-[0-9]{8}-[A-Z0-9]{6}$`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the trade spend allocation. Tracks progression from planning through approval, execution, and final settlement with retailer. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|committed|executed|settled|cancelled|rejected — 8 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'The date when this trade spend allocation was formally approved by the authorized approver. Marks transition from draft to committed status.',
    `baseline_volume` DECIMAL(18,2) COMMENT 'The expected sales volume without promotional activity, used as the baseline for measuring promotional lift. Expressed in units or cases.',
    `committed_amount` DECIMAL(18,2) COMMENT 'The amount of trade spend formally committed after approval. May differ from allocated amount due to negotiation or budget adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade spend allocation record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this allocation record. Supports multi-currency trade spend management for global operations.. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'The amount deducted by the retailer from invoice payments as part of this trade spend allocation. Tracks retailer-initiated deductions for reconciliation and dispute resolution.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year to which this allocation is assigned. Used for period-level spend tracking and variance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this trade spend allocation is assigned for budgeting and financial reporting purposes.',
    `gmroi_percentage` DECIMAL(18,2) COMMENT 'The gross margin return on investment for this trade spend allocation. Measures gross margin dollars generated per dollar of trade spend invested.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this trade spend allocation is currently active. False indicates the allocation has been cancelled or superseded.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade spend allocation record was last modified. Audit field for change tracking and data governance.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this trade spend allocation. Captures special conditions, negotiation details, or post-event observations.',
    `pricing_strategy` STRING COMMENT 'The pricing strategy employed for this trade spend allocation. Distinguishes between Hi-Lo promotional pricing, Everyday Low Price (EDLP), and other strategic approaches.. Valid values are `hi_lo|edlp|hybrid|premium|penetration|competitive`',
    `promotion_end_date` DATE COMMENT 'The end date of the promotion event to which this spend is allocated. Defines the promotional activity window for ROI measurement and post-event analysis.',
    `promotion_start_date` DATE COMMENT 'The start date of the promotion event to which this spend is allocated. Used for temporal analysis and matching spend to promotional activity periods.',
    `roi_percentage` DECIMAL(18,2) COMMENT 'The calculated return on investment for this trade spend allocation, expressed as a percentage. Measures incremental profit generated per dollar of trade spend.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The final settled amount paid to the retailer after reconciliation of accruals, deductions, and actual performance. Represents the true cost of the promotion.',
    `settlement_date` DATE COMMENT 'The date when final settlement with the retailer was completed. Marks closure of the allocation lifecycle and reconciliation with accounts payable.',
    `spend_type` STRING COMMENT 'Classification of the trade spend mechanism. [ENUM-REF-CANDIDATE: off_invoice_discount|scan_back|bill_back|lump_sum|coop_advertising|slotting_fee|display_allowance|free_goods|volume_rebate|growth_incentive — promote to reference product]. Valid values are `off_invoice_discount|scan_back|bill_back|lump_sum|coop_advertising|slotting_fee`',
    `target_volume` DECIMAL(18,2) COMMENT 'The target sales volume expected with this trade spend allocation. Used for performance measurement and ROI calculation.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between committed and actual spend amounts. Positive variance indicates under-spend; negative indicates over-spend. Used for budget control and post-event analysis.',
    `volume_uom` STRING COMMENT 'The unit of measure for baseline, target, and actual volume fields. Ensures consistent interpretation of volume metrics across different product categories.. Valid values are `units|cases|pallets|kg|liters`',
    CONSTRAINT pk_trade_spend_allocation PRIMARY KEY(`trade_spend_allocation_id`)
) COMMENT 'Transactional record capturing the allocation of trade spend budget to a specific promotion event, retailer account, brand, or SKU group. Tracks allocated amount, spend type (off-invoice discount, scan-back, bill-back, lump sum, co-op advertising, slotting fee, display allowance, free goods), spend category classification, GL account mapping, fiscal period, cost center, approval status, and variance between planned and committed spend. Feeds into COGS and trade spend reporting for S&OP and finance reconciliation.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` (
    `funding_agreement_id` BIGINT COMMENT 'Unique identifier for the funding agreement record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Funding agreements represent committed trade spend tracked against cost centers. Consumer Goods finance teams require cost center assignment on funding agreements for trade spend budget management and',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Funding agreements represent committed trade spend that must be tracked against approved finance budgets. Budget vs. committed funding is a core Consumer Goods finance control. total_committed_amount ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Funding agreements specify how trade funds are accrued and posted to GL accounts. Consumer Goods finance teams need this link to trace funding agreement accruals (accrued_to_date_amount, paid_to_date_',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Funding agreements between manufacturers and retailers are governed by jurisdiction-specific laws (US Robinson-Patman Act, EU competition law on promotional allowances). Legal teams must identify the ',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_brand. Business justification: Retailer funding agreements in CPG are brand-specific commercial contracts. Linking funding_agreement to marketing_brand enables brand-level funding commitment reporting, brand P&L trade spend analysi',
    `previous_agreement_funding_agreement_id` BIGINT COMMENT 'Reference to the prior funding agreement that this agreement renews or replaces, if applicable.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Funding agreements are tracked against profit centers for brand/channel net revenue management. Consumer Goods companies need this link to report total_committed_amount and accrued_to_date_amount by p',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Supplier co-op funding traceability: retailer funding agreements in consumer goods are backed by supplier contracts that authorize co-op promotional funds. Finance and trade marketing teams must recon',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail trade account (customer) that is party to this funding agreement.',
    `accrual_method` STRING COMMENT 'Method used to accrue trade spend liability over the agreement period: straight-line (evenly over time), event-based (per promotional event), scan-based (per unit sold), or milestone-based (upon achievement of targets).. Valid values are `straight_line|event_based|scan_based|milestone_based`',
    `accrued_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of trade spend accrued under this agreement as of the current date, based on the accrual method.',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the funding agreement, often including retailer name and fiscal year.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the funding agreement, typically formatted as prefix-numeric sequence.. Valid values are `^[A-Z]{3}-[0-9]{6,10}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the funding agreement: draft (being prepared), pending approval (submitted for review), approved (signed but not yet active), active (in effect), suspended (temporarily paused), terminated (ended early), or expired (reached end date). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|terminated|expired — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the funding agreement structure: annual lump sum (fixed payment), scan-back (per-unit sold), co-op (shared marketing), slotting (shelf placement fee), performance-based (conditional on metrics), or volume rebate (tiered discount).. Valid values are `annual_lump_sum|scan_back|co_op|slotting|performance_based|volume_rebate`',
    `approval_status` STRING COMMENT 'Current approval workflow status: not submitted (draft), pending review (awaiting decision), approved (authorized), rejected (denied), or revision required (needs changes before resubmission).. Valid values are `not_submitted|pending_review|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the funding agreement (typically a sales director, finance manager, or VP of trade marketing).',
    `approved_date` DATE COMMENT 'Date when the funding agreement was formally approved by the authorized signatory.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this agreement automatically renews at the end of the funding period (true) or requires explicit renewal (false).',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed contract document stored in the document management system (e.g., Salesforce Files, SharePoint, Veeva Vault).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the funding agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deduction_settlement_terms` STRING COMMENT 'Terms and conditions governing how retailer deductions are validated, matched, and settled against this funding agreement (e.g., backup documentation requirements, dispute resolution process, settlement timeline).',
    `funding_period_end_date` DATE COMMENT 'The date when the funding agreement expires and the funding period ends. Nullable for open-ended agreements.',
    `funding_period_start_date` DATE COMMENT 'The date when the funding agreement becomes effective and the funding period begins.',
    `gmroi_target` DECIMAL(18,2) COMMENT 'Target gross margin return on investment for this funding agreement, measuring gross profit generated per dollar of trade spend invested.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the funding agreement record was most recently updated.',
    `manufacturer_signatory_name` STRING COMMENT 'Full name of the manufacturer representative who signed the funding agreement on behalf of the CPG company.',
    `manufacturer_signatory_title` STRING COMMENT 'Job title or role of the manufacturer signatory (e.g., VP of Sales, Director of Trade Marketing, Key Account Manager).',
    `manufacturer_signature_date` DATE COMMENT 'Date when the manufacturer signatory signed the funding agreement.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special conditions related to the funding agreement.',
    `paid_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of funding actually paid out to the retailer under this agreement as of the current date.',
    `payment_frequency` STRING COMMENT 'Frequency at which payments are made under this agreement: one-time (lump sum), monthly, quarterly, semi-annual, annual, or event-based (triggered by specific promotional events).. Valid values are `one_time|monthly|quarterly|semi_annual|annual|event_based`',
    `payment_terms` STRING COMMENT 'Detailed description of payment terms, including timing, method, and conditions for fund disbursement (e.g., quarterly installments, post-event settlement, net 30 days).',
    `performance_conditions` STRING COMMENT 'Detailed description of performance metrics, targets, or conditions that must be met for funding to be released or for rebates to be earned (e.g., minimum sales volume, market share targets, display compliance).',
    `remaining_balance_amount` DECIMAL(18,2) COMMENT 'Remaining uncommitted or unpaid funding balance available under this agreement (total committed minus paid to date).',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether this funding agreement is a renewal of a previous agreement (true) or a new agreement (false).',
    `retailer_signatory_name` STRING COMMENT 'Full name of the retailer representative who signed the funding agreement on behalf of the retail account.',
    `retailer_signatory_title` STRING COMMENT 'Job title or role of the retailer signatory (e.g., Category Manager, Buyer, VP of Merchandising).',
    `retailer_signature_date` DATE COMMENT 'Date when the retailer signatory signed the funding agreement.',
    `roi_target_percentage` DECIMAL(18,2) COMMENT 'Target return on investment percentage for this funding agreement, used to measure promotional effectiveness and justify trade spend allocation.',
    `source_system` STRING COMMENT 'Name of the operational system from which this funding agreement record originated (e.g., Salesforce Consumer Goods Cloud, SAP SD, TradeEdge).',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated early, if applicable. Null if the agreement was not terminated.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement prior to the end date.',
    `termination_reason` STRING COMMENT 'Explanation or reason code for early termination of the agreement (e.g., breach of contract, mutual agreement, business restructuring, poor performance).',
    `total_committed_amount` DECIMAL(18,2) COMMENT 'Total funding amount committed by the manufacturer to the retailer under this agreement, in the agreement currency.',
    CONSTRAINT pk_funding_agreement PRIMARY KEY(`funding_agreement_id`)
) COMMENT 'Master entity representing a formal retailer funding agreement (RFA) or joint business plan (JBP) between the CPG manufacturer and a retail account. Captures agreement name, retailer account, agreement type (annual lump sum, scan-back, co-op, slotting, performance-based), total committed funding amount, funding period, payment terms, performance conditions, approval status, and signatory details. Serves as the contractual basis for trade spend commitments and deduction settlements.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`deduction` (
    `deduction_id` BIGINT COMMENT 'Unique identifier for the promotion deduction record. Primary key for the promotion deduction entity representing the complete lifecycle from initial short-payment through final settlement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links each deduction to the cost center responsible for the expense, required for cost allocation and reporting.',
    `distribution_shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_shipment. Business justification: Deduction root cause analysis: retailers raise promotion deductions citing specific short or late shipments. Linking promotion_deduction to distribution_shipment enables deduction-to-shipment traceabi',
    `event_id` BIGINT COMMENT 'Identifier of the originating promotion event that triggered this deduction. Links to the promotion event master.',
    `funding_agreement_id` BIGINT COMMENT 'Identifier of the trade promotion funding agreement under which this deduction was claimed. Links to the funding agreement master.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Deduction entries must be posted to a specific GL account; removes redundant gl_account_code column.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice against which the deduction was taken. Links to the originating invoice record.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Provides profit‑center level visibility of deduction impact, supporting profit analysis and KPI tracking.',
    `proof_of_delivery_id` BIGINT COMMENT 'Foreign key linking to logistics.proof_of_delivery. Business justification: Deduction dispute resolution: in consumer goods, retailers raise deductions citing non-delivery or short-shipment; the POD is the primary document used to validate or dispute the claim. Direct FK from',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retailer or trade account that initiated the deduction. Links to the customer trade account master.',
    `accrual_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this deduction impacts trade promotion accruals. True indicates the deduction should be reconciled against accrued trade spend, false indicates it is outside accrual scope.',
    `aging_days` STRING COMMENT 'Number of days the deduction has been open since the deduction date. Used for aging analysis and prioritization of dispute resolution activities.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary amount deducted by the retailer from the invoice payment. Represents the initial claim amount before dispute resolution.',
    `approval_date` DATE COMMENT 'Date on which the deduction settlement was approved by the authorized approver. Represents the decision point in the workflow.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the deduction that was approved and accepted by the manufacturer after dispute resolution. May be less than, equal to, or zero relative to the original deduction amount.',
    `business_unit_code` STRING COMMENT 'Business unit or division code responsible for managing this deduction. Used for organizational reporting and accountability.',
    `claim_reference_number` STRING COMMENT 'External reference number provided by the retailer for their deduction claim. Used for cross-referencing with retailer systems and documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deduction record was first created in the system. Represents the audit trail creation point.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deduction amount. Indicates the currency in which the deduction was taken.. Valid values are `^[A-Z]{3}$`',
    `deduction_date` DATE COMMENT 'Date on which the retailer took the deduction from the invoice payment. Represents the business event timestamp for the deduction.',
    `deduction_number` STRING COMMENT 'Business-facing unique deduction number assigned by the retailer or internal system. Used for external communication and dispute tracking.',
    `deduction_source` STRING COMMENT 'Source system or channel through which the deduction was received. Retailer portal indicates web-based submission, EDI 846 indicates electronic data interchange, manual entry indicates internal creation, bank reconciliation indicates discovery during payment matching, and automated matching indicates system-generated from remittance data.. Valid values are `retailer_portal|edi_846|manual_entry|bank_reconciliation|automated_matching`',
    `deduction_type` STRING COMMENT 'Classification of the deduction based on the reason for the short-payment. Promotional deductions relate to trade promotions, pricing deductions to price discrepancies, shortage to quantity issues, compliance to retailer policy violations, quality to product defects, freight to shipping issues, and administrative to processing errors. [ENUM-REF-CANDIDATE: promotional|pricing|shortage|compliance|quality|freight|administrative — 7 candidates stripped; promote to reference product]',
    `dispute_reason` STRING COMMENT 'Detailed textual explanation of why the manufacturer disputed all or part of the deduction. Provides context for dispute resolution and audit trail.',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the deduction in the dispute resolution workflow. Open indicates initial receipt, approved indicates full acceptance, disputed indicates challenge by manufacturer, partially_approved indicates partial acceptance, written_off indicates unrecoverable amount, and pending_review indicates under investigation.. Valid values are `open|approved|disputed|partially_approved|written_off|pending_review`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the deduction that is currently under dispute or was rejected by the manufacturer. Represents the portion of the deduction not accepted.',
    `gmroi_impact_percentage` DECIMAL(18,2) COMMENT 'Percentage impact of this deduction on the gross margin return on investment for the associated promotion. Used for profitability analysis and promotional effectiveness measurement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this deduction record was last modified. Used for audit trail and change tracking.',
    `priority_level` STRING COMMENT 'Priority classification for dispute resolution based on deduction amount, retailer relationship, and aging. Critical indicates immediate attention required, high indicates urgent resolution needed, medium indicates standard processing, and low indicates routine handling.. Valid values are `critical|high|medium|low`',
    `product_category_code` STRING COMMENT 'Product category or brand code associated with the deduction. Used for category-level trade spend analysis and promotional effectiveness measurement.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution process, communications with the retailer, and final settlement rationale. Provides audit trail and knowledge base for future similar deductions.',
    `retailer_claim_date` DATE COMMENT 'Date on which the retailer filed the deduction claim in their system. May differ from the deduction date.',
    `retailer_contact_email` STRING COMMENT 'Email address of the retailer contact person for this deduction. Used for electronic communication during dispute resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `retailer_contact_name` STRING COMMENT 'Name of the retailer contact person responsible for this deduction claim. Used for communication and relationship management during dispute resolution.',
    `roi_impact_amount` DECIMAL(18,2) COMMENT 'Calculated impact of this deduction on the promotional return on investment. Represents the reduction in promotional effectiveness due to the deduction. Used for post-event analysis and promotional optimization.',
    `settled_amount` DECIMAL(18,2) COMMENT 'Final monetary amount settled between the manufacturer and retailer after all dispute resolution activities. Represents the actual financial impact of the deduction.',
    `settlement_date` DATE COMMENT 'Date on which the deduction was fully settled and closed. Represents the completion of the deduction lifecycle.',
    `settlement_method` STRING COMMENT 'Method by which the deduction was settled. Credit memo indicates issuance of a credit note, check indicates physical or electronic check payment, offset_future_invoice indicates deduction from future invoices, write_off indicates unrecoverable amount expensed, and bank_transfer indicates direct electronic payment.. Valid values are `credit_memo|check|offset_future_invoice|write_off|bank_transfer`',
    `settlement_reason_code` STRING COMMENT 'Standardized code indicating the reason for the settlement decision. Used for categorization and analysis of settlement patterns.',
    `sla_resolution_date` DATE COMMENT 'Target date by which the deduction should be resolved based on internal service level agreements or retailer contractual terms. Used for performance tracking and escalation management.',
    `supporting_document_url` STRING COMMENT 'URL or file path to supporting documentation for the deduction claim, such as proof of performance, promotional materials, or retailer correspondence. Used for audit and dispute resolution.',
    CONSTRAINT pk_deduction PRIMARY KEY(`deduction_id`)
) COMMENT 'Transactional record representing the full lifecycle of a retailer deduction from initial short-payment through final settlement. Captures deduction number, retailer account, invoice reference, deduction amount, deduction type (promotional, pricing, shortage, compliance), deduction date, dispute status (open, approved, disputed, written-off), and complete settlement details: settlement date, settlement method (credit memo, check, offset against future invoice, write-off), settled amount, approved amount, disputed amount, settlement reason code, approver, and linkage to originating promotion event and funding agreement. Serves as the single entity for the entire deduction management workflow — no separate settlement record exists. Central to trade spend reconciliation, dispute resolution, and retailer relationship management.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` (
    `deduction_settlement_id` BIGINT COMMENT 'Unique identifier for the deduction settlement record. Primary key for the deduction settlement entity.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Deduction settlements in Consumer Goods are applied against specific AR invoices to clear the outstanding balance. Cash application and deduction management processes require direct linkage between se',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: deduction_settlement carries cost_center_code as a denormalized plain text attribute. A proper FK to finance.cost_center is required for tracking settlement costs by cost center and for period-end tra',
    `deduction_id` BIGINT COMMENT 'Reference to the originating retailer deduction that this settlement resolves. Links to the deduction record in the trade promotion management system.',
    `funding_agreement_id` BIGINT COMMENT 'Reference to the trade promotion funding agreement or contract that governs the terms under which this deduction was taken and settled.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: deduction_settlement carries gl_account_code as a denormalized plain text attribute. A proper FK to finance.gl_account is required for posting deduction settlements to the correct clearing accounts an',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: When a deduction settlement is posted in Consumer Goods, it creates a journal entry for the clearing of the deduction. Finance and audit teams require direct traceability from settlement record to jou',
    `parent_settlement_deduction_settlement_id` BIGINT COMMENT 'Reference to a parent settlement record if this is a follow-up or partial settlement. Enables tracking of multi-stage settlement processes for complex deductions.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: deduction_settlement carries profit_center_code as a denormalized plain text attribute. A proper FK to finance.profit_center is required for brand/channel P&L impact reporting of deduction settlements',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail customer account associated with this deduction settlement. Identifies the retailer or distributor party.',
    `approval_date` DATE COMMENT 'The date on which the settlement was formally approved by the authorized approver. Marks the transition from under review to approved status.',
    `approved_amount` DECIMAL(18,2) COMMENT 'The amount approved by the manufacturer for settlement after review and validation. May differ from the claimed amount due to disputes or partial approvals.',
    `business_unit_code` STRING COMMENT 'The business unit or division responsible for this settlement. Used for organizational reporting and trade spend allocation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement record was first created in the system. Provides audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this settlement record. Ensures consistent currency interpretation across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `deduction_claimed_amount` DECIMAL(18,2) COMMENT 'The original amount claimed by the retailer in the deduction. Represents the initial disputed or taken amount before settlement negotiation.',
    `dispute_resolution_method` STRING COMMENT 'The approach used to resolve any disputes between the claimed and approved amounts. Documents the resolution process for compliance and process improvement.. Valid values are `negotiation|arbitration|escalation|partial_approval|full_approval|write_off`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The portion of the deduction claimed amount that was disputed or rejected by the manufacturer. Represents the difference between claimed and approved amounts when not fully approved.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which this settlement was recorded. Enables period-based trade spend tracking.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this settlement was recorded. Used for period-based financial reporting and year-over-year trade spend analysis.',
    `is_partial_settlement` BOOLEAN COMMENT 'Boolean flag indicating whether this settlement represents a partial resolution of the deduction. True if the deduction requires additional settlements; false if fully resolved.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement record was last updated. Tracks the most recent change for audit and data quality purposes.',
    `payment_date` DATE COMMENT 'The date on which the settlement payment was issued or credited to the retailer. Represents the actual financial transaction date.',
    `payment_reference_number` STRING COMMENT 'External reference number for the payment transaction, such as check number, wire transfer confirmation, or credit memo number. Used for reconciliation with financial systems.',
    `settled_amount` DECIMAL(18,2) COMMENT 'The final amount paid or credited to the retailer as part of this settlement. This is the actual financial transaction amount and may include adjustments beyond the approved amount.',
    `settlement_cycle_time_days` STRING COMMENT 'The number of days elapsed from deduction claim date to settlement completion. Used for process efficiency measurement and Service Level Agreement (SLA) tracking.',
    `settlement_date` DATE COMMENT 'The date on which the deduction settlement was finalized and agreed upon by both parties. Represents the business event date for settlement completion.',
    `settlement_method` STRING COMMENT 'The mechanism used to resolve and pay the deduction. Indicates how the settlement amount was transferred or credited to the retailer.. Valid values are `credit_memo|check|wire_transfer|offset_invoice|write_off|accrual_adjustment`',
    `settlement_notes` STRING COMMENT 'Free-form text field for additional comments, negotiation details, or special circumstances related to the settlement. Provides context for future reference and audit.',
    `settlement_number` STRING COMMENT 'Business-readable unique identifier for the settlement transaction. Used for external communication and audit trails. Format: STL- followed by 8-12 digits.. Valid values are `^STL-[0-9]{8,12}$`',
    `settlement_reason_code` STRING COMMENT 'Standardized code indicating the business reason or category for the settlement. Used for classification and root cause analysis of deductions.. Valid values are `^[A-Z0-9]{2,10}$`',
    `settlement_reason_description` STRING COMMENT 'Detailed textual explanation of the reason for the settlement, including any specific circumstances, negotiations, or justifications documented during the settlement process.',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the deduction settlement. Tracks the settlement through approval, payment, and closure workflows. [ENUM-REF-CANDIDATE: pending|approved|rejected|paid|cancelled|under_review|disputed — 7 candidates stripped; promote to reference product]',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this settlement was completed within the agreed Service Level Agreement (SLA) timeframe. Used for performance monitoring and retailer relationship management.',
    `source_system_code` STRING COMMENT 'Identifier for the operational system from which this settlement record originated. Supports data lineage and multi-system integration scenarios.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this settlement record in the source operational system. Enables traceability back to the system of record for reconciliation and troubleshooting.',
    CONSTRAINT pk_deduction_settlement PRIMARY KEY(`deduction_settlement_id`)
) COMMENT 'Transactional record capturing the resolution and settlement of a retailer deduction. Tracks settlement date, settlement method (credit memo, check, offset against future invoice, write-off), settled amount, approved amount, disputed amount, settlement reason code, approver, and linkage to the originating deduction and funding agreement. Enables closed-loop deduction management and accurate trade spend reconciliation.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` (
    `post_event_analysis_id` BIGINT COMMENT 'Unique identifier for the post-event analysis record. Primary key for this analytical entity capturing promotion performance measurement at SKU-retailer-period granularity.',
    `baseline_volume_id` BIGINT COMMENT 'Foreign key linking to promotion.baseline_volume. Business justification: Post-event analysis computes incremental lift by comparing actual promoted volume against a statistical baseline. The baseline_volume entity is the authoritative source for the baseline estimate used ',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: CPG post-event analysis explicitly isolates trade promotion contribution from concurrent marketing campaign contribution. A direct campaign_id enables the integrated post-event scorecard report that',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Post-event analysis in CPG is segmented by consumer segment to understand differential response rates. This segment-level breakdown is a standard deliverable in CPG post-event analysis reports and inf',
    `event_id` BIGINT COMMENT 'Reference to the completed promotion event being analyzed. Links to the source promotion execution record in the TPM system.',
    `oos_event_id` BIGINT COMMENT 'Foreign key linking to inventory.oos_event. Business justification: Post-event analysis tracks oos_impact_estimated_units and oos_incident_count as plain attributes, indicating OOS data is consumed here. Linking to the actual oos_event record enables drill-down from p',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU that was promoted during this event. Enables SKU-level performance analysis and lift measurement.',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Post-event analysis calculates cost_per_incremental_case and promotional_roi, which require standard cost data. Consumer Goods analysts use standard cost to compute true promotional profitability. Dom',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade partner where the promotion was executed. Enables retailer-level performance comparison and compliance tracking.',
    `actual_promoted_volume_units` DECIMAL(18,2) COMMENT 'Actual sales volume in units achieved during the promotional period. Core metric for calculating incremental lift and ROI.',
    `actual_trade_spend_amount` DECIMAL(18,2) COMMENT 'Total trade spend actually incurred for this promotion event, including all accruals, deductions, and settlements. Used for actual ROI and GMROI calculation.',
    `analysis_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the post-event analysis was completed and results finalized. Marks the transition to approved or archived status.',
    `analysis_period_end_date` DATE COMMENT 'End date of the promotional period being analyzed. Completes the temporal boundary for performance measurement window.',
    `analysis_period_start_date` DATE COMMENT 'Start date of the promotional period being analyzed. Defines the temporal boundary for lift measurement and baseline comparison.',
    `analysis_status` STRING COMMENT 'Current lifecycle status of the post-event analysis. Tracks progression from initial draft through approval and archival.. Valid values are `draft|in_progress|completed|approved|rejected|archived`',
    `analyst_notes` STRING COMMENT 'Free-text commentary from the analyst conducting the post-event review. Captures qualitative insights, contextual factors, and recommendations for future planning.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this post-event analysis was formally approved. Locks the record for reporting and TPO model training.',
    `baseline_confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the statistical confidence interval for baseline estimate. Quantifies uncertainty in baseline calculation.',
    `baseline_confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the statistical confidence interval for baseline estimate. Completes the uncertainty quantification for baseline.',
    `baseline_data_source` STRING COMMENT 'Primary data source used for baseline estimation. Identifies whether baseline was derived from POS scan data, syndicated panels, or internal systems.. Valid values are `pos_scan|nielsen_iq|tradeedge_secondary|internal_shipment|syndicated_panel|custom`',
    `baseline_estimation_methodology` STRING COMMENT 'Statistical or analytical method used to calculate the baseline volume estimate. Critical for understanding confidence and reproducibility of lift measurements. [ENUM-REF-CANDIDATE: moving_average|exponential_smoothing|regression|causal_model|nielsen_iq|tradeedge|custom — 7 candidates stripped; promote to reference product]',
    `baseline_volume_units` DECIMAL(18,2) COMMENT 'Estimated baseline sales volume in units that would have occurred without the promotion. Foundation for incremental lift calculation.',
    `cost_per_incremental_case` DECIMAL(18,2) COMMENT 'Trade spend divided by incremental lift in case-equivalent units. Measures cost efficiency of generating incremental volume.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this post-event analysis record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record. Ensures consistent financial reporting across markets.. Valid values are `^[A-Z]{3}$`',
    `data_vintage_date` DATE COMMENT 'As-of date for the sales data used in this analysis. Important for understanding data latency and potential for future revisions.',
    `display_compliance_flag` BOOLEAN COMMENT 'Indicates whether the retailer executed the agreed in-store display (end cap, shipper, pallet) as planned. True if compliant, False if not.',
    `feature_compliance_flag` BOOLEAN COMMENT 'Indicates whether the retailer executed the agreed feature advertising (circular, flyer, digital ad) as planned. True if compliant, False if not.',
    `gmroi` DECIMAL(18,2) COMMENT 'Gross margin return on investment, calculated as incremental gross margin divided by actual trade spend. Measures profitability efficiency of promotional investment.',
    `incremental_lift_percentage` DECIMAL(18,2) COMMENT 'Percentage lift over baseline, calculated as (incremental lift units / baseline volume units) * 100. Enables comparison across SKUs and events of different scales.',
    `incremental_lift_units` DECIMAL(18,2) COMMENT 'Incremental sales volume in units attributable to the promotion, calculated as actual promoted volume minus baseline volume. Primary measure of promotional effectiveness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this post-event analysis record was last updated. Tracks iterative refinement during analysis workflow.',
    `learning_classification` STRING COMMENT 'Categorical assessment of promotion performance used to feed TPO learning loops. Enables pattern recognition and future optimization.. Valid values are `best_practice|acceptable|underperformer|failure|outlier`',
    `lift_measurement_methodology` STRING COMMENT 'Analytical approach used to isolate and measure promotional lift. Determines rigor and defensibility of lift claims.. Valid values are `simple_difference|control_group|matched_market|time_series|causal_impact|machine_learning`',
    `lift_measurement_source` STRING COMMENT 'Primary data source used to measure actual promoted volume and calculate lift. Critical for understanding data quality and measurement reliability.. Valid values are `pos_scan|nielsen_iq_panel|tradeedge_secondary|internal_shipment|syndicated_data|blended`',
    `oos_impact_estimated_units` DECIMAL(18,2) COMMENT 'Estimated sales volume lost due to out-of-stock incidents during the promotion. Quantifies the opportunity cost of poor availability.',
    `oos_incident_count` STRING COMMENT 'Number of out-of-stock incidents detected during the promotional period. Critical for understanding lost sales opportunity and execution quality.',
    `planned_trade_spend_amount` DECIMAL(18,2) COMMENT 'Total trade spend budgeted for this promotion event at planning time. Baseline for variance analysis and ROI calculation.',
    `pre_promotion_trend` STRING COMMENT 'Observed sales trend in the period immediately preceding the promotion. Contextualizes baseline and helps explain lift performance.. Valid values are `increasing|stable|decreasing|seasonal|volatile`',
    `pricing_compliance_flag` BOOLEAN COMMENT 'Indicates whether the retailer maintained the agreed promotional price throughout the event period. True if compliant, False if not.',
    `promotional_roi` DECIMAL(18,2) COMMENT 'Return on investment for this promotion, calculated as (incremental gross profit - actual trade spend) / actual trade spend. Primary financial effectiveness metric.',
    `recommendation_for_future` STRING COMMENT 'Strategic recommendation for how this promotion type should be treated in future planning cycles based on performance results.. Valid values are `repeat|modify|avoid|test_further|scale_up`',
    `retailer_compliance_score` DECIMAL(18,2) COMMENT 'Composite score (0-100) measuring retailer adherence to promotional execution requirements including pricing, display, feature, and inventory. Higher scores indicate better execution quality.',
    `sell_through_rate` DECIMAL(18,2) COMMENT 'Percentage of promoted inventory that sold through to consumers during the promotional period. Indicates promotional velocity and inventory efficiency.',
    `trade_spend_variance_amount` DECIMAL(18,2) COMMENT 'Difference between actual and planned trade spend (actual minus planned). Highlights budget adherence and cost control effectiveness.',
    CONSTRAINT pk_post_event_analysis PRIMARY KEY(`post_event_analysis_id`)
) COMMENT 'Comprehensive analytical record capturing post-event review (PER) results for a completed promotion event at SKU-retailer-period granularity. Stores baseline volume estimates (methodology, confidence interval, data source, pre-promotion trend), actual promoted volume, incremental lift measurements (units, percentage, lift source — POS scan data, Nielsen IQ panel, TradeEdge secondary sales), measurement methodology, data vintage, planned vs. actual trade spend, promotional ROI, GMROI, cost per incremental case, sell-through rate, OOS incidents, retailer compliance score, and analyst notes. Serves as the single analytical SSOT for all promotion performance measurement including baseline estimation, lift calculation, and ROI analysis. Feeds TPO optimization models, learning loops, and future planning decisions.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` (
    `promoted_price_id` BIGINT COMMENT 'Primary key for promoted_price',
    `event_id` BIGINT COMMENT 'Reference to the parent promotion event or campaign under which this promotional price is defined. Links to the broader trade promotion execution context.',
    `funding_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.funding_agreement. Business justification: Promotional price points are often funded under a specific retailer funding agreement — the price reduction depth and scan-back rates are negotiated as part of the RFA/JBP. Linking promoted_price to f',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Promoted prices must comply with jurisdiction-specific pricing regulations — EU reference pricing rules, unit pricing laws, promotional price disclosure requirements. Pricing teams validate promoted p',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to sales.price_list_item. Business justification: Promoted prices are calculated as discounts from the standard list price. The price_list_item holds the authoritative list_price and cost_price per SKU. Linking enables automated discount depth calcul',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this promotional price is defined. Identifies the specific product variant being promoted.',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Promoted price decisions require comparison against standard cost to enforce margin floors. Consumer Goods pricing approval processes validate that promotional_price_amount does not breach minimum mar',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade account for which this promotional price applies. Enables account-specific promotional pricing strategies.',
    `accrual_method` STRING COMMENT 'The method used to accrue and settle trade promotion funds for this promotional price. Scan-back (per unit sold), bill-back (post-event invoice), off-invoice (upfront discount), lump-sum (fixed payment), or performance-based (tied to metrics).. Valid values are `scan_back|bill_back|off_invoice|lump_sum|performance_based`',
    `approval_date` DATE COMMENT 'The date when this promotional price was formally approved for execution. Part of the audit trail for trade promotion compliance.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the promotional price record. Tracks the approval workflow from draft through execution to expiration. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|active|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'The manufacturers cost of goods sold per unit for the SKU at the time this promotional price was defined. Used for promotional ROI and GMROI analysis.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where this promotional price is valid. Supports multi-country promotional planning and compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional pricing record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the promotional price amount and regular shelf price (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date when this promotional price expires and is no longer valid. Nullable for open-ended or evergreen promotional pricing programs.',
    `effective_start_date` DATE COMMENT 'The date when this promotional price becomes active and available for use in retail execution and point-of-sale systems.',
    `estimated_volume_lift` DECIMAL(18,2) COMMENT 'The projected percentage increase in sales volume expected from this promotional price compared to baseline sales. Used for demand planning and promotional forecasting.',
    `funding_source` STRING COMMENT 'Identifies the party responsible for funding this promotional price discount. Manufacturer-funded, retailer-funded, co-op (shared), vendor-funded, or third-party funded.. Valid values are `manufacturer|retailer|co_op|vendor|third_party`',
    `is_advertised` BOOLEAN COMMENT 'Boolean flag indicating whether this promotional price is featured in retailer advertising, circulars, or marketing campaigns. True if advertised, False if unadvertised in-store promotion.',
    `is_stackable` BOOLEAN COMMENT 'Boolean flag indicating whether this promotional price can be combined (stacked) with other promotions, coupons, or discounts. True if stackable, False if exclusive.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional pricing record was last updated or modified. Used for change tracking and audit purposes.',
    `maximum_purchase_quantity` STRING COMMENT 'The maximum number of units eligible for this promotional price per transaction or per customer. Used to cap promotional exposure and manage trade spend. Nullable if no cap applies.',
    `minimum_purchase_quantity` STRING COMMENT 'The minimum number of units a consumer or retailer must purchase to qualify for this promotional price. Used for multi-buy and volume-based promotions. Nullable if no minimum applies.',
    `price_reduction_percentage` DECIMAL(18,2) COMMENT 'The percentage discount from the regular shelf price, calculated as ((regular_shelf_price - promotional_price_amount) / regular_shelf_price) * 100. Represents the depth of the promotional discount.',
    `pricing_strategy_type` STRING COMMENT 'Classification of the promotional pricing strategy. Hi-Lo (High-Low temporary price reduction), EDLP (Everyday Low Price), multi-buy (e.g., 2 for $5), BOGO (Buy One Get One), scan-back (retailer scans at checkout for discount), temporary price reduction, rebate, or coupon-based pricing. [ENUM-REF-CANDIDATE: hi_lo|edlp|multi_buy|bogo|scan_back|temporary_price_reduction|rebate|coupon — 8 candidates stripped; promote to reference product]',
    `promotional_allowance_amount` DECIMAL(18,2) COMMENT 'The per-unit allowance or funding provided by the manufacturer to the retailer to support this promotional price. Used for trade spend accrual and settlement calculations.',
    `promotional_price_amount` DECIMAL(18,2) COMMENT 'The promoted price point for the SKU during the promotional period. This is the actual selling price offered to consumers or retailers during the promotion.',
    `promotional_price_code` STRING COMMENT 'Business identifier or code for this promotional price record. Used for external reference and integration with TPM systems.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `promotional_price_description` STRING COMMENT 'Detailed description of the promotional price offer, including terms, conditions, and any special instructions for retail execution or consumer communication.',
    `promotional_price_name` STRING COMMENT 'Human-readable name or label for this promotional price configuration, used for identification and reporting purposes.',
    `region_code` STRING COMMENT 'Geographic region code where this promotional price is applicable. Enables regional pricing strategies and localized trade promotions.. Valid values are `^[A-Z]{2,10}$`',
    `regular_shelf_price` DECIMAL(18,2) COMMENT 'The standard or recommended selling price (RSP/MSRP) for the SKU before the promotional discount is applied. Used as the baseline for calculating price reduction depth.',
    `retailer_margin_percentage` DECIMAL(18,2) COMMENT 'The target or agreed-upon margin percentage for the retailer when selling at this promotional price. Used for trade negotiation and pricing strategy analysis.',
    `scan_back_rate` DECIMAL(18,2) COMMENT 'The per-unit reimbursement rate paid to the retailer for each unit sold at the promotional price under a scan-back pricing model. Nullable if not a scan-back promotion.',
    `tpm_system_code` STRING COMMENT 'External system identifier from the source Trade Promotion Management system (e.g., Salesforce TPM, SAP TPM). Used for data lineage and system integration.',
    CONSTRAINT pk_promoted_price PRIMARY KEY(`promoted_price_id`)
) COMMENT 'Master entity capturing the promotional price points defined for SKUs within a promotion event or pricing program. Tracks promoted price type (Hi-Lo temporary price reduction, EDLP, multi-buy, BOGO, scan-back price), promoted price amount, regular shelf price (RSP/MSRP), price reduction depth (%), effective date range, retailer account, channel, and approval status. Distinct from standard list pricing — this entity owns the promotional price layer used during trade events.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` (
    `lift_measurement_id` BIGINT COMMENT 'Unique identifier for the promotional lift measurement record.',
    `baseline_volume_id` BIGINT COMMENT 'Foreign key linking to promotion.baseline_volume. Business justification: Lift measurement calculates incremental volume by comparing actual promoted volume against a statistical baseline. The baseline_volume entity is the authoritative source for the baseline estimate used',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: CPG integrated effectiveness reporting requires separating media-driven lift from trade-driven lift. Linking lift_measurement to the concurrent marketing campaign enables the trade vs. media contribu',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: CPG promotion analytics routinely measures lift by consumer segment (heavy vs. light buyers, loyalists vs. switchers). Linking lift_measurement to marketing-defined consumer segments enables segment-l',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Lift measurement is captured at the event execution level — a specific promotional event drives the incremental volume lift being measured. While lift_measurement already links to trade_promotion (the',
    `oos_event_id` BIGINT COMMENT 'Foreign key linking to inventory.oos_event. Business justification: Lift measurement methodology must identify and adjust for OOS events during the measurement period, as stockouts suppress observed promotional lift. Linking to the specific OOS record enables statisti',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store location where lift was measured, if applicable.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU for which promotional lift is measured.',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Lift measurement calculates incremental_revenue and ROI metrics that require standard cost for margin calculations. Consumer Goods finance and commercial teams use standard cost to convert volume lift',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade account where the promotion was executed.',
    `trade_promotion_id` BIGINT COMMENT 'Reference to the trade promotion event for which lift is being measured.',
    `actual_promoted_volume_units` DECIMAL(18,2) COMMENT 'The actual volume in units sold during the promotional period.',
    `baseline_calculation_method` STRING COMMENT 'The specific method used to calculate the baseline volume for comparison.. Valid values are `moving_average|exponential_smoothing|linear_regression|seasonal_decomposition|custom_model`',
    `baseline_period_weeks` STRING COMMENT 'The number of weeks of historical data used to establish the baseline trend.',
    `baseline_volume_units` DECIMAL(18,2) COMMENT 'The expected volume in units based on pre-promotion trend analysis, representing what would have sold without the promotion.',
    `cannibalization_rate` DECIMAL(18,2) COMMENT 'The percentage of incremental lift that came from other SKUs within the same brand or category, indicating internal sales transfer.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the confidence interval for the lift measurement, typically at 95% confidence level.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the confidence interval for the lift measurement, typically at 95% confidence level.',
    `confidence_level_percentage` DECIMAL(18,2) COMMENT 'The statistical confidence level of the lift measurement, typically 90%, 95%, or 99%.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this lift measurement record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary values in this record.. Valid values are `^[A-Z]{3}$`',
    `data_vintage_date` DATE COMMENT 'The date when the source data used for this lift measurement was extracted or made available.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount offered during the promotion, calculated as ((regular price - promotional price) / regular price) * 100.',
    `halo_effect_units` DECIMAL(18,2) COMMENT 'The additional volume lift observed in related non-promoted SKUs due to the promotion, representing positive spillover effects.',
    `incremental_lift_percentage` DECIMAL(18,2) COMMENT 'The percentage lift over baseline, calculated as (incremental lift units / baseline volume units) * 100.',
    `incremental_lift_units` DECIMAL(18,2) COMMENT 'The incremental volume in units attributable to the promotion, calculated as actual promoted volume minus baseline volume.',
    `incremental_revenue` DECIMAL(18,2) COMMENT 'The incremental revenue generated by the promotion, calculated as incremental lift units multiplied by promotional price.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this lift measurement record was last updated.',
    `lift_source` STRING COMMENT 'The data source used to measure promotional lift.. Valid values are `pos_scan_data|nielsen_iq_panel|tradeedge_secondary_sales|iri_panel|internal_shipment_data|syndicated_data`',
    `measurement_methodology` STRING COMMENT 'The statistical methodology used to calculate baseline and incremental lift.. Valid values are `pre_post_comparison|control_group|time_series_regression|matched_market|causal_impact`',
    `measurement_notes` STRING COMMENT 'Free-text notes documenting any anomalies, data quality issues, or special considerations for this lift measurement.',
    `measurement_status` STRING COMMENT 'The current status of the lift measurement in the validation and approval workflow.. Valid values are `preliminary|validated|final|revised|rejected`',
    `measurement_week_end_date` DATE COMMENT 'The end date of the week for which lift is measured.',
    `measurement_week_start_date` DATE COMMENT 'The start date of the week for which lift is measured, typically aligned with retailer calendar weeks.',
    `p_value` DECIMAL(18,2) COMMENT 'The p-value from the statistical test of lift significance, where values below 0.05 typically indicate statistical significance.',
    `post_promotion_dip_units` DECIMAL(18,2) COMMENT 'The volume decline observed in the weeks immediately following the promotion, indicating pantry loading or forward buying effects.',
    `promotional_price` DECIMAL(18,2) COMMENT 'The actual selling price during the promotional period.',
    `regular_price` DECIMAL(18,2) COMMENT 'The regular non-promotional selling price used as baseline for price comparison.',
    `statistical_significance_flag` BOOLEAN COMMENT 'Indicates whether the measured lift is statistically significant at the specified confidence level.',
    `tpm_system_reference_code` STRING COMMENT 'The unique identifier for this lift measurement record in the source TPM system (Salesforce Consumer Goods Cloud).',
    `validated_timestamp` TIMESTAMP COMMENT 'The date and time when the lift measurement was validated and approved for use in ROI calculations.',
    CONSTRAINT pk_lift_measurement PRIMARY KEY(`lift_measurement_id`)
) COMMENT 'Transactional record capturing incremental volume lift measurements for a promotion event at the SKU-retailer-week level. Stores baseline volume (pre-promotion trend), actual promoted volume, incremental lift units, incremental lift percentage, lift source (POS scan data, Nielsen IQ panel, TradeEdge secondary sales), measurement methodology, confidence interval, and data vintage. Feeds TPO optimization models and post-event ROI calculations.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` (
    `retailer_compliance_id` BIGINT COMMENT 'Unique identifier for the retailer compliance record. Primary key for this transactional compliance audit entity.',
    `account_call_id` BIGINT COMMENT 'Foreign key linking to sales.account_call. Business justification: Retailer compliance observations (display, price, OSA compliance) are captured during sales rep account calls in consumer goods field execution. Linking retailer_compliance to the account_call that ge',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Retailer compliance audits verify adherence to specific regulatory compliance obligations (e.g., pricing disclosure requirements, promotional labeling rules). Auditors need to reference the specific c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Retailer compliance non-compliance penalties and funding_adjustment_amount are tracked to cost centers. Consumer Goods finance teams require cost center assignment on compliance records to properly al',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Retailer compliance is checked at the event execution level — compliance audits (price, display, feature ad) are conducted for specific promotion events at specific stores. While retailer_compliance a',
    `funding_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.funding_agreement. Business justification: Retailer compliance violations directly impact funding agreement settlements — non-compliance triggers funding adjustments (retailer_compliance.funding_adjustment_amount) and penalties under the terms',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Retailer compliance penalties and funding adjustments post to specific GL accounts. Consumer Goods finance requires this link to post penalty_amount and funding_adjustment_amount to the correct GL acc',
    `oos_event_id` BIGINT COMMENT 'Foreign key linking to inventory.oos_event. Business justification: OSA (On-Shelf Availability) compliance failures tracked in retailer_compliance are directly caused by OOS events. Linking enables root cause analysis: was non-compliance due to a specific OOS incident',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store location where compliance was audited. Enables store-level compliance tracking and analysis.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retailer or trade account whose compliance is being measured. Identifies the party responsible for executing the promotional mechanics.',
    `trade_promotion_id` BIGINT COMMENT 'Reference to the trade promotion event being audited for compliance. Links this compliance record to the parent promotional campaign.',
    `actual_retail_price` DECIMAL(18,2) COMMENT 'The actual price observed at the retail location during the compliance audit. Compared against agreed promotional price to determine price compliance.',
    `ad_feature_compliant_flag` BOOLEAN COMMENT 'Indicates whether the retailer included the promoted product in their feature advertisement or circular as agreed. True = compliant, False = non-compliant.',
    `agreed_promotional_price` DECIMAL(18,2) COMMENT 'The promotional price point that was contractually agreed between the manufacturer and retailer. Used as the benchmark for price compliance verification.',
    `audit_method` STRING COMMENT 'The method used to verify compliance. Field rep visit = in-person store check by manufacturer sales team, third-party audit = independent compliance service, POS data analysis = automated analysis of retailer sales data, photo verification = photographic evidence submitted digitally, retailer self-report = retailer-provided compliance attestation.. Valid values are `field_rep_visit|third_party_audit|pos_data_analysis|photo_verification|retailer_self_report`',
    `auditor_name` STRING COMMENT 'The name of the field representative or third-party auditor who conducted the compliance check. Provides human-readable reference for audit accountability.',
    `compliance_check_date` DATE COMMENT 'The date when the compliance audit or field check was performed. Represents the business event timestamp for this compliance observation.',
    `compliance_score_percentage` DECIMAL(18,2) COMMENT 'The overall compliance score expressed as a percentage (0.00 to 100.00). Represents the degree to which the retailer met the agreed promotional execution terms. Used for funding adjustments and future negotiation leverage.',
    `compliance_status` STRING COMMENT 'The overall compliance determination for this audit record. Compliant = all mechanics met, non-compliant = one or more mechanics failed, partial compliant = some mechanics met, pending review = audit submitted but not yet adjudicated, disputed = retailer has challenged the compliance finding.. Valid values are `compliant|non_compliant|partial_compliant|pending_review|disputed`',
    `compliance_type` STRING COMMENT 'The category of promotional mechanic being audited. Ad feature = retailer circular/flyer inclusion, display = in-store promotional display presence, price compliance = agreed promotional price point adherence, OSA = On Shelf Availability during promotion, POG placement = planogram compliance, multi-mechanic = combined audit.. Valid values are `ad_feature|display|price_compliance|osa|pog_placement|multi_mechanic`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance record was first created in the system. Audit trail for data lineage and compliance reporting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this compliance record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The system or channel from which this compliance record originated. SFA field audit = Salesforce mobile app, third-party service = external compliance vendor, POS integration = retailer point-of-sale data feed, retailer portal = retailer self-service submission, manual entry = back-office data entry.. Valid values are `sfa_field_audit|third_party_service|pos_integration|retailer_portal|manual_entry`',
    `data_source_reference_code` STRING COMMENT 'The unique identifier from the originating system (e.g., SFA visit ID, third-party audit ticket number, POS transaction batch ID). Enables traceability back to source system for dispute resolution.',
    `display_compliant_flag` BOOLEAN COMMENT 'Indicates whether the retailer set up the agreed in-store promotional display (end cap, floor stand, shipper display). True = compliant, False = non-compliant.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the retailer has formally disputed this compliance assessment. True = dispute filed, False = no dispute. Disputed records feed deduction dispute resolution workflows.',
    `dispute_reason` STRING COMMENT 'Free-text explanation provided by the retailer for why they are disputing the compliance finding. Captures retailer perspective and supporting evidence for dispute resolution.',
    `funding_adjustment_amount` DECIMAL(18,2) COMMENT 'The net adjustment to trade spend funding based on compliance performance. Positive values indicate additional funding earned through over-compliance; negative values indicate funding clawback due to non-compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance record was last updated. Tracks changes due to dispute resolution, data corrections, or status updates.',
    `non_compliance_category` STRING COMMENT 'Standardized classification of the non-compliance root cause. Enables aggregated analysis of compliance failure patterns across retailers and promotions.. Valid values are `inventory_shortage|pricing_error|display_not_built|ad_omission|operational_failure|system_error`',
    `non_compliance_reason` STRING COMMENT 'Free-text explanation of why the retailer failed to meet compliance requirements. Captures root cause details such as inventory shortage, operational error, pricing system failure, or deliberate non-execution.',
    `notes` STRING COMMENT 'Additional free-text observations or context from the auditor. May include qualitative details about store conditions, retailer cooperation, or extenuating circumstances affecting compliance.',
    `osa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the promoted product was in stock and available on shelf during the promotional period. True = compliant (in stock), False = non-compliant (out of stock).',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The financial penalty or funding adjustment applied due to non-compliance. May be deducted from retailer rebate or future funding allocations. Null if fully compliant.',
    `photo_evidence_url` STRING COMMENT 'URL or file path to photographic evidence captured during the compliance audit. Supports visual verification of display presence, pricing signage, shelf placement, and ad feature inclusion.',
    `pog_placement_compliant_flag` BOOLEAN COMMENT 'Indicates whether the product was placed according to the agreed planogram specifications (shelf position, facings, adjacency). True = compliant, False = non-compliant.',
    `price_compliant_flag` BOOLEAN COMMENT 'Indicates whether the retailer honored the agreed promotional price point (Hi-Lo or EDLP pricing strategy). True = compliant, False = non-compliant.',
    `resolution_date` DATE COMMENT 'The date when a disputed compliance record was resolved or when final compliance determination was made. Null if still pending or not disputed.',
    `resolution_outcome` STRING COMMENT 'The final outcome of a disputed compliance record. Upheld = original non-compliance finding stands, overturned = retailer dispute accepted and compliance restored, partial adjustment = compromise reached with reduced penalty, withdrawn = manufacturer withdrew the compliance claim.. Valid values are `upheld|overturned|partial_adjustment|withdrawn`',
    CONSTRAINT pk_retailer_compliance PRIMARY KEY(`retailer_compliance_id`)
) COMMENT 'Transactional record capturing retailer execution compliance for a promotion event — whether the retailer delivered the agreed promotional mechanics (feature ad, display, price point, shelf placement per POG). Tracks compliance check date, compliance type (ad feature, display, price compliance, OSA), compliance score (%), non-compliance reason, penalty amount applied, auditor/field rep reference, and data source (SFA field audit, third-party compliance service). Feeds deduction dispute resolution and future funding negotiations.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` (
    `baseline_volume_id` BIGINT COMMENT 'Unique identifier for the baseline volume record. Primary key for this entity.',
    `category_id` BIGINT COMMENT 'Foreign key reference to the product category for which baseline volume is calculated.',
    `market_research_study_id` BIGINT COMMENT 'Foreign key linking to marketing.market_research_study. Business justification: CPG baseline volume models incorporate market research data (household panel studies, purchase frequency research). Linking baseline_volume to market_research_study documents the research inputs used ',
    `product_brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Baseline volumes in trade promotion management are computed and tracked at the product brand level for brand-level promotional lift analysis and annual planning. Brand managers review baseline trends ',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the SKU for which baseline volume is calculated.',
    `trade_account_id` BIGINT COMMENT 'Foreign key reference to the retailer or trade account for which baseline volume is calculated.',
    `analyst_override_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the baseline volume estimate was manually overridden by an analyst (True) or is system-generated (False).',
    `approval_date` DATE COMMENT 'The date when the baseline volume estimate was approved for use in promotional lift calculations.',
    `baseline_methodology` STRING COMMENT 'The statistical methodology used to calculate the baseline volume estimate (e.g., moving average, regression, Nielsen IQ panel, Bayesian structural time series).. Valid values are `moving_average|regression|nielsen_iq_panel|bayesian_structural_time_series|exponential_smoothing|seasonal_decomposition`',
    `baseline_period_end_date` DATE COMMENT 'The end date of the period for which this baseline volume estimate applies.',
    `baseline_period_start_date` DATE COMMENT 'The start date of the period for which this baseline volume estimate applies.',
    `baseline_revenue_amount` DECIMAL(18,2) COMMENT 'The estimated baseline revenue for the SKU-retailer-period combination at regular pricing, absent promotional activity.',
    `baseline_status` STRING COMMENT 'The current lifecycle status of the baseline volume record (e.g., draft, approved, active, archived, superseded, rejected).. Valid values are `draft|approved|active|archived|superseded|rejected`',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the baseline volume calculation was performed.',
    `cases` DECIMAL(18,2) COMMENT 'The estimated baseline sales volume in cases, representing expected sales absent any promotional activity.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the confidence interval for the baseline volume estimate, representing statistical uncertainty.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the confidence interval for the baseline volume estimate, representing statistical uncertainty.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'The confidence level percentage for the confidence interval (e.g., 95.00 for 95% confidence).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this baseline volume record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the baseline revenue amount.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The source system or data provider from which the baseline calculation data was obtained (e.g., POS, Nielsen IQ, IRI, internal sales, TradeEdge).. Valid values are `pos|nielsen_iq|iri|internal_sales|trade_edge|syndicated_panel`',
    `geography_code` STRING COMMENT 'Three-letter ISO country code or geographic region code for which the baseline volume applies.. Valid values are `^[A-Z]{3}$`',
    `historical_lookback_weeks` STRING COMMENT 'The number of historical weeks of data used in the baseline volume calculation methodology.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this baseline volume record was last modified.',
    `last_refresh_date` DATE COMMENT 'The date when the baseline volume estimate was last refreshed or recalculated.',
    `model_accuracy_score` DECIMAL(18,2) COMMENT 'A statistical measure of the baseline model accuracy, such as R-squared or Mean Absolute Percentage Error (MAPE), represented as a decimal value.',
    `model_version` STRING COMMENT 'The version identifier of the baseline calculation model or algorithm used to generate this estimate.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or context related to the baseline volume calculation.',
    `outlier_exclusion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether statistical outliers were excluded from the baseline calculation (True) or included (False).',
    `override_reason` STRING COMMENT 'The business justification or reason provided by the analyst for manually overriding the system-generated baseline estimate.',
    `override_timestamp` TIMESTAMP COMMENT 'The date and time when the analyst override was applied to the baseline estimate.',
    `promotional_periods_excluded_count` STRING COMMENT 'The number of promotional periods that were excluded from the historical data when calculating the baseline volume.',
    `seasonality_adjustment_factor` DECIMAL(18,2) COMMENT 'The multiplicative factor applied to adjust for seasonal patterns in the baseline volume calculation.',
    `tpm_system_reference_code` STRING COMMENT 'External reference identifier from the source Trade Promotion Management system (e.g., Salesforce TPM) for traceability.',
    `trend_adjustment_factor` DECIMAL(18,2) COMMENT 'The multiplicative factor applied to adjust for long-term trend patterns in the baseline volume calculation.',
    `units` DECIMAL(18,2) COMMENT 'The estimated baseline sales volume in units, representing expected sales absent any promotional activity.',
    CONSTRAINT pk_baseline_volume PRIMARY KEY(`baseline_volume_id`)
) COMMENT 'Transactional record capturing the statistical baseline volume estimate for a SKU-retailer-period combination, representing expected sales absent any promotional activity. Stores baseline volume (units/cases), baseline revenue, baseline methodology (moving average, regression, Nielsen IQ panel, Bayesian structural time series), data source, baseline period, confidence interval, last refresh date, analyst override flag, and model version. Serves as the reusable baseline denominator consumed by post_event_analysis for incremental lift calculation across all promotion events. Maintained independently of any single promotion event to enable consistent cross-event comparison and baseline trend monitoring.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` (
    `consumer_offer_id` BIGINT COMMENT 'Unique identifier for the consumer-facing promotional offer. Primary key.',
    `campaign_id` BIGINT COMMENT 'Identifier of the broader marketing campaign that this consumer offer supports. Links to the marketing campaign entity. Null if not part of a campaign.',
    `category_id` BIGINT COMMENT 'Identifier of the product category associated with this consumer offer. Links to the product category master data entity.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Consumer offers (coupons, rebates, sweepstakes) are subject to distinct B2C compliance obligations — FTC disclosure rules, EU consumer promotion regulations, country-specific sweepstakes laws. Offer m',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Consumer offer costs (actual_cost_incurred, total_budget_allocated) are tracked against cost centers for marketing and trade spend reporting. Consumer Goods finance teams require cost center assignmen',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Consumer offers (coupons, digital offers, loyalty rewards) are often tied to specific promotion events — e.g., a digital coupon activated during a specific in-store event window. While consumer_offer ',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Consumer offers are planned against finance budgets. Budget vs. actual redemption cost reporting is a core Consumer Goods finance control. total_budget_allocated on consumer_offer must reconcile to th',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Consumer offer redemption costs post to specific GL accounts (coupon redemption expense, consumer promotion expense). Consumer Goods finance requires this link for accrual posting and period-end close',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Consumer offers are jurisdiction-specific instruments — a coupon valid in the US must comply with US rules; EU offers must meet EU consumer rights directives. Legal and regulatory teams need the gover',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Consumer offers are designed for marketing-defined consumer segments. The existing target_segment_id points to consumer.segment (a different domain). This new FK links to marketing.consumer_segment, e',
    `product_brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Consumer offers (coupons, rebates, loyalty rewards) in consumer goods are funded and approved by product brand teams — brand budgets fund consumer promotions. This link enables brand-level consumer of',
    `segment_id` BIGINT COMMENT 'Foreign key linking to consumer.consumer_segment. Business justification: Required for Offer‑to‑Segment targeting report; marketers need to join offers with consumer segments to measure lift and compliance.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Consumer offers in consumer goods are frequently retailer-exclusive (e.g., retailer-specific digital coupons, loyalty program offers). Linking consumer_offer to trade_account enables retailer-specific',
    `trade_promotion_id` BIGINT COMMENT 'Identifier of the parent trade promotion program that this consumer offer is part of. Links to the trade promotion entity. Null if offer is standalone.',
    `actual_cost_incurred` DECIMAL(18,2) COMMENT 'Actual total cost incurred from all redemptions of this offer to date. Used for budget variance analysis and financial reconciliation.',
    `actual_redemption_count` STRING COMMENT 'Actual number of times this offer has been redeemed by consumers to date. Updated in near real-time from POS (Point of Sale) and e-commerce systems.',
    `approval_status` STRING COMMENT 'Current approval status of the consumer offer in the governance workflow. Pending = awaiting review; Approved = authorized for activation; Rejected = not approved.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the consumer offer was approved. Null if not yet approved.',
    `barcode` STRING COMMENT 'Barcode value associated with the consumer offer for scanning at POS (Point of Sale). May be UPC (Universal Product Code), EAN (European Article Number), or proprietary coupon barcode format.',
    `consumer_offer_description` STRING COMMENT 'Detailed description of the consumer offer including terms, conditions, and value proposition. Used for consumer communication and internal reference.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the offer is valid (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consumer offer record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to qualifying purchase. Null if discount is fixed-value based. Expressed as decimal (e.g., 15.00 for 15% off).',
    `discount_value` DECIMAL(18,2) COMMENT 'Fixed monetary discount amount provided by the offer in the specified currency. Null if discount is percentage-based.',
    `distribution_channel` STRING COMMENT 'Primary channel through which the consumer offer is distributed. FSI = Free Standing Insert (newspaper); Digital = online/web; In-Store = physical retail location; DTC App = Direct-to-Consumer mobile application; Email = email marketing; Social Media = social platforms; POS = Point of Sale display. [ENUM-REF-CANDIDATE: fsi|digital|in_store|dtc_app|email|social_media|pos — 7 candidates stripped; promote to reference product]',
    `estimated_cost_per_redemption` DECIMAL(18,2) COMMENT 'Projected cost to the business for each redemption of this offer, including discount value and administrative costs. Used for budget planning and ROI (Return on Investment) analysis.',
    `funding_source` STRING COMMENT 'Entity responsible for funding the consumer offer discount. Brand = manufacturer-funded; Trade = trade promotion budget; Co-op = cooperative funding between manufacturer and retailer; Retailer = retailer-funded.. Valid values are `brand|trade|co_op|retailer`',
    `geographic_scope` STRING COMMENT 'Geographic reach of the consumer offer. National = available across entire country; Regional = specific regions or states; Local = specific cities or markets; Store-Specific = individual retail locations.. Valid values are `national|regional|local|store_specific`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consumer offer record was last modified in the system.',
    `maximum_redemption_per_customer` STRING COMMENT 'Maximum number of times a single customer can redeem this offer during the validity period. Null indicates unlimited redemptions.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum purchase value required to qualify for the offer. Null if no minimum purchase requirement exists.',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum number of qualifying units or SKUs (Stock Keeping Units) that must be purchased to redeem the offer. Null if no quantity requirement exists.',
    `offer_code` STRING COMMENT 'Unique alphanumeric code assigned to the consumer offer for redemption tracking and identification. Used by consumers at point of sale or digital checkout.. Valid values are `^[A-Z0-9]{6,20}$`',
    `offer_name` STRING COMMENT 'Marketing name or title of the consumer offer as displayed to consumers in promotional materials and digital channels.',
    `offer_status` STRING COMMENT 'Current lifecycle status of the consumer offer. Draft = under development; Approved = ready for activation; Active = currently redeemable; Paused = temporarily suspended; Expired = validity period ended; Cancelled = terminated before expiration.. Valid values are `draft|approved|active|paused|expired|cancelled`',
    `offer_type` STRING COMMENT 'Classification of the consumer offer mechanism. Coupon = physical or digital coupon; Digital Offer = app-based or online promotion; Loyalty Reward = points-based redemption; Instant Rebate = immediate price reduction; Free Goods = complimentary product with purchase; BOGO = Buy One Get One; Bundle Discount = multi-product savings. [ENUM-REF-CANDIDATE: coupon|digital_offer|loyalty_reward|instant_rebate|free_goods|bogo|bundle_discount — 7 candidates stripped; promote to reference product]',
    `qualifying_sku_list` STRING COMMENT 'Comma-separated list of SKU identifiers or product codes that qualify for this offer. May reference specific products, product families, or categories. Null if offer applies to all products.',
    `redemption_channel` STRING COMMENT 'Channel where the consumer can redeem the offer. In-Store = physical retail; Online = e-commerce website; Mobile App = DTC (Direct-to-Consumer) mobile application; Call Center = phone order; Any = omnichannel redemption allowed.. Valid values are `in_store|online|mobile_app|call_center|any`',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this offer can be combined with other offers or promotions. True = can be stacked; False = exclusive offer.',
    `terms_and_conditions` STRING COMMENT 'Full legal terms and conditions governing the use and redemption of this consumer offer. Includes restrictions, exclusions, and compliance requirements.',
    `total_budget_allocated` DECIMAL(18,2) COMMENT 'Total budget amount allocated for this consumer offer across all redemptions. Used for financial planning and spend tracking.',
    `total_redemption_limit` STRING COMMENT 'Maximum total number of redemptions allowed across all customers for this offer. Null indicates no aggregate limit.',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether the offer can be transferred or shared between consumers. True = transferable; False = non-transferable, tied to original recipient.',
    `valid_from_date` DATE COMMENT 'Start date when the consumer offer becomes active and redeemable. Consumers cannot redeem the offer before this date.',
    `valid_to_date` DATE COMMENT 'End date when the consumer offer expires and is no longer redeemable. Consumers cannot redeem the offer after this date.',
    CONSTRAINT pk_consumer_offer PRIMARY KEY(`consumer_offer_id`)
) COMMENT 'Master entity defining consumer-facing promotional offers (coupons, digital offers, loyalty rewards, instant rebates, free goods with purchase) that are part of a trade promotion or brand marketing program. Captures offer code, offer type, offer description, discount value/percentage, qualifying SKUs, minimum purchase requirement, offer validity period, distribution channel (FSI, digital, in-store, DTC app), maximum redemption limit, and offer status. Distinct from trade funding — this entity owns the consumer-facing offer definition.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_trade_calendar_id` FOREIGN KEY (`trade_calendar_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_trade_calendar_id` FOREIGN KEY (`trade_calendar_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_parent_calendar_trade_calendar_id` FOREIGN KEY (`parent_calendar_trade_calendar_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_previous_agreement_funding_agreement_id` FOREIGN KEY (`previous_agreement_funding_agreement_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_deduction_id` FOREIGN KEY (`deduction_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`deduction`(`deduction_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_parent_settlement_deduction_settlement_id` FOREIGN KEY (`parent_settlement_deduction_settlement_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`deduction_settlement`(`deduction_settlement_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_baseline_volume_id` FOREIGN KEY (`baseline_volume_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`baseline_volume`(`baseline_volume_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_baseline_volume_id` FOREIGN KEY (`baseline_volume_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`baseline_volume`(`baseline_volume_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_funding_agreement_id` FOREIGN KEY (`funding_agreement_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`funding_agreement`(`funding_agreement_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_promotion`(`trade_promotion_id`);

-- ========= TAGS =========
ALTER SCHEMA `consumer_goods_ecm`.`promotion` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `consumer_goods_ecm`.`promotion` SET TAGS ('dbx_domain' = 'promotion');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Accrual Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Approval Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `authorized_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Trade Spend Budget Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `authorized_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Retail Channel Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'grocery|mass_merchandiser|drug|convenience|club|ecommerce');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `coupon_flag` SET TAGS ('dbx_business_glossary_term' = 'Coupon Included Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Deduction Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `display_type` SET TAGS ('dbx_business_glossary_term' = 'In-Store Display Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `display_type` SET TAGS ('dbx_value_regex' = 'end_cap|free_standing|shelf_talker|pallet|cooler|none');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `expected_roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expected Return on Investment (ROI) Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `expected_roi_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `feature_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Feature Advertisement Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `funding_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Funding Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `funding_type` SET TAGS ('dbx_value_regex' = 'off_invoice|scan_back|bill_back|lump_sum|accrual');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `maximum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Purchase Quantity');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity (MOQ)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Promotion Notes');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Classification');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'hi_lo|edlp|hybrid');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Name');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Number');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_number` SET TAGS ('dbx_value_regex' = '^TPM-[0-9]{8}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_objective` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Objective');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_objective` SET TAGS ('dbx_value_regex' = 'volume_growth|market_share_gain|new_product_launch|competitive_defense|inventory_clearance|seasonal_event');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_value_regex' = 'planned|approved|active|closed|cancelled|on_hold');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'temporary_price_reduction|feature_ad|display|bogo|multi_buy|scan_back');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Settlement Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|settled|disputed');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `target_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Target Volume Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `target_volume_units` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ALTER COLUMN `tpm_system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System Reference ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Program ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `actual_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Trade Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `actual_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Event End Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_execution|completed|cancelled');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'feature_ad|display|temporary_price_reduction|bogo|scan_back|coupon');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'manufacturer|retailer|cooperative');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `gmroi_ratio` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Ratio');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `planned_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Trade Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `planned_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `post_event_analysis_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Analysis Completed Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `post_event_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Analysis Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'hi_lo|edlp|hybrid');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `promotional_lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Promotional Lift Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `salesforce_tpm_event_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Trade Promotion Management (TPM) Event ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `salesforce_tpm_event_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|settled|disputed');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `event_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event SKU (Stock Keeping Unit) ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Funding Agreement ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `actual_promotional_volume_cases` SET TAGS ('dbx_business_glossary_term' = 'Actual Promotional Volume (Cases)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `actual_promotional_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Promotional Volume (Units)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `baseline_volume_estimate_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Estimate (Units)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'Not Checked|Compliant|Non-Compliant|Under Review');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `compliance_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `display_location_type` SET TAGS ('dbx_business_glossary_term' = 'Display Location Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `feature_type` SET TAGS ('dbx_business_glossary_term' = 'Feature Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'GTIN (Global Trade Item Number)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `incremental_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `incremental_lift_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Volume (Units)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `is_featured_sku` SET TAGS ('dbx_business_glossary_term' = 'Is Featured SKU Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `planned_promotional_volume_cases` SET TAGS ('dbx_business_glossary_term' = 'Planned Promotional Volume (Cases)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `planned_promotional_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Planned Promotional Volume (Units)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `price_reduction_depth_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Reduction Depth Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `pricing_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Approval Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `pricing_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pricing Approved Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `promoted_price` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `promoted_price_type` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `promotion_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `promotion_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `promotional_discount_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Per Unit');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `promotional_gmroi` SET TAGS ('dbx_business_glossary_term' = 'Promotional GMROI (Gross Margin Return on Investment)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `promotional_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Promotional ROI (Return on Investment) Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `regular_shelf_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Shelf Price (RSP)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Reconciled|Settled|Disputed');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `total_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Trade Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'UPC (Universal Product Code)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Identifier');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `parent_calendar_trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Calendar ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `actual_event_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Event Count');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Calendar Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Calendar Name');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Calendar Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|locked|active|closed');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `is_baseline_calendar` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Calendar');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `locked_date` SET TAGS ('dbx_business_glossary_term' = 'Locked Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Calendar Notes');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `planned_event_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Event Count');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `planning_cycle` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `planning_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|monthly');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'hi-lo|edlp|hybrid|promotional|premium');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `total_planned_trade_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Trade Spend');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `total_planned_trade_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `tpm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `trade_calendar_description` SET TAGS ('dbx_business_glossary_term' = 'Calendar Description');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` SET TAGS ('dbx_subdomain' = 'spend_settlement');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_spend_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Allocation ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `actual_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Allocation Number');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^TSA-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `baseline_volume` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `gmroi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'hi_lo|edlp|hybrid|premium|penetration|competitive');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `promotion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `promotion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spend_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `spend_type` SET TAGS ('dbx_value_regex' = 'off_invoice_discount|scan_back|bill_back|lump_sum|coop_advertising|slotting_fee');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `target_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Volume');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'units|cases|pallets|kg|liters');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `previous_agreement_funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Agreement ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'straight_line|event_based|scan_based|milestone_based');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `accrued_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued To Date Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{6,10}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'annual_lump_sum|scan_back|co_op|slotting|performance_based|volume_rebate');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_required');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `deduction_settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Deduction Settlement Terms');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `funding_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Period End Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `funding_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Period Start Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `gmroi_target` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Target');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `manufacturer_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Signatory Name');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `manufacturer_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Signatory Title');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `manufacturer_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Signature Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `paid_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid To Date Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annual|annual|event_based');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `performance_conditions` SET TAGS ('dbx_business_glossary_term' = 'Performance Conditions');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `remaining_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `retailer_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Signatory Name');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `retailer_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Retailer Signatory Title');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `retailer_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Retailer Signature Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `roi_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Target Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ALTER COLUMN `total_committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` SET TAGS ('dbx_subdomain' = 'spend_settlement');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `deduction_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Deduction ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Delivery Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `accrual_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Accrual Impact Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Reference Number');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `deduction_date` SET TAGS ('dbx_business_glossary_term' = 'Deduction Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `deduction_number` SET TAGS ('dbx_business_glossary_term' = 'Deduction Number');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `deduction_source` SET TAGS ('dbx_business_glossary_term' = 'Deduction Source');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `deduction_source` SET TAGS ('dbx_value_regex' = 'retailer_portal|edi_846|manual_entry|bank_reconciliation|automated_matching');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `deduction_type` SET TAGS ('dbx_business_glossary_term' = 'Deduction Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|approved|disputed|partially_approved|written_off|pending_review');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `gmroi_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Impact Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `retailer_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Retailer Claim Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Retailer Contact Email');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Contact Name');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `retailer_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `roi_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Impact Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Settled Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'credit_memo|check|offset_future_invoice|write_off|bank_transfer');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `settlement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reason Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `sla_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ALTER COLUMN `supporting_document_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` SET TAGS ('dbx_subdomain' = 'spend_settlement');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Deduction Settlement Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_id` SET TAGS ('dbx_business_glossary_term' = 'Deduction Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `parent_settlement_deduction_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Settlement Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Settlement Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `deduction_claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Claimed Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'negotiation|arbitration|escalation|partial_approval|full_approval|write_off');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `is_partial_settlement` SET TAGS ('dbx_business_glossary_term' = 'Is Partial Settlement Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Settled Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Time in Days');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'credit_memo|check|wire_transfer|offset_invoice|write_off|accrual_adjustment');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Number');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_value_regex' = '^STL-[0-9]{8,12}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reason Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reason Description');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `post_event_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Post Event Analysis ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_volume_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `oos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Oos Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `actual_promoted_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Promoted Volume Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `actual_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Trade Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `actual_trade_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `analysis_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completed Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `analysis_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period End Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `analysis_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period Start Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Analysis Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|approved|rejected|archived');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Baseline Confidence Interval Lower Bound');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Baseline Confidence Interval Upper Bound');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_data_source` SET TAGS ('dbx_business_glossary_term' = 'Baseline Data Source');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_data_source` SET TAGS ('dbx_value_regex' = 'pos_scan|nielsen_iq|tradeedge_secondary|internal_shipment|syndicated_panel|custom');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_estimation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Baseline Estimation Methodology');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `cost_per_incremental_case` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Incremental Case');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `cost_per_incremental_case` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `data_vintage_date` SET TAGS ('dbx_business_glossary_term' = 'Data Vintage Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `display_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Display Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `feature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Feature Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `gmroi` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `gmroi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `incremental_lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `incremental_lift_units` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `learning_classification` SET TAGS ('dbx_business_glossary_term' = 'Learning Classification');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `learning_classification` SET TAGS ('dbx_value_regex' = 'best_practice|acceptable|underperformer|failure|outlier');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `lift_measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Lift Measurement Methodology');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `lift_measurement_methodology` SET TAGS ('dbx_value_regex' = 'simple_difference|control_group|matched_market|time_series|causal_impact|machine_learning');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `lift_measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Lift Measurement Source');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `lift_measurement_source` SET TAGS ('dbx_value_regex' = 'pos_scan|nielsen_iq_panel|tradeedge_secondary|internal_shipment|syndicated_data|blended');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `oos_impact_estimated_units` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Impact Estimated Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `oos_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Incident Count');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `planned_trade_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Trade Spend Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `planned_trade_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `pre_promotion_trend` SET TAGS ('dbx_business_glossary_term' = 'Pre-Promotion Trend');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `pre_promotion_trend` SET TAGS ('dbx_value_regex' = 'increasing|stable|decreasing|seasonal|volatile');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `pricing_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Pricing Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `promotional_roi` SET TAGS ('dbx_business_glossary_term' = 'Promotional Return on Investment (ROI)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `promotional_roi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `recommendation_for_future` SET TAGS ('dbx_business_glossary_term' = 'Recommendation for Future Promotions');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `recommendation_for_future` SET TAGS ('dbx_value_regex' = 'repeat|modify|avoid|test_further|scale_up');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `retailer_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Retailer Compliance Score');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `sell_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Sell-Through Rate');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `trade_spend_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Variance Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ALTER COLUMN `trade_spend_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `promoted_price_id` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Identifier');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'scan_back|bill_back|off_invoice|lump_sum|performance_based');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `estimated_volume_lift` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume Lift Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'manufacturer|retailer|co_op|vendor|third_party');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `is_advertised` SET TAGS ('dbx_business_glossary_term' = 'Is Advertised Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Is Stackable Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `maximum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Purchase Quantity');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `price_reduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Reduction Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `pricing_strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `promotional_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Allowance Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_description` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Description');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `promotional_price_name` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Name');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `regular_shelf_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Shelf Price (RSP)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `retailer_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retailer Margin Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `scan_back_rate` SET TAGS ('dbx_business_glossary_term' = 'Scan-Back Rate');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ALTER COLUMN `tpm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `lift_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Lift Measurement ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_volume_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `oos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Oos Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `actual_promoted_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Promoted Volume Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Baseline Calculation Method');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_calculation_method` SET TAGS ('dbx_value_regex' = 'moving_average|exponential_smoothing|linear_regression|seasonal_decomposition|custom_model');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_period_weeks` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Weeks');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `baseline_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `cannibalization_rate` SET TAGS ('dbx_business_glossary_term' = 'Cannibalization Rate');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `confidence_level_percentage` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `data_vintage_date` SET TAGS ('dbx_business_glossary_term' = 'Data Vintage Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `halo_effect_units` SET TAGS ('dbx_business_glossary_term' = 'Halo Effect Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `incremental_lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `incremental_lift_units` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `incremental_revenue` SET TAGS ('dbx_business_glossary_term' = 'Incremental Revenue');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `lift_source` SET TAGS ('dbx_business_glossary_term' = 'Lift Source');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `lift_source` SET TAGS ('dbx_value_regex' = 'pos_scan_data|nielsen_iq_panel|tradeedge_secondary_sales|iri_panel|internal_shipment_data|syndicated_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_value_regex' = 'pre_post_comparison|control_group|time_series_regression|matched_market|causal_impact');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'preliminary|validated|final|revised|rejected');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_week_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Week End Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `measurement_week_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Week Start Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `post_promotion_dip_units` SET TAGS ('dbx_business_glossary_term' = 'Post-Promotion Dip Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `promotional_price` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `regular_price` SET TAGS ('dbx_business_glossary_term' = 'Regular Price');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `statistical_significance_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `tpm_system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System Reference ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `retailer_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Compliance ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `account_call_id` SET TAGS ('dbx_business_glossary_term' = 'Account Call Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `oos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Oos Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `actual_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Actual Retail Price');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `ad_feature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Ad Feature Compliant Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `agreed_promotional_price` SET TAGS ('dbx_business_glossary_term' = 'Agreed Promotional Price');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `audit_method` SET TAGS ('dbx_value_regex' = 'field_rep_visit|third_party_audit|pos_data_analysis|photo_verification|retailer_self_report');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial_compliant|pending_review|disputed');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `compliance_type` SET TAGS ('dbx_value_regex' = 'ad_feature|display|price_compliance|osa|pog_placement|multi_mechanic');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'sfa_field_audit|third_party_service|pos_integration|retailer_portal|manual_entry');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `data_source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Data Source Reference ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `display_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Display Compliant Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `funding_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Adjustment Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `non_compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Category');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `non_compliance_category` SET TAGS ('dbx_value_regex' = 'inventory_shortage|pricing_error|display_not_built|ad_omission|operational_failure|system_error');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `osa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Compliant Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `photo_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence URL');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `pog_placement_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Placement Compliant Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `price_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Compliant Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|partial_adjustment|withdrawn');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_volume_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `market_research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Market Research Study Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `analyst_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Analyst Override Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_methodology` SET TAGS ('dbx_business_glossary_term' = 'Baseline Methodology');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_methodology` SET TAGS ('dbx_value_regex' = 'moving_average|regression|nielsen_iq_panel|bayesian_structural_time_series|exponential_smoothing|seasonal_decomposition');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period End Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Start Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Revenue Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_status` SET TAGS ('dbx_business_glossary_term' = 'Baseline Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `baseline_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|archived|superseded|rejected');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `cases` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Cases');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percent');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'pos|nielsen_iq|iri|internal_sales|trade_edge|syndicated_panel');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `historical_lookback_weeks` SET TAGS ('dbx_business_glossary_term' = 'Historical Lookback Weeks');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `last_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `model_accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Model Accuracy Score');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `outlier_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Outlier Exclusion Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `promotional_periods_excluded_count` SET TAGS ('dbx_business_glossary_term' = 'Promotional Periods Excluded Count');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `seasonality_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Adjustment Factor');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `tpm_system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) System Reference ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `trend_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Trend Adjustment Factor');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ALTER COLUMN `units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Units');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` SET TAGS ('dbx_subdomain' = 'trade_planning');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `consumer_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Offer ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion ID');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `actual_cost_incurred` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Incurred');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `actual_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Redemption Count');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Offer Barcode');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `consumer_offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `estimated_cost_per_redemption` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Per Redemption');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'brand|trade|co_op|retailer');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|local|store_specific');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `maximum_redemption_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Per Customer');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_business_glossary_term' = 'Offer Name');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|paused|expired|cancelled');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `qualifying_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Qualifying SKU (Stock Keeping Unit) List');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile_app|call_center|any');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `total_budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Allocated');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `total_redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Limit');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable Flag');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
