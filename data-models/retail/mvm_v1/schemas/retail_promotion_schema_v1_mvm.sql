-- Schema for Domain: promotion | Business: Retail | Version: v1_mvm
-- Generated on: 2026-05-04 13:27:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `retail_ecm`.`promotion` COMMENT 'Manages promotional campaigns, deals, coupons, rebates, BOGO offers, seasonal sales events, circular ads, and digital promotions across channels. Tracks promotion effectiveness, redemption rates, incremental lift, promotional ROI, and vendor-funded promotion agreements. Distinct from pricing — promotions are time-bound, event-driven incentives. Supports omnichannel promotion execution across POS, e-commerce, and mobile apps.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `retail_ecm`.`promotion`.`promo_campaign` (
    `promo_campaign_id` BIGINT COMMENT 'Unique identifier for the promotional campaign. Primary key.',
    `assortment_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_plan. Business justification: Retail buyers tie promotional campaigns to specific assortment plans during seasonal planning (e.g., new-item launch campaigns). The campaign-to-assortment alignment report is a standard retail plan',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Brand-level promotional campaigns (e.g., Summer Pepsi Campaign, Nike Back-to-School) are a core retail/CPG process. Brand campaign planning, vendor co-op reporting, and brand promotional spend ana',
    `buyer_id` BIGINT COMMENT 'Foreign key linking to merchandising.buyer. Business justification: In retail, buyers own promotional campaigns for their categories and negotiate vendor-funded promotions. Campaign performance reporting by buyer (ROI, redemption rate, margin impact) is a standard ret',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Promotional campaigns are planned and executed at category level. Category managers need visibility to all campaigns targeting their categories for assortment planning, inventory positioning, and perf',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Promo campaigns span fiscal periods; finance teams align campaign spend to financial periods for period-close and promotional ROI reporting. Retail finance requires campaign-level fiscal period attrib',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Campaign expenses must post to specific GL accounts for financial reporting. Every campaign has a default expense account (promotional allowances, markdown expense) required for proper accounting clas',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Campaigns target product categories/departments (e.g., Back to School - Electronics). Budget allocation, buyer approval workflows, and performance rollup all operate at hierarchy level. Enables cate',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Promo campaign budgets and GL postings are made against a specific ledger in retail finance. Ledger attribution on promo_campaign ensures correct multi-GAAP reporting of promotional spend across leadi',
    `member_segment_id` BIGINT COMMENT 'Foreign key linking to loyalty.member_segment. Business justification: promo_campaign.customer_segment_target is a plain-text denormalization of loyalty.member_segment. Campaign targeting, personalization reporting, and segment-level ROI analysis require a proper FK. Ret',
    `parent_promo_campaign_id` BIGINT COMMENT 'Self-referencing FK on promo_campaign (parent_promo_campaign_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Campaigns are executed by specific profit centers (stores, channels, regions). P&L reporting requires linking campaign revenue and costs to profit centers for performance analysis and financial statem',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: Retailers run loyalty-program-scoped campaigns (e.g., Members Only Double Points Weekend). promo_campaign.loyalty_exclusive_flag requires knowing WHICH loyalty program is exclusive. Campaign plannin',
    `promo_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_calendar. Business justification: Campaigns are planned and executed according to promotional calendar periods. The promo_campaign has start_date and end_date that should align with promotional periods defined in promo_calendar (e.g.,',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Seasonal promotions (Back-to-School, Holiday, Spring clearance) are core retail planning. Campaigns must align with merchandising seasonal calendars for coordinated go-to-market execution. Critical fo',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor providing funding or support for the campaign, if applicable.',
    `approval_status` STRING COMMENT 'Approval workflow status indicating whether the campaign has been reviewed and authorized for execution.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the business user who approved the campaign for execution.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign was approved for execution.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for the promotional campaign including discounts, advertising, and operational costs.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the campaign budget amount.. Valid values are `^[A-Z]{3}$`',
    `campaign_code` STRING COMMENT 'Externally-known unique business identifier for the campaign used across systems and communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `campaign_description` STRING COMMENT 'Detailed description of the campaign objectives, target audience, and promotional strategy.',
    `campaign_name` STRING COMMENT 'Human-readable name of the promotional campaign for business user identification and reporting.',
    `campaign_type` STRING COMMENT 'Classification of the promotional campaign by strategic purpose and funding model.. Valid values are `seasonal|clearance|new_product_launch|loyalty|vendor_funded|flash_sale`',
    `channel_scope` STRING COMMENT 'Distribution channels where the promotional campaign is active (omnichannel, in-store, e-commerce, mobile).. Valid values are `omnichannel|in_store_only|online_only|mobile_app_only`',
    `circular_ad_flag` BOOLEAN COMMENT 'Indicates whether the campaign is featured in printed or digital circular advertisements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was first created in the system.',
    `digital_promotion_flag` BOOLEAN COMMENT 'Indicates whether the campaign includes digital promotions delivered via e-commerce, mobile app, or email.',
    `discount_strategy` STRING COMMENT 'Primary discount mechanism used in the campaign (percentage off, fixed amount, BOGO, bundle pricing, tiered discounts, rebate).. Valid values are `percentage_off|fixed_amount_off|bogo|bundle|tiered|rebate`',
    `end_date` DATE COMMENT 'Date when the promotional campaign concludes and offers are no longer valid.',
    `event_classification` STRING COMMENT 'Specific promotional event type within the campaign (e.g., Flash Sale, Doorbuster, BOGO). [ENUM-REF-CANDIDATE: flash_sale|doorbuster|holiday_sale|weekly_circular|bogo|markdown|rebate — 7 candidates stripped; promote to reference product]',
    `geographic_scope` STRING COMMENT 'Geographic reach of the promotional campaign (national, regional, local, or specific stores).. Valid values are `national|regional|local|store_specific`',
    `loyalty_exclusive_flag` BOOLEAN COMMENT 'Indicates whether the campaign offers are exclusive to loyalty program members.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified the campaign record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was last updated.',
    `owner_email` STRING COMMENT 'Email address of the campaign owner for communication and escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Name of the marketing manager or business owner responsible for the campaign execution and performance.',
    `priority_level` STRING COMMENT 'Business priority level of the campaign for resource allocation and conflict resolution.. Valid values are `critical|high|medium|low`',
    `promo_campaign_status` STRING COMMENT 'Current lifecycle status of the promotional campaign.. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `source_system` STRING COMMENT 'Name of the operational system from which the campaign record originated (e.g., Oracle Retail Price Management, Salesforce Commerce Cloud).',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether campaign offers can be combined with other promotions or coupons.',
    `start_date` DATE COMMENT 'Date when the promotional campaign becomes active and offers are available to customers.',
    `target_customer_reach` STRING COMMENT 'Number of unique customers the campaign aims to reach or engage.',
    `target_revenue` DECIMAL(18,2) COMMENT 'Expected revenue target for the promotional campaign period.',
    `target_units_sold` STRING COMMENT 'Target number of units expected to be sold during the promotional campaign.',
    `terms_and_conditions` STRING COMMENT 'Legal terms, conditions, and exclusions governing the promotional campaign offers.',
    `vendor_funded_flag` BOOLEAN COMMENT 'Indicates whether the promotional campaign is partially or fully funded by vendor cooperative marketing agreements.',
    CONSTRAINT pk_promo_campaign PRIMARY KEY(`promo_campaign_id`)
) COMMENT 'Master record for a promotional campaign representing a time-bound marketing initiative encompassing both the strategic campaign wrapper and discrete promotional sales events (Flash Sales, Doorbuster Events, Holiday Sales). Captures campaign name, type, start/end dates, event classification, budget, and performance targets.';

