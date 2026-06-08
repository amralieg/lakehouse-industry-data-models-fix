-- Schema for Domain: promotion | Business: Grocery | Version: v1_mvm
-- Generated on: 2026-05-04 20:42:52

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`promotion` COMMENT 'Marketing campaigns, weekly ad circulars, BOGO offers, TPRs, digital coupons, personalized deals, and loyalty reward promotions. Manages promotion planning, calendars, offer eligibility rules, execution, redemption tracking, markdown optimization, and GMROI analysis. Supports slotting fee negotiations and post-promotion performance measurement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`promo_campaign` (
    `promo_campaign_id` BIGINT COMMENT 'Unique identifier for the promotional campaign. Primary key.',
    `banner_id` BIGINT COMMENT 'Foreign key linking to store.banner. Business justification: Promotional campaigns in grocery retail are banner-scoped — a campaign runs for Kroger banner vs. Fred Meyer banner with distinct budgets, mechanics, and approval workflows. Campaign planners and fina',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Promotional campaigns are planned against formal finance budgets; budget vs. actual trade spend variance reporting is a core retail-grocery finance process. Linking campaign to budget enables real-tim',
    `category_id` BIGINT COMMENT 'Primary merchandise category targeted by this campaign for assortment focus and performance measurement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed for Promotion Budget vs Actual report; campaigns are budgeted to cost centers to track spend versus allocated budget.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Promotional campaigns are planned, budgeted, and reported within fiscal periods. Retail-grocery finance teams produce campaign P&L reports by fiscal period; this link enables budget vs. actual trade s',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.format. Business justification: Promotional campaigns in grocery retail are frequently format-targeted — a supercenter campaign differs from a neighborhood market campaign in mechanics, SKU depth, and display requirements. Campaign ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for Promotion Expense GL Mapping report; each campaign must post its costs to a specific GL account for monthly financial close.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Major promotional campaigns (holiday, grand opening) are tracked as internal orders in retail-grocery finance systems (SAP CO) for cost collection and settlement. This enables campaign-level cost accu',
    `new_item_intro_id` BIGINT COMMENT 'Foreign key linking to assortment.new_item_intro. Business justification: New item introductions in grocery are routinely supported by launch campaigns (introductory pricing, feature placement). Category managers track new item launch performance against the supporting camp',
    `plan_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_plan. Business justification: Grocery category management requires promotional campaigns to be scoped to specific assortment plan periods (seasonal resets, category reviews). Merchandising teams validate that promoted items are ra',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Campaign‑pricing zone assignment report used to allocate promotional budgets per pricing zone.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Promotional campaigns are attributed to profit centers (banner/division/store cluster) for divisional P&L reporting. Retail-grocery chains run campaigns by banner; profit center attribution enables ba',
    `promo_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_calendar. Business justification: Link campaigns to their planning calendar; child (promo_campaign) gets FK to parent (promo_calendar). No existing reverse link, resolves silo for promo_calendar.',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: REQUIRED: Campaign Store‑Cluster Targeting report needs campaign.store_cluster_id to map each promo campaign to the store clusters it targets.',
    `supplier_id` BIGINT COMMENT 'Identifier of the Consumer Packaged Goods (CPG) vendor or supplier sponsoring or co-funding the campaign.',
    `segment_id` BIGINT COMMENT 'Customer segment the campaign is designed to reach, used for personalized offer eligibility and targeting.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Promotional campaigns funded by vendors (co-op advertising, slotting commitments) are governed by trade agreements. Trade promotion management systems link campaigns to the specific trade agreement au',
    `ad_circular_week` STRING COMMENT 'ISO week identifier for the weekly ad circular publication associated with this campaign (format: YYYY-Www).. Valid values are `^d{4}-Wd{2}$`',
    `approval_workflow_status` STRING COMMENT 'Current state of the campaign in the multi-stage approval process across merchandising, finance, and legal functions.. Valid values are `not_submitted|pending_merchandising|pending_finance|pending_legal|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign received final approval and was authorized for execution.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for the campaign in USD, covering markdowns, vendor funding, and execution costs.',
    `campaign_code` STRING COMMENT 'Externally-known unique business identifier for the campaign, used in marketing materials, ad circulars, and system integrations.. Valid values are `^[A-Z0-9]{6,20}$`',
    `campaign_name` STRING COMMENT 'Human-readable name of the promotional campaign for internal reference and reporting.',
    `campaign_objective` STRING COMMENT 'Primary business goal the campaign is designed to achieve, driving offer design and performance measurement.. Valid values are `trial|frequency|basket_size|loyalty_acquisition|clearance|seasonal_sell_through`',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the promotional campaign in the approval and execution workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|completed|cancelled|suspended — 7 candidates stripped; promote to reference product]',
    `campaign_type` STRING COMMENT 'Classification of the promotional campaign by execution format and channel strategy.. Valid values are `weekly_ad_circular|digital|in_store_event|seasonal|vendor_sponsored|loyalty_exclusive`',
    `cancellation_reason` STRING COMMENT 'Explanation for why the campaign was cancelled or suspended before completion, if applicable.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign was cancelled or suspended.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the campaign ends and offers are no longer available for redemption.',
    `effective_start_date` DATE COMMENT 'Date when the campaign becomes active and offers are available for customer redemption.',
    `expected_incremental_sales` DECIMAL(18,2) COMMENT 'Projected incremental revenue in USD attributed to the campaign, above baseline sales without promotion.',
    `expected_redemption_count` STRING COMMENT 'Forecasted number of offer redemptions expected during the campaign period, used for budget planning and inventory allocation.',
    `is_digital_coupon_enabled` BOOLEAN COMMENT 'Indicates whether the campaign includes digital coupons that customers can clip and redeem via mobile app or online account.',
    `is_loyalty_exclusive` BOOLEAN COMMENT 'Indicates whether campaign offers are available exclusively to loyalty program members.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was most recently updated.',
    `legal_disclaimer` STRING COMMENT 'Legal terms, conditions, and disclaimers required for campaign advertising and offer redemption compliance.',
    `planning_start_date` DATE COMMENT 'Date when campaign planning and design activities commenced.',
    `promo_campaign_description` STRING COMMENT 'Detailed narrative describing the campaign strategy, target audience, key offers, and expected business outcomes.',
    `promotion_mechanics` STRING COMMENT 'Description of the offer structure and redemption rules, such as Buy One Get One (BOGO), Temporary Price Reduction (TPR), or multi-buy thresholds.',
    `target_channel` STRING COMMENT 'Primary sales and fulfillment channel where the campaign will be executed and offers redeemed.. Valid values are `in_store|digital|omnichannel|pickup|delivery`',
    `target_gmroi` DECIMAL(18,2) COMMENT 'Target Gross Margin Return on Investment ratio for the campaign, measuring profitability of promotional spend.',
    `vendor_funding_amount` DECIMAL(18,2) COMMENT 'Amount in USD contributed by the vendor partner toward campaign costs, including slotting fees and markdown support.',
    CONSTRAINT pk_promo_campaign PRIMARY KEY(`promo_campaign_id`)
) COMMENT 'Master record for a promotional marketing campaign. Captures campaign identity, type (weekly ad circular, digital, in-store event, seasonal, vendor-sponsored), planning horizon, budget allocation, sponsoring vendor/CPG partner, campaign objectives (trial, frequency, basket size, loyalty acquisition), target channel (in-store, digital, omnichannel), approval workflow status, and lifecycle state (draft, approved, active, completed, cancelled). Top-level organizing entity for all promotional activity. Source of truth for campaign planning, budget management, and post-promotion performance measurement.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`promo_offer` (
    `promo_offer_id` BIGINT COMMENT 'Unique identifier for the promotional offer. Primary key for the promo_offer product.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: REQUIRED: Offer Category Targeting analysis uses promo_offer.category_id to associate each offer with the category it discounts.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Offer zone‑specific pricing ensures correct discount application across regional price zones.',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign that contains this offer.',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: Promotional offers are executed at the store cluster level in grocery — offer eligibility, discount depth, and redemption limits vary by cluster based on competitive intensity and demographics. This l',
    `supplier_id` BIGINT COMMENT 'Reference to the Consumer Packaged Goods (CPG) vendor or supplier funding or co-funding this offer. Null for grocer-funded offers.',
    `segment_id` BIGINT COMMENT 'Reference to the customer segment this offer is targeted to. Null for mass offers or individual personalization.',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Tender-linked promotional offers are a standard grocery retail business process: Save $5 when you pay with our store Visa card. promo_offer must reference the qualifying tender_type to enforce eligi',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Offer funding and rebate terms are governed by trade agreements; linking enables agreement compliance reporting.',
    `activation_requirement` STRING COMMENT 'Action required by the customer to activate the offer. Auto-apply (no action), clip-required (digital coupon clipping), loyalty-required (loyalty program membership), or code-entry (manual coupon code input).. Valid values are `auto_apply|clip_required|loyalty_required|code_entry`',
    `clip_required_flag` BOOLEAN COMMENT 'Indicates whether the customer must explicitly clip or activate this digital coupon before redemption. True if clipping required, False if auto-applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional offer record was first created in the system.',
    `delivery_channel` STRING COMMENT 'Primary communication channel used to deliver this offer to targeted customers.. Valid values are `email|mobile_app|sms|direct_mail|in_store|web`',
    `digital_coupon_barcode` STRING COMMENT 'Barcode or QR code value for digital coupon redemption at Point of Sale (POS). Null for non-digital-coupon offers.',
    `digital_coupon_format` STRING COMMENT 'Barcode format standard used for digital coupon encoding. Null for non-digital-coupon offers.. Valid values are `upc_a|databar|qr_code|code_128`',
    `discount_type` STRING COMMENT 'Method by which the discount value is calculated and applied.. Valid values are `percentage|fixed_amount|free_item|tiered`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount. Interpretation depends on discount_type (percentage points for percentage, dollar amount for fixed_amount).',
    `eligible_channel` STRING COMMENT 'Sales channel where this offer can be redeemed. Supports omnichannel promotion strategy.. Valid values are `in_store|online|mobile_app|kiosk|all_channels`',
    `exclusion_rules` STRING COMMENT 'Business rules defining products, categories, or conditions that are explicitly excluded from this offer.',
    `funding_source` STRING COMMENT 'Entity responsible for funding the promotional discount. Vendor-funded (trade promotion), grocer-funded (markdown), or co-funded (shared investment).. Valid values are `vendor_funded|grocer_funded|co_funded`',
    `gmroi_target` DECIMAL(18,2) COMMENT 'Target Gross Margin Return on Investment ratio for this promotional offer. Used for post-promotion performance measurement and optimization.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points awarded to the customer upon redemption of this offer. Null if no points are earned.',
    `loyalty_points_required` STRING COMMENT 'Number of loyalty program points required to redeem this offer. Null if not a points-based loyalty reward.',
    `manufacturer_coupon_flag` BOOLEAN COMMENT 'Indicates whether this is a manufacturer-issued coupon funded by the Consumer Packaged Goods (CPG) vendor. True for manufacturer coupons, False for retailer coupons.',
    `maximum_discount_amount` DECIMAL(18,2) COMMENT 'Cap on the total dollar discount that can be applied per transaction. Null if no cap applies.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum dollar amount of qualifying items required to activate the offer. Null if no minimum threshold applies.',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum quantity of qualifying items required to activate the offer. Null if no quantity threshold applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional offer record was last modified.',
    `offer_code` STRING COMMENT 'Externally-known unique code for the promotional offer. Used for tracking, redemption, and customer communication.. Valid values are `^[A-Z0-9]{6,20}$`',
    `offer_description` STRING COMMENT 'Detailed description of the promotional offer including terms, conditions, and value proposition.',
    `offer_name` STRING COMMENT 'Human-readable name of the promotional offer displayed to customers.',
    `offer_status` STRING COMMENT 'Current lifecycle status of the promotional offer.. Valid values are `draft|scheduled|active|paused|expired|cancelled`',
    `offer_subtype` STRING COMMENT 'Secondary classification indicating the delivery and targeting mechanism of the offer.. Valid values are `digital_coupon|loyalty_reward|personalized_deal|mass_offer|ad_circular|endcap_promo`',
    `offer_type` STRING COMMENT 'Classification of the promotional offer mechanics. BOGO (Buy One Get One), TPR (Temporary Price Reduction), percent-off, dollar-off, mix-and-match, or bundle.. Valid values are `bogo|tpr|percent_off|dollar_off|mix_and_match|bundle`',
    `personalization_model_code` STRING COMMENT 'Identifier of the machine learning model or rule set used to generate this personalized offer. Null for mass offers.',
    `personalization_type` STRING COMMENT 'Method used to target and personalize this offer. ML model (machine learning recommendation), rule-based (business rule segmentation), mass (broadcast to all), or segment-targeted (predefined customer segment).. Valid values are `ml_model|rule_based|mass|segment_targeted`',
    `priority_rank` STRING COMMENT 'Numeric priority used to resolve conflicts when multiple offers apply to the same item. Lower numbers indicate higher priority.',
    `redemption_limit_per_customer` STRING COMMENT 'Maximum number of times a single customer or household can redeem this offer during its validity period. Null for unlimited redemptions.',
    `redemption_limit_per_transaction` STRING COMMENT 'Maximum number of times this offer can be applied within a single transaction. Null for unlimited applications per transaction.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this offer can be combined with other offers in the same transaction. True if stackable, False if mutually exclusive.',
    `terms_and_conditions` STRING COMMENT 'Full legal terms and conditions governing the use and redemption of this promotional offer.',
    `valid_from_date` DATE COMMENT 'Start date when the offer becomes active and eligible for redemption.',
    `valid_to_date` DATE COMMENT 'End date when the offer expires and is no longer eligible for redemption.',
    CONSTRAINT pk_promo_offer PRIMARY KEY(`promo_offer_id`)
) COMMENT 'Atomic unit of promotional value delivered to shoppers within a campaign. Captures offer mechanics (BOGO, TPR, percent-off, dollar-off, mix-and-match, bundle, loyalty reward, digital coupon, personalized deal), discount calculation rules, minimum purchase thresholds, maximum redemption limits, offer validity window, eligible channels (in-store, app, web, kiosk), stackability rules, funding source (vendor-funded vs. grocer-funded), activation requirements (auto-apply vs. clip-required), personalization targeting (ML model, rule-based, mass), delivery channel for targeted offers, digital coupon attributes (barcode/QR code, clip status, clip timestamp, coupon code, issuing channel, CPG manufacturer funding), personalization metadata (generation source, targeting rationale, customer/household linkage, deal acceptance/redemption outcome, behavioral signal inputs). Each campaign contains multiple offers targeting different SKUs, customer segments, or channels. Single Source of Truth for ALL promotional offer types including digital coupons, personalized deals, loyalty rewards, and mass offers — no other product in this domain models offer-level promotional value.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`promo_calendar` (
    `promo_calendar_id` BIGINT COMMENT 'Unique identifier for the promotional calendar entry. Primary key for the promotional calendar planning entity.',
    `banner_id` BIGINT COMMENT 'Foreign key linking to store.banner. Business justification: Promotional calendars in grocery retail are fundamentally banner-specific — each banner (Kroger, Ralphs, Fred Meyer) maintains its own weekly ad schedule and promotional event calendar. Merchandising ',
    `category_id` BIGINT COMMENT 'Reference to the primary product category that this promotional calendar entry focuses on (e.g., Fresh Produce, Dairy, Meat, Bakery). Nullable if promotion spans multiple categories.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Promotional calendars are explicitly organized around fiscal quarters and periods; the fiscal period drives the promotional planning cycle. Retail-grocery merchandising teams build promo calendars ali',
    `plan_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_plan. Business justification: Promotional calendars are built in lockstep with assortment planning cycles (fiscal_quarter/fiscal_year alignment exists on both). Category managers use this link to synchronize ad circular slots with',
    `store_cluster_id` BIGINT COMMENT 'Reference to the store cluster or zone that this promotional calendar entry applies to. Store clusters group stores by geography, demographics, or performance characteristics for targeted promotional planning. Nullable if promotion applies to all stores.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Calendar budgeting and supplier‑funded promotions need supplier attribution for financial reconciliation.',
    `ad_circular_print_flag` BOOLEAN COMMENT 'Indicates whether this promotional calendar entry will be featured in the printed weekly ad circular flyer. True means print ad placement is planned; False means digital-only or in-store signage only.',
    `ad_circular_week` STRING COMMENT 'The week number within the fiscal year that this promotional calendar entry corresponds to, used for weekly ad circular planning and coordination. Aligns with retail fiscal calendar conventions.',
    `approval_date` DATE COMMENT 'The date when this promotional calendar entry received executive or merchandising leadership approval to proceed. Nullable if still in draft or planning status.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or manager who approved this promotional calendar entry. Used for governance and audit trail purposes. Nullable if not yet approved.',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether this calendar entry represents a blackout period during which no new promotions should be scheduled. True means this is a blackout period (e.g., inventory count week, system maintenance); False means normal promotional activity is allowed.',
    `calendar_code` STRING COMMENT 'Short alphanumeric code used to reference the promotional calendar in operational systems and reports (e.g., Q4-2024-HOL, SP-FRESH-01).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `calendar_name` STRING COMMENT 'Business-friendly name for the promotional calendar period (e.g., Q4 Holiday Campaign 2024, Spring Fresh Produce Event).',
    `calendar_status` STRING COMMENT 'Current lifecycle state of the promotional calendar entry. Draft indicates initial planning; planned means dates are set but not approved; approved indicates executive sign-off; active means promotion is currently running; completed means promotion has ended; cancelled indicates promotion was terminated before completion.. Valid values are `draft|planned|approved|active|completed|cancelled`',
    `calendar_type` STRING COMMENT 'Classification of the promotional calendar entry by its business purpose and funding model. Weekly ad circular represents recurring weekly promotional cycles; seasonal event covers spring, summer, fall, winter campaigns; holiday promotion targets specific holidays; category event focuses on specific product categories; vendor funded indicates supplier-sponsored promotions; markdown clearance represents end-of-season or overstock price reductions.. Valid values are `weekly_ad_circular|seasonal_event|holiday_promotion|category_event|vendor_funded|markdown_clearance`',
    `conflict_resolution_notes` STRING COMMENT 'Free-text notes documenting any promotional conflicts detected with other calendar entries (overlapping dates, same category, same store cluster) and how they were resolved. Used for planning coordination and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional calendar entry was first created in the system. Used for audit trail and planning timeline analysis.',
    `digital_coupon_flag` BOOLEAN COMMENT 'Indicates whether this promotional calendar entry includes digital coupon offers that customers can clip via mobile app or website. True means digital coupons are part of the promotion; False means no digital coupon component.',
    `end_date` DATE COMMENT 'The date when the promotional period ends. This is the last day that promotional pricing and offers are valid. Nullable for open-ended promotions.',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'The estimated total budget allocated for this promotional calendar entry, including markdown costs, advertising spend, and vendor co-op funding. Expressed in the retailers reporting currency (typically USD).',
    `event_theme` STRING COMMENT 'The marketing theme or creative concept for the promotional period (e.g., Back to School, Summer BBQ, Holiday Feast, Fresh Start January). Used for merchandising and marketing alignment.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (Q1, Q2, Q3, Q4) to which this promotional calendar entry belongs, used for quarterly promotional planning and performance analysis.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this promotional calendar entry belongs, following the retailers fiscal calendar (e.g., 2024, 2025).',
    `loyalty_exclusive_flag` BOOLEAN COMMENT 'Indicates whether this promotional calendar entry is exclusive to loyalty program members. True means only loyalty cardholders can access the promotional pricing; False means promotion is available to all customers.',
    `merchandising_notes` STRING COMMENT 'Free-text notes from merchandising team regarding assortment planning, display requirements, inventory positioning, or special handling instructions for this promotional calendar entry.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this promotional calendar entry. Used for accountability and audit trail purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this promotional calendar entry was last modified. Used for change tracking and audit trail purposes.',
    `overlap_allowed_flag` BOOLEAN COMMENT 'Indicates whether this promotional calendar entry can overlap with other promotions in the same category or store cluster. True allows concurrent promotions; False enforces exclusivity to prevent promotional conflicts and margin erosion.',
    `slotting_commitment_flag` BOOLEAN COMMENT 'Indicates whether this promotional calendar entry is tied to a contractual slotting fee commitment with a vendor. True means vendor has paid for guaranteed promotional placement during this period; False means no slotting commitment exists.',
    `start_date` DATE COMMENT 'The date when the promotional period begins. This is the first day that promotional pricing, offers, or ad circular content becomes effective in stores and digital channels.',
    `target_channel` STRING COMMENT 'The primary sales channel where this promotional calendar entry will be executed. In-store represents physical retail locations; online represents eCommerce website; mobile app represents mobile application; omnichannel indicates promotion spans all channels.. Valid values are `in_store|online|mobile_app|omnichannel`',
    `target_gmroi` DECIMAL(18,2) COMMENT 'The target Gross Margin Return on Investment ratio for this promotional calendar entry. GMROI measures the profitability of inventory investment and is a key performance metric for promotional effectiveness in retail. Calculated as gross margin dollars divided by average inventory cost.',
    `vendor_funded_flag` BOOLEAN COMMENT 'Indicates whether this promotional calendar entry includes vendor-funded promotional support (slotting fees, co-op advertising, markdown allowances). True means vendor is contributing funding; False means retailer-funded only.',
    CONSTRAINT pk_promo_calendar PRIMARY KEY(`promo_calendar_id`)
) COMMENT 'Promotional planning calendar that organizes all campaigns and offers across time. Tracks weekly ad circular cycles, promotional periods, blackout dates, holiday event windows, and overlap constraints. Supports merchandise planning and assortment management by providing a structured view of promotional cadence across store zones, categories, and channels. Enables conflict detection between simultaneous promotions and coordination with vendor slotting commitments.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`ad_circular` (
    `ad_circular_id` BIGINT COMMENT 'Unique identifier for the ad circular. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Ad circular production, print, and distribution costs are allocated to cost centers for departmental marketing expense tracking. Retail-grocery finance requires cost center attribution on circulars fo',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Ad circular production and distribution costs are budgeted and reported by fiscal period. Retail-grocery finance teams track circular spend by fiscal period for period-close accruals and marketing exp',
    `promo_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_calendar. Business justification: Associate each ad circular with its planning calendar; child (ad_circular) gets FK to parent (promo_calendar). Removes redundant week number column.',
    `region_id` BIGINT COMMENT 'Foreign key linking to store.region. Business justification: Ad circular distribution planning is region-scoped in grocery retail — regional marketing teams plan and approve circulars for their geographic territory. The distribution_zone text field is a denor',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: Ad circulars are versioned and distributed by store cluster in grocery retail — different clusters receive different circular editions based on demographics and assortment depth. distribution_zone is ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Ad circular funding source tracking for supplier‑funded circulars required for marketing spend reporting.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Enables linking each ad circular to the targeted customer segment for segment performance reporting and media spend allocation.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Ad circular features are funded under trade agreements (co-op advertising, feature fees, slotting). Grocery merchandising teams link circular placements to the governing trade agreement to track co-op',
    `circular_name` STRING COMMENT 'Descriptive name or title of the circular (e.g., Spring Savings Event, Weekly Deals March 15-21).',
    `circular_number` STRING COMMENT 'Business identifier for the circular edition, typically a sequential number or code used for tracking and reference (e.g., WK2401, C-2024-15).',
    `circular_status` STRING COMMENT 'Current lifecycle status of the circular from planning through execution to expiration. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_production|published|active|expired|cancelled — 8 candidates stripped; promote to reference product]',
    `circular_type` STRING COMMENT 'Classification of the circular based on frequency and purpose (weekly standard circular, seasonal promotion, holiday special, etc.).. Valid values are `weekly|bi-weekly|monthly|seasonal|special_event|holiday`',
    `cover_page_headline` STRING COMMENT 'Primary headline or promotional message displayed on the cover page of the circular.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad circular record was first created in the system.',
    `digital_coupon_flag` BOOLEAN COMMENT 'Indicates whether this circular includes digital coupon offers that customers can clip and redeem online or via mobile app.',
    `digital_platform` STRING COMMENT 'Digital platform or technology used to publish and distribute the online version of the circular (e.g., Salesforce Commerce Cloud, Mobile App, Email Campaign).',
    `digital_reach_estimate` STRING COMMENT 'Estimated number of unique digital viewers or impressions for the online version of the circular.',
    `effective_end_date` DATE COMMENT 'Date when the circular expires and promotional offers are no longer valid.',
    `effective_start_date` DATE COMMENT 'Date when the circular becomes active and promotional offers are valid for customer redemption.',
    `endcap_feature_count` STRING COMMENT 'Number of endcap (end-of-aisle display) features promoted in this circular.',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'Total estimated marketing and production budget allocated for this circular in USD, including print costs, digital advertising, and promotional funding.',
    `estimated_gmroi_target` DECIMAL(18,2) COMMENT 'Target Gross Margin Return on Investment (GMROI) ratio for this circular, representing expected gross margin dollars returned per dollar of inventory investment.',
    `featured_category` STRING COMMENT 'Primary product category or department featured prominently in this circular (e.g., Fresh Produce, Meat & Seafood, Private Label).',
    `format_type` STRING COMMENT 'Distribution format of the circular indicating whether it is available in print, digital, or both channels.. Valid values are `print_only|digital_only|print_and_digital`',
    `language` STRING COMMENT 'Primary language of the circular content using 3-letter ISO 639-2 language codes (ENG=English, SPA=Spanish, FRA=French, CHI=Chinese).. Valid values are `ENG|SPA|FRA|CHI`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad circular record was last updated or modified.',
    `loyalty_exclusive_flag` BOOLEAN COMMENT 'Indicates whether this circular contains offers exclusive to loyalty program members.',
    `merchandiser_name` STRING COMMENT 'Name of the merchandising manager or team responsible for selecting offers and planning the circular content.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this circular edition.',
    `page_count` STRING COMMENT 'Total number of pages in the printed or digital circular.',
    `print_circulation_quantity` STRING COMMENT 'Number of physical copies printed and distributed for this circular edition.',
    `print_vendor_name` STRING COMMENT 'Name of the external printing vendor or service provider used for physical circular production.',
    `production_deadline_date` DATE COMMENT 'Final deadline for completing circular production and sending to print or digital publishing.',
    `proof_approval_date` DATE COMMENT 'Date when the final proof of the circular was approved by merchandising and marketing teams.',
    `proof_approval_status` STRING COMMENT 'Current approval status of the circular proof during the review and approval workflow.. Valid values are `pending|approved|rejected|revision_required`',
    `publication_date` DATE COMMENT 'Date when the circular was published and made available to customers (print distribution or digital release).',
    `theme` STRING COMMENT 'Marketing theme or campaign message for the circular (e.g., Back to School, Summer BBQ, Holiday Feast).',
    `total_offers_count` STRING COMMENT 'Total number of promotional offers and SKUs (Stock Keeping Units) featured in this circular.',
    `tpr_offers_count` STRING COMMENT 'Number of Temporary Price Reduction (TPR) offers included in this circular.',
    `vendor_funded_flag` BOOLEAN COMMENT 'Indicates whether promotional offers in this circular are partially or fully funded by vendor slotting fees or trade allowances.',
    CONSTRAINT pk_ad_circular PRIMARY KEY(`ad_circular_id`)
) COMMENT 'Weekly or periodic printed and digital advertising circular that communicates promotional offers to shoppers. Captures circular edition number, effective date range, distribution zone, page count, item placements with page/position coordinates, endcap and gondola feature assignments, digital vs. print format flags, circulation reach, production deadline, and proof approval status. Links to specific offers featured in each circular. Core artifact for weekly promotional execution in retail-grocery — the primary vehicle for communicating TPRs and BOGO offers to price-sensitive shoppers.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`offer_item` (
    `offer_item_id` BIGINT COMMENT 'Unique identifier for the offer item association record.',
    `ad_circular_id` BIGINT COMMENT 'Foreign key linking to promotion.ad_circular. Business justification: offer_item has ad_circular_featured_flag (BOOLEAN) indicating whether this offer item is featured in an ad circular. Adding ad_circular_id normalizes this reference to identify WHICH circular features',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: Offer items must reference the authoritative assortment record to validate that promoted SKUs are actively ranged in the target store cluster. Grocery merchandising systems enforce this as a pre-activ',
    `planogram_id` BIGINT COMMENT 'Foreign key linking to assortment.planogram. Business justification: REQUIRED: Offer Placement Planning process links each offer_item to a specific planogram for shelf‑space allocation.',
    `sku_id` BIGINT COMMENT 'Reference to the sellable item (product, SKU) that is eligible for this promotional offer.',
    `promo_offer_id` BIGINT COMMENT 'Reference to the parent promotional offer that this item is associated with.',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: Promotional offer planning requires validating that the promotional price does not violate the price floor or MAP. Grocery merchandisers reference the baseline retail_price when setting discount_overr',
    `store_cluster_id` BIGINT COMMENT 'Reference to the store cluster or group where this promotional item is active. Enables localized promotions tailored to regional preferences and competitive dynamics.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor (supplier, manufacturer) funding or co-funding this promotional item. Used for vendor-funded promotion tracking and chargeback processing.',
    `ad_circular_featured_flag` BOOLEAN COMMENT 'Indicates whether this item is featured in the weekly promotional flyer (ad circular). True if the item appears in print or digital advertising materials.',
    `age_restriction_required_flag` BOOLEAN COMMENT 'Indicates whether age verification is required at POS for this promotional item (alcohol, tobacco, restricted medications). Ensures compliance with state and federal age-restricted product regulations.',
    `channel_restriction` STRING COMMENT 'Specifies which sales channels this promotional item is valid for. Supports omnichannel promotion strategy with channel-specific offers for POS, eCommerce, mobile app, curbside pickup, and delivery.. Valid values are `all_channels|in_store_only|online_only|mobile_app_only|pickup_only|delivery_only`',
    `cost_override_amount` DECIMAL(18,2) COMMENT 'Special cost basis for this item during the promotion period, typically negotiated with vendors for promotional pricing. Used for accurate GMROI and margin analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offer item association record was first created in the system. Used for audit trail and promotion planning analysis.',
    `digital_coupon_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item is eligible for digital coupon stacking on top of the base promotional offer. Enables omnichannel personalized deal combinations.',
    `discount_override_amount` DECIMAL(18,2) COMMENT 'Item-specific discount amount that overrides the offer-level discount for this particular SKU. Enables variable discounts within a single promotional campaign.',
    `discount_override_percentage` DECIMAL(18,2) COMMENT 'Item-specific discount percentage that overrides the offer-level discount rate for this SKU. Allows differentiated markdown rates within the same promotion.',
    `effective_end_date` DATE COMMENT 'Date when this item is no longer eligible for the promotional offer. Used for promotion calendar management and automatic expiration.',
    `effective_start_date` DATE COMMENT 'Date when this item becomes eligible for the promotional offer. Supports phased rollout and time-limited flash promotions.',
    `facing_count` STRING COMMENT 'Number of product fronts on shelf required for this promotional item. Ensures adequate visibility and stock availability during the promotion period.',
    `inclusion_type` STRING COMMENT 'Specifies whether this item is included in the promotion, explicitly excluded, required for eligibility, or optional within a multi-item offer.. Valid values are `included|excluded|required|optional`',
    `item_identifier_type` STRING COMMENT 'Type of item identifier used for promotion eligibility determination. SKU (Stock Keeping Unit) for internal codes, UPC (Universal Product Code) for standard barcodes, GTIN (Global Trade Item Number) for GS1 standards, PLU (Price Look-Up Code) for produce, EAN for European Article Numbers, ISBN for books.. Valid values are `SKU|UPC|GTIN|PLU|EAN|ISBN`',
    `item_identifier_value` DECIMAL(18,2) COMMENT 'The actual identifier value (SKU code, UPC barcode, GTIN number, PLU code) used to match this item to the promotion at POS and digital checkout.',
    `item_role` STRING COMMENT 'Mechanical role this item plays in the promotion structure. Buy item vs get item in BOGO (Buy One Get One) offers, trigger item vs reward item in mix-and-match promotions, qualifying item for threshold-based offers, or bundle component in multi-item packages.. Valid values are `buy_item|get_item|trigger_item|reward_item|qualifying_item|bundle_component`',
    `loyalty_points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to loyalty reward points earned on this item during the promotion. For example, 2.0 means double points, 3.0 means triple points.',
    `maximum_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity of this item eligible for the promotional discount within a single transaction. Used to cap BOGO offers and prevent abuse.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age in years required to purchase this promotional item. Typically 18 for tobacco, 21 for alcohol in most US states.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this offer item association record was last modified. Tracks changes to promotion eligibility, discount overrides, and item roles.',
    `offer_item_status` STRING COMMENT 'Current lifecycle status of this offer item association. Active means the item is currently eligible for the promotion, pending means scheduled for future activation, expired means the effective period has ended, suspended means temporarily disabled, cancelled means permanently removed from the offer.. Valid values are `active|inactive|pending|expired|suspended|cancelled`',
    `planogram_placement_code` STRING COMMENT 'Code indicating the visual merchandise display plan location where this promotional item should be placed (endcap, gondola, front-of-store, checkout lane). Supports execution of promotional planograms.',
    `priority_rank` STRING COMMENT 'Ranking used to determine which promotion applies when an item qualifies for multiple overlapping offers. Lower numbers indicate higher priority.',
    `quantity_unit` STRING COMMENT 'Unit of measure for required and maximum quantities. Each for discrete items, weight units for produce and bulk goods, volume units for liquids, case or pack for wholesale quantities. [ENUM-REF-CANDIDATE: each|pound|kilogram|ounce|liter|gallon|case|pack — 8 candidates stripped; promote to reference product]',
    `required_quantity` DECIMAL(18,2) COMMENT 'Minimum purchase quantity of this item required to qualify for the promotional offer. Supports fractional quantities for weight-based items (e.g., 2.5 lbs of produce).',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this promotional item is eligible for purchase using SNAP benefits (EBT - Electronic Benefits Transfer). Required for compliance with USDA SNAP regulations.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that originated this offer item association (Oracle Retail Price Management, SAP SD Sales and Distribution, proprietary promotion engine). Used for data lineage and reconciliation.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether item substitution is permitted if the promoted item is out of stock (OOS). Relevant for online order fulfillment and click-and-collect services.',
    `vendor_funded_flag` BOOLEAN COMMENT 'Indicates whether the promotional discount for this item is funded by the vendor (manufacturer) rather than the retailer. Used for slotting fee negotiations and GMROI (Gross Margin Return on Investment) analysis.',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this promotional item is eligible for purchase using WIC benefits. Required for compliance with USDA WIC program regulations.',
    CONSTRAINT pk_offer_item PRIMARY KEY(`offer_item_id`)
) COMMENT 'Association entity linking promotional offers to specific sellable items (SKUs, UPCs, GTINs, PLU codes) eligible for the promotion. Captures included and excluded items, required purchase quantities, qualifying item roles (buy item vs. get item in BOGO, trigger item vs. reward item in mix-and-match), item-level discount overrides, and planogram placement context. Enables precise eligibility determination at POS, self-checkout, and digital checkout. Supports complex multi-item promotions where different items play different mechanical roles.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` (
    `offer_eligibility_rule_id` BIGINT COMMENT 'Unique identifier for the offer eligibility rule. Primary key.',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Grocery category managers define promotional eligibility rules scoped to product hierarchy nodes (e.g., all organic produce, all private-label beverages). Linking offer_eligibility_rule to item_hierar',
    `segment_id` BIGINT COMMENT 'Reference to the customer segment that this rule targets. Used for household segmentation and personalized deal targeting.',
    `promo_offer_id` BIGINT COMMENT 'Reference to the promotional offer that this eligibility rule governs.',
    `store_cluster_id` BIGINT COMMENT 'Reference to the store cluster or group where the offer is valid. Used to target specific store formats, market types, or performance tiers.',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Tender-restricted promotion eligibility is a named business process in grocery retail: manufacturer coupons may be invalid with EBT, fuel rewards only apply at pump with specific tender. offer_eligibi',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Eligibility rules reference loyalty tier thresholds; FK enables tier‑based rule enforcement and reporting.',
    `channel_restriction` STRING COMMENT 'Sales channel or fulfillment method where the offer is valid. Restricts eligibility to specific shopping channels such as in-store, online, mobile app, curbside pickup, or delivery.. Valid values are `in_store|online|mobile_app|curbside_pickup|delivery|all_channels`',
    `compliance_notes` STRING COMMENT 'Free-text field capturing regulatory compliance considerations, legal restrictions, or program-specific requirements (e.g., SNAP, WIC, age verification) associated with the rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility rule record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the eligibility rule expires and is no longer enforced. Null indicates an open-ended rule with no expiration.',
    `effective_start_date` DATE COMMENT 'Date when the eligibility rule becomes active and begins to be enforced for offer qualification.',
    `evaluation_frequency` STRING COMMENT 'Frequency at which the eligibility rule is evaluated or refreshed. Determines whether qualification is checked in real-time at transaction, on a batch schedule, or on-demand.. Valid values are `real_time|daily|weekly|on_demand`',
    `exclusion_reason` STRING COMMENT 'Business rationale or explanation for why certain customers or segments are excluded from the offer. Provides transparency for compliance and customer service purposes.',
    `geographic_zone_code` STRING COMMENT 'Code representing the geographic zone, region, or market where the offer is valid. Used to restrict offers to specific trading areas, ZIP codes, or store clusters.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility rule record was most recently updated.',
    `maximum_age_years` STRING COMMENT 'Maximum age in years for customer eligibility. Used for youth-targeted promotions or senior discount programs with upper age limits.',
    `minimum_age_years` STRING COMMENT 'Minimum age in years required for a customer to qualify for the offer. Used for age-restricted products such as alcohol, tobacco, or pharmacy items.',
    `minimum_loyalty_tier` STRING COMMENT 'The minimum loyalty program tier or level required for a customer to qualify for the offer. Examples include Bronze, Silver, Gold, Platinum, or program-specific tier names.',
    `new_customer_definition_days` STRING COMMENT 'Number of days since first transaction or account creation that defines a customer as new for eligibility purposes. Typically ranges from 30 to 90 days.',
    `new_customer_flag` BOOLEAN COMMENT 'Indicates whether the offer is restricted to new customers only. Used for customer acquisition campaigns and first-time shopper incentives.',
    `priority_rank` STRING COMMENT 'Numeric ranking used to resolve conflicts when multiple eligibility rules apply to the same offer. Lower numbers indicate higher priority.',
    `purchase_history_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum cumulative purchase amount required in the customers transaction history to qualify for the offer. Used for spend-based eligibility rules.',
    `purchase_history_threshold_period_days` STRING COMMENT 'Number of days in the lookback period for evaluating purchase history thresholds. Defines the time window over which customer spending or transaction counts are assessed.',
    `rule_description` STRING COMMENT 'Detailed textual description of the eligibility rule, including business context, intended audience, and any special conditions or exceptions.',
    `rule_logic_expression` STRING COMMENT 'Structured expression or formula defining the eligibility logic. May contain conditional operators, attribute references, and threshold values that are evaluated to determine customer qualification.',
    `rule_name` STRING COMMENT 'Human-readable name or label for the eligibility rule, used for identification and reporting purposes.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the eligibility rule. Indicates whether the rule is actively enforced, temporarily suspended, in draft state, or expired.. Valid values are `active|inactive|draft|expired|suspended`',
    `rule_type` STRING COMMENT 'Category of eligibility rule that determines the nature of the restriction or qualification. Defines whether the rule is based on loyalty membership, customer newness, geography, household segmentation, purchase history, government assistance program eligibility (SNAP/EBT, WIC), loyalty tier, age, or sales channel. [ENUM-REF-CANDIDATE: loyalty_member_only|new_customer|geographic_zone|household_segment|purchase_history_threshold|snap_ebt_eligible|wic_eligible|minimum_loyalty_tier|age_restriction|channel_restriction — 10 candidates stripped; promote to reference product]',
    `rule_version` STRING COMMENT 'Version number of the eligibility rule. Incremented with each modification to support rule history tracking and rollback capabilities.',
    `snap_ebt_eligible_flag` BOOLEAN COMMENT 'Indicates whether the offer is available to customers using SNAP or EBT payment methods. Ensures compliance with federal nutrition assistance program regulations.',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether the offer is available to customers using WIC benefits. Ensures compliance with WIC program restrictions and approved product lists.',
    CONSTRAINT pk_offer_eligibility_rule PRIMARY KEY(`offer_eligibility_rule_id`)
) COMMENT 'Business rules governing customer eligibility for promotional offers. Captures rule type (loyalty member only, new customer, geographic zone, household segment, purchase history threshold, SNAP/EBT eligible, WIC eligible), rule logic expressions, customer segment targeting criteria, minimum loyalty tier requirements, and exclusion conditions. Supports personalized deal targeting and compliance with program-specific restrictions such as WIC and SNAP regulations.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`digital_coupon` (
    `digital_coupon_id` BIGINT COMMENT 'Unique identifier for the digital coupon. Primary key for the digital coupon entity.',
    `banner_id` BIGINT COMMENT 'Foreign key linking to store.banner. Business justification: Digital coupons in grocery retail are issued per banner — a Kroger app coupon is not redeemable at Fred Meyer. The eligible_store_list text field is a denormalized banner-scoping workaround. banner_',
    `category_id` BIGINT COMMENT 'Identifier of the product category to which this digital coupon applies. Used for category-level coupon offers rather than Stock Keeping Unit (SKU)-specific offers.',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: Manufacturer digital coupons in retail-grocery pharmacy are tied to specific drug NDCs for eligibility verification during pharmacy coupon adjudication. This supports the named process pharmacy coupo',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Digital coupon liability (unredeemed coupons) must be accrued by fiscal period under GAAP. Retail-grocery finance teams report coupon liability and redemption expense by fiscal period for period-close',
    `membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: Digital coupon clipping in grocery loyalty is performed against a loyalty membership account (loyalty card number). The clip_status and clip_timestamp on digital_coupon represent membership-level acti',
    `promo_campaign_id` BIGINT COMMENT 'Identifier of the broader marketing or promotional campaign to which this digital coupon belongs. Links coupon to campaign planning and performance measurement.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: A digital coupon is the digital delivery mechanism for a specific promotional offer. Linking digital_coupon to promo_offer normalizes the relationship so coupon details (discount_type, discount_value,',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: FTC coupon compliance requires that coupon face_value does not exceed the items retail price. Grocery digital coupon issuance workflows validate face_value against the current retail_price record, an',
    `segment_id` BIGINT COMMENT 'Identifier of the customer segment targeted by this personalized digital coupon offer. Null for mass-distribution coupons.',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to customer.shopper. Business justification: Required for tracking which shopper clips each digital coupon, used in loyalty analytics and regulatory reporting of coupon usage.',
    `supplier_id` BIGINT COMMENT 'Identifier of the Consumer Packaged Goods (CPG) manufacturer or vendor funding the coupon offer. Null if retailer-funded.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Manufacturer-funded digital coupons are governed by trade agreements specifying face value, redemption reimbursement rates, and clearing house settlement terms. Grocery retailers require this link to ',
    `barcode` STRING COMMENT 'GS1-compliant barcode number for Point of Sale (POS) scanning. Typically UPC (Universal Product Code) or EAN format for digital coupon redemption.. Valid values are `^[0-9]{12,14}$`',
    `clip_status` STRING COMMENT 'Current activation and usage status of the digital coupon: available for clipping, clipped by customer, redeemed at Point of Sale (POS), or expired without redemption.. Valid values are `available|clipped|redeemed|expired`',
    `clip_timestamp` TIMESTAMP COMMENT 'Date and time when the customer activated or clipped the digital coupon to their loyalty account. Null if coupon has not been clipped.',
    `coupon_code` STRING COMMENT 'Unique alphanumeric code identifying the digital coupon offer. Used for tracking and redemption validation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the digital coupon record was first created in the system. Used for audit trail and coupon lifecycle tracking.',
    `current_redemption_count` STRING COMMENT 'Current cumulative number of times this digital coupon has been redeemed across all customers. Used to enforce total redemption limits.',
    `digital_coupon_description` STRING COMMENT 'Detailed description of the digital coupon offer including terms, conditions, eligible products, and redemption instructions.',
    `discount_type` STRING COMMENT 'Type of discount mechanism applied by the coupon: percentage off, dollar amount off, Buy One Get One (BOGO), fixed price, or free item.. Valid values are `percentage_off|dollar_off|bogo|fixed_price|free_item`',
    `effective_start_date` DATE COMMENT 'Date when the digital coupon becomes valid and available for customer clipping and redemption.',
    `eligible_sku_list` STRING COMMENT 'Comma-separated list of Stock Keeping Unit (SKU) identifiers eligible for this digital coupon offer. Null if coupon applies to entire category or store-wide.',
    `excluded_sku_list` STRING COMMENT 'Comma-separated list of Stock Keeping Unit (SKU) identifiers explicitly excluded from this digital coupon offer despite category or store-wide eligibility.',
    `expiration_date` DATE COMMENT 'Date when the digital coupon expires and can no longer be clipped or redeemed. After this date, the coupon is invalid.',
    `face_value` DECIMAL(18,2) COMMENT 'Monetary value or percentage discount amount displayed on the coupon. For percentage discounts, represents the percentage; for dollar discounts, represents the dollar amount.',
    `image_url` STRING COMMENT 'Uniform Resource Locator (URL) of the promotional image or graphic associated with the digital coupon for display in mobile app, website, and email.. Valid values are `^https?://.*.(jpg|jpeg|png|gif|webp)$`',
    `issuing_channel` STRING COMMENT 'Digital channel through which the coupon was originally issued or made available to customers: mobile app, website, email campaign, SMS, loyalty portal, or social media.. Valid values are `mobile_app|website|email|sms|loyalty_portal|social_media`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the digital coupon record was last updated or modified. Used for change tracking and audit purposes.',
    `loyalty_points_eligible_flag` BOOLEAN COMMENT 'Indicates whether purchases made using this digital coupon are still eligible for loyalty program points accrual. True if points can be earned, false if coupon disqualifies points.',
    `manufacturer_funded_flag` BOOLEAN COMMENT 'Indicates whether the coupon discount is funded by a Consumer Packaged Goods (CPG) manufacturer or vendor rather than by the retailer. True if manufacturer-funded, false if retailer-funded.',
    `maximum_discount_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount that can be discounted when redeeming this coupon. Applies primarily to percentage-based offers to cap total discount.',
    `maximum_redemption_count` STRING COMMENT 'Maximum number of times a single customer can redeem this digital coupon during the offer period. Null indicates unlimited redemptions per customer.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum transaction subtotal required to qualify for coupon redemption. Null if no minimum purchase requirement exists.',
    `personalization_source` STRING COMMENT 'Method by which the coupon was personalized or targeted: mass distribution to all customers, targeted based on segment, behavioral analysis, demographic profile, or predictive Customer Lifetime Value (CLTV) modeling.. Valid values are `mass|targeted|behavioral|demographic|predictive`',
    `priority_rank` STRING COMMENT 'Display priority ranking for the digital coupon when multiple offers are available. Lower numbers indicate higher priority for customer presentation.',
    `qr_code` STRING COMMENT 'Quick Response code data payload for mobile app or self-checkout scanning. Encodes coupon identifier and validation data.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this digital coupon can be combined or stacked with other coupons, promotions, or Temporary Price Reductions (TPR) in a single transaction. True if stackable, false if exclusive.',
    `store_eligibility_type` STRING COMMENT 'Defines which store locations or channels are eligible for coupon redemption: all stores, specific store list, store cluster, online orders only, or in-store purchases only.. Valid values are `all_stores|specific_stores|store_cluster|online_only|in_store_only`',
    `terms_and_conditions` STRING COMMENT 'Full legal terms and conditions governing the use, redemption, and restrictions of the digital coupon. Required for regulatory compliance and customer transparency.',
    `title` STRING COMMENT 'Customer-facing title or headline of the digital coupon offer displayed in mobile app, website, and loyalty platform.',
    `total_redemption_limit` STRING COMMENT 'Total number of redemptions allowed across all customers before the coupon offer is exhausted. Null indicates no aggregate limit.',
    CONSTRAINT pk_digital_coupon PRIMARY KEY(`digital_coupon_id`)
) COMMENT 'Digital coupon issued through the grocers mobile app, website, or loyalty platform. Captures coupon code, barcode/QR code, face value, discount type, issuing channel (app clip, email, web), clip status, clip timestamp, expiration date, maximum redemption count, CPG manufacturer funding flag, and personalization source (targeted vs. mass). Distinct from paper coupons and in-store TPRs — digital coupons require explicit customer clip/activation before redemption.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`promotion_redemption` (
    `promotion_redemption_id` BIGINT COMMENT 'Unique identifier for the promotion redemption transaction. Primary key for this entity.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Promotion redemptions occur at a specific in-store department — pharmacy coupons redeemed at pharmacy, deli offers at deli counter. Department-level redemption data drives shrink analysis, department ',
    `digital_coupon_id` BIGINT COMMENT 'Foreign key linking to promotion.digital_coupon. Business justification: When a digital coupon is redeemed, the redemption record should reference the specific digital_coupon entity to enable coupon-level redemption tracking (clip-to-redeem rates, coupon performance analyt',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Promotional redemptions generate discount expense that must be accrued and reported by fiscal period for period-close. Retail-grocery finance teams require fiscal period attribution on redemptions for',
    `household_id` BIGINT COMMENT 'Foreign key linking to customer.household. Business justification: Household-level redemption tracking is a core grocery loyalty analytics process: household lift reports, household redemption limits (preventing abuse), and campaign ROI measured per household unit. A',
    `member_offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.member_offer. Business justification: When a loyalty-exclusive or personalized promotion is redeemed, the redemption must trace back to the specific member_offer assignment for offer performance measurement, redemption limit enforcement, ',
    `membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: Needed for Redemption‑Member reporting linking each redemption to the member for ROI and engagement analysis.',
    `offer_item_id` BIGINT COMMENT 'Foreign key linking to promotion.offer_item. Business justification: A promotion redemption occurs at the item level — a specific SKU/UPC is scanned and a discount applied. offer_item is the association entity linking offers to specific sellable items. Linking promotio',
    `order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Omnichannel vendor reimbursement audits and fraud detection require tracing each promotion redemption to its fulfillment order. Grocery retailers reconcile vendor funding claims by matching redemption',
    `points_transaction_id` BIGINT COMMENT 'Foreign key linking to loyalty.points_transaction. Business justification: Promotion redemption reconciliation reporting requires direct linkage to the points awarded. In grocery loyalty operations, every qualifying promotion redemption triggers a points_transaction; auditor',
    `product_order_line_id` BIGINT COMMENT 'Foreign key linking to product.product_order_line. Business justification: Vendor funding reconciliation and discount audit require linking each redemption event to the specific order line that triggered it. Grocery retailers use this to validate claimed_units_sold in fundin',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the promotional offer that was redeemed. Links to the promotion master entity.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: A promotion redemption records the specific offer being redeemed at POS or digital checkout. promotion_redemption already has promo_campaign_id but lacks offer-level granularity. Adding promo_offer_id',
    `shopper_id` BIGINT COMMENT 'Reference to the customer who redeemed the promotion. Links to loyalty account or shopper profile.',
    `store_location_id` BIGINT COMMENT 'Reference to the physical store location where the redemption occurred. Null for pure digital fulfillment.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier who funded or co-funded the promotion. Used for vendor funding reconciliation and slotting fee settlement.',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Promotion performance reporting by tender type and regulatory compliance (EBT/SNAP/WIC tender restrictions on promotions) require linking each redemption to the tender used. promotion_redemption.payme',
    `tpr_id` BIGINT COMMENT 'Foreign key linking to pricing.tpr. Business justification: Vendor TPR reimbursement reconciliation requires matching each redemption record to the specific pricing TPR executed at POS. Grocery AP teams use this link to validate claimed vendor-funded discount ',
    `transaction_id` BIGINT COMMENT 'Reference to the Point of Sale (POS) transaction or order in which this promotion was redeemed.',
    `ad_circular_week` STRING COMMENT 'Week identifier for the weekly ad circular in which this promotion was featured. Format: YYYY-WW. Used for ad circular performance measurement.',
    `channel` STRING COMMENT 'Channel through which the promotion was redeemed: POS (Point of Sale), self-checkout kiosk, online web storefront, mobile app, curbside pickup, or in-store pickup.. Valid values are `pos|self_checkout|online|mobile_app|curbside_pickup|in_store_pickup`',
    `clearing_house_submission_date` DATE COMMENT 'Date when the coupon redemption was submitted to the clearing house for vendor reimbursement. Null if not yet submitted.',
    `clearing_house_submission_flag` BOOLEAN COMMENT 'Indicates whether this manufacturer coupon redemption has been submitted to the coupon clearing house for reimbursement. True if submitted, False otherwise.',
    `coupon_code` STRING COMMENT 'Unique coupon code or barcode scanned at redemption. Used for digital coupon clips, manufacturer coupons, and personalized deal codes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount amount (e.g., USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `digital_coupon_clip_timestamp` TIMESTAMP COMMENT 'Date and time when the customer clipped or activated the digital coupon in the mobile app or website. Null for non-digital offers.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of discount applied to the transaction as a result of this promotion redemption. Expressed in local currency.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied if the promotion was percentage-based (e.g., 20% off). Null for fixed-amount discounts.',
    `ebt_eligible_flag` BOOLEAN COMMENT 'Indicates whether the redeemed item was eligible for EBT/SNAP/WIC payment. True if eligible, False otherwise.',
    `final_price` DECIMAL(18,2) COMMENT 'Final unit price after the promotional discount was applied. Used for net revenue and margin calculation.',
    `item_quantity` STRING COMMENT 'Number of units of the item purchased that qualified for the promotion. Supports BOGO and multi-buy offer tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was last updated. Used for change tracking and audit compliance.',
    `loyalty_account_number` STRING COMMENT 'Customer loyalty program account number used at time of redemption. Enables tracking of personalized deal usage and reward point accrual.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty reward points earned by the customer as a result of this promotion redemption. Used for loyalty program accrual tracking.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty reward points redeemed by the customer to activate or apply this promotion. Used for loyalty liability tracking.',
    `offer_type` STRING COMMENT 'Type of promotional offer redeemed: BOGO (Buy One Get One), TPR (Temporary Price Reduction), digital coupon, paper coupon, personalized deal, loyalty reward, or vendor-funded promotion. [ENUM-REF-CANDIDATE: bogo|tpr|digital_coupon|paper_coupon|personalized_deal|loyalty_reward|vendor_funded — 7 candidates stripped; promote to reference product]',
    `original_price` DECIMAL(18,2) COMMENT 'Original unit price of the item before the promotional discount was applied. Used for markdown and GMROI (Gross Margin Return on Investment) analysis.',
    `personalized_deal_flag` BOOLEAN COMMENT 'Indicates whether this was a personalized deal targeted to the specific customer based on purchase history or predictive analytics. True if personalized, False otherwise.',
    `promotion_end_date` DATE COMMENT 'End date of the promotional offer period. Used to validate redemption timing and identify expired offer redemption attempts.',
    `promotion_start_date` DATE COMMENT 'Start date of the promotional offer period. Used to validate redemption timing and measure promotion lifecycle performance.',
    `redemption_date` DATE COMMENT 'Calendar date of the redemption event. Used for daily aggregation and ad circular performance reporting.',
    `redemption_timestamp` TIMESTAMP COMMENT 'Exact date and time when the promotion was redeemed at POS, self-checkout, or digital checkout. Core business event timestamp for this transaction.',
    `register_number` STRING COMMENT 'POS register or terminal number where the redemption was processed. Used for audit trail and transaction reconciliation.',
    `reimbursement_status` STRING COMMENT 'Status of vendor reimbursement for this coupon redemption: pending (awaiting clearing house processing), approved (validated by vendor), rejected (not eligible for reimbursement), or paid (funds received).. Valid values are `pending|approved|rejected|paid`',
    `rejection_reason` STRING COMMENT 'Detailed reason why the promotion redemption was rejected or partially applied. Examples: item not eligible, minimum purchase not met, limit exceeded, expired offer.',
    `retailer_funded_amount` DECIMAL(18,2) COMMENT 'Portion of the discount amount funded by the retailer. Used for internal cost allocation and GMROI analysis.',
    `sku` STRING COMMENT 'Stock Keeping Unit identifier for the item on which the promotion was applied. Supports item-level redemption tracking.',
    `upc` STRING COMMENT 'Universal Product Code (barcode) of the item redeemed. Used for manufacturer coupon validation and vendor funding reconciliation.',
    `validation_status` STRING COMMENT 'Status of the redemption validation: approved (fully applied), rejected (not eligible), partially applied (some conditions not met), pending review (manual verification needed), expired (offer past end date), or invalid coupon (code not recognized).. Valid values are `approved|rejected|partially_applied|pending_review|expired|invalid_coupon`',
    `vendor_funded_amount` DECIMAL(18,2) COMMENT 'Portion of the discount amount funded by the vendor or manufacturer. Used for vendor chargeback and coupon clearing house settlement.',
    CONSTRAINT pk_promotion_redemption PRIMARY KEY(`promotion_redemption_id`)
) COMMENT 'Transactional record of a promotional offer being redeemed at POS, self-checkout, or digital checkout. Captures redemption timestamp, transaction/order reference, store or fulfillment channel, offer redeemed (including digital coupon clips and personalized deal acceptances), discount amount applied, customer loyalty account, payment method used (including EBT/SNAP/WIC), item-level redemption detail, and redemption validation status (approved, rejected, partially applied). Core transactional entity for post-promotion performance measurement, vendor funding reconciliation, and coupon clearing house settlement.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`tpr_event` (
    `tpr_event_id` BIGINT COMMENT 'Unique identifier for the TPR event record. Primary key.',
    `ad_circular_id` BIGINT COMMENT 'Foreign key linking to promotion.ad_circular. Business justification: A TPR event is frequently featured in the weekly ad circular (tpr_event.is_ad_circular_featured = BOOLEAN confirms this relationship). tpr_event currently stores ad_circular_week as a denormalized STR',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: TPR events must be validated against the active assortment — a TPR on a delisted item is a pricing compliance failure. Linking tpr_event to assortment_item enables TPR eligibility validation and post-',
    `category_id` BIGINT COMMENT 'Reference to the product category for reporting and analysis of TPR performance by category.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: TPR markdown costs are allocated to cost centers for departmental P&L and budget variance reporting. Retail-grocery finance teams track markdown expense by cost center to manage category-level profita',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: TPR events are executed at the department level within a store — meat department runs beef TPRs, produce runs berry TPRs. Department managers own TPR execution and shrink accountability. department_id',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: TPR markdown accruals must be attributed to fiscal periods for period-close reporting. Retail-grocery finance requires fiscal period attribution on TPR events to recognize markdown expense in the corr',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: TPR markdown expenses are posted to specific GL accounts (markdown expense accounts) for retail-grocery P&L reporting. Markdown accounting is a core finance process; GL attribution on TPR events enabl',
    `planogram_id` BIGINT COMMENT 'Foreign key linking to assortment.planogram. Business justification: TPR events with endcap or display placement (is_endcap_display flag) must reference the governing planogram for compliance auditing. Grocery space planning teams use this link to verify TPR display ex',
    `price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.price_rule. Business justification: TPR price compliance validation requires checking that tpr_price_amount respects the price_rule margin floor, price ceiling, and price-ending conventions for the category/zone. Grocery pricing governa',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the parent promotional campaign that this TPR event is part of, if applicable. Null for standalone TPRs.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU (Stock Keeping Unit) that is subject to this temporary price reduction.',
    `store_location_id` BIGINT COMMENT 'Reference to the specific store where this TPR is applied. Null if TPR applies to a zone or all stores.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor/supplier associated with this SKU, used for tracking vendor-funded TPRs and slotting fee negotiations.',
    `tpr_id` BIGINT COMMENT 'Foreign key linking to pricing.tpr. Business justification: TPR reconciliation and vendor funding validation require linking the promotional TPR event (planned by merchandising) to the executed pricing TPR record (activated at POS). Grocery operators use this ',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: TPR events are set up under trade agreements that specify allowable discount depths, vendor funding obligations, and SRP compliance requirements. Grocery buyers reference the governing trade agreement',
    `trade_allowance_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_allowance. Business justification: TPR events are funded by specific trade allowances (off-invoice allowances, scan allowances). Grocery buyers reference the specific trade allowance when setting up TPR events to validate funding avail',
    `vendor_funding_id` BIGINT COMMENT 'Foreign key linking to promotion.vendor_funding. Business justification: A TPR event is frequently vendor-funded (tpr_event.is_vendor_funded = BOOLEAN confirms this). tpr_event has vendor_funding_amount (a denormalized capture of the funding amount for this specific TPR) b',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this TPR requires management approval before activation, typically based on discount depth thresholds or margin impact.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this TPR event was approved for execution. Null if not yet approved or approval not required.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why this TPR event was cancelled before completion. Null if not cancelled.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when this TPR event was cancelled. Null if not cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this TPR event record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this TPR event record.. Valid values are `USD|CAD|MXN|EUR|GBP`',
    `discount_depth_percentage` DECIMAL(18,2) COMMENT 'The percentage discount from original SRP, calculated as ((original_srp_amount - tpr_price_amount) / original_srp_amount) * 100. Key metric for TPR performance analysis.',
    `display_location_code` STRING COMMENT 'Code identifying the specific in-store display location for this TPR (e.g., endcap number, gondola aisle, front-end display). Null if standard shelf location.',
    `effective_end_date` DATE COMMENT 'The date when the temporary price reduction ends and pricing reverts to standard SRP. Inclusive end date.',
    `effective_start_date` DATE COMMENT 'The date when the temporary price reduction becomes active at point of sale. TPR pricing is applied automatically at POS starting this date.',
    `expected_revenue_amount` DECIMAL(18,2) COMMENT 'Forecasted total revenue expected from this TPR event, calculated as expected_unit_sales * tpr_price_amount.',
    `expected_unit_sales` STRING COMMENT 'Forecasted number of units expected to sell during the TPR period, used for inventory planning and performance measurement.',
    `is_ad_circular_featured` BOOLEAN COMMENT 'Indicates whether this TPR is featured in the weekly ad circular promotional flyer. True = featured in ad; False = in-store only TPR.',
    `is_endcap_display` BOOLEAN COMMENT 'Indicates whether this TPR SKU is featured on an endcap (end-of-aisle display) for increased visibility. True = endcap placement; False = standard shelf location.',
    `is_vendor_funded` BOOLEAN COMMENT 'Indicates whether the vendor/supplier is providing funding or allowances to support this TPR. True = vendor-funded; False = retailer-funded markdown.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this TPR event record was last updated. Audit trail field for tracking changes.',
    `markdown_reason_code` STRING COMMENT 'Business reason code for the temporary price reduction. Seasonal = seasonal promotion; Clearance = inventory clearance; Competitive = competitive response; Vendor_funded = vendor trade spend; Category_driver = traffic driver; New_item_intro = new product launch support; Overstock = excess inventory liquidation. [ENUM-REF-CANDIDATE: seasonal|clearance|competitive|vendor_funded|category_driver|new_item_intro|overstock — 7 candidates stripped; promote to reference product]',
    `maximum_purchase_quantity` STRING COMMENT 'Maximum number of units per transaction eligible for TPR pricing, used to limit exposure on deep discounts. Null if no limit.',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum number of units customer must purchase to receive the TPR price. Typically 1 for standard TPRs; may be higher for multi-buy offers. Null if no minimum.',
    `notes` STRING COMMENT 'Free-text field for additional notes, instructions, or context about this TPR event. Used for internal communication and documentation.',
    `original_srp_amount` DECIMAL(18,2) COMMENT 'The standard suggested retail price of the SKU before the temporary price reduction is applied. Used as baseline for discount depth calculation.',
    `pos_activation_timestamp` TIMESTAMP COMMENT 'Date and time when the TPR price was successfully activated in POS systems and began applying at checkout.',
    `pos_integration_status` STRING COMMENT 'Status of TPR price transmission to POS systems. Pending = awaiting transmission; Transmitted = sent to POS; Active = confirmed active at POS; Failed = transmission error; Reverted = price reverted to SRP.. Valid values are `pending|transmitted|active|failed|reverted`',
    `target_gmroi` DECIMAL(18,2) COMMENT 'Target GMROI (Gross Margin Return on Investment) ratio for this TPR event, used to evaluate promotional profitability. Calculated as gross_margin / average_inventory_cost.',
    `tpr_price_amount` DECIMAL(18,2) COMMENT 'The reduced price at which the SKU is sold during the TPR period. This is the shelf price automatically applied at POS without customer action.',
    `tpr_status` STRING COMMENT 'Current lifecycle status of the TPR event. Planned = scheduled but not yet approved; Approved = ready for execution; Active = currently in effect at POS; Completed = ended normally; Cancelled = terminated before completion; Suspended = temporarily paused.. Valid values are `planned|approved|active|completed|cancelled|suspended`',
    `vendor_funding_amount` DECIMAL(18,2) COMMENT 'The total dollar amount of vendor funding or allowances provided to support this TPR. Null if not vendor-funded.',
    CONSTRAINT pk_tpr_event PRIMARY KEY(`tpr_event_id`)
) COMMENT 'Temporary Price Reduction (TPR) event record capturing a time-bound price reduction applied to specific SKUs at store or zone level. Tracks TPR start and end dates, original SRP, TPR price, discount depth percentage, store zone applicability, category, vendor funding flag, and whether the TPR is featured in the ad circular or endcap display. Distinct from digital coupons and loyalty offers — TPRs are shelf-level price changes applied automatically at POS without customer action.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`vendor_funding` (
    `vendor_funding_id` BIGINT COMMENT 'Unique identifier for the vendor funding record. Primary key for this entity.',
    `banner_id` BIGINT COMMENT 'Foreign key linking to store.banner. Business justification: Vendor funding agreements in grocery retail are negotiated and tracked at the banner level — a CPG supplier commits funding specifically to the Kroger banner vs. the Smiths banner. Finance and trade ',
    `category_id` BIGINT COMMENT 'Identifier of the product category this vendor funding applies to (e.g., beverages, snacks, dairy). Used for category management and slotting fee allocation.',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Vendor funding accruals (bill-back allowances) directly reduce the net landed cost tracked in cost_price. Grocery cost accounting reconciliation links received_funding_amount to the cost_price record ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Vendor funding accruals and reconciliations are period-bound; period-close processes require fiscal period attribution to recognize trade income correctly. Retail-grocery finance teams report vendor f',
    `plan_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_plan. Business justification: Vendor funding agreements are negotiated and reconciled against specific assortment plan periods. Grocery buyers use this link to match vendor funding commitments to the assortment plan cycle during a',
    `promo_campaign_id` BIGINT COMMENT 'Identifier of the promotional campaign this vendor funding supports. Links funding to specific marketing initiatives.',
    `reward_offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.reward_offer. Business justification: Vendor-funded loyalty reward offers (e.g., CPG-sponsored bonus points events) require tracking which vendor_funding agreement backs each reward_offer. Funding reconciliation, accrual accounting, and v',
    `store_cluster_id` BIGINT COMMENT 'Identifier of the store cluster or group this funding applies to. Null if funding applies to all stores.',
    `supplier_id` BIGINT COMMENT 'Identifier of the CPG manufacturer or DSD distributor providing the promotional funding.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Vendor funding commitments are always governed by a specific trade agreement specifying payment terms, rebate structure, and funding rates. AP/finance teams reconcile vendor funding records against th',
    `trade_allowance_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_allowance. Business justification: Vendor funding records accrue against specific trade allowances (e.g., promotional allowances, scan-down allowances). Grocery trade promotion management requires linking accrued funding to the specifi',
    `accrued_funding_amount` DECIMAL(18,2) COMMENT 'Dollar amount of vendor funding that has been earned or accrued to date based on promotional performance and agreement terms.',
    `actual_performance` DECIMAL(18,2) COMMENT 'Actual performance achieved during the promotional period, measured in units corresponding to the performance metric type.',
    `agreement_end_date` DATE COMMENT 'Date when the vendor funding agreement expires and the promotional period ends. Nullable for open-ended agreements.',
    `agreement_start_date` DATE COMMENT 'Date when the vendor funding agreement becomes effective and the promotional period begins.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this vendor funding agreement was approved by authorized personnel.',
    `committed_funding_amount` DECIMAL(18,2) COMMENT 'Total dollar amount the vendor has committed to provide for this promotional funding agreement.',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed vendor funding agreement contract document stored in the document management system.',
    `cost_center_code` STRING COMMENT 'Cost center code for internal allocation of vendor funding benefits, used for profitability analysis and departmental accounting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this vendor funding record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this funding agreement.. Valid values are `USD|CAD|MXN`',
    `dispute_reason` STRING COMMENT 'Explanation of why the vendor funding reconciliation is disputed, including details of the disagreement between retailer and vendor.',
    `funding_agreement_number` STRING COMMENT 'Externally-known unique identifier for the vendor funding agreement, used for contract reference and vendor reconciliation.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `funding_rate` DECIMAL(18,2) COMMENT 'Rate at which vendor funding is earned, expressed as dollars per unit of performance (e.g., $0.50 per case sold, 2% of sales dollars).',
    `funding_rate_unit` STRING COMMENT 'Unit of measure for the funding rate: per unit sold, per case, per pallet, percentage of sales dollars, or flat fee.. Valid values are `per_unit|per_case|per_pallet|percent_of_sales|flat_fee`',
    `funding_status` STRING COMMENT 'Current lifecycle status of the vendor funding agreement: draft (being negotiated), pending approval (awaiting internal sign-off), approved (contract signed), active (funding period in effect), completed (funding period ended and reconciled), cancelled (agreement terminated), or disputed (reconciliation disagreement). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|completed|cancelled|disputed — 7 candidates stripped; promote to reference product]',
    `funding_type` STRING COMMENT 'Category of vendor promotional funding: slotting fee for shelf space allocation, endcap placement for end-of-aisle displays, new item introduction support, ad circular co-op, TPR (Temporary Price Reduction) support, BOGO (Buy One Get One) support, display allowance, markdown allowance, volume rebate, or other trade promotion funding. [ENUM-REF-CANDIDATE: slotting_fee|endcap_placement|new_item_intro|ad_circular|tpr_support|bogo_support|display_allowance|markdown_allowance|volume_rebate|other — 10 candidates stripped; promote to reference product]',
    `gl_account_code` STRING COMMENT 'General ledger account code where vendor funding is recorded for financial reporting and COGS (Cost of Goods Sold) offset.. Valid values are `^[0-9]{4,10}$`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this vendor funding agreement is currently active and in effect.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this vendor funding record was last updated in the system.',
    `notes` STRING COMMENT 'Free-text notes and comments about the vendor funding agreement, including special terms, conditions, or historical context.',
    `payment_method` STRING COMMENT 'Method by which vendor funding will be remitted: check, ACH (Automated Clearing House), wire transfer, credit memo applied to future invoices, or deduction from current invoices.. Valid values are `check|ach|wire_transfer|credit_memo|deduction_from_invoice`',
    `payment_terms` STRING COMMENT 'Terms defining when and how the vendor will remit the promotional funding: net 30/60/90 days, upon promotion completion, quarterly settlement, annual settlement, or performance-based milestone payments. [ENUM-REF-CANDIDATE: net_30|net_60|net_90|upon_completion|quarterly|annual|performance_based — 7 candidates stripped; promote to reference product]',
    `performance_metric_type` STRING COMMENT 'Type of performance metric used to measure promotional success and determine funding accrual: sales volume (units sold), sales dollars (revenue), unit movement (velocity), display compliance (planogram adherence), distribution points (store penetration), or market share gain.. Valid values are `sales_volume|sales_dollars|unit_movement|display_compliance|distribution_points|market_share_gain`',
    `performance_threshold` DECIMAL(18,2) COMMENT 'Minimum performance level required to earn the vendor funding, measured in units corresponding to the performance metric type.',
    `received_funding_amount` DECIMAL(18,2) COMMENT 'Dollar amount of vendor funding that has been actually received or credited to the retailers accounts payable.',
    `reconciliation_date` DATE COMMENT 'Date when the vendor funding was reconciled and final accrual amounts were confirmed between retailer and vendor.',
    `reconciliation_status` STRING COMMENT 'Status of the funding reconciliation process: not started, in progress, completed (both parties agree), disputed (disagreement on amounts), or resolved (dispute settled).. Valid values are `not_started|in_progress|completed|disputed|resolved`',
    `sku_list` STRING COMMENT 'Comma-separated list of SKU identifiers or UPC codes that are eligible for this vendor funding. May be null if funding applies to entire category or vendor portfolio.',
    CONSTRAINT pk_vendor_funding PRIMARY KEY(`vendor_funding_id`)
) COMMENT 'Vendor promotional funding record tracking all financial contributions from CPG manufacturers and DSD distributors, including slotting fees for shelf space allocation, endcap placement, new item introductions, and other trade promotion funding arrangements.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`funding_claim` (
    `funding_claim_id` BIGINT COMMENT 'Unique identifier for the vendor funding claim transaction. Primary key for the funding claim record.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Vendor funding claims generate AP debit memos or credit memos when the retailer bills suppliers for promotional funding. This is the core trade spend settlement process; linking claim to AP invoice en',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Funding claims are submitted and reconciled within fiscal periods; period-close trade spend accrual reporting requires fiscal period attribution. Retail-grocery finance teams report claim liability by',
    `payment_run_id` BIGINT COMMENT 'Foreign key linking to finance.payment_run. Business justification: Vendor funding claim settlements are executed via payment runs (ACH/check batches). Linking claim to payment_run enables end-to-end trade spend settlement tracking from claim submission to cash disbur',
    `promo_campaign_id` BIGINT COMMENT 'Identifier of the promotional campaign for which vendor funding reimbursement is being claimed. Links claim to specific marketing initiative.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor (supplier or manufacturer) from whom promotional funding reimbursement is being claimed. Links to the vendor master data.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Funding claims are submitted against specific trade agreements to collect vendor reimbursements. The claim settlement process requires referencing the governing trade agreement for payment terms, disp',
    `trade_allowance_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_allowance. Business justification: Funding claims are the settlement mechanism for specific trade allowances (scan allowances, off-invoice allowances, performance allowances). Grocery AP teams submit claims against individual trade all',
    `vendor_funding_id` BIGINT COMMENT 'Reference to the promotional funding agreement or contract that authorizes this reimbursement claim. Defines terms, rates, and eligible promotional activities.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar difference between claimed funding amount and approved funding amount. Positive values indicate vendor reductions; negative values indicate vendor increases.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the funding claim received internal approval before submission to vendor. Part of the SOX-compliant approval workflow audit trail.',
    `approved_funding_amount` DECIMAL(18,2) COMMENT 'Vendor-approved reimbursement amount after claim review and validation. May differ from claimed amount due to disputes, adjustments, or partial approvals.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the funding claim was cancelled before or after submission. Reasons may include promotional campaign cancellation, incorrect claim data, or vendor agreement termination.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the funding claim was cancelled. Used for audit trail and to track claim lifecycle from creation through cancellation.',
    `claim_period_end_date` DATE COMMENT 'Ending date of the promotional activity period covered by this funding claim. Defines the end of the redemption window for which reimbursement is requested.',
    `claim_period_start_date` DATE COMMENT 'Beginning date of the promotional activity period covered by this funding claim. Defines the start of the redemption window for which reimbursement is requested.',
    `claim_reference_number` STRING COMMENT 'Externally-known unique business identifier for the funding claim used in vendor communications and EDI transactions. Format: FC-YYYYMMDD-XXXXXX.. Valid values are `^FC-[0-9]{8}-[A-Z0-9]{6}$`',
    `claim_status` STRING COMMENT 'Current lifecycle status of the funding claim in the vendor reimbursement workflow. Tracks progression from draft through payment or rejection. [ENUM-REF-CANDIDATE: draft|submitted|acknowledged|under_review|approved|rejected|partially_approved|paid|disputed|cancelled — 10 candidates stripped; promote to reference product]',
    `claimed_discount_amount` DECIMAL(18,2) COMMENT 'Total dollar value of promotional discounts provided to customers during the claim period, for which vendor reimbursement is being requested. Gross claim amount before adjustments.',
    `claimed_funding_amount` DECIMAL(18,2) COMMENT 'Total vendor funding reimbursement amount being claimed based on the funding agreement terms, claimed units, and discount amounts. Net amount requested from vendor.',
    `claimed_units_sold` DECIMAL(18,2) COMMENT 'Total quantity of promotional units sold during the claim period for which vendor funding reimbursement is being requested. Supports per-unit funding calculations.',
    `cost_center_code` STRING COMMENT 'Cost center responsible for the promotional campaign and associated vendor funding claim. Used for internal cost allocation and GMROI analysis by business unit.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this funding claim record was first created in the system, typically in draft status before submission.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this claim (claimed, approved, adjustment, paid). Typically USD for US operations.. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Vendor-provided explanation for claim rejection, partial approval, or adjustment. Captures reasons such as ineligible products, incorrect calculations, missing documentation, or contract term violations.',
    `dispute_resolution_status` STRING COMMENT 'Current status of dispute resolution process when vendor and retailer disagree on claim amount or eligibility. Tracks negotiation and escalation workflow.. Valid values are `not_applicable|open|under_negotiation|resolved_accepted|resolved_rejected|escalated`',
    `edi_transaction_set_code` STRING COMMENT 'EDI transaction set identifier for the electronic claim submission, typically EDI 810 Invoice or custom promotional claim transaction. Used for EDI audit trail and reconciliation.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the vendor funding reimbursement will be posted in the financial system. Typically a promotional allowance or vendor funding receivable account.. Valid values are `^[0-9]{4,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this funding claim record was most recently updated, including status changes, amount adjustments, or supporting documentation additions.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or internal notes related to the funding claim processing, vendor communications, or dispute resolution.',
    `payment_method` STRING COMMENT 'Method by which the vendor remitted the approved funding amount. ACH and wire transfer are most common for large claims; credit memos may offset future invoices.. Valid values are `ach|wire_transfer|check|credit_memo|offset`',
    `payment_received_date` DATE COMMENT 'Date when the vendor funding reimbursement payment was received and posted to accounts receivable. Used for cash flow tracking and vendor payment performance analysis.',
    `payment_reference_number` STRING COMMENT 'Vendor-provided payment reference number, check number, wire confirmation number, or remittance advice identifier used to reconcile the funding payment in accounts receivable.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the funding claim was officially submitted to the vendor for reimbursement processing. Represents the principal business event timestamp for this transaction.',
    `supporting_evidence_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation for this claim, such as POS transaction reports, redemption summaries, or scan data extracts required by vendor for validation.',
    `vendor_acknowledgment_status` STRING COMMENT 'Indicates whether the vendor has acknowledged receipt of the funding claim submission via EDI 997 Functional Acknowledgment or other communication channel.. Valid values are `pending|acknowledged|not_acknowledged`',
    `vendor_acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor acknowledged receipt of the funding claim, typically via EDI transaction or vendor portal confirmation.',
    `vendor_response_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor provided their approval, rejection, or partial approval decision on the funding claim.',
    CONSTRAINT pk_funding_claim PRIMARY KEY(`funding_claim_id`)
) COMMENT 'Transactional claim submitted to a vendor for reimbursement of promotional funding. Captures claim reference number, vendor identifier, funding agreement reference, claim period, claimed units sold, claimed discount amount, supporting redemption evidence, submission date, vendor acknowledgment status, and payment received date. Supports EDI-based vendor claim processing and accounts receivable reconciliation for promotional funding.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`personalized_deal` (
    `personalized_deal_id` BIGINT COMMENT 'Unique identifier for the personalized deal record. Primary key.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: Personalized deals are generated only for items in the shoppers accessible assortment. Linking to assortment_item enables ML personalization models to filter eligible items by assortment tier and sto',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: Retail-grocery pharmacy runs medication adherence incentive programs where personalized deals (loyalty points, discounts) are tied to specific drugs. This supports the named process medication adhere',
    `category_id` BIGINT COMMENT 'Identifier of the product category eligible for this personalized deal. Links to the category entity. Null if deal applies to specific SKUs.',
    `household_id` BIGINT COMMENT 'Identifier of the household to which this personalized deal was targeted. Links to the household master entity for multi-member household-level targeting.',
    `membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: Personalized deals in grocery are generated, delivered, and activated against a loyalty membership account. The activated_timestamp, delivered_timestamp, and redeemed_timestamp on personalized_deal re',
    `promo_campaign_id` BIGINT COMMENT 'Identifier of the parent promotional campaign under which this personalized deal was generated. Links to the promo_campaign entity.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: A personalized deal is generated from a base promotional offer and customized for a specific customer or household. personalized_deal has promo_campaign_id (existing) but lacks a link to the specific ',
    `promotion_redemption_id` BIGINT COMMENT 'Identifier of the point-of-sale or online transaction in which this personalized deal was redeemed. Null if not yet redeemed.',
    `segment_id` BIGINT COMMENT 'Identifier of the customer segment used for targeting this personalized deal. Links to the customer_segment entity.',
    `shopper_id` BIGINT COMMENT 'Identifier of the individual shopper to whom this personalized deal was targeted. Links to the shopper master entity for individual-level targeting.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store where this personalized deal was redeemed, if redeemed in-store. Links to the store entity. Null if redeemed online or not yet redeemed.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: personalized_deal.loyalty_tier is a denormalized plain-text column representing the loyalty tier targeted by the deal. Tier-based personalized deal generation is a named business process (e.g., Gold-t',
    `ab_test_variant` STRING COMMENT 'Identifier of the A/B test variant or experiment group to which this personalized deal belongs. Used for testing deal effectiveness and optimization.',
    `activated_timestamp` TIMESTAMP COMMENT 'Date and time when the customer activated or clipped this personalized deal for use. Null if not yet activated.',
    `actual_discount_applied` DECIMAL(18,2) COMMENT 'Actual dollar amount of discount applied at redemption. May differ from discount_amount due to purchase amount or maximum discount cap. Null if not yet redeemed.',
    `bonus_points` STRING COMMENT 'Number of loyalty bonus points awarded upon redemption of this deal, if deal_type is bonus_points.',
    `cancellation_reason` STRING COMMENT 'Reason why this personalized deal was cancelled before redemption or expiration, if applicable. Null if deal was not cancelled.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when this personalized deal was cancelled. Null if deal was not cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this personalized deal record was first created in the system. Audit trail for record creation.',
    `deal_code` STRING COMMENT 'Unique alphanumeric code assigned to this personalized deal for redemption tracking and customer reference. Displayed in app, email, or kiosk.. Valid values are `^[A-Z0-9]{8,20}$`',
    `deal_name` STRING COMMENT 'Human-readable name or title of the personalized deal, displayed to the customer (e.g., Your Weekly Savings on Fresh Produce).',
    `deal_status` STRING COMMENT 'Current lifecycle status of the personalized deal. Tracks progression from generation through redemption or expiration. [ENUM-REF-CANDIDATE: generated|delivered|viewed|activated|redeemed|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `deal_type` STRING COMMENT 'Type of promotional offer mechanism for this personalized deal. Defines the discount structure or reward type. [ENUM-REF-CANDIDATE: percentage_discount|fixed_amount_discount|bogo|buy_x_get_y|free_item|bonus_points|cashback — 7 candidates stripped; promote to reference product]',
    `delivered_timestamp` TIMESTAMP COMMENT 'Date and time when this personalized deal was successfully delivered to the customer via the specified delivery channel. Null if not yet delivered.',
    `delivery_channel` STRING COMMENT 'Channel through which this personalized deal was delivered to the customer. Supports omnichannel personalization tracking. [ENUM-REF-CANDIDATE: mobile_app_push|email|sms|in_store_kiosk|website_banner|direct_mail|pos_receipt — 7 candidates stripped; promote to reference product]',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount discount offered by this deal, if deal_type is fixed_amount_discount. Expressed in local currency.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered by this deal, if deal_type is percentage_discount. Expressed as a decimal (e.g., 15.00 for 15% off).',
    `eligible_sku_list` STRING COMMENT 'Comma-separated list of SKU identifiers eligible for this personalized deal. Null if deal applies to categories or all items.',
    `generated_timestamp` TIMESTAMP COMMENT 'Date and time when this personalized deal was generated by the system. Represents the business event time of deal creation.',
    `generation_source` STRING COMMENT 'System or process that generated this personalized deal. Identifies whether the deal was created by machine learning model, business rules, CRM campaign, or manual curation.. Valid values are `ml_recommendation_engine|rule_based_engine|crm_campaign|manual_selection|loyalty_tier_auto|behavioral_trigger`',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether this personalized deal can be combined with other promotions or coupons in a single transaction. True if stackable, False if exclusive.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this personalized deal record was last updated in the system. Audit trail for record modification.',
    `maximum_discount_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount that can be discounted under this deal, if applicable. Used to cap percentage-based discounts.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum purchase amount required to qualify for this personalized deal. Null if no minimum applies.',
    `ml_model_code` STRING COMMENT 'Identifier of the machine learning model or algorithm version that generated this deal, if applicable. Used for model performance tracking and A/B testing.',
    `offer_description` STRING COMMENT 'Detailed description of the personalized deal offer, including terms, conditions, and customer-facing messaging.',
    `priority_rank` STRING COMMENT 'Priority ranking of this personalized deal relative to other deals for the same customer. Lower numbers indicate higher priority for display and redemption sequencing.',
    `redeemed_timestamp` TIMESTAMP COMMENT 'Date and time when this personalized deal was redeemed at point of sale or online checkout. Null if not yet redeemed.',
    `redemption_count` STRING COMMENT 'Number of times this personalized deal has been redeemed by the customer or household to date. Incremented at each redemption.',
    `redemption_limit` STRING COMMENT 'Maximum number of times this personalized deal can be redeemed by the targeted customer or household. Null if unlimited.',
    `targeting_rationale` STRING COMMENT 'Business reason or logic for why this deal was targeted to this customer or household. May include segment, purchase history pattern, or behavioral signal summary.',
    `valid_from_date` DATE COMMENT 'Start date of the validity window for this personalized deal. Customer can redeem the deal on or after this date.',
    `valid_until_date` DATE COMMENT 'End date of the validity window for this personalized deal. Customer must redeem the deal on or before this date.',
    `viewed_timestamp` TIMESTAMP COMMENT 'Date and time when the customer first viewed this personalized deal in the app, email, or kiosk. Null if not yet viewed.',
    CONSTRAINT pk_personalized_deal PRIMARY KEY(`personalized_deal_id`)
) COMMENT 'Personalized promotional deal generated for a specific customer or household based on purchase history, loyalty tier, segment, and behavioral signals. Captures deal generation source (ML model, rule-based, CRM campaign), offer details, targeting rationale, customer or household identifier, deal delivery channel (app push, email, in-store kiosk), deal validity window, and acceptance/redemption outcome. Supports Customer Loyalty and Promotions Management with 1:1 personalization at scale.';

CREATE OR REPLACE TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` (
    `circular_offer_placement_id` BIGINT COMMENT 'Primary key for the circular_offer_placement association',
    `ad_circular_id` BIGINT COMMENT 'Foreign key linking this placement record to the specific ad circular edition in which the offer is featured.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking this placement record to the specific promotional offer being featured in the circular.',
    `bogo_offers_count` STRING COMMENT 'Number of Buy One Get One (BOGO) promotional offers included in this circular. [Moved from ad_circular: This is a derived aggregate count of BOGO offer placements within the circular. It is derivable by querying circular_offer_placement records joined to promo_offer where discount_type = BOGO. Storing it on ad_circular creates a denormalized redundancy that will drift out of sync as placements are added or removed. It should be removed from ad_circular and computed on demand.]',
    `feature_size` STRING COMMENT 'Physical or digital dimensions of the offer placement within the circular (e.g., 4x6 inches, 300x250px). Specific to each offer-circular placement combination.',
    `feature_type` STRING COMMENT 'Classification of the feature format for this offer placement within the circular (e.g., full-page feature, half-page, thumbnail). Determined per placement, not per offer or per circular.',
    `page_number` BIGINT COMMENT 'The page number within the circular on which this offer placement appears. Belongs to the placement, not to the offer or the circular independently.',
    `placement_position` STRING COMMENT 'The specific position or coordinate slot on the page where this offer is placed (e.g., top-left, center-spread, endcap callout). Belongs to the placement relationship.',
    `slotting_fee_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the vendor-paid slotting fee negotiated for this specific offer placement in this circular. Varies per offer-circular combination and cannot reside on either parent entity.',
    CONSTRAINT pk_circular_offer_placement PRIMARY KEY(`circular_offer_placement_id`)
) COMMENT 'This association product represents the Placement event between a promo_offer and an ad_circular. It captures the operational decision by merchandisers to feature a specific promotional offer at a specific position within a specific circular edition, including the negotiated slotting fee, page location, feature type, and feature size. Each record links one promo_offer to one ad_circular and carries attributes that exist only in the context of that specific placement — they belong neither to the offer alone nor to the circular alone.. Existence Justification: In grocery retail, merchandisers actively manage which promotional offers are placed in which ad circulars — a single offer (e.g., a BOGO on cereal) can appear in multiple circulars (weekly standard, loyalty-exclusive, digital-only), and a single circular contains dozens to hundreds of distinct offers. The placement itself is a managed business artifact: merchandisers negotiate page position, feature size, and slotting fees for each offer-circular combination, making the relationship a first-class operational entity called circular offer placement that carries its own attributes independent of either the offer or the circular.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ADD CONSTRAINT `fk_promotion_ad_circular_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_ad_circular_id` FOREIGN KEY (`ad_circular_id`) REFERENCES `grocery_ecm`.`promotion`.`ad_circular`(`ad_circular_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ADD CONSTRAINT `fk_promotion_offer_eligibility_rule_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_digital_coupon_id` FOREIGN KEY (`digital_coupon_id`) REFERENCES `grocery_ecm`.`promotion`.`digital_coupon`(`digital_coupon_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_offer_item_id` FOREIGN KEY (`offer_item_id`) REFERENCES `grocery_ecm`.`promotion`.`offer_item`(`offer_item_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_ad_circular_id` FOREIGN KEY (`ad_circular_id`) REFERENCES `grocery_ecm`.`promotion`.`ad_circular`(`ad_circular_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_vendor_funding_id` FOREIGN KEY (`vendor_funding_id`) REFERENCES `grocery_ecm`.`promotion`.`vendor_funding`(`vendor_funding_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ADD CONSTRAINT `fk_promotion_funding_claim_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ADD CONSTRAINT `fk_promotion_funding_claim_vendor_funding_id` FOREIGN KEY (`vendor_funding_id`) REFERENCES `grocery_ecm`.`promotion`.`vendor_funding`(`vendor_funding_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_promotion_redemption_id` FOREIGN KEY (`promotion_redemption_id`) REFERENCES `grocery_ecm`.`promotion`.`promotion_redemption`(`promotion_redemption_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` ADD CONSTRAINT `fk_promotion_circular_offer_placement_ad_circular_id` FOREIGN KEY (`ad_circular_id`) REFERENCES `grocery_ecm`.`promotion`.`ad_circular`(`ad_circular_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` ADD CONSTRAINT `fk_promotion_circular_offer_placement_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`promotion` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `grocery_ecm`.`promotion` SET TAGS ('dbx_domain' = 'promotion');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `banner_id` SET TAGS ('dbx_business_glossary_term' = 'Banner Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Format Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `new_item_intro_id` SET TAGS ('dbx_business_glossary_term' = 'New Item Intro Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Calendar Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `ad_circular_week` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular Week');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `ad_circular_week` SET TAGS ('dbx_value_regex' = '^d{4}-Wd{2}$');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_merchandising|pending_finance|pending_legal|approved|rejected');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_value_regex' = 'trial|frequency|basket_size|loyalty_acquisition|clearance|seasonal_sell_through');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'weekly_ad_circular|digital|in_store_event|seasonal|vendor_sponsored|loyalty_exclusive');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `expected_incremental_sales` SET TAGS ('dbx_business_glossary_term' = 'Expected Incremental Sales');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `expected_incremental_sales` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `expected_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Redemption Count');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `is_digital_coupon_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is Digital Coupon Enabled Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `is_loyalty_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Loyalty Exclusive Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `legal_disclaimer` SET TAGS ('dbx_business_glossary_term' = 'Legal Disclaimer');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `planning_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Start Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `promo_campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `promotion_mechanics` SET TAGS ('dbx_business_glossary_term' = 'Promotion Mechanics');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `target_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Channel');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `target_channel` SET TAGS ('dbx_value_regex' = 'in_store|digital|omnichannel|pickup|delivery');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `target_gmroi` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Margin Return on Investment (GMROI)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `target_gmroi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `vendor_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funding Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `vendor_funding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `activation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Activation Requirement');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `activation_requirement` SET TAGS ('dbx_value_regex' = 'auto_apply|clip_required|loyalty_required|code_entry');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `clip_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Clip Required Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|mobile_app|sms|direct_mail|in_store|web');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `digital_coupon_barcode` SET TAGS ('dbx_business_glossary_term' = 'Digital Coupon Barcode');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `digital_coupon_format` SET TAGS ('dbx_business_glossary_term' = 'Digital Coupon Format');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `digital_coupon_format` SET TAGS ('dbx_value_regex' = 'upc_a|databar|qr_code|code_128');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_item|tiered');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `eligible_channel` SET TAGS ('dbx_business_glossary_term' = 'Eligible Channel');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `eligible_channel` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile_app|kiosk|all_channels');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `exclusion_rules` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rules');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'vendor_funded|grocer_funded|co_funded');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `gmroi_target` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Target');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `gmroi_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `loyalty_points_required` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Required');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `manufacturer_coupon_flag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Coupon Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `maximum_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_business_glossary_term' = 'Offer Name');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|expired|cancelled');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_subtype` SET TAGS ('dbx_business_glossary_term' = 'Offer Subtype');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_subtype` SET TAGS ('dbx_value_regex' = 'digital_coupon|loyalty_reward|personalized_deal|mass_offer|ad_circular|endcap_promo');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'bogo|tpr|percent_off|dollar_off|mix_and_match|bundle');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `personalization_model_code` SET TAGS ('dbx_business_glossary_term' = 'Personalization Model ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `personalization_type` SET TAGS ('dbx_business_glossary_term' = 'Personalization Type');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `personalization_type` SET TAGS ('dbx_value_regex' = 'ml_model|rule_based|mass|segment_targeted');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `redemption_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Customer');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `redemption_limit_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Transaction');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Calendar ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `banner_id` SET TAGS ('dbx_business_glossary_term' = 'Banner Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `ad_circular_print_flag` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular Print Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `ad_circular_week` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular Week Number');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Calendar Code');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Calendar Name');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Calendar Status');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_value_regex' = 'draft|planned|approved|active|completed|cancelled');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_business_glossary_term' = 'Calendar Type');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_value_regex' = 'weekly_ad_circular|seasonal_event|holiday_promotion|category_event|vendor_funded|markdown_clearance');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict Resolution Notes');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `digital_coupon_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Coupon Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Budget Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `event_theme` SET TAGS ('dbx_business_glossary_term' = 'Event Theme');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `loyalty_exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Exclusive Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `merchandising_notes` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Notes');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `overlap_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overlap Allowed Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `slotting_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'Slotting Commitment Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `target_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Channel');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `target_channel` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile_app|omnichannel');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `target_gmroi` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Margin Return on Investment (GMROI)');
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `vendor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `ad_circular_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular ID');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Calendar Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `circular_name` SET TAGS ('dbx_business_glossary_term' = 'Circular Name');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `circular_number` SET TAGS ('dbx_business_glossary_term' = 'Circular Number');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `circular_status` SET TAGS ('dbx_business_glossary_term' = 'Circular Status');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `circular_type` SET TAGS ('dbx_business_glossary_term' = 'Circular Type');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `circular_type` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|monthly|seasonal|special_event|holiday');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `cover_page_headline` SET TAGS ('dbx_business_glossary_term' = 'Cover Page Headline');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `digital_coupon_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Coupon Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `digital_platform` SET TAGS ('dbx_business_glossary_term' = 'Digital Platform');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `digital_reach_estimate` SET TAGS ('dbx_business_glossary_term' = 'Digital Reach Estimate');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `endcap_feature_count` SET TAGS ('dbx_business_glossary_term' = 'Endcap Feature Count');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Budget Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `estimated_gmroi_target` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Margin Return on Investment (GMROI) Target');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `estimated_gmroi_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `featured_category` SET TAGS ('dbx_business_glossary_term' = 'Featured Category');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Format Type');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'print_only|digital_only|print_and_digital');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'ENG|SPA|FRA|CHI');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `loyalty_exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Exclusive Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `merchandiser_name` SET TAGS ('dbx_business_glossary_term' = 'Merchandiser Name');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `print_circulation_quantity` SET TAGS ('dbx_business_glossary_term' = 'Print Circulation Quantity');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `print_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Print Vendor Name');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `production_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Production Deadline Date');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `proof_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Proof Approval Date');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `proof_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Proof Approval Status');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `proof_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `theme` SET TAGS ('dbx_business_glossary_term' = 'Circular Theme');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `total_offers_count` SET TAGS ('dbx_business_glossary_term' = 'Total Offers Count');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `tpr_offers_count` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction (TPR) Offers Count');
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ALTER COLUMN `vendor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` SET TAGS ('dbx_subdomain' = 'offer_eligibility');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `offer_item_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Item ID');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `ad_circular_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster ID');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `ad_circular_featured_flag` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular Featured Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `age_restriction_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction Required Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `channel_restriction` SET TAGS ('dbx_business_glossary_term' = 'Channel Restriction');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `channel_restriction` SET TAGS ('dbx_value_regex' = 'all_channels|in_store_only|online_only|mobile_app_only|pickup_only|delivery_only');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `cost_override_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Override Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `cost_override_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `digital_coupon_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Coupon Eligible Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `discount_override_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Override Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `discount_override_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Override Percentage');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `facing_count` SET TAGS ('dbx_business_glossary_term' = 'Facing Count');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `inclusion_type` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Type');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `inclusion_type` SET TAGS ('dbx_value_regex' = 'included|excluded|required|optional');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `item_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Item Identifier Type');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `item_identifier_type` SET TAGS ('dbx_value_regex' = 'SKU|UPC|GTIN|PLU|EAN|ISBN');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `item_identifier_value` SET TAGS ('dbx_business_glossary_term' = 'Item Identifier Value');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `item_role` SET TAGS ('dbx_business_glossary_term' = 'Item Role');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `item_role` SET TAGS ('dbx_value_regex' = 'buy_item|get_item|trigger_item|reward_item|qualifying_item|bundle_component');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `loyalty_points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Multiplier');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `maximum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `offer_item_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Item Status');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `offer_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended|cancelled');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `planogram_placement_code` SET TAGS ('dbx_business_glossary_term' = 'Planogram Placement Code');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'SNAP (Supplemental Nutrition Assistance Program) Eligible Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `vendor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'WIC (Women Infants and Children Program) Eligible Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` SET TAGS ('dbx_subdomain' = 'offer_eligibility');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `offer_eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Eligibility Rule ID');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment ID');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster ID');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `channel_restriction` SET TAGS ('dbx_business_glossary_term' = 'Channel Restriction');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `channel_restriction` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile_app|curbside_pickup|delivery|all_channels');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Frequency');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|on_demand');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `geographic_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Zone Code');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `maximum_age_years` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age (Years)');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `minimum_age_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age (Years)');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `minimum_loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Minimum Loyalty Tier');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `new_customer_definition_days` SET TAGS ('dbx_business_glossary_term' = 'New Customer Definition (Days)');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `new_customer_flag` SET TAGS ('dbx_business_glossary_term' = 'New Customer Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `purchase_history_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase History Threshold Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `purchase_history_threshold_period_days` SET TAGS ('dbx_business_glossary_term' = 'Purchase History Threshold Period (Days)');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `rule_logic_expression` SET TAGS ('dbx_business_glossary_term' = 'Rule Logic Expression');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|expired|suspended');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `snap_ebt_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) / Electronic Benefits Transfer (EBT) Eligible Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women, Infants, and Children (WIC) Eligible Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` SET TAGS ('dbx_subdomain' = 'offer_eligibility');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `digital_coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Coupon ID');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `banner_id` SET TAGS ('dbx_business_glossary_term' = 'Banner Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Campaign ID');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment ID');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `barcode` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `clip_status` SET TAGS ('dbx_business_glossary_term' = 'Clip Status');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `clip_status` SET TAGS ('dbx_value_regex' = 'available|clipped|redeemed|expired');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `clip_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clip Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `coupon_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `current_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Current Redemption Count');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `digital_coupon_description` SET TAGS ('dbx_business_glossary_term' = 'Coupon Description');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage_off|dollar_off|bogo|fixed_price|free_item');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `eligible_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Eligible Stock Keeping Unit (SKU) List');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `excluded_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Excluded Stock Keeping Unit (SKU) List');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `face_value` SET TAGS ('dbx_business_glossary_term' = 'Face Value');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Image Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|gif|webp)$');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `issuing_channel` SET TAGS ('dbx_business_glossary_term' = 'Issuing Channel');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `issuing_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|website|email|sms|loyalty_portal|social_media');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `loyalty_points_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `manufacturer_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Packaged Goods (CPG) Manufacturer Funded Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `maximum_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `maximum_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Count');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `personalization_source` SET TAGS ('dbx_business_glossary_term' = 'Personalization Source');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `personalization_source` SET TAGS ('dbx_value_regex' = 'mass|targeted|behavioral|demographic|predictive');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `qr_code` SET TAGS ('dbx_business_glossary_term' = 'QR (Quick Response) Code');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `store_eligibility_type` SET TAGS ('dbx_business_glossary_term' = 'Store Eligibility Type');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `store_eligibility_type` SET TAGS ('dbx_value_regex' = 'all_stores|specific_stores|store_cluster|online_only|in_store_only');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Coupon Title');
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ALTER COLUMN `total_redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Limit');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` SET TAGS ('dbx_subdomain' = 'vendor_funding');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `promotion_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Redemption ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `digital_coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Coupon Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `member_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Member Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `offer_item_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `points_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Points Transaction Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Order Line Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `tpr_id` SET TAGS ('dbx_business_glossary_term' = 'Tpr Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `ad_circular_week` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular Week');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'pos|self_checkout|online|mobile_app|curbside_pickup|in_store_pickup');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `clearing_house_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Submission Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `clearing_house_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Submission Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `digital_coupon_clip_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Digital Coupon Clip Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `ebt_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Eligible Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `final_price` SET TAGS ('dbx_business_glossary_term' = 'Final Price');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `item_quantity` SET TAGS ('dbx_business_glossary_term' = 'Item Quantity');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `loyalty_account_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Number');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `loyalty_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `loyalty_account_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Price');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `personalized_deal_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalized Deal Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `promotion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `promotion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Date');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `register_number` SET TAGS ('dbx_business_glossary_term' = 'Register Number');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Status');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|paid');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `retailer_funded_amount` SET TAGS ('dbx_business_glossary_term' = 'Retailer Funded Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|partially_applied|pending_review|expired|invalid_coupon');
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ALTER COLUMN `vendor_funded_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` SET TAGS ('dbx_subdomain' = 'vendor_funding');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `tpr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction (TPR) Event ID');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `ad_circular_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Campaign ID');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `tpr_id` SET TAGS ('dbx_business_glossary_term' = 'Tpr Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `trade_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Allowance Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `vendor_funding_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funding Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN|EUR|GBP');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `discount_depth_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Depth Percentage');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `display_location_code` SET TAGS ('dbx_business_glossary_term' = 'Display Location Code');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `expected_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Revenue Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `expected_unit_sales` SET TAGS ('dbx_business_glossary_term' = 'Expected Unit Sales');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `is_ad_circular_featured` SET TAGS ('dbx_business_glossary_term' = 'Is Ad Circular Featured Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `is_endcap_display` SET TAGS ('dbx_business_glossary_term' = 'Is Endcap Display Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `is_vendor_funded` SET TAGS ('dbx_business_glossary_term' = 'Is Vendor Funded Flag');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `markdown_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Markdown Reason Code');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `maximum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Purchase Quantity');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `original_srp_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Suggested Retail Price (SRP) Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `pos_activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Activation Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `pos_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Integration Status');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `pos_integration_status` SET TAGS ('dbx_value_regex' = 'pending|transmitted|active|failed|reverted');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `target_gmroi` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Margin Return on Investment (GMROI)');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `tpr_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction (TPR) Price Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `tpr_status` SET TAGS ('dbx_business_glossary_term' = 'Temporary Price Reduction (TPR) Status');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `tpr_status` SET TAGS ('dbx_value_regex' = 'planned|approved|active|completed|cancelled|suspended');
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ALTER COLUMN `vendor_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funding Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` SET TAGS ('dbx_subdomain' = 'vendor_funding');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `vendor_funding_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funding ID');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `banner_id` SET TAGS ('dbx_business_glossary_term' = 'Banner Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `reward_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster ID');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `trade_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Allowance Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `accrued_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Funding Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `actual_performance` SET TAGS ('dbx_business_glossary_term' = 'Actual Performance');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `committed_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Funding Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `funding_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Number');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `funding_agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `funding_rate` SET TAGS ('dbx_business_glossary_term' = 'Funding Rate');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `funding_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Funding Rate Unit');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `funding_rate_unit` SET TAGS ('dbx_value_regex' = 'per_unit|per_case|per_pallet|percent_of_sales|flat_fee');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `funding_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Status');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `funding_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Type');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire_transfer|credit_memo|deduction_from_invoice');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `performance_metric_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Type');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `performance_metric_type` SET TAGS ('dbx_value_regex' = 'sales_volume|sales_dollars|unit_movement|display_compliance|distribution_points|market_share_gain');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `performance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Performance Threshold');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `received_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Received Funding Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|disputed|resolved');
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ALTER COLUMN `sku_list` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) List');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` SET TAGS ('dbx_subdomain' = 'vendor_funding');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `funding_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Claim ID');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `trade_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Allowance Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `vendor_funding_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement ID');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `approved_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Funding Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `claim_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Period End Date');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `claim_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Period Start Date');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Reference Number');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_value_regex' = '^FC-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `claimed_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Discount Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `claimed_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Funding Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `claimed_units_sold` SET TAGS ('dbx_business_glossary_term' = 'Claimed Units Sold');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Status');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_value_regex' = 'not_applicable|open|under_negotiation|resolved_accepted|resolved_rejected|escalated');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `edi_transaction_set_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set ID');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_memo|offset');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `supporting_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence Reference');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `vendor_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Acknowledgment Status');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `vendor_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|not_acknowledged');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `vendor_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Vendor Acknowledgment Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ALTER COLUMN `vendor_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` SET TAGS ('dbx_subdomain' = 'offer_eligibility');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `personalized_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Personalized Deal ID');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Eligible Category ID');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `promotion_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Transaction ID');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment ID');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Store ID');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `actual_discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Actual Discount Applied');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Bonus Points');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `deal_code` SET TAGS ('dbx_business_glossary_term' = 'Deal Code');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `deal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Deal Name');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `eligible_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Eligible Stock Keeping Unit (SKU) List');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Generated Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `generation_source` SET TAGS ('dbx_business_glossary_term' = 'Generation Source');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `generation_source` SET TAGS ('dbx_value_regex' = 'ml_recommendation_engine|rule_based_engine|crm_campaign|manual_selection|loyalty_tier_auto|behavioral_trigger');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Is Stackable');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `maximum_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `ml_model_code` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model ID');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `redeemed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redeemed Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `targeting_rationale` SET TAGS ('dbx_business_glossary_term' = 'Targeting Rationale');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ALTER COLUMN `viewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Viewed Timestamp');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` SET TAGS ('dbx_association_edges' = 'promotion.promo_offer,promotion.ad_circular');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` ALTER COLUMN `circular_offer_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Offer Placement - Circular Offer Placement Id');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` ALTER COLUMN `ad_circular_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Offer Placement - Ad Circular Id');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Offer Placement - Promo Offer Id');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` ALTER COLUMN `bogo_offers_count` SET TAGS ('dbx_business_glossary_term' = 'Buy One Get One (BOGO) Offers Count');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` ALTER COLUMN `feature_size` SET TAGS ('dbx_business_glossary_term' = 'Feature Size');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` ALTER COLUMN `feature_type` SET TAGS ('dbx_business_glossary_term' = 'Feature Type');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` ALTER COLUMN `page_number` SET TAGS ('dbx_business_glossary_term' = 'Circular Page Number');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` ALTER COLUMN `placement_position` SET TAGS ('dbx_business_glossary_term' = 'Placement Position');
ALTER TABLE `grocery_ecm`.`promotion`.`circular_offer_placement` ALTER COLUMN `slotting_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Slotting Fee Amount');