CREATE OR REPLACE TABLE `retail_ecm`.`promotion`.`promo_offer` (
    `promo_offer_id` BIGINT COMMENT 'Unique identifier for the promotional offer. Primary key for this entity.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_item. Business justification: Promotional offers are created for items in the active assortment; buyers need to measure promotional lift per assortment item to evaluate assortment performance and sell-through. This offer-to-assor',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Brand-level promotional offers (e.g., Buy any Coca-Cola product, save 20%) are a core retail/CPG process. Brand promotional planning, vendor co-op reporting, and brand performance analytics all requ',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: Shipping promotional offers (free UPS Ground on orders over $35, upgraded to 2-day delivery) are configured against specific carrier services. Retail promotions teams must link shipping offers to ',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Offers target specific categories (e.g., 20% off Apparel). Merchandising needs category-level offer visibility for pricing decisions, margin analysis, and assortment adjustments. Essential for categor',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Retail finance allocates promotional offer spend to cost centers for budget-vs-actual reporting and P&L control. Finance teams require offer-level cost center attribution to track promotional expense ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: promo_offer.customer_segment_eligibility is a denormalized text field. A proper FK to customer.segment enables accurate offer eligibility enforcement at POS/e-commerce, segment-based offer performance',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Finance teams align promo offer activity to fiscal periods for period-close accruals and promotional spend reporting. Retail finance requires offer-level fiscal period attribution to ensure correct pe',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Different offer types (BOGO, percentage off, dollar off) may require different GL account treatments per accounting policy. Offer-level GL mapping enables proper expense classification for financial r',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Retail promotional offers are scoped at hierarchy/category level (e.g., all Beverages 20% off). Promotional eligibility planning and offer setup require a structured FK to item_hierarchy, not just a',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Promo offers are scoped to specific profit centers (department, channel) for promotional ROI and margin analysis reporting. Retail finance expects offer-level profit center attribution to measure prom',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: promo_offer.loyalty_exclusive_flag and customer_segment_eligibility require a proper FK to the loyalty program for POS eligibility enforcement and offer personalization. Loyalty-exclusive offers must ',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the parent promotional campaign under which this offer is organized.',
    `return_policy_id` BIGINT COMMENT 'Foreign key linking to returns.return_policy. Business justification: Final-sale and restricted-return promotional offers must reference the governing return_policy so POS and e-commerce systems enforce return restrictions at offer activation. Retail domain experts expe',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Seasonal offers (new season launch promotions, end-of-season clearance) require season context for merchandising coordination. Buyers need to see all offers planned for their seasons to coordinate inv',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Promotional offers target specific SKUs for discount application. Essential for offer eligibility validation, POS redemption logic, inventory planning for promoted items, and promotional ROI analysis ',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Offer eligibility enforcement per ecommerce storefront and storefront-specific offer activation require promo_offer to reference its primary target storefront. Retail digital merchandising teams confi',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor/supplier funding or co-funding this promotional offer. Null if retailer-funded.',
    `activation_trigger` STRING COMMENT 'Event or condition that activates this offer for a customer. manual = customer enters code; cart_threshold = automatically applied when cart meets criteria; login = activated upon customer login; geofence = triggered by location; time_based = activated at specific time; event_based = triggered by business event.. Valid values are `manual|cart_threshold|login|geofence|time_based|event_based`',
    `approval_status` STRING COMMENT 'Approval workflow status for this promotional offer. pending = awaiting approval; approved = authorized for execution; rejected = not approved.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the business user who approved this promotional offer. Null if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional offer was approved. Null if not yet approved.',
    `channel_eligibility` STRING COMMENT 'Sales channels where this offer is valid. POS = in-store Point of Sale; ecommerce = online web storefront; mobile = mobile app; BOPIS = Buy Online Pick Up In Store; ROPIS = Reserve Online Pick Up In Store; all_channels = valid across all channels. [ENUM-REF-CANDIDATE: POS|ecommerce|mobile|BOPIS|ROPIS|call_center|kiosk — promote to reference product]. Valid values are `POS|ecommerce|mobile|BOPIS|ROPIS|all_channels`',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of promotional discount cost borne by the vendor (0-100). Null if not applicable or fully retailer-funded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional offer record was first created in the system.',
    `digital_delivery_flag` BOOLEAN COMMENT 'Indicates whether this offer is delivered digitally (e.g., via email, mobile app push notification, personalized web banner). True = digital delivery; False = traditional circular/print or in-store signage only.',
    `discount_method` STRING COMMENT 'Method by which the discount is calculated and applied. Percentage = discount as a percentage of price; fixed_amount = flat dollar/currency discount; tiered = discount varies by purchase tier; quantity_based = discount based on quantity purchased.. Valid values are `percentage|fixed_amount|tiered|quantity_based`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount. Interpretation depends on discount_method: for percentage, this is the percentage (e.g., 15.00 for 15%); for fixed_amount, this is the currency amount (e.g., 5.00 for $5 off).',
    `display_message` STRING COMMENT 'Customer-facing promotional message displayed at Point of Sale (POS), e-commerce checkout, and mobile app. Concise marketing copy highlighting the offer value.',
    `effective_end_date` DATE COMMENT 'Date when this promotional offer expires and is no longer eligible for redemption. Null indicates an open-ended offer.',
    `effective_end_time` TIMESTAMP COMMENT 'Precise timestamp when this promotional offer expires, supporting time-of-day specific promotions. Null indicates no specific end time constraint.',
    `effective_start_date` DATE COMMENT 'Date when this promotional offer becomes active and eligible for redemption.',
    `effective_start_time` TIMESTAMP COMMENT 'Precise timestamp when this promotional offer becomes active, supporting time-of-day specific promotions (e.g., happy hour deals, flash sales).',
    `jurisdiction_restriction_flag` BOOLEAN COMMENT 'Indicates whether this offer has jurisdiction-specific restrictions (e.g., state-level promotional laws, EU consumer protection price display requirements). True = restrictions apply; False = no jurisdiction restrictions.',
    `maximum_redemption_per_customer` STRING COMMENT 'Maximum number of times a single customer can redeem this offer. Null indicates unlimited redemptions per customer.',
    `maximum_redemption_total` STRING COMMENT 'Maximum total number of redemptions allowed across all customers for this offer. Null indicates unlimited total redemptions.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum purchase amount (in currency) required to qualify for this promotional offer. Null if no minimum threshold applies.',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum quantity of eligible items required to qualify for this promotional offer. Null if no quantity threshold applies.',
    `modified_by` STRING COMMENT 'Name or identifier of the business user who last modified this promotional offer record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional offer record was last modified.',
    `offer_code` STRING COMMENT 'Externally-known unique alphanumeric code for the promotional offer, used for redemption at Point of Sale (POS), e-commerce checkout, and mobile applications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `offer_description` STRING COMMENT 'Detailed description of the promotional offer, including terms, conditions, and customer-facing messaging.',
    `offer_name` STRING COMMENT 'Human-readable name of the promotional offer for internal reference and customer-facing display.',
    `offer_priority` STRING COMMENT 'Priority ranking for offer application when multiple offers are eligible. Lower numbers indicate higher priority. Used by Point of Sale (POS) and e-commerce checkout engines to resolve offer conflicts.',
    `offer_status` STRING COMMENT 'Current lifecycle status of the promotional offer. draft = under development; scheduled = approved and awaiting activation; active = currently redeemable; paused = temporarily suspended; expired = past end date; cancelled = terminated before completion.. Valid values are `draft|scheduled|active|paused|expired|cancelled`',
    `offer_type` STRING COMMENT 'Classification of the promotional offer mechanics. BOGO = Buy One Get One; percent_off = percentage discount; dollar_off = fixed amount discount; free_gift = gift with purchase; bundle = bundled product deal; threshold_discount = discount upon reaching purchase threshold.. Valid values are `BOGO|percent_off|dollar_off|free_gift|bundle|threshold_discount`',
    `personalization_flag` BOOLEAN COMMENT 'Indicates whether this offer is personalized to individual customers based on purchase history, preferences, or predictive analytics. True = personalized; False = mass-market offer.',
    `product_eligibility_scope` STRING COMMENT 'Defines which products are eligible for this offer. all_products = applies to entire catalog; category = applies to specific product categories; SKU_list = applies to specific Stock Keeping Units (SKUs); brand = applies to specific brands; excluded_products = applies to all products except specified exclusions.. Valid values are `all_products|category|SKU_list|brand|excluded_products`',
    `restricted_jurisdictions` STRING COMMENT 'Comma-separated list of jurisdiction codes (ISO 3166-1 alpha-3 country codes or state/province codes) where this offer is restricted or prohibited due to regulatory compliance requirements. Null if no restrictions.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this offer can be combined (stacked) with other promotional offers in a single transaction. True = stackable; False = exclusive offer.',
    `store_eligibility_scope` STRING COMMENT 'Defines the scope of store eligibility for this offer. all_stores = valid at all retail locations; store_group = valid at a defined group of stores; individual_store = valid at specific stores only; excluded_stores = valid everywhere except specified stores.. Valid values are `all_stores|store_group|individual_store|excluded_stores`',
    `terms_and_conditions` STRING COMMENT 'Full legal terms and conditions text for this promotional offer, including disclaimers, exclusions, and fine print required for regulatory compliance.',
    `vendor_funded_flag` BOOLEAN COMMENT 'Indicates whether this promotional offer is funded (wholly or partially) by a vendor/supplier rather than the retailer. True = vendor-funded; False = retailer-funded.',
    `created_by` STRING COMMENT 'Name or identifier of the business user who created this promotional offer record.',
    CONSTRAINT pk_promo_offer PRIMARY KEY(`promo_offer_id`)
) COMMENT 'Defines a specific promotional offer within a campaign, representing the actual deal mechanics (BOGO, percent-off, dollar-off, free gift with purchase, bundle deal, threshold discount). Captures offer type, discount value, discount method (percentage vs. fixed), minimum purchase threshold, maximum redemption limit, stackability rules, offer priority, eligible SKUs/categories/product hierarchies (with inclusion/exclusion flags), channel eligibility (POS, e-commerce, mobile, BOPIS), store/store-group scope, digital delivery attributes (targeting segment, personalization, activation trigger) when applicable, effective date range, and jurisdictional compliance flags (e.g., state-level promotional restrictions, EU consumer protection price display requirements). This is the atomic unit of promotion logic executed at POS and e-commerce checkout engines. Encompasses SKU eligibility rules, channel assignments, store assignments, and digital offer mechanics as integral attributes. Supports international compliance by carrying jurisdiction-specific restriction flags that gate offer activation by market.';

CREATE OR REPLACE TABLE `retail_ecm`.`promotion`.`coupon` (
    `coupon_id` BIGINT COMMENT 'Unique identifier for the coupon instrument. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Manufacturer/brand-funded coupons (e.g., CPG brand coupons) are a core retail process. Brand-level coupon targeting, vendor co-op settlement, and brand coupon redemption reporting all require a direct',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Coupons are category-specific ("$5 off Grocery", "20% off Electronics"). Category managers track coupon redemption impact on sales velocity, margin, and inventory turn. Essential for category-level pr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Coupon issuance and redemption costs are charged to cost centers in retail finance for budget tracking and P&L reporting. Finance teams require cost center attribution to track coupon liability and re',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Retail marketers issue segment-targeted coupons (loyalty tier win-back, churn-risk, VIP coupons). A FK from coupon to customer.segment defines the eligible segment for coupon distribution and redempti',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Coupon discount expense is posted to a specific GL account (e.g., coupon redemption expense) in retail finance. GL-level tracking of coupon costs is required for P&L reporting, audit compliance, and f',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Coupons are frequently scoped to a product category/hierarchy node (e.g., any cereal product). Retail coupon programs targeting hierarchy levels require this FK for eligibility validation, redemptio',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Coupons frequently tier-gated (e.g., Platinum members: extra 20% off) - requires tier validation at redemption, supports VIP member retention strategies, and enables tier-specific promotional ROI an',
    `profile_id` BIGINT COMMENT 'Foreign key linking to customer.profile. Business justification: Personalized coupon issuance to a specific customer profile is a core retail marketing process (targeted win-back, birthday, loyalty coupons). Distinct from redemption tracking — this records which cu',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the parent promotional campaign under which this coupon was issued.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Coupons are instruments that implement specific promotional offers. While coupon already has promotion_campaign_id (linking to the campaign), it needs promo_offer_id to identify the exact offer the co',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Coupons restrict redemption to qualifying SKUs. POS systems validate coupon eligibility against product attributes (brand, category, vendor). Inventory planning uses this to forecast demand spikes. Ve',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturer funding the coupon, if applicable. Null for retailer-funded coupons.',
    `barcode` STRING COMMENT 'UPC or EAN barcode number for physical coupon scanning at POS. May be 12-digit UPC-A or 13-digit EAN format.. Valid values are `^[0-9]{12,14}$`',
    `coupon_code` STRING COMMENT 'Alphanumeric code that customers enter or scan to redeem the coupon. Unique business identifier for the coupon across all channels.. Valid values are `^[A-Z0-9]{6,20}$`',
    `coupon_status` STRING COMMENT 'Current lifecycle state of the coupon. active means available for redemption, inactive means not yet released, expired means past expiration_date, suspended means temporarily disabled, redeemed means fully used (for single-use coupons).. Valid values are `active|inactive|expired|suspended|redeemed`',
    `coupon_type` STRING COMMENT 'Classification of coupon by issuing authority and format. Manufacturer coupons are vendor-funded, store coupons are retailer-funded, digital coupons are app/email-based, paper coupons are physical print, loyalty coupons are tied to loyalty programs, vendor_funded are supplier co-op promotions.. Valid values are `manufacturer|store|digital|paper|loyalty|vendor_funded`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the coupon record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the face value (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `digital_distribution_quantity` STRING COMMENT 'Total number of digital coupon codes issued via email, app, or SMS. Null for paper-only coupons.',
    `digital_wallet_enabled_flag` BOOLEAN COMMENT 'Indicates whether this coupon can be stored in a digital wallet (mobile app, Apple Wallet, Google Pay) for redemption (True) or is paper-only (False).',
    `discount_type` STRING COMMENT 'Mechanism by which the coupon provides value. Percentage applies a percent off, fixed_amount deducts a dollar value, BOGO is buy-one-get-one, free_shipping waives delivery charges, tiered applies different discounts based on purchase thresholds.. Valid values are `percentage|fixed_amount|bogo|free_shipping|tiered`',
    `eligible_channel` STRING COMMENT 'Sales channels where the coupon can be redeemed. all_channels means omnichannel, pos is in-store only, ecommerce is online only, mobile_app is app-only, bopis is buy-online-pickup-in-store.. Valid values are `all_channels|pos|ecommerce|mobile_app|bopis`',
    `eligible_product_scope` STRING COMMENT 'Defines the breadth of products to which the coupon applies. all_products means store-wide, category restricts to a product category, brand restricts to a specific brand, sku restricts to specific SKUs, basket applies to entire cart total.. Valid values are `all_products|category|brand|sku|basket`',
    `exclusion_list` STRING COMMENT 'Comma-separated list of product SKUs, categories, or brands explicitly excluded from coupon eligibility. Null if no exclusions apply.',
    `expiration_date` DATE COMMENT 'Last date on which the coupon can be redeemed. After this date, the coupon is no longer valid.',
    `face_value` DECIMAL(18,2) COMMENT 'Nominal discount value of the coupon. For fixed_amount coupons, this is the dollar discount. For percentage coupons, this is the percentage (e.g., 15.00 for 15% off). For BOGO, may represent the value of the free item.',
    `geographic_restriction` STRING COMMENT 'Comma-separated list of geographic regions (states, provinces, countries) where the coupon is valid. Null if valid everywhere. Uses ISO 3166-1 alpha-3 country codes and ISO 3166-2 subdivision codes.',
    `issue_channel` STRING COMMENT 'Distribution channel through which the coupon was issued to customers. Circular refers to weekly print ads, mobile_app and email are digital channels, in_store_kiosk is physical print at store, website is online portal, social_media includes Facebook/Instagram ads, direct_mail is postal delivery, SMS is text message. [ENUM-REF-CANDIDATE: circular|mobile_app|email|in_store_kiosk|website|social_media|direct_mail|sms — 8 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'Date on which the coupon was first made available to customers. Marks the start of the coupons validity window.',
    `issuing_authority` STRING COMMENT 'Entity responsible for funding and issuing the coupon. Retailer indicates store-funded, manufacturer indicates vendor-funded, vendor indicates supplier co-op, third_party indicates external promotion partner.. Valid values are `retailer|manufacturer|vendor|third_party`',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified the coupon record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the coupon record was last updated.',
    `maximum_discount_amount` DECIMAL(18,2) COMMENT 'Cap on the total discount that can be applied by this coupon, regardless of cart value. Null if no cap applies. Relevant for percentage-based coupons.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum transaction subtotal required to qualify for coupon redemption. Null if no minimum applies.',
    `print_quantity` STRING COMMENT 'Total number of physical paper coupons printed for distribution. Null for digital-only coupons.',
    `redemption_limit_per_customer` STRING COMMENT 'Maximum number of times a single customer can redeem this coupon. Null or 0 indicates unlimited redemptions per customer.',
    `single_use_flag` BOOLEAN COMMENT 'Indicates whether the coupon can only be used once (True) or multiple times (False) by the same customer, subject to redemption_limit_per_customer.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this coupon can be combined with other coupons or promotions in a single transaction (True) or must be used alone (False).',
    `terms_and_conditions` STRING COMMENT 'Full legal text of coupon usage terms, restrictions, and disclaimers. Required for regulatory compliance and customer transparency.',
    `total_redemption_limit` STRING COMMENT 'Maximum total number of redemptions allowed across all customers for this coupon. Null or 0 indicates unlimited total redemptions.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created the coupon record.',
    CONSTRAINT pk_coupon PRIMARY KEY(`coupon_id`)
) COMMENT 'Master record for a coupon instrument issued as part of a promotional campaign. Captures coupon code, barcode/UPC, coupon type (manufacturer, store, digital, paper), face value, discount type, issue channel (circular, app, email, in-store kiosk), expiration date, single-use vs. multi-use flag, maximum redemption count, stackability with other offers, issuing authority (store vs. vendor-funded), and print/digital distribution quantity. Supports both digital wallet coupons and physical paper formats across POS and e-commerce channels. Coupon redemption events are recorded in promo_redemption (the SSOT for all redemption activity).';

CREATE OR REPLACE TABLE `retail_ecm`.`promotion`.`rebate` (
    `rebate_id` BIGINT COMMENT 'Unique identifier for the rebate program. Primary key.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_item. Business justification: Vendor rebates are negotiated per assortment item to drive inclusion and depth decisions during line reviews. Buyers track vendor rebate funding by assortment item to justify assortment choices — a co',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Brand-level manufacturer rebates (e.g., CPG brand funding rebates) are a standard retail vendor funding mechanism. Brand rebate accrual, settlement reporting, and vendor co-op accounting require a dir',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Rebates are category-level incentives (appliance rebates, electronics rebates). Category managers track rebate impact on sales lift, margin erosion, and competitive positioning. Essential for category',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rebate accruals and settlements are tracked to cost centers in retail finance for budget-vs-actual reporting. Finance teams require cost center attribution on rebates to allocate vendor funding correc',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: rebate.customer_segment_eligibility is a denormalized text field. A proper FK to customer.segment enables structured rebate eligibility enforcement, segment-based rebate redemption reporting, and auto',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Rebate accruals must align to financial periods for period-close processing and revenue recognition under ASC 606. Retail finance teams accrue vendor rebates by fiscal period and require this link for',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Rebate liabilities and expenses post to specific GL accounts for accrual accounting. Required for accurate balance sheet (rebate liability) and P&L (rebate expense) reporting per GAAP/IFRS.',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Vendor rebate agreements in retail are commonly structured at category/hierarchy level (e.g., rebate on all frozen food purchases). Rebate accrual reporting, vendor settlement, and category-level re',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Rebate accruals are attributed to profit centers for vendor rebate P&L reporting and margin analysis. Retail finance requires profit center attribution on rebates to measure net margin impact of vendo',
    `promo_campaign_id` BIGINT COMMENT 'Identifier of the parent promotional campaign or event to which this rebate belongs. Null if rebate is standalone.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: A rebate is a specific promotional mechanic that implements a promotional offer within a campaign. While rebate already links to promo_campaign, linking it directly to the specific promo_offer it impl',
    `return_policy_id` BIGINT COMMENT 'Foreign key linking to returns.return_policy. Business justification: Rebate programs require a linked return_policy to enforce rebate clawback rules when qualifying items are returned. Retail finance and compliance teams depend on this link to void or recover rebate pa',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Seasonal rebates (spring lawn equipment, holiday electronics) require season alignment for merchandising planning. Buyers coordinate rebate timing with seasonal inventory builds and markdown strategie',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Rebates apply to specific qualifying products. Claim validation verifies purchased SKU matches rebate terms. Vendor chargeback reconciliation requires SKU-level tracking. Inventory planning adjusts fo',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: Vendor rebate terms (percentage, qualifying products, payment schedule) are negotiated within vendor contracts in retail. Merchandising and AP teams reconcile rebate payments against contract terms fo',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor sponsoring or funding the rebate program. Null for retailer-funded rebates.',
    `amount` DECIMAL(18,2) COMMENT 'Fixed monetary value of the rebate in the transaction currency. Null if rebate is percentage-based.',
    `approval_status` STRING COMMENT 'Workflow approval state for the rebate program before it can be activated. Ensures financial and legal review compliance.. Valid values are `pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the rebate program was approved. Null if not yet approved.',
    `channel_eligibility` STRING COMMENT 'Sales channels where the rebate can be redeemed: all_channels (any touchpoint), pos_only (in-store Point of Sale only), ecommerce_only (online purchases), mobile_app_only (mobile app transactions), or omnichannel (integrated cross-channel).. Valid values are `all_channels|pos_only|ecommerce_only|mobile_app_only|omnichannel`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the rebate program record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rebate amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the rebate program expires and is no longer available for new submissions. Null for open-ended programs.',
    `effective_start_date` DATE COMMENT 'Date when the rebate program becomes active and eligible for customer redemption.',
    `exclusion_product_list` STRING COMMENT 'Comma-separated list of Stock Keeping Unit (SKU) codes or product categories explicitly excluded from the rebate program.',
    `geographic_eligibility` STRING COMMENT 'Comma-separated list of three-letter ISO country codes or region codes where the rebate is valid (e.g., USA, CAN, GBR). Null if available in all operating regions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the rebate program record was last updated.',
    `marketing_message` STRING COMMENT 'Customer-facing promotional message displayed in circulars, digital ads, and at Point of Sale to communicate the rebate offer.',
    `maximum_rebate_amount` DECIMAL(18,2) COMMENT 'Cap on the total rebate value that can be claimed per transaction or per customer. Null if no cap applies.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum transaction value required to qualify for the rebate. Null if no minimum threshold applies.',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum number of qualifying units (Stock Keeping Units) that must be purchased to qualify for the rebate. Null if no quantity threshold applies.',
    `payment_method` STRING COMMENT 'Mechanism by which the rebate value is returned to the customer: check (mailed physical check), store_credit (loyalty account credit), digital_credit (e-wallet or app credit), prepaid_card (branded debit card), bank_transfer (direct deposit), or instant_discount (applied at Point of Sale).. Valid values are `check|store_credit|digital_credit|prepaid_card|bank_transfer|instant_discount`',
    `payment_processing_days` STRING COMMENT 'Expected number of business days from rebate approval to payment issuance. Used for customer Service Level Agreement (SLA) communication.',
    `percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied as rebate (e.g., 10.00 for 10% off). Null if rebate is fixed-amount.',
    `qualifying_product_list` STRING COMMENT 'Comma-separated list of Stock Keeping Unit (SKU) codes, Universal Product Code (UPC) numbers, or product category codes that qualify for the rebate. Null if rebate applies to all products.',
    `rebate_description` STRING COMMENT 'Detailed internal description of the rebate program purpose, target audience, and business objectives. Used for internal planning and reporting.',
    `rebate_name` STRING COMMENT 'Marketing name of the rebate program displayed to customers and used in promotional materials.',
    `rebate_number` STRING COMMENT 'Externally-visible unique business identifier for the rebate program, used in customer communications and vendor agreements.. Valid values are `^RBT-[A-Z0-9]{8,12}$`',
    `rebate_status` STRING COMMENT 'Current lifecycle state of the rebate program: draft (being configured), active (live and accepting submissions), paused (temporarily suspended), expired (past end date), cancelled (terminated early), or completed (ended successfully).. Valid values are `draft|active|paused|expired|cancelled|completed`',
    `rebate_type` STRING COMMENT 'Classification of the rebate mechanism: instant rebate (applied at Point of Sale), mail-in rebate (customer submits proof of purchase), vendor-funded rebate (supplier-sponsored), digital rebate (online redemption), promotional allowance (trade promotion), or volume rebate (quantity-based incentive).. Valid values are `instant_rebate|mail_in_rebate|vendor_funded_rebate|digital_rebate|promotional_allowance|volume_rebate`',
    `redemption_limit_per_customer` STRING COMMENT 'Maximum number of times a single customer can claim this rebate during the program period. Null if no limit applies.',
    `redemption_limit_per_transaction` STRING COMMENT 'Maximum number of rebate instances that can be applied in a single transaction. Null if no limit applies.',
    `requires_proof_of_purchase` BOOLEAN COMMENT 'Indicates whether customers must submit receipt or purchase documentation to claim the rebate. True for mail-in rebates, false for instant rebates applied at Point of Sale.',
    `stackable_with_other_promotions` BOOLEAN COMMENT 'Indicates whether this rebate can be combined with other promotional offers (coupons, markdowns, Buy One Get One (BOGO) deals) in the same transaction.',
    `submission_deadline_date` DATE COMMENT 'Final date by which customers must submit rebate claims for purchases made during the effective period. Typically extends beyond the effective end date for mail-in rebates.',
    `terms_and_conditions` STRING COMMENT 'Full legal text of the rebate program terms, conditions, restrictions, and disclaimers. Must comply with Federal Trade Commission (FTC) disclosure requirements.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total financial budget allocated for the rebate program. Used for cost control and Return on Investment (ROI) tracking. Null if budget is uncapped.',
    `vendor_funding_percentage` DECIMAL(18,2) COMMENT 'Percentage of the rebate cost funded by the vendor in co-op promotional agreements (e.g., 75.00 means vendor pays 75%, retailer pays 25%). Null for fully retailer-funded rebates.',
    CONSTRAINT pk_rebate PRIMARY KEY(`rebate_id`)
) COMMENT 'Master record for a rebate program offered to customers or funded by vendors. Captures rebate name, rebate type (instant rebate, mail-in rebate, vendor-funded rebate), rebate amount or percentage, qualifying purchase conditions, submission deadline, payment method (check, store credit, digital credit), sponsoring vendor, and rebate program status. Supports both consumer-facing rebates and vendor-funded promotional allowances.';

CREATE OR REPLACE TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` (
    `vendor_promo_agreement_id` BIGINT COMMENT 'Unique identifier for the vendor-funded promotional agreement record. Primary key.',
    `assortment_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_plan. Business justification: Vendor promotional agreements are negotiated during assortment planning to secure placement and depth commitments. Linking vendor_promo_agreement to assortment_plan enables vendor funding analysis by ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Vendor promo agreements are frequently brand-specific (CPG manufacturer funds promotions for their brand). Brand-level vendor funding agreements, co-op accrual by brand, and brand performance reportin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor promotional funding agreements are tracked against cost centers for budget allocation and chargeback processing. Retail finance requires cost center attribution on vendor agreements to control ',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Vendor promo agreements span fiscal periods; finance teams align accruals and settlements to financial periods for period-close processing. Retail finance requires fiscal period attribution for vendor',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Vendor funding accruals post to specific GL accounts (co-op advertising receivable, vendor allowance). Required for proper accounting of vendor-funded promotions and chargeback processing per retail a',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Vendor promotional agreements in retail are scoped to product categories/hierarchies (e.g., vendor funds 10% on all Snacks promotions). Vendor funding accrual, category-level agreement tracking, and',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Vendor promo agreement accruals generate journal entries in retail finance. Direct link from agreement to journal entry enables audit traceability of vendor funding accruals and supports financial clo',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Vendor promo agreements are attributed to profit centers for vendor funding P&L reporting and margin analysis. Retail finance teams report vendor funding income by profit center to measure net promoti',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Vendor promotional agreements (co-op advertising, promotional allowances) fund specific promotional campaigns. The vendor_promo_agreement table currently only links to vendor but needs promo_campaign_',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: A vendor-funded promotional agreement funds specific promotional offer mechanics (e.g., a BOGO or discount offer) within a campaign. While vendor_promo_agreement already links to promo_campaign, the a',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: Retail promotional funding agreements are authorized under and governed by master vendor contracts. Finance and compliance teams must trace vendor_promo_agreement back to the vendor_contract for settl',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier providing promotional funding for this agreement.',
    `accrual_method` STRING COMMENT 'Method used to calculate promotional funding accrual. Purchase-based: accrues on retailer purchase volume. Sales-based: accrues on consumer sales (scan data). Display-based: accrues on compliance with display requirements. Hybrid: combination of methods.. Valid values are `purchase-based|sales-based|display-based|hybrid`',
    `ad_placement_required` BOOLEAN COMMENT 'Indicates whether the retailer must feature the product in circular ads, digital promotions, or other marketing materials to qualify for co-op advertising funding.',
    `agreement_name` STRING COMMENT 'Human-readable descriptive name for the promotional agreement, typically including campaign theme or product category.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the promotional agreement, used in vendor communications and settlement documents.',
    `agreement_type` STRING COMMENT 'Classification of the vendor promotional funding mechanism. Co-op advertising: shared advertising cost. Off-invoice allowance: upfront discount on purchase invoice. Bill-back: post-event reimbursement. Scan allowance: per-unit sold rebate. New item allowance: slotting fee for new SKU introduction. Volume rebate: tiered discount based on purchase volume.. Valid values are `co-op advertising|off-invoice allowance|bill-back|scan allowance|new item allowance|volume rebate`',
    `approval_date` DATE COMMENT 'Date when the promotional agreement was internally approved and authorized for execution.',
    `chargeback_eligible` BOOLEAN COMMENT 'Indicates whether the retailer can issue chargebacks to the vendor for non-compliance with agreement terms (e.g., late delivery, incorrect pricing, missing promotional materials).',
    `chargeback_penalty_amount` DECIMAL(18,2) COMMENT 'Fixed monetary penalty amount per chargeback incident for vendor non-compliance, in the agreement currency. Nullable if chargeback is not eligible or penalty is variable.',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the signed legal contract or agreement document stored in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional agreement record was first created in the system.',
    `display_compliance_required` BOOLEAN COMMENT 'Indicates whether the retailer must meet specific in-store display requirements (endcap placement, planogram compliance, shelf positioning) to qualify for funding.',
    `effective_end_date` DATE COMMENT 'Date when the promotional agreement expires and funding accrual ceases. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the promotional agreement becomes active and funding accrual begins.',
    `funding_amount` DECIMAL(18,2) COMMENT 'Total monetary value of vendor promotional funding committed under this agreement, in the agreement currency.',
    `funding_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the funding amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `funding_percentage` DECIMAL(18,2) COMMENT 'Percentage of qualifying costs or sales that the vendor will fund, expressed as a decimal (e.g., 15.00 for 15%). Used for co-op advertising and scan-based allowances.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional agreement record was most recently updated.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum monetary value of purchases required to qualify for the promotional funding, in the agreement currency. Nullable if no minimum applies.',
    `minimum_purchase_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity of product that must be purchased to qualify for the promotional funding. Nullable if no minimum applies.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or internal notes related to the promotional agreement.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Difference between total accrued amount and total settled amount, representing funding owed by the vendor but not yet paid, in the agreement currency.',
    `performance_obligation_description` STRING COMMENT 'Detailed narrative of the retailers obligations under this agreement, including display requirements, advertising commitments, volume targets, and reporting duties.',
    `qualifying_product_scope` STRING COMMENT 'Defines which products are eligible for promotional funding under this agreement. Specific SKU: single item. Product category: all items in a category. Brand: all items of a vendor brand. Private label: retailer-branded items.. Valid values are `all products|specific SKU|product category|brand|private label`',
    `settlement_frequency` STRING COMMENT 'Frequency at which funding settlements or accruals are processed under this agreement.. Valid values are `one-time|weekly|monthly|quarterly|annually|event-based`',
    `settlement_terms` STRING COMMENT 'Defines how and when the vendor funding will be paid or credited. Upfront credit: applied at purchase. Monthly accrual: credited monthly. Quarterly settlement: paid quarterly. Post-event claim: retailer submits claim after promotion ends. Scan-based settlement: paid based on POS scan data.. Valid values are `upfront credit|monthly accrual|quarterly settlement|post-event claim|scan-based settlement`',
    `termination_date` DATE COMMENT 'Date when the agreement was terminated early, if applicable. Nullable for agreements that completed normally or are still active.',
    `termination_reason` STRING COMMENT 'Explanation for early termination of the agreement, such as vendor non-compliance, retailer strategic change, or mutual agreement. Nullable if not terminated.',
    `total_accrued_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of promotional funding accrued to date under this agreement, in the agreement currency. Updated as qualifying events occur.',
    `total_settled_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of promotional funding that has been paid or credited to the retailer to date, in the agreement currency.',
    `vendor_promo_agreement_status` STRING COMMENT 'Current lifecycle state of the promotional agreement. Draft: under negotiation. Pending approval: awaiting internal sign-off. Active: in effect and accruing. Suspended: temporarily paused. Completed: ended normally. Terminated: ended early. Settled: financially reconciled. [ENUM-REF-CANDIDATE: draft|pending approval|active|suspended|completed|terminated|settled — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_vendor_promo_agreement PRIMARY KEY(`vendor_promo_agreement_id`)
) COMMENT 'Master record for a vendor-funded promotional agreement (co-op advertising, promotional allowance, scan-based trading deal). Captures vendor identifier, agreement type (co-op ad, off-invoice allowance, bill-back, scan allowance, new item allowance), agreed funding amount, funding percentage, qualifying conditions (minimum volume, display compliance, ad placement), performance obligations, agreement start/end dates, settlement terms, and agreement status. Distinct from the supplier contract in the supplier domain — this is specifically the promotional funding arrangement that drives vendor chargeback and deduction management. Supports accounts receivable accrual and vendor compliance auditing.';

CREATE OR REPLACE TABLE `retail_ecm`.`promotion`.`promo_redemption` (
    `promo_redemption_id` BIGINT COMMENT 'Unique identifier for each promotional offer redemption instance. Primary key for the promo_redemption product.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: B2B retail requires account-level promotional redemption tracking for billing, credit management, and account-level promotional performance reporting. promo_redemption already has profile_id; account_',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Vendor-funded promo redemptions and chargebacks generate AP invoices for settlement. Linking promo_redemption to ap_invoice enables reconciliation of redemption activity against vendor settlement invo',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Redemption analysis by category is essential for merchandising to assess promotional effectiveness, cannibalization, and incremental sales. Category managers use redemption data to adjust future assor',
    `checkout_id` BIGINT COMMENT 'Foreign key linking to ecommerce.checkout. Business justification: Full ecommerce funnel traceability — linking a promotion redemption back to the specific checkout session — is required for checkout abandonment analysis with active promotions and for auditing discou',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Promo redemption costs are allocated to cost centers for budget-vs-actual tracking in retail finance. Finance teams require cost center attribution on redemptions to report promotional discount expens',
    `coupon_id` BIGINT COMMENT 'Foreign key linking to promotion.coupon. Business justification: When a redemption is triggered by a coupon, promo_redemption needs a structured FK to the coupon master record. Currently has coupon_code as STRING, which should be replaced with coupon_id FK. This en',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Department-level redemption reporting is a standard retail analytics requirement — department managers track promotional redemption rates for P&L attribution, shrinkage correlation, and labor planning',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Promo redemptions must be aligned to financial periods for period-close accrual and promotional spend reporting. Retail finance requires fiscal period attribution on redemptions to ensure correct peri',
    `fulfillment_line_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_line. Business justification: Retail vendor chargeback reconciliation and SKU-level promo performance reporting require line-level promo attribution. Promotions (BOGO, item discounts) apply to specific fulfillment lines, not just ',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Retail operations measure promotional effectiveness by fulfillment method (BOPIS vs ship-from-store vs DC fulfillment). Links redemptions to fulfillment execution for channel-specific lift analysis, v',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Promotion redemptions in e-commerce/omnichannel orders need order-level context for multi-line promotion analysis, customer journey tracking, and cross-channel promotional effectiveness measurement. D',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: High-value or manual redemptions may require direct journal entries for accounting adjustments (e.g., promotional allowance corrections, fraud writeoffs). Links promotional activity to financial posti',
    `location_id` BIGINT COMMENT 'Reference to the physical store location where the redemption occurred. Populated for POS and BOPIS transactions. Null for pure e-commerce fulfillment.',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: Redemptions must track which loyalty member redeemed the promotion to accrue points, update tier qualification metrics, and reconcile promotional liability with loyalty liability - core operational re',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal or register where the redemption was processed. Used for audit trail and fraud detection. Null for e-commerce transactions.',
    `pos_transaction_id` BIGINT COMMENT 'Reference to the customer transaction (POS or e-commerce order) where this promotion was applied. Links to the sales transaction header.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who redeemed the promotion. May be null for anonymous transactions where no customer identification was captured.',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the promotional offer that was redeemed. Links to the promotion master data defining the offer terms, discount rules, and eligibility criteria.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Promotional redemptions capture the application of a specific promotional offer to a transaction. While promo_redemption already has promo_campaign_id, it needs promo_offer_id to identify the exact of',
    `rebate_id` BIGINT COMMENT 'Foreign key linking to promotion.rebate. Business justification: Redemptions can be for rebate offers specifically. A customer may redeem a rebate offer at transaction time (e.g., instant rebate applied at POS), and tracking which rebate was redeemed is essential f',
    `rma_id` BIGINT COMMENT 'Foreign key linking to returns.rma. Business justification: Returns of promotional purchases require tracking original promotion for accurate refund calculation, vendor chargeback allocation, and fraud detection. Critical for partial refund logic when promotio',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Storefront-level redemption reporting and ecommerce channel offer performance analysis require each online promo_redemption to reference the storefront where it occurred. Retail digital teams track re',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier funding the promotion. Populated only when vendor_funded_flag is true. Used for chargeback processing and vendor settlement.',
    `vendor_promo_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.vendor_promo_agreement. Business justification: promo_redemption already has vendor_funded_flag, chargeback_amount, and chargeback_status attributes, indicating that vendor-funded redemptions require chargeback processing against a specific vendor ',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'The amount claimed from or paid by the vendor for this promotion redemption. May differ from discount_amount due to negotiated funding rates or caps.',
    `chargeback_status` STRING COMMENT 'Status of the vendor chargeback claim for vendor-funded promotions. Tracks the lifecycle from pending submission through payment receipt.. Valid values are `pending|submitted|approved|rejected|paid`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this redemption record was first created in the database. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount amount. Supports multi-currency operations across international markets.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary value of the discount granted to the customer through this promotion redemption. Expressed in the transaction currency. Critical for promotional ROI calculation and vendor chargeback reconciliation.',
    `discount_type` STRING COMMENT 'The category of discount applied. Distinguishes between percentage-based discounts, fixed dollar amounts, buy-one-get-one offers, bundle deals, spend threshold promotions, and shipping incentives.. Valid values are `percentage_off|fixed_amount_off|bogo|bundle_discount|threshold_discount|free_shipping`',
    `final_price` DECIMAL(18,2) COMMENT 'The post-discount price after this promotion was applied. May differ from transaction final price if multiple promotions were stacked.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score assigned by fraud detection algorithms to assess the likelihood of fraudulent coupon use or promotion abuse. Higher scores indicate higher risk. Scale 0-100.',
    `loyalty_points_earned` STRING COMMENT 'The number of loyalty program points awarded to the customer as part of this promotion redemption. Null if the promotion does not include a points component.',
    `loyalty_points_redeemed` STRING COMMENT 'The number of loyalty program points the customer spent to activate or qualify for this promotion. Null if no points were used.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this redemption record was last updated. Tracks changes to status, chargeback processing, or validation outcomes.',
    `original_price` DECIMAL(18,2) COMMENT 'The pre-discount price of the item or basket to which the promotion was applied. Used to calculate discount percentage and promotional lift.',
    `processing_system` STRING COMMENT 'The system or platform that processed and validated the promotion redemption. Identifies the source system for audit and reconciliation purposes.. Valid values are `pos|ecommerce_engine|oms|loyalty_platform|promotion_engine`',
    `promotion_tier` STRING COMMENT 'The tier or level of the promotion when tiered discount structures are used (e.g., spend $50 get 10% off, spend $100 get 20% off). Indicates which threshold was achieved.',
    `quantity_redeemed` STRING COMMENT 'The number of units or items to which the promotion was applied. For BOGO offers, represents the number of qualifying item sets. For single-item discounts, typically 1.',
    `redemption_channel` STRING COMMENT 'The sales channel through which the promotion was redeemed. Distinguishes between in-store POS, e-commerce platforms, mobile apps, and other customer touchpoints.. Valid values are `pos|ecommerce_web|ecommerce_mobile|call_center|kiosk|mobile_app`',
    `redemption_limit_type` STRING COMMENT 'The scope of redemption limits enforced for this promotion. Indicates whether limits apply per customer, per transaction, per day, or across the entire campaign period.. Valid values are `per_customer|per_transaction|per_day|per_campaign|unlimited`',
    `redemption_mechanism` STRING COMMENT 'Method by which the promotion was applied to the transaction. Indicates whether the discount was automatically triggered by system rules, manually entered via coupon code, applied through loyalty program, or activated through other channels. [ENUM-REF-CANDIDATE: automatic_system_triggered|coupon_code_entry|loyalty_auto_apply|cart_rule|manual_cashier_apply|mobile_app_clip|digital_wallet — 7 candidates stripped; promote to reference product]',
    `redemption_sequence_number` STRING COMMENT 'The sequential count of this redemption within the applicable limit scope. For example, if limit is per_customer, this tracks which redemption number this is for that customer (1st, 2nd, 3rd, etc.).',
    `redemption_status` STRING COMMENT 'Validation status of the promotion redemption. Indicates whether the redemption was successfully processed or rejected due to expiration, duplicate use, limit violations, or fraud detection.. Valid values are `valid|invalid|duplicate|expired|limit_exceeded|fraud_suspected`',
    `redemption_timestamp` TIMESTAMP COMMENT 'The precise date and time when the promotion was applied to the transaction. Represents the business event time of redemption, distinct from record creation time.',
    `sku` STRING COMMENT 'The specific product SKU to which the promotion was applied. Populated for item-level promotions. Null for transaction-level or basket-level promotions.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this redemption record in the source operational system. Enables traceability back to the system of record.',
    `source_system` STRING COMMENT 'The originating operational system that created this redemption record. Used for data lineage and cross-system reconciliation.',
    `stack_sequence` STRING COMMENT 'The order in which this promotion was applied within a stacked promotion scenario. Determines calculation precedence when multiple discounts are layered.',
    `validation_error_code` STRING COMMENT 'System error code returned when a redemption attempt fails validation. Provides technical detail for troubleshooting invalid redemptions. Null for successful redemptions.',
    `validation_error_message` STRING COMMENT 'Human-readable error message explaining why a redemption was rejected. Displayed to customers or cashiers. Null for successful redemptions.',
    `vendor_funded_flag` BOOLEAN COMMENT 'Indicates whether this promotion discount is funded by a vendor/supplier through a trade promotion agreement. True when the cost is charged back to the vendor; false when retailer-funded.',
    CONSTRAINT pk_promo_redemption PRIMARY KEY(`promo_redemption_id`)
) COMMENT 'Transactional record capturing each instance of a promotional offer being applied to a customer transaction at POS or e-commerce checkout. Records offer applied, redemption mechanism (automatic system-triggered, coupon code entry, loyalty auto-apply, cart rule), coupon reference (when coupon-based), transaction reference, store or channel, customer identifier, discount amount granted, redemption timestamp, redemption status (valid, invalid, duplicate, expired), and processing system. Serves as the single source of truth for all promotion redemption activity — including coupon redemptions, automatic BOGO applications, threshold discounts, and bundle deals. Critical for promotional ROI calculation, coupon fraud prevention, vendor chargeback evidence, and real-time redemption limit enforcement.';

CREATE OR REPLACE TABLE `retail_ecm`.`promotion`.`promo_budget` (
    `promo_budget_id` BIGINT COMMENT 'Unique identifier for the promotional budget record. Primary key for the promotional budget master data.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Retail finance teams reconcile promotional budgets against the master finance budget for the same cost center/profit center/period. This link enables integrated budget-vs-actual reporting and ensures ',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Promotional budgets are allocated by category. Category managers need visibility to total promotional investment to balance promotional spending with margin targets and competitive positioning. Essent',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Promotion budgets are allocated to finance cost centers for accounting and budget tracking. The cost_center_code column becomes redundant as it can be joined from finance.cost_center. This links promo',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Promo budgets are planned by fiscal period; linking to financial_period enables budget-to-actual reporting aligned to the retail fiscal calendar. Finance teams require this for period-close promotiona',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: promo_budget has denormalized gl_account_code but no FK to finance.gl_account. Retail finance requires promo budgets linked to GL accounts for budget-to-actual variance reporting and financial stateme',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Promotional budgets in retail are allocated by product category/hierarchy (e.g., Beverages promotional budget). Category-level budget planning, OTB integration, and promotional spend reporting by hier',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Retail finance requires promo budgets posted against a specific ledger (leading vs. local GAAP) for multi-ledger reporting. Ledger attribution on promo_budget ensures correct financial statement prese',
    `merch_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.merch_plan. Business justification: Promotional budgets are coordinated with merchandise plans. Total category investment includes both promotional spend and OTB. Buyers need integrated view of promotional and inventory investment to ma',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: promo_budget has denormalized profit_center_code but no FK to finance.profit_center. Retail finance links promo budgets to profit centers for channel/department-level promotional spend reporting. Remo',
    `promo_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_calendar. Business justification: Promotional budgets are planned and allocated against promotional calendar periods (fiscal year, fiscal quarter, seasonal events). The promo_budget table has fiscal_year and fiscal_period as standalon',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Promotional budgets are allocated to specific promotional campaigns. The promo_budget table tracks budget_owner_type and budget_owner_id as generic strings, but needs a structured FK to promo_campaign',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: Storefront-level promotional budget tracking and ecommerce spend reporting require promo_budget to reference the specific storefront. Retail finance teams allocate and monitor promotional spend by sto',
    `vendor_promo_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.vendor_promo_agreement. Business justification: promo_budget has a vendor_funded_amount attribute that tracks the portion of the promotional budget funded by a vendor. Linking promo_budget directly to vendor_promo_agreement enables direct reconcili',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Cumulative actual spend to date against this promotional budget, including all posted promotional costs, markdowns, vendor co-op claims, and advertising expenses. Updated in real-time as promotional transactions are processed.',
    `approval_date` DATE COMMENT 'Date when this promotional budget was formally approved by authorized management. Marks the transition from pending to approved status.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the promotional budget. Not submitted indicates budget has not been submitted for approval; pending review indicates awaiting management approval; approved indicates budget has been authorized; rejected indicates budget was not approved; revision required indicates budget must be modified and resubmitted.. Valid values are `not_submitted|pending_review|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Identifier or name of the manager or executive who approved this promotional budget. Typically a user ID or employee identifier from the HR system.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP, CAD). All budget amounts and spend tracking for this budget are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `budget_owner_type` STRING COMMENT 'Classification of the organizational unit responsible for managing and executing this promotional budget. Department indicates merchandising department ownership; category indicates product category team ownership; brand indicates brand management team ownership; channel indicates channel-specific ownership (e-commerce, stores); region indicates geographic region ownership; store cluster indicates store group ownership.. Valid values are `department|category|brand|channel|region|store_cluster`',
    `budget_status` STRING COMMENT 'Current lifecycle status of the promotional budget. Draft indicates initial planning stage; pending approval indicates submitted for management review; approved indicates authorized but not yet active; active indicates currently in use for promotional spend; suspended indicates temporarily paused; closed indicates completed and finalized; cancelled indicates terminated before completion. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the promotional budget source and purpose. Internal marketing budgets are company-funded campaigns; vendor co-op budgets are supplier-funded promotional agreements; markdown allowance budgets cover planned price reductions; clearance reserve budgets are set aside for end-of-season inventory liquidation; trade promotion budgets support B2B channel incentives; digital advertising budgets fund online and mobile promotional campaigns.. Valid values are `internal_marketing|vendor_coop|markdown_allowance|clearance_reserve|trade_promotion|digital_advertising`',
    `circular_ad_allocation` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated specifically for circular advertising and weekly ad production, including print circulars, digital circulars, and featured promotional items in weekly ad campaigns.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Amount committed but not yet spent, representing approved promotional activities that have been scheduled or contracted but not yet executed (e.g., scheduled markdowns, booked advertising placements, approved vendor co-op agreements).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional budget record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `effective_end_date` DATE COMMENT 'Date when this promotional budget expires and is no longer available for new promotional spend allocation. Any uncommitted budget remaining after this date typically rolls back to the general promotional fund or is reallocated.',
    `effective_start_date` DATE COMMENT 'Date when this promotional budget becomes active and available for promotional spend allocation. Promotional activities can begin drawing from this budget on or after this date.',
    `fiscal_period` STRING COMMENT 'Fiscal period within the fiscal year for which this budget is allocated. Format: Q1-Q4 for quarters, M01-M12 for months, H1-H2 for half-years, FY for full fiscal year. Supports period-based budget planning and performance tracking.. Valid values are `^(Q[1-4]|M(0[1-9]|1[0-2])|H[1-2]|FY)$`',
    `fiscal_year` STRING COMMENT 'Fiscal year for which this promotional budget is allocated, typically a four-digit year (e.g., 2024). Aligns with the companys financial planning and reporting calendar.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional budget record was last updated. Audit field for change tracking and data quality monitoring.',
    `mobile_channel_allocation` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated specifically for mobile app promotional activities, including app-exclusive offers, push notification campaigns, and mobile wallet coupons. Supports omnichannel budget planning and mobile channel ROI tracking.',
    `notes` STRING COMMENT 'Free-text notes and comments about the promotional budget, including planning assumptions, special conditions, vendor agreement details, or budget reallocation history. Supports collaborative budget management and audit trail documentation.',
    `otb_integration_flag` BOOLEAN COMMENT 'Boolean indicator of whether this promotional budget is integrated with the Open to Buy (OTB) merchandise planning system. When true, promotional markdowns and clearance budgets are factored into inventory purchasing decisions and margin planning.',
    `planned_spend_amount` DECIMAL(18,2) COMMENT 'Total planned or forecasted spend amount for the promotional budget based on campaign planning and historical performance. May be less than or equal to total budget amount, representing the expected utilization.',
    `pos_channel_allocation` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated specifically for in-store point-of-sale promotional activities, including store markdowns, in-store coupons, and physical promotional displays. Supports omnichannel budget planning and channel-specific ROI tracking.',
    `remaining_budget_amount` DECIMAL(18,2) COMMENT 'Available budget remaining for new promotional activities, calculated as total budget amount minus actual spend amount minus committed amount. Represents the unallocated budget available for additional promotional planning.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget amount for the promotional plan in the budget currency. Represents the maximum authorized spend for this promotional budget across all channels and activities.',
    `variance_threshold_amount` DECIMAL(18,2) COMMENT 'Absolute amount threshold for budget variance alerts. When actual spend deviates from planned spend by more than this amount, automated alerts are triggered to budget owners and finance teams. Used in conjunction with or as an alternative to percentage-based thresholds.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'Percentage threshold for budget variance alerts. When actual spend deviates from planned spend by more than this percentage, automated alerts are triggered to budget owners and finance teams. Typical values range from 5% to 20%.',
    `vendor_funded_amount` DECIMAL(18,2) COMMENT 'Portion of the total budget that is funded by vendor co-op agreements, trade promotion allowances, or supplier marketing development funds. Represents external funding contribution to the promotional budget.',
    CONSTRAINT pk_promo_budget PRIMARY KEY(`promo_budget_id`)
) COMMENT 'Master record for the promotional budget allocated to a campaign, promotional event, or category-level promotional plan. Captures total budget amount, budget type (internal marketing, vendor co-op, markdown allowance, clearance reserve), budget owner (department, category, or brand team), planned spend by channel, actual spend to date, committed but unspent amount, remaining budget, budget approval status, fiscal period, and variance threshold for alerts. Supports OTB (Open to Buy) integration, promotional P&L management, and real-time budget consumption monitoring. Distinct from finance domain general ledger — this is the operational promotional spend plan that feeds GL accruals.';

CREATE OR REPLACE TABLE `retail_ecm`.`promotion`.`promo_calendar` (
    `promo_calendar_id` BIGINT COMMENT 'Unique identifier for the promotional calendar period. Primary key for the promotional calendar master record.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Promo calendar periods must align to fiscal periods for promotional planning and budget allocation. promo_calendar has denormalized fiscal_year/month/quarter/week attributes. Linking to financial_peri',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Promotional calendars in retail are planned by product category/hierarchy (e.g., Frozen Foods promotional week). Category-level promotional calendar planning, inventory build scheduling, and merchan',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Promotional calendar periods align with merchandising seasons. Planning requires synchronized timing for new season launches, mid-season promotions, and end-of-season clearance. Critical for coordinat',
    `applicable_banner_codes` STRING COMMENT 'Comma-separated list of banner codes to which this promotional period applies. Populated only when banner_applicability is banner_specific.',
    `applicable_market_codes` STRING COMMENT 'Comma-separated list of market or region codes to which this promotional period applies. Populated when market_applicability is regional or local.',
    `approval_date` DATE COMMENT 'The date when this promotional calendar period was formally approved by management. Null if still pending approval.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether executive or senior management approval is required for promotions during this period (true) or standard approval workflows apply (false).',
    `approved_by_name` STRING COMMENT 'Name of the executive or manager who approved this promotional calendar period.',
    `banner_applicability` STRING COMMENT 'Indicates whether this promotional period applies across all retail banners (enterprise-wide) or is specific to individual banners (banner-specific). Supports multi-banner coordination.. Valid values are `enterprise_wide|banner_specific`',
    `blackout_reason` STRING COMMENT 'Business justification for why this period is designated as a promotional blackout (e.g., inventory transition, system maintenance, post-holiday recovery).',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for this promotional period including markdown funding, advertising spend, and vendor co-op contributions.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the promotional budget amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `channel_applicability` STRING COMMENT 'Indicates which sales channels this promotional period applies to (omnichannel, store-only, e-commerce-only, mobile-app-only).. Valid values are `omnichannel|store_only|ecommerce_only|mobile_app_only`',
    `circular_production_deadline` DATE COMMENT 'The deadline by which all promotional circular materials (print ads, digital circulars) must be finalized for production and distribution.',
    `competitive_response_flag` BOOLEAN COMMENT 'Indicates whether this promotional period was created as a competitive response to rival retailer promotions (true) or is part of the planned calendar (false).',
    `competitive_trigger_description` STRING COMMENT 'Description of the competitive market event or rival promotion that triggered this promotional period. Populated when competitive_response_flag is true.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional calendar record was first created in the system.',
    `end_date` DATE COMMENT 'The date when the promotional period ends. Defines the effective end of promotional activity and pricing.',
    `expected_sales_lift_pct` DECIMAL(18,2) COMMENT 'Forecasted percentage increase in sales revenue expected during this promotional period compared to baseline or prior year.',
    `expected_traffic_lift_pct` DECIMAL(18,2) COMMENT 'Forecasted percentage increase in customer traffic (footfall and digital visits) expected during this promotional period compared to baseline.',
    `inventory_build_start_date` DATE COMMENT 'The date when inventory positioning and build-up for this promotional period should begin to ensure adequate stock levels.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this promotional calendar period is currently active and valid (true) or has been logically deleted or superseded (false).',
    `is_blackout_period` BOOLEAN COMMENT 'Flag indicating whether this period is a promotional blackout window where no new promotions should be launched (true) or a normal promotional period (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional calendar record was last updated or modified.',
    `market_applicability` STRING COMMENT 'Geographic scope of the promotional period indicating whether it applies nationally, regionally, or to specific local markets.. Valid values are `national|regional|local`',
    `notes` STRING COMMENT 'Free-text notes and comments regarding special considerations, constraints, or coordination requirements for this promotional period.',
    `period_name` STRING COMMENT 'Business-friendly name for the promotional period (e.g., Spring Sale 2024, Black Friday Week, Back to School August).',
    `period_type` STRING COMMENT 'Classification of the promotional period indicating the nature and purpose of the promotion (weekly ad cycle, seasonal event, holiday, clearance window, competitive response, vendor-funded).. Valid values are `weekly_ad_cycle|seasonal_event|holiday|clearance_window|competitive_response|vendor_funded`',
    `planning_lock_date` DATE COMMENT 'The date by which all promotional planning for this period must be finalized and locked. After this date, changes require executive approval.',
    `planning_owner_email` STRING COMMENT 'Email address of the planning owner for coordination and communication regarding this promotional period.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `planning_owner_name` STRING COMMENT 'Name of the merchandising or marketing manager responsible for planning and executing this promotional period.',
    `planning_status` STRING COMMENT 'Current lifecycle status of the promotional calendar period (draft - under development, locked - finalized for execution, active - currently running, archived - completed and historical).. Valid values are `draft|locked|active|archived`',
    `priority_tier` STRING COMMENT 'Priority classification of the promotional period indicating strategic importance and resource allocation level (tier 1 strategic, tier 2 major, tier 3 standard, tier 4 tactical).. Valid values are `tier_1_strategic|tier_2_major|tier_3_standard|tier_4_tactical`',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this promotional calendar record originated (e.g., ORMS, RPM, internal planning tool).',
    `start_date` DATE COMMENT 'The date when the promotional period begins. Defines the effective start of promotional activity and pricing.',
    `target_customer_segment` STRING COMMENT 'Primary customer segment or demographic group targeted by this promotional period (e.g., families, millennials, loyalty members, value shoppers).',
    `theme_description` STRING COMMENT 'Marketing theme or creative concept for the promotional period (e.g., Summer Savings, Holiday Gift Guide, New Year New You).',
    `vendor_negotiation_deadline` DATE COMMENT 'The deadline by which all vendor-funded promotional agreements and co-op advertising commitments must be finalized.',
    CONSTRAINT pk_promo_calendar PRIMARY KEY(`promo_calendar_id`)
) COMMENT 'Master record for the retail promotional calendar defining planned promotional periods, key retail events, blackout dates, and competitive response windows for a fiscal year. Captures period name, period type (weekly ad cycle, seasonal event, holiday, clearance window, competitive response), start/end dates, fiscal week/month/quarter alignment, priority tier, planning lock date, planning status (draft, locked, active, archived), and banner/market applicability for multi-banner retailers. Used by merchandising, marketing, and supply chain teams to coordinate promotional activity, inventory positioning, and circular production timelines. Serves as the shared planning backbone that prevents promotional conflicts and ensures adequate lead time for vendor negotiations and inventory builds. Supports multi-banner coordination by allowing banner-specific or enterprise-wide calendar periods.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_parent_promo_campaign_id` FOREIGN KEY (`parent_promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `retail_ecm`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `retail_ecm`.`promotion`.`coupon`(`coupon_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_rebate_id` FOREIGN KEY (`rebate_id`) REFERENCES `retail_ecm`.`promotion`.`rebate`(`rebate_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `retail_ecm`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `retail_ecm`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `retail_ecm`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `retail_ecm`.`promotion` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `retail_ecm`.`promotion` SET TAGS ('dbx_domain' = 'promotion');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `assortment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `buyer_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `member_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Segment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `parent_promo_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Calendar Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'seasonal|clearance|new_product_launch|loyalty|vendor_funded|flash_sale');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `channel_scope` SET TAGS ('dbx_value_regex' = 'omnichannel|in_store_only|online_only|mobile_app_only');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `circular_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Circular Ad Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `digital_promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Promotion Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `discount_strategy` SET TAGS ('dbx_business_glossary_term' = 'Discount Strategy');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `discount_strategy` SET TAGS ('dbx_value_regex' = 'percentage_off|fixed_amount_off|bogo|bundle|tiered|rebate');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `event_classification` SET TAGS ('dbx_business_glossary_term' = 'Event Classification');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|local|store_specific');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `loyalty_exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Exclusive Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Campaign Owner Email');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Owner Name');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `promo_campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `promo_campaign_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `target_customer_reach` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Reach');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `target_revenue` SET TAGS ('dbx_business_glossary_term' = 'Target Revenue');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `target_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `target_units_sold` SET TAGS ('dbx_business_glossary_term' = 'Target Units Sold');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ALTER COLUMN `vendor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `return_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `activation_trigger` SET TAGS ('dbx_business_glossary_term' = 'Activation Trigger');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `activation_trigger` SET TAGS ('dbx_value_regex' = 'manual|cart_threshold|login|geofence|time_based|event_based');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `channel_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Channel Eligibility');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `channel_eligibility` SET TAGS ('dbx_value_regex' = 'POS|ecommerce|mobile|BOPIS|ROPIS|all_channels');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `digital_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Delivery Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `discount_method` SET TAGS ('dbx_business_glossary_term' = 'Discount Method');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `discount_method` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|tiered|quantity_based');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `display_message` SET TAGS ('dbx_business_glossary_term' = 'Display Message');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `effective_end_time` SET TAGS ('dbx_business_glossary_term' = 'Effective End Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `effective_start_time` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `jurisdiction_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Restriction Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `maximum_redemption_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Per Customer');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `maximum_redemption_total` SET TAGS ('dbx_business_glossary_term' = 'Maximum Total Redemptions');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_business_glossary_term' = 'Offer Name');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_priority` SET TAGS ('dbx_business_glossary_term' = 'Offer Priority');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|expired|cancelled');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'BOGO|percent_off|dollar_off|free_gift|bundle|threshold_discount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `personalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `product_eligibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Eligibility Scope');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `product_eligibility_scope` SET TAGS ('dbx_value_regex' = 'all_products|category|SKU_list|brand|excluded_products');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `restricted_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Restricted Jurisdictions');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `store_eligibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Store Eligibility Scope');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `store_eligibility_scope` SET TAGS ('dbx_value_regex' = 'all_stores|store_group|individual_store|excluded_stores');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `vendor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` SET TAGS ('dbx_subdomain' = 'offer_redemption');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon ID');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Campaign ID');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `barcode` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `coupon_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `coupon_status` SET TAGS ('dbx_business_glossary_term' = 'Coupon Status');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `coupon_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|redeemed');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `coupon_type` SET TAGS ('dbx_business_glossary_term' = 'Coupon Type');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `coupon_type` SET TAGS ('dbx_value_regex' = 'manufacturer|store|digital|paper|loyalty|vendor_funded');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `digital_distribution_quantity` SET TAGS ('dbx_business_glossary_term' = 'Digital Distribution Quantity');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `digital_wallet_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Enabled Flag');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|bogo|free_shipping|tiered');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `eligible_channel` SET TAGS ('dbx_business_glossary_term' = 'Eligible Channel');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `eligible_channel` SET TAGS ('dbx_value_regex' = 'all_channels|pos|ecommerce|mobile_app|bopis');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `eligible_product_scope` SET TAGS ('dbx_business_glossary_term' = 'Eligible Product Scope');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `eligible_product_scope` SET TAGS ('dbx_value_regex' = 'all_products|category|brand|sku|basket');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `exclusion_list` SET TAGS ('dbx_business_glossary_term' = 'Exclusion List');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `face_value` SET TAGS ('dbx_business_glossary_term' = 'Face Value');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `issue_channel` SET TAGS ('dbx_business_glossary_term' = 'Issue Channel');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_value_regex' = 'retailer|manufacturer|vendor|third_party');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `maximum_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `print_quantity` SET TAGS ('dbx_business_glossary_term' = 'Print Quantity');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `redemption_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Customer');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `single_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Use Flag');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `total_redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Limit');
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` SET TAGS ('dbx_subdomain' = 'offer_redemption');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `rebate_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate ID');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `return_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `channel_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Channel Eligibility');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `channel_eligibility` SET TAGS ('dbx_value_regex' = 'all_channels|pos_only|ecommerce_only|mobile_app_only|omnichannel');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `exclusion_product_list` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Product List');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `geographic_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Geographic Eligibility');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `marketing_message` SET TAGS ('dbx_business_glossary_term' = 'Marketing Message');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `maximum_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Rebate Amount');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|store_credit|digital_credit|prepaid_card|bank_transfer|instant_discount');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `payment_processing_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Processing Days');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `qualifying_product_list` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Product List');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `rebate_description` SET TAGS ('dbx_business_glossary_term' = 'Rebate Description');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `rebate_name` SET TAGS ('dbx_business_glossary_term' = 'Rebate Name');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `rebate_number` SET TAGS ('dbx_business_glossary_term' = 'Rebate Number');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `rebate_number` SET TAGS ('dbx_value_regex' = '^RBT-[A-Z0-9]{8,12}$');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `rebate_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Status');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `rebate_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|expired|cancelled|completed');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `rebate_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Type');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `rebate_type` SET TAGS ('dbx_value_regex' = 'instant_rebate|mail_in_rebate|vendor_funded_rebate|digital_rebate|promotional_allowance|volume_rebate');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `redemption_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Customer');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `redemption_limit_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Transaction');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `requires_proof_of_purchase` SET TAGS ('dbx_business_glossary_term' = 'Requires Proof of Purchase');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `stackable_with_other_promotions` SET TAGS ('dbx_business_glossary_term' = 'Stackable With Other Promotions');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `submission_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline Date');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ALTER COLUMN `vendor_funding_percentage` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funding Percentage');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `vendor_promo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Promotional Agreement ID');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `assortment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'purchase-based|sales-based|display-based|hybrid');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `ad_placement_required` SET TAGS ('dbx_business_glossary_term' = 'Advertisement Placement Required Flag');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'co-op advertising|off-invoice allowance|bill-back|scan allowance|new item allowance|volume rebate');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `chargeback_eligible` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Eligible Flag');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `chargeback_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Penalty Amount');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `display_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Display Compliance Required Flag');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Amount');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `funding_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Currency Code');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `funding_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `funding_percentage` SET TAGS ('dbx_business_glossary_term' = 'Funding Percentage');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `qualifying_product_scope` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Product Scope');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `qualifying_product_scope` SET TAGS ('dbx_value_regex' = 'all products|specific SKU|product category|brand|private label');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'one-time|weekly|monthly|quarterly|annually|event-based');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_value_regex' = 'upfront credit|monthly accrual|quarterly settlement|post-event claim|scan-based settlement');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `total_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Accrued Amount');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `total_settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Settled Amount');
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `vendor_promo_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` SET TAGS ('dbx_subdomain' = 'offer_redemption');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `promo_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Redemption ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `checkout_id` SET TAGS ('dbx_business_glossary_term' = 'Checkout Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `fulfillment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `rebate_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Rma Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `vendor_promo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Promo Agreement Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Status');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|approved|rejected|paid');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage_off|fixed_amount_off|bogo|bundle_discount|threshold_discount|free_shipping');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `final_price` SET TAGS ('dbx_business_glossary_term' = 'Final Price');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Price');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `processing_system` SET TAGS ('dbx_business_glossary_term' = 'Processing System');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `processing_system` SET TAGS ('dbx_value_regex' = 'pos|ecommerce_engine|oms|loyalty_platform|promotion_engine');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `promotion_tier` SET TAGS ('dbx_business_glossary_term' = 'Promotion Tier');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `quantity_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Redeemed');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_value_regex' = 'pos|ecommerce_web|ecommerce_mobile|call_center|kiosk|mobile_app');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Type');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_limit_type` SET TAGS ('dbx_value_regex' = 'per_customer|per_transaction|per_day|per_campaign|unlimited');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Redemption Mechanism');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Redemption Sequence Number');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|duplicate|expired|limit_exceeded|fraud_suspected');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `stack_sequence` SET TAGS ('dbx_business_glossary_term' = 'Stack Sequence');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `validation_error_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Code');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `validation_error_message` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Message');
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ALTER COLUMN `vendor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `promo_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Budget ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `merch_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Merch Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Calendar Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `vendor_promo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Promo Agreement Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_required');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `budget_owner_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Type');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `budget_owner_type` SET TAGS ('dbx_value_regex' = 'department|category|brand|channel|region|store_cluster');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'internal_marketing|vendor_coop|markdown_allowance|clearance_reserve|trade_promotion|digital_advertising');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `circular_ad_allocation` SET TAGS ('dbx_business_glossary_term' = 'Circular Advertisement Allocation');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|M(0[1-9]|1[0-2])|H[1-2]|FY)$');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `mobile_channel_allocation` SET TAGS ('dbx_business_glossary_term' = 'Mobile Channel Allocation');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `mobile_channel_allocation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `mobile_channel_allocation` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `otb_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Open to Buy (OTB) Integration Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `pos_channel_allocation` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Channel Allocation');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `remaining_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `variance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percent');
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ALTER COLUMN `vendor_funded_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Calendar ID');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `applicable_banner_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Banner Codes');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `applicable_market_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Market Codes');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `banner_applicability` SET TAGS ('dbx_business_glossary_term' = 'Banner Applicability Scope');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `banner_applicability` SET TAGS ('dbx_value_regex' = 'enterprise_wide|banner_specific');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_business_glossary_term' = 'Blackout Period Reason');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Budget Amount');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability Scope');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_value_regex' = 'omnichannel|store_only|ecommerce_only|mobile_app_only');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `circular_production_deadline` SET TAGS ('dbx_business_glossary_term' = 'Circular Production Deadline');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `competitive_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Response Flag');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `competitive_trigger_description` SET TAGS ('dbx_business_glossary_term' = 'Competitive Trigger Description');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional Period End Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `expected_sales_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Expected Sales Lift Percentage');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `expected_traffic_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Expected Traffic Lift Percentage');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `inventory_build_start_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Build Start Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `is_blackout_period` SET TAGS ('dbx_business_glossary_term' = 'Blackout Period Indicator');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `market_applicability` SET TAGS ('dbx_business_glossary_term' = 'Market Applicability Scope');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `market_applicability` SET TAGS ('dbx_value_regex' = 'national|regional|local');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Planning Notes');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Promotional Period Name');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Promotional Period Type');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'weekly_ad_cycle|seasonal_event|holiday|clearance_window|competitive_response|vendor_funded');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `planning_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Lock Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Planning Owner Email Address');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Planning Owner Name');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `planning_status` SET TAGS ('dbx_business_glossary_term' = 'Planning Status');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `planning_status` SET TAGS ('dbx_value_regex' = 'draft|locked|active|archived');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Promotional Priority Tier');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1_strategic|tier_2_major|tier_3_standard|tier_4_tactical');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional Period Start Date');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `theme_description` SET TAGS ('dbx_business_glossary_term' = 'Promotional Theme Description');
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ALTER COLUMN `vendor_negotiation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Vendor Negotiation Deadline');
