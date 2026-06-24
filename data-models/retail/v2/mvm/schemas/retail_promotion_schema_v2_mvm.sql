-- Schema for Domain: promotion | Business: Retail | Version: v2_mvm
-- Generated on: 2026-06-24 00:49:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_retail_v1`.`promotion` COMMENT 'Manages promotional campaigns, deals, coupons, rebates, BOGO offers, seasonal sales events, circular ads, and digital promotions across channels. Tracks promotion effectiveness, redemption rates, incremental lift, promotional ROI, and vendor-funded promotion agreements. Distinct from pricing — promotions are time-bound, event-driven incentives. Supports omnichannel promotion execution across POS, e-commerce, and mobile apps.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` (
    `promo_campaign_id` BIGINT COMMENT 'Unique identifier for the promotional campaign. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Retail promotion campaigns are frequently brand-level events (e.g., Pepsi brand week, private label push). This FK enables brand-level promotion spend tracking, vendor co-op funding reconciliation',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.format. Business justification: Store format drives promotional strategy — hypermarket formats run different campaigns than convenience formats. A format_id FK on promo_campaign enables format-specific promotional planning, campaign',
    `parent_promo_campaign_id` BIGINT COMMENT 'Self-referencing FK on promo_campaign (parent_promo_campaign_id)',
    `promo_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_calendar. Business justification: Campaigns are planned and executed according to promotional calendar periods. The promo_campaign has start_date and end_date that should align with promotional periods defined in promo_calendar (e.g.,',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to store.sales_territory. Business justification: Promotional campaigns are scoped to sales territories to align with sales rep coverage and territory-based revenue targets. promo_campaign.geographic_scope is a plain-text field that should be replace',
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
    `cost_center_code` STRING COMMENT 'Financial cost center code to which campaign expenses are allocated for P&L reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was first created in the system.',
    `customer_segment_target` STRING COMMENT 'Target customer segment or persona for the promotional campaign (e.g., loyalty members, new customers, high-value).',
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
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether campaign offers can be combined with other promotions or coupons.',
    `start_date` DATE COMMENT 'Date when the promotional campaign becomes active and offers are available to customers.',
    `target_customer_reach` STRING COMMENT 'Number of unique customers the campaign aims to reach or engage.',
    `target_revenue` DECIMAL(18,2) COMMENT 'Expected revenue target for the promotional campaign period.',
    `target_units_sold` STRING COMMENT 'Target number of units expected to be sold during the promotional campaign.',
    `terms_and_conditions` STRING COMMENT 'Legal terms, conditions, and exclusions governing the promotional campaign offers.',
    `vendor_funded_flag` BOOLEAN COMMENT 'Indicates whether the promotional campaign is partially or fully funded by vendor cooperative marketing agreements.',
    CONSTRAINT pk_promo_campaign PRIMARY KEY(`promo_campaign_id`)
) COMMENT 'Master record for a promotional campaign representing a time-bound marketing initiative encompassing both the strategic campaign wrapper and discrete promotional sales events (Flash Sales, Doorbuster Events, Holiday Sales). Captures campaign name, type, start/end dates, event classification, budget, and performance targets.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`promotion`.`promo_offer` (
    `promo_offer_id` BIGINT COMMENT 'Unique identifier for the promotional offer. Primary key for this entity.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Promotional offers are frequently brand-scoped (e.g., buy any Kraft product, save $2). This FK enables brand-level offer performance reporting, vendor co-op tracking, and brand manager analysis — a ',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: Shipping promotion offers (free ground shipping, discounted overnight) must specify which carrier_service is eligible. Retailers enforce this at offer creation to control cost exposure and carrier con',
    `cluster_id` BIGINT COMMENT 'Foreign key linking to store.cluster. Business justification: Promotional offers are targeted to store clusters — cluster-based offer eligibility is a core retail promotional planning process. promo_offer.store_eligibility_scope is a plain-text denormalization. ',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Retail promotions are frequently scoped at the category level (e.g., 20% off all beverages). Category managers require this FK for category-level offer planning, promotion performance reporting by d',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the parent promotional campaign under which this offer is organized.',
    `region_id` BIGINT COMMENT 'Foreign key linking to store.region. Business justification: Promotional offers have regional eligibility driven by regulatory differences, tax jurisdictions, and market conditions. promo_offer.jurisdiction_restriction_flag and store_eligibility_scope indicate ',
    `return_policy_id` BIGINT COMMENT 'Foreign key linking to returns.return_policy. Business justification: Promotional offers frequently carry specific return policy overrides — final-sale offers restrict returns, loyalty offers extend return windows. POS and e-commerce systems must enforce the correct ret',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Promotional offers target specific SKUs for discount application. Essential for offer eligibility validation, POS redemption logic, inventory planning for promoted items, and promotional ROI analysis ',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor/supplier funding or co-funding this promotional offer. Null if retailer-funded.',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_item. Business justification: Promotional offers in retail are planned at the vendor item level (specific pack size, cost, and configuration). Vendor item promotional planning requires linking offers to the exact vendor_item to ',
    `activation_trigger` STRING COMMENT 'Event or condition that activates this offer for a customer. manual = customer enters code; cart_threshold = automatically applied when cart meets criteria; login = activated upon customer login; geofence = triggered by location; time_based = activated at specific time; event_based = triggered by business event.. Valid values are `manual|cart_threshold|login|geofence|time_based|event_based`',
    `approval_status` STRING COMMENT 'Approval workflow status for this promotional offer. pending = awaiting approval; approved = authorized for execution; rejected = not approved.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the business user who approved this promotional offer. Null if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional offer was approved. Null if not yet approved.',
    `channel_eligibility` STRING COMMENT 'Sales channels where this offer is valid. POS = in-store Point of Sale; ecommerce = online web storefront; mobile = mobile app; BOPIS = Buy Online Pick Up In Store; ROPIS = Reserve Online Pick Up In Store; all_channels = valid across all channels. [ENUM-REF-CANDIDATE: POS|ecommerce|mobile|BOPIS|ROPIS|call_center|kiosk — promote to reference product]. Valid values are `POS|ecommerce|mobile|BOPIS|ROPIS|all_channels`',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of promotional discount cost borne by the vendor (0-100). Null if not applicable or fully retailer-funded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional offer record was first created in the system.',
    `customer_segment_eligibility` STRING COMMENT 'Defines which customer segments are eligible to redeem this offer. all_customers = no restrictions; loyalty_members = requires loyalty program membership; VIP = high-value customers only; new_customers = first-time buyers; targeted_segment = specific marketing segment.. Valid values are `all_customers|loyalty_members|VIP|new_customers|targeted_segment`',
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
    `maximum_redemption_total` DECIMAL(18,2) COMMENT 'Maximum total number of redemptions allowed across all customers for this offer. Null indicates unlimited total redemptions.',
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

CREATE OR REPLACE TABLE `vibe_retail_v1`.`promotion`.`coupon` (
    `coupon_id` BIGINT COMMENT 'Unique identifier for the coupon instrument. Primary key.',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Coupons are frequently scoped to a product category (e.g., $1 off any cereal, save on all organic produce). This FK enables category-level coupon planning, redemption analysis by department, and c',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the parent promotional campaign under which this coupon was issued.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Coupons are instruments that implement specific promotional offers. While coupon already has promotion_campaign_id (linking to the campaign), it needs promo_offer_id to identify the exact offer the co',
    `region_id` BIGINT COMMENT 'Foreign key linking to store.region. Business justification: Coupons have geographic restrictions by region — coupon.geographic_restriction is a plain-text denormalization of region data. A region_id FK enables proper geographic restriction enforcement, regiona',
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

CREATE OR REPLACE TABLE `vibe_retail_v1`.`promotion`.`circular_ad` (
    `circular_ad_id` BIGINT COMMENT 'Unique identifier for the circular advertisement. Primary key for the circular ad entity.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Circular ads feature specific hero SKUs on cover/pages. Production teams need product images, descriptions, compliance attributes. Inventory planning ensures featured items are in stock. Performance t',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Circular ads are planned by department/category (e.g., produce feature page, frozen foods spread). Category managers require this FK for circular space allocation planning and category-level ad pe',
    `promo_budget_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_budget. Business justification: Circular ads have production costs (production_cost_amount, production_cost_currency_code) that are funded from promotional budgets. While circular_ad.promo_campaign_id links to campaign, the specific',
    `promo_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_calendar. Business justification: Circular ads are published according to promotional calendar periods. The circular_ad has effective_start_date and effective_end_date that align with promotional periods defined in promo_calendar (e.g',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Circular ads are marketing vehicles that promote specific promotional campaigns. While circular_ad already links to promotion.campaign (cross-domain for overall marketing campaign), it needs a link to',
    `region_id` BIGINT COMMENT 'Foreign key linking to store.region. Business justification: Circular ads are published for specific geographic markets/regions. circular_ad.geographic_market is a plain-text denormalization of region data. A region_id FK enables circular distribution planning,',
    `vendor_id` BIGINT COMMENT 'Reference to the external vendor or agency responsible for circular design, production, or distribution services.',
    `approval_date` DATE COMMENT 'Date when the circular content and design were officially approved for production and distribution by marketing management.',
    `circular_name` STRING COMMENT 'Marketing name or title of the circular advertisement, such as Weekly Savings, Holiday Spectacular, or Back to School Event.',
    `circular_number` STRING COMMENT 'Business identifier for the circular advertisement, typically a human-readable code or number used for reference in marketing and merchandising operations.',
    `circular_type` STRING COMMENT 'Classification of the circular advertisement based on its purpose and timing, such as weekly promotional circular, seasonal event, holiday special, clearance sale, or grand opening.. Valid values are `weekly|seasonal|holiday|event|clearance|grand_opening`',
    `compliance_review_flag` BOOLEAN COMMENT 'Indicates whether the circular has undergone legal and regulatory compliance review for advertising standards, pricing transparency, and consumer protection requirements. True if reviewed, false otherwise.',
    `cover_image_url` STRING COMMENT 'URL or file path to the cover image or hero graphic for the circular, used for digital display and thumbnail previews.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the circular record was first created in the system, used for audit trail and lifecycle tracking.',
    `digital_impressions_target` STRING COMMENT 'Target number of digital impressions or views for the circular across digital channels, used for campaign planning and performance measurement.',
    `distribution_channel` STRING COMMENT 'Primary channel through which the circular is distributed to customers, including print mail, digital web, email, mobile app, social media, or in-store display.. Valid values are `print|digital|email|mobile_app|social_media|in_store`',
    `edition_number` STRING COMMENT 'Edition or version number of the circular, used to track revisions and multiple releases within a campaign period.',
    `effective_end_date` DATE COMMENT 'Date when the promotional offers and pricing featured in the circular expire and are no longer valid for customer redemption.',
    `effective_start_date` DATE COMMENT 'Date when the promotional offers and pricing featured in the circular become valid and active for customer redemption.',
    `is_vendor_funded` BOOLEAN COMMENT 'Indicates whether the circular includes vendor-funded promotional offers or co-op advertising agreements. True if vendor funding is involved, false otherwise.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language of the circular content, such as en for English or es for Spanish.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the circular record was most recently updated, used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about the circular production, distribution, or performance.',
    `page_count` STRING COMMENT 'Total number of pages in the circular advertisement, used for production planning and cost management.',
    `pdf_file_url` STRING COMMENT 'URL or file path to the complete PDF version of the circular, used for digital distribution and archival purposes.',
    `print_quantity` STRING COMMENT 'Total number of physical copies printed for distribution, used for production cost tracking and circulation analysis. Null for digital-only circulars.',
    `production_cost_amount` DECIMAL(18,2) COMMENT 'Total cost to produce and distribute the circular, including design, printing, mailing, and digital distribution expenses. Used for marketing ROI analysis.',
    `production_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the production cost amount, such as USD, CAD, or EUR.. Valid values are `^[A-Z]{3}$`',
    `production_status` STRING COMMENT 'Current lifecycle status of the circular in the production workflow, from initial draft through review, approval, production, publication, and archival.. Valid values are `draft|in_review|approved|in_production|published|archived`',
    `publication_date` DATE COMMENT 'Date when the circular advertisement is officially published or released to customers across distribution channels.',
    `target_audience` STRING COMMENT 'Primary customer segment or demographic targeted by this circular, such as families, millennials, budget shoppers, or loyalty members. Supports personalized marketing strategies.',
    `theme` STRING COMMENT 'Marketing theme or creative concept for the circular, such as Summer Savings, Holiday Gift Guide, or Spring Refresh, used for brand consistency and customer engagement.',
    `vendor_funding_amount` DECIMAL(18,2) COMMENT 'Total amount of vendor co-op funding or promotional allowances applied to this circular, used for cost allocation and vendor settlement.',
    CONSTRAINT pk_circular_ad PRIMARY KEY(`circular_ad_id`)
) COMMENT 'Master record for a printed or digital weekly/seasonal circular advertisement, including both the circular header and its featured item lines. Header captures circular name, edition number, publication date, effective date range, distribution channel (print, digital, email, app), geographic market coverage, page count, and production status. Item lines capture featured SKU, advertised price, promotional price, page number, position on page, feature type (front page, endcap feature, in-book), ad copy headline, image reference, and loss-leader flag. The circular is a key promotional vehicle in retail that drives planned traffic and is directly linked to campaign offers. Supports circular effectiveness analysis by item and planogram alignment with advertised features.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`promotion`.`rebate` (
    `rebate_id` BIGINT COMMENT 'Unique identifier for the rebate program. Primary key.',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Retail rebate programs are frequently structured at the category level (e.g., all frozen foods rebate). The existing rebate.sku_id covers SKU-level rebates; this FK enables category-level rebate acc',
    `promo_budget_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_budget. Business justification: A rebate program is funded from a promotional budget. rebate.total_budget_amount is a budget tracking field that duplicates the authoritative budget record in promo_budget. Adding promo_budget_id to r',
    `promo_campaign_id` BIGINT COMMENT 'Identifier of the parent promotional campaign or event to which this rebate belongs. Null if rebate is standalone.',
    `region_id` BIGINT COMMENT 'Foreign key linking to store.region. Business justification: Rebates have geographic eligibility by region — rebate.geographic_eligibility is a plain-text denormalization of region data. A region_id FK enables proper regional rebate eligibility enforcement, reg',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Rebates apply to specific qualifying products. Claim validation verifies purchased SKU matches rebate terms. Vendor chargeback reconciliation requires SKU-level tracking. Inventory planning adjusts fo',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor sponsoring or funding the rebate program. Null for retailer-funded rebates.',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_item. Business justification: Vendor rebates in retail are negotiated at the vendor item level — qualifying purchase quantities and costs are specific to a vendors item configuration (pack size, unit cost). Vendor item rebate tr',
    `vendor_promo_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.vendor_promo_agreement. Business justification: rebate has vendor_funding_percentage indicating vendor-funded rebates. The vendor_promo_agreement is the contractual basis governing vendor-funded rebate programs — it defines the funding terms, settl',
    `amount` DECIMAL(18,2) COMMENT 'Fixed monetary value of the rebate in the transaction currency. Null if rebate is percentage-based.',
    `approval_status` STRING COMMENT 'Workflow approval state for the rebate program before it can be activated. Ensures financial and legal review compliance.. Valid values are `pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the rebate program was approved. Null if not yet approved.',
    `channel_eligibility` STRING COMMENT 'Sales channels where the rebate can be redeemed: all_channels (any touchpoint), pos_only (in-store Point of Sale only), ecommerce_only (online purchases), mobile_app_only (mobile app transactions), or omnichannel (integrated cross-channel).. Valid values are `all_channels|pos_only|ecommerce_only|mobile_app_only|omnichannel`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the rebate program record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rebate amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_segment_eligibility` STRING COMMENT 'Comma-separated list of customer segment codes eligible for the rebate (e.g., loyalty_member, employee, senior, student). Null if available to all customers.',
    `rebate_description` STRING COMMENT 'Detailed internal description of the rebate program purpose, target audience, and business objectives. Used for internal planning and reporting.',
    `effective_end_date` DATE COMMENT 'Date when the rebate program expires and is no longer available for new submissions. Null for open-ended programs.',
    `effective_start_date` DATE COMMENT 'Date when the rebate program becomes active and eligible for customer redemption.',
    `exclusion_product_list` STRING COMMENT 'Comma-separated list of Stock Keeping Unit (SKU) codes or product categories explicitly excluded from the rebate program.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the rebate program record was last updated.',
    `marketing_message` STRING COMMENT 'Customer-facing promotional message displayed in circulars, digital ads, and at Point of Sale to communicate the rebate offer.',
    `maximum_rebate_amount` DECIMAL(18,2) COMMENT 'Cap on the total rebate value that can be claimed per transaction or per customer. Null if no cap applies.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum transaction value required to qualify for the rebate. Null if no minimum threshold applies.',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum number of qualifying units (Stock Keeping Units) that must be purchased to qualify for the rebate. Null if no quantity threshold applies.',
    `rebate_name` STRING COMMENT 'Marketing name of the rebate program displayed to customers and used in promotional materials.',
    `payment_method` STRING COMMENT 'Mechanism by which the rebate value is returned to the customer: check (mailed physical check), store_credit (loyalty account credit), digital_credit (e-wallet or app credit), prepaid_card (branded debit card), bank_transfer (direct deposit), or instant_discount (applied at Point of Sale).. Valid values are `check|store_credit|digital_credit|prepaid_card|bank_transfer|instant_discount`',
    `payment_processing_days` STRING COMMENT 'Expected number of business days from rebate approval to payment issuance. Used for customer Service Level Agreement (SLA) communication.',
    `percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied as rebate (e.g., 10.00 for 10% off). Null if rebate is fixed-amount.',
    `qualifying_product_list` STRING COMMENT 'Comma-separated list of Stock Keeping Unit (SKU) codes, Universal Product Code (UPC) numbers, or product category codes that qualify for the rebate. Null if rebate applies to all products.',
    `rebate_number` STRING COMMENT 'Externally-visible unique business identifier for the rebate program, used in customer communications and vendor agreements.. Valid values are `^RBT-[A-Z0-9]{8,12}$`',
    `rebate_status` STRING COMMENT 'Current lifecycle state of the rebate program: draft (being configured), active (live and accepting submissions), paused (temporarily suspended), expired (past end date), cancelled (terminated early), or completed (ended successfully).. Valid values are `draft|active|paused|expired|cancelled|completed`',
    `rebate_type` STRING COMMENT 'Classification of the rebate mechanism: instant rebate (applied at Point of Sale), mail-in rebate (customer submits proof of purchase), vendor-funded rebate (supplier-sponsored), digital rebate (online redemption), promotional allowance (trade promotion), or volume rebate (quantity-based incentive).. Valid values are `instant_rebate|mail_in_rebate|vendor_funded_rebate|digital_rebate|promotional_allowance|volume_rebate`',
    `redemption_limit_per_customer` STRING COMMENT 'Maximum number of times a single customer can claim this rebate during the program period. Null if no limit applies.',
    `redemption_limit_per_transaction` STRING COMMENT 'Maximum number of rebate instances that can be applied in a single transaction. Null if no limit applies.',
    `requires_proof_of_purchase` BOOLEAN COMMENT 'Indicates whether customers must submit receipt or purchase documentation to claim the rebate. True for mail-in rebates, false for instant rebates applied at Point of Sale.',
    `stackable_with_other_promotions` BOOLEAN COMMENT 'Indicates whether this rebate can be combined with other promotional offers (coupons, markdowns, Buy One Get One (BOGO) deals) in the same transaction.',
    `submission_deadline_date` DATE COMMENT 'Final date by which customers must submit rebate claims for purchases made during the effective period. Typically extends beyond the effective end date for mail-in rebates.',
    `terms_and_conditions` STRING COMMENT 'Full legal text of the rebate program terms, conditions, restrictions, and disclaimers. Must comply with Federal Trade Commission (FTC) disclosure requirements.',
    `vendor_funding_percentage` DECIMAL(18,2) COMMENT 'Percentage of the rebate cost funded by the vendor in co-op promotional agreements (e.g., 75.00 means vendor pays 75%, retailer pays 25%). Null for fully retailer-funded rebates.',
    CONSTRAINT pk_rebate PRIMARY KEY(`rebate_id`)
) COMMENT 'Master record for a rebate program offered to customers or funded by vendors. Captures rebate name, rebate type (instant rebate, mail-in rebate, vendor-funded rebate), rebate amount or percentage, qualifying purchase conditions, submission deadline, payment method (check, store credit, digital credit), sponsoring vendor, and rebate program status. Supports both consumer-facing rebates and vendor-funded promotional allowances.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` (
    `vendor_promo_agreement_id` BIGINT COMMENT 'Unique identifier for the vendor-funded promotional agreement record. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Vendor promo agreements are negotiated at the brand level (e.g., Unilever brand promotion agreement). This FK enables brand-level funding reconciliation, accrual tracking, and settlement reporting —',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Vendor promo agreements in retail are negotiated at the category level (e.g., all private label dairy). This FK enables structured category-level vendor funding reconciliation, accrual reporting, an',
    `promo_budget_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_budget. Business justification: A vendor promotional agreement is the contractual basis for vendor-funded budget contributions. vendor_promo_agreement tracks funding_amount, total_accrued_amount, total_settled_amount, and outstandin',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Vendor promotional agreements (co-op advertising, promotional allowances) fund specific promotional campaigns. The vendor_promo_agreement table currently only links to vendor but needs promo_campaign_',
    `region_id` BIGINT COMMENT 'Foreign key linking to store.region. Business justification: Vendor promotional agreements are scoped to geographic markets/regions — vendors fund promotions only in specific regions based on distribution footprint and market strategy. A region_id FK enables re',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: Promotional funding agreements are executed under master vendor contracts. Finance teams perform promotional contract reconciliation — validating that agreed funding amounts and terms in vendor_prom',
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

CREATE OR REPLACE TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` (
    `promo_redemption_id` BIGINT COMMENT 'Unique identifier for each promotional offer redemption instance. Primary key for the promo_redemption product.',
    `coupon_id` BIGINT COMMENT 'Foreign key linking to promotion.coupon. Business justification: When a redemption is triggered by a coupon, promo_redemption needs a structured FK to the coupon master record. Currently has coupon_code as STRING, which should be replaced with coupon_id FK. This en',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Promotion redemptions in e-commerce/omnichannel orders need order-level context for multi-line promotion analysis, customer journey tracking, and cross-channel promotional effectiveness measurement. D',
    `location_id` BIGINT COMMENT 'Reference to the physical store location where the redemption occurred. Populated for POS and BOPIS transactions. Null for pure e-commerce fulfillment.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Shipping promotions (free shipping, expedited upgrade offers) are redeemed against a specific fulfillment_order. Retailers need direct linkage for vendor chargeback reconciliation, shipping cost subsi',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: promo_redemption links to header and pos_transaction but not to the specific order_line where the promotion was redeemed. Line-level redemption tracking is required for item-level promotional margin a',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal or register where the redemption was processed. Used for audit trail and fraud detection. Null for e-commerce transactions.',
    `pos_transaction_id` BIGINT COMMENT 'Reference to the customer transaction (POS or e-commerce order) where this promotion was applied. Links to the sales transaction header.',
    `profile_id` BIGINT COMMENT 'Customer who redeemed',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the promotional offer that was redeemed. Links to the promotion master data defining the offer terms, discount rules, and eligibility criteria.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Promotional redemptions capture the application of a specific promotional offer to a transaction. While promo_redemption already has promo_campaign_id, it needs promo_offer_id to identify the exact of',
    `rebate_id` BIGINT COMMENT 'Foreign key linking to promotion.rebate. Business justification: Redemptions can be for rebate offers specifically. A customer may redeem a rebate offer at transaction time (e.g., instant rebate applied at POS), and tracking which rebate was redeemed is essential f',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Redemption records must reference the redeemed SKU via proper FK for product-level promotion performance reporting, margin analysis, and vendor chargeback reconciliation. The existing plain `sku` colu',
    `vendor_promo_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.vendor_promo_agreement. Business justification: promo_redemption has chargeback_amount and chargeback_status fields that are directly governed by vendor_promo_agreements chargeback_eligible and chargeback_penalty_amount terms. When a redemption is',
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
    `source_record_reference` STRING COMMENT 'The unique identifier of this redemption record in the source operational system. Enables traceability back to the system of record.',
    `stack_sequence` STRING COMMENT 'The order in which this promotion was applied within a stacked promotion scenario. Determines calculation precedence when multiple discounts are layered.',
    `validation_error_code` STRING COMMENT 'System error code returned when a redemption attempt fails validation. Provides technical detail for troubleshooting invalid redemptions. Null for successful redemptions.',
    `validation_error_message` STRING COMMENT 'Human-readable error message explaining why a redemption was rejected. Displayed to customers or cashiers. Null for successful redemptions.',
    `vendor_funded_flag` BOOLEAN COMMENT 'Indicates whether this promotion discount is funded by a vendor/supplier through a trade promotion agreement. True when the cost is charged back to the vendor; false when retailer-funded.',
    CONSTRAINT pk_promo_redemption PRIMARY KEY(`promo_redemption_id`)
) COMMENT 'Transactional record capturing each instance of a promotional offer being applied to a customer transaction at POS or e-commerce checkout. Records offer applied, redemption mechanism (automatic system-triggered, coupon code entry, loyalty auto-apply, cart rule), coupon reference (when coupon-based), transaction reference, store or channel, customer identifier, discount amount granted, redemption timestamp, redemption status (valid, invalid, duplicate, expired), and processing system. Serves as the single source of truth for all promotion redemption activity — including coupon redemptions, automatic BOGO applications, threshold discounts, and bundle deals. Critical for promotional ROI calculation, coupon fraud prevention, vendor chargeback evidence, and real-time redemption limit enforcement.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`promotion`.`promo_budget` (
    `promo_budget_id` BIGINT COMMENT 'Unique identifier for the promotional budget record. Primary key for the promotional budget master data.',
    `promo_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_calendar. Business justification: Promotional budgets are planned and allocated against promotional calendar periods (fiscal year, fiscal quarter, seasonal events). The promo_budget table has fiscal_year and fiscal_period as standalon',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Promotional budgets are allocated to specific promotional campaigns. The promo_budget table tracks budget_owner_type and budget_owner_id as generic strings, but needs a structured FK to promo_campaign',
    `region_id` BIGINT COMMENT 'Foreign key linking to store.region. Business justification: Regional promotional budgets are a core retail financial construct — regional directors manage and report on promotional spend for their markets. A region_id FK on promo_budget enables regional budget',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Cumulative actual spend to date against this promotional budget, including all posted promotional costs, markdowns, vendor co-op claims, and advertising expenses. Updated in real-time as promotional transactions are processed.',
    `approval_date` DATE COMMENT 'Date when this promotional budget was formally approved by authorized management. Marks the transition from pending to approved status.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the promotional budget. Not submitted indicates budget has not been submitted for approval; pending review indicates awaiting management approval; approved indicates budget has been authorized; rejected indicates budget was not approved; revision required indicates budget must be modified and resubmitted.. Valid values are `not_submitted|pending_review|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Identifier or name of the manager or executive who approved this promotional budget. Typically a user ID or employee identifier from the HR system.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP, CAD). All budget amounts and spend tracking for this budget are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `budget_name` STRING COMMENT 'Descriptive name of the promotional budget plan, typically indicating the campaign, event, or category scope (e.g., Q4 Holiday Electronics Promotion, Spring Apparel Clearance).',
    `budget_number` STRING COMMENT 'Human-readable business identifier for the promotional budget, typically following format PB-YYYYNNNN where YYYY is fiscal year and NNNN is sequence number.. Valid values are `^PB-[0-9]{8}$`',
    `budget_owner_type` STRING COMMENT 'Classification of the organizational unit responsible for managing and executing this promotional budget. Department indicates merchandising department ownership; category indicates product category team ownership; brand indicates brand management team ownership; channel indicates channel-specific ownership (e-commerce, stores); region indicates geographic region ownership; store cluster indicates store group ownership.. Valid values are `department|category|brand|channel|region|store_cluster`',
    `budget_status` STRING COMMENT 'Current lifecycle status of the promotional budget. Draft indicates initial planning stage; pending approval indicates submitted for management review; approved indicates authorized but not yet active; active indicates currently in use for promotional spend; suspended indicates temporarily paused; closed indicates completed and finalized; cancelled indicates terminated before completion. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the promotional budget source and purpose. Internal marketing budgets are company-funded campaigns; vendor co-op budgets are supplier-funded promotional agreements; markdown allowance budgets cover planned price reductions; clearance reserve budgets are set aside for end-of-season inventory liquidation; trade promotion budgets support B2B channel incentives; digital advertising budgets fund online and mobile promotional campaigns.. Valid values are `internal_marketing|vendor_coop|markdown_allowance|clearance_reserve|trade_promotion|digital_advertising`',
    `circular_ad_allocation` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated specifically for circular advertising and weekly ad production, including print circulars, digital circulars, and featured promotional items in weekly ad campaigns.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Amount committed but not yet spent, representing approved promotional activities that have been scheduled or contracted but not yet executed (e.g., scheduled markdowns, booked advertising placements, approved vendor co-op agreements).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional budget record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `ecommerce_channel_allocation` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated specifically for e-commerce and digital promotional activities, including online discounts, digital coupons, email campaigns, and website promotional banners. Supports omnichannel budget planning and digital channel ROI tracking.',
    `effective_end_date` DATE COMMENT 'Date when this promotional budget expires and is no longer available for new promotional spend allocation. Any uncommitted budget remaining after this date typically rolls back to the general promotional fund or is reallocated.',
    `effective_start_date` DATE COMMENT 'Date when this promotional budget becomes active and available for promotional spend allocation. Promotional activities can begin drawing from this budget on or after this date.',
    `fiscal_period` STRING COMMENT 'Fiscal period within the fiscal year for which this budget is allocated. Format: Q1-Q4 for quarters, M01-M12 for months, H1-H2 for half-years, FY for full fiscal year. Supports period-based budget planning and performance tracking.. Valid values are `^(Q[1-4]|M(0[1-9]|1[0-2])|H[1-2]|FY)$`',
    `fiscal_year` STRING COMMENT 'Fiscal year for which this promotional budget is allocated, typically a four-digit year (e.g., 2024). Aligns with the companys financial planning and reporting calendar.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which promotional spend from this budget is posted for financial reporting and P&L tracking. Links operational promotional budget management to financial accounting.. Valid values are `^[0-9]{4,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotional budget record was last updated. Audit field for change tracking and data quality monitoring.',
    `mobile_channel_allocation` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated specifically for mobile app promotional activities, including app-exclusive offers, push notification campaigns, and mobile wallet coupons. Supports omnichannel budget planning and mobile channel ROI tracking.',
    `notes` STRING COMMENT 'Free-text notes and comments about the promotional budget, including planning assumptions, special conditions, vendor agreement details, or budget reallocation history. Supports collaborative budget management and audit trail documentation.',
    `otb_integration_flag` BOOLEAN COMMENT 'Boolean indicator of whether this promotional budget is integrated with the Open to Buy (OTB) merchandise planning system. When true, promotional markdowns and clearance budgets are factored into inventory purchasing decisions and margin planning.',
    `planned_spend_amount` DECIMAL(18,2) COMMENT 'Total planned or forecasted spend amount for the promotional budget based on campaign planning and historical performance. May be less than or equal to total budget amount, representing the expected utilization.',
    `pos_channel_allocation` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated specifically for in-store point-of-sale promotional activities, including store markdowns, in-store coupons, and physical promotional displays. Supports omnichannel budget planning and channel-specific ROI tracking.',
    `profit_center_code` STRING COMMENT 'Profit center code associated with this promotional budget, used for segment reporting and profitability analysis. Enables tracking of promotional ROI by business unit or product line.. Valid values are `^PC-[0-9]{6}$`',
    `remaining_budget_amount` DECIMAL(18,2) COMMENT 'Available budget remaining for new promotional activities, calculated as total budget amount minus actual spend amount minus committed amount. Represents the unallocated budget available for additional promotional planning.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget amount for the promotional plan in the budget currency. Represents the maximum authorized spend for this promotional budget across all channels and activities.',
    `variance_threshold_amount` DECIMAL(18,2) COMMENT 'Absolute amount threshold for budget variance alerts. When actual spend deviates from planned spend by more than this amount, automated alerts are triggered to budget owners and finance teams. Used in conjunction with or as an alternative to percentage-based thresholds.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'Percentage threshold for budget variance alerts. When actual spend deviates from planned spend by more than this percentage, automated alerts are triggered to budget owners and finance teams. Typical values range from 5% to 20%.',
    `vendor_funded_amount` DECIMAL(18,2) COMMENT 'Portion of the total budget that is funded by vendor co-op agreements, trade promotion allowances, or supplier marketing development funds. Represents external funding contribution to the promotional budget.',
    CONSTRAINT pk_promo_budget PRIMARY KEY(`promo_budget_id`)
) COMMENT 'Master record for the promotional budget allocated to a campaign, promotional event, or category-level promotional plan. Captures total budget amount, budget type (internal marketing, vendor co-op, markdown allowance, clearance reserve), budget owner (department, category, or brand team), planned spend by channel, actual spend to date, committed but unspent amount, remaining budget, budget approval status, fiscal period, and variance threshold for alerts. Supports OTB (Open to Buy) integration, promotional P&L management, and real-time budget consumption monitoring. Distinct from finance domain general ledger — this is the operational promotional spend plan that feeds GL accruals.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` (
    `promo_calendar_id` BIGINT COMMENT 'Unique identifier for the promotional calendar period. Primary key for the promotional calendar master record.',
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
    `fiscal_month` STRING COMMENT 'The fiscal month (1-12) to which this promotional period belongs.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) to which this promotional period belongs.',
    `fiscal_week` STRING COMMENT 'The fiscal week number (1-52 or 1-53) to which this promotional period belongs, aligned with the retail 4-5-4 calendar.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this promotional period belongs (e.g., 2024, 2025).',
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

CREATE OR REPLACE TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` (
    `circular_ad_placement_id` BIGINT COMMENT 'Primary key for the circular_ad_placement association',
    `circular_ad_id` BIGINT COMMENT 'Foreign key linking this placement record to the parent circular advertisement.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking this placement record to the specific promotional offer being featured.',
    `ad_copy_override` STRING COMMENT 'Circular-specific advertising copy headline or tagline for this offer, overriding the offers default display_message when the circular requires custom messaging for this placement.',
    `ad_placement_position` STRING COMMENT 'The specific position on the page where this offer is displayed within the circular. Captures the commercial value of premium placement positions.',
    `display_priority` STRING COMMENT 'Numeric priority or ordering of this offers prominence within the circular, used to resolve display conflicts and rank featured items for digital rendering.',
    `feature_size` STRING COMMENT 'The physical or digital size of the ad feature for this offer within the circular. Determines production cost allocation and vendor co-op billing.',
    `page_number` STRING COMMENT 'The page number within the circular on which this promotional offer is featured. Belongs to the placement, not the circular header or the offer definition.',
    `vendor_funded_placement_flag` BOOLEAN COMMENT 'Indicates whether the vendor co-funded or fully funded this specific placement within this circular, as distinct from the offer-level cost_share_percentage. A placement may be vendor-funded even when the parent offer is not, or vice versa.',
    CONSTRAINT pk_circular_ad_placement PRIMARY KEY(`circular_ad_placement_id`)
) COMMENT 'This association product represents the Contract between circular_ad and promo_offer. It captures the commercial placement of a specific promotional offer within a specific circular advertisement, including the physical or digital position, feature size, page number, display priority, and vendor funding status for that placement. Each record links one circular_ad to one promo_offer and carries attributes that exist only in the context of that specific placement — a given offer may appear in multiple circulars at different positions and sizes, and a given circular features many offers at distinct locations.. Existence Justification: In retail, a circular advertisement features multiple promotional offers (e.g., a weekly circular may include a BOGO offer on beverages, a percent-off offer on produce, and a dollar-off offer on household goods simultaneously). Conversely, a single promotional offer can be featured across multiple circulars (e.g., a vendor-funded BOGO offer appearing in both the weekly print circular and the digital holiday circular). The placement of an offer within a circular is a recognized commercial transaction — retailers charge vendors for featured ad space, and each placement carries its own page number, position, feature size, and vendor-funding flag that belong to neither the circular nor the offer alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_parent_promo_campaign_id` FOREIGN KEY (`parent_promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ADD CONSTRAINT `fk_promotion_circular_ad_promo_budget_id` FOREIGN KEY (`promo_budget_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_budget`(`promo_budget_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ADD CONSTRAINT `fk_promotion_circular_ad_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ADD CONSTRAINT `fk_promotion_circular_ad_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_promo_budget_id` FOREIGN KEY (`promo_budget_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_budget`(`promo_budget_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `vibe_retail_v1`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_promo_budget_id` FOREIGN KEY (`promo_budget_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_budget`(`promo_budget_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `vibe_retail_v1`.`promotion`.`coupon`(`coupon_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_rebate_id` FOREIGN KEY (`rebate_id`) REFERENCES `vibe_retail_v1`.`promotion`.`rebate`(`rebate_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `vibe_retail_v1`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` ADD CONSTRAINT `fk_promotion_circular_ad_placement_circular_ad_id` FOREIGN KEY (`circular_ad_id`) REFERENCES `vibe_retail_v1`.`promotion`.`circular_ad`(`circular_ad_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` ADD CONSTRAINT `fk_promotion_circular_ad_placement_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_retail_v1`.`promotion` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_retail_v1`.`promotion` SET TAGS ('dbx_domain' = 'promotion');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Format Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `parent_promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Promo Campaign Id');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `parent_promo_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Calendar Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'seasonal|clearance|new_product_launch|loyalty|vendor_funded|flash_sale');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `channel_scope` SET TAGS ('dbx_value_regex' = 'omnichannel|in_store_only|online_only|mobile_app_only');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `circular_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Circular Ad Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `customer_segment_target` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Target');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `digital_promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Promotion Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `discount_strategy` SET TAGS ('dbx_business_glossary_term' = 'Discount Strategy');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `discount_strategy` SET TAGS ('dbx_value_regex' = 'percentage_off|fixed_amount_off|bogo|bundle|tiered|rebate');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `event_classification` SET TAGS ('dbx_business_glossary_term' = 'Event Classification');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|local|store_specific');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `loyalty_exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Exclusive Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Campaign Owner Email');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `owner_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Owner Name');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `owner_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `owner_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `promo_campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `promo_campaign_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `target_customer_reach` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Reach');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `target_revenue` SET TAGS ('dbx_business_glossary_term' = 'Target Revenue');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `target_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `target_units_sold` SET TAGS ('dbx_business_glossary_term' = 'Target Units Sold');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ALTER COLUMN `vendor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Cluster Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `return_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `activation_trigger` SET TAGS ('dbx_business_glossary_term' = 'Activation Trigger');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `activation_trigger` SET TAGS ('dbx_value_regex' = 'manual|cart_threshold|login|geofence|time_based|event_based');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `channel_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Channel Eligibility');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `channel_eligibility` SET TAGS ('dbx_value_regex' = 'POS|ecommerce|mobile|BOPIS|ROPIS|all_channels');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `customer_segment_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Eligibility');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `customer_segment_eligibility` SET TAGS ('dbx_value_regex' = 'all_customers|loyalty_members|VIP|new_customers|targeted_segment');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `digital_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Delivery Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `discount_method` SET TAGS ('dbx_business_glossary_term' = 'Discount Method');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `discount_method` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|tiered|quantity_based');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `display_message` SET TAGS ('dbx_business_glossary_term' = 'Display Message');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `effective_end_time` SET TAGS ('dbx_business_glossary_term' = 'Effective End Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `effective_start_time` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `jurisdiction_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Restriction Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `maximum_redemption_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Per Customer');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `maximum_redemption_total` SET TAGS ('dbx_business_glossary_term' = 'Maximum Total Redemptions');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_business_glossary_term' = 'Offer Name');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `offer_priority` SET TAGS ('dbx_business_glossary_term' = 'Offer Priority');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|expired|cancelled');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'BOGO|percent_off|dollar_off|free_gift|bundle|threshold_discount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `personalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `product_eligibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Eligibility Scope');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `product_eligibility_scope` SET TAGS ('dbx_value_regex' = 'all_products|category|SKU_list|brand|excluded_products');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `restricted_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Restricted Jurisdictions');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `store_eligibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Store Eligibility Scope');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `store_eligibility_scope` SET TAGS ('dbx_value_regex' = 'all_stores|store_group|individual_store|excluded_stores');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `vendor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` SET TAGS ('dbx_subdomain' = 'offer_execution');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Campaign ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `barcode` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `coupon_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `coupon_status` SET TAGS ('dbx_business_glossary_term' = 'Coupon Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `coupon_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|redeemed');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `coupon_type` SET TAGS ('dbx_business_glossary_term' = 'Coupon Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `coupon_type` SET TAGS ('dbx_value_regex' = 'manufacturer|store|digital|paper|loyalty|vendor_funded');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `digital_distribution_quantity` SET TAGS ('dbx_business_glossary_term' = 'Digital Distribution Quantity');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `digital_wallet_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|bogo|free_shipping|tiered');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `eligible_channel` SET TAGS ('dbx_business_glossary_term' = 'Eligible Channel');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `eligible_channel` SET TAGS ('dbx_value_regex' = 'all_channels|pos|ecommerce|mobile_app|bopis');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `eligible_product_scope` SET TAGS ('dbx_business_glossary_term' = 'Eligible Product Scope');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `eligible_product_scope` SET TAGS ('dbx_value_regex' = 'all_products|category|brand|sku|basket');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `exclusion_list` SET TAGS ('dbx_business_glossary_term' = 'Exclusion List');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `face_value` SET TAGS ('dbx_business_glossary_term' = 'Face Value');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `issue_channel` SET TAGS ('dbx_business_glossary_term' = 'Issue Channel');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_value_regex' = 'retailer|manufacturer|vendor|third_party');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `maximum_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `print_quantity` SET TAGS ('dbx_business_glossary_term' = 'Print Quantity');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `redemption_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Customer');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `single_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Use Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `total_redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Limit');
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` SET TAGS ('dbx_subdomain' = 'offer_execution');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `circular_ad_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Advertisement ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Sku Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `promo_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Budget Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Calendar Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `circular_name` SET TAGS ('dbx_business_glossary_term' = 'Circular Name');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `circular_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `circular_number` SET TAGS ('dbx_business_glossary_term' = 'Circular Number');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `circular_type` SET TAGS ('dbx_business_glossary_term' = 'Circular Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `circular_type` SET TAGS ('dbx_value_regex' = 'weekly|seasonal|holiday|event|clearance|grand_opening');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `compliance_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `cover_image_url` SET TAGS ('dbx_business_glossary_term' = 'Cover Image URL');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `digital_impressions_target` SET TAGS ('dbx_business_glossary_term' = 'Digital Impressions Target');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'print|digital|email|mobile_app|social_media|in_store');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `edition_number` SET TAGS ('dbx_business_glossary_term' = 'Edition Number');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `is_vendor_funded` SET TAGS ('dbx_business_glossary_term' = 'Is Vendor Funded Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Circular Notes');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `pdf_file_url` SET TAGS ('dbx_business_glossary_term' = 'PDF File URL');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `print_quantity` SET TAGS ('dbx_business_glossary_term' = 'Print Quantity');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `production_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `production_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `production_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Currency Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `production_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `production_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|in_production|published|archived');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `theme` SET TAGS ('dbx_business_glossary_term' = 'Circular Theme');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `vendor_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funding Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ALTER COLUMN `vendor_funding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` SET TAGS ('dbx_subdomain' = 'offer_execution');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `rebate_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `promo_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Budget Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `vendor_promo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Promo Agreement Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `channel_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Channel Eligibility');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `channel_eligibility` SET TAGS ('dbx_value_regex' = 'all_channels|pos_only|ecommerce_only|mobile_app_only|omnichannel');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `customer_segment_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Eligibility');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `rebate_description` SET TAGS ('dbx_business_glossary_term' = 'Rebate Description');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `exclusion_product_list` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Product List');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `marketing_message` SET TAGS ('dbx_business_glossary_term' = 'Marketing Message');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `maximum_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Rebate Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `rebate_name` SET TAGS ('dbx_business_glossary_term' = 'Rebate Name');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `rebate_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|store_credit|digital_credit|prepaid_card|bank_transfer|instant_discount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `payment_processing_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Processing Days');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `qualifying_product_list` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Product List');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `rebate_number` SET TAGS ('dbx_business_glossary_term' = 'Rebate Number');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `rebate_number` SET TAGS ('dbx_value_regex' = '^RBT-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `rebate_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `rebate_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|expired|cancelled|completed');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `rebate_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `rebate_type` SET TAGS ('dbx_value_regex' = 'instant_rebate|mail_in_rebate|vendor_funded_rebate|digital_rebate|promotional_allowance|volume_rebate');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `redemption_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Customer');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `redemption_limit_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Transaction');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `requires_proof_of_purchase` SET TAGS ('dbx_business_glossary_term' = 'Requires Proof of Purchase');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `stackable_with_other_promotions` SET TAGS ('dbx_business_glossary_term' = 'Stackable With Other Promotions');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `submission_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ALTER COLUMN `vendor_funding_percentage` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funding Percentage');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` SET TAGS ('dbx_subdomain' = 'vendor_funding');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `vendor_promo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Promotional Agreement ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `promo_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Budget Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'purchase-based|sales-based|display-based|hybrid');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `ad_placement_required` SET TAGS ('dbx_business_glossary_term' = 'Advertisement Placement Required Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'co-op advertising|off-invoice allowance|bill-back|scan allowance|new item allowance|volume rebate');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `chargeback_eligible` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Eligible Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `chargeback_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Penalty Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `display_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Display Compliance Required Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `funding_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Currency Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `funding_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `funding_percentage` SET TAGS ('dbx_business_glossary_term' = 'Funding Percentage');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `qualifying_product_scope` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Product Scope');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `qualifying_product_scope` SET TAGS ('dbx_value_regex' = 'all products|specific SKU|product category|brand|private label');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'one-time|weekly|monthly|quarterly|annually|event-based');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_value_regex' = 'upfront credit|monthly accrual|quarterly settlement|post-event claim|scan-based settlement');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `total_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Accrued Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `total_settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Settled Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ALTER COLUMN `vendor_promo_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` SET TAGS ('dbx_subdomain' = 'vendor_funding');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `promo_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Redemption ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `rebate_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `vendor_promo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Promo Agreement Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|approved|rejected|paid');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage_off|fixed_amount_off|bogo|bundle_discount|threshold_discount|free_shipping');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `final_price` SET TAGS ('dbx_business_glossary_term' = 'Final Price');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Price');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `processing_system` SET TAGS ('dbx_business_glossary_term' = 'Processing System');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `processing_system` SET TAGS ('dbx_value_regex' = 'pos|ecommerce_engine|oms|loyalty_platform|promotion_engine');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `promotion_tier` SET TAGS ('dbx_business_glossary_term' = 'Promotion Tier');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `quantity_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Redeemed');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_value_regex' = 'pos|ecommerce_web|ecommerce_mobile|call_center|kiosk|mobile_app');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_limit_type` SET TAGS ('dbx_value_regex' = 'per_customer|per_transaction|per_day|per_campaign|unlimited');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Redemption Mechanism');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Redemption Sequence Number');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|duplicate|expired|limit_exceeded|fraud_suspected');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `stack_sequence` SET TAGS ('dbx_business_glossary_term' = 'Stack Sequence');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `validation_error_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `validation_error_message` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Message');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ALTER COLUMN `vendor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `promo_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Budget ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Calendar Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_required');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_value_regex' = '^PB-[0-9]{8}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `budget_owner_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `budget_owner_type` SET TAGS ('dbx_value_regex' = 'department|category|brand|channel|region|store_cluster');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'internal_marketing|vendor_coop|markdown_allowance|clearance_reserve|trade_promotion|digital_advertising');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `circular_ad_allocation` SET TAGS ('dbx_business_glossary_term' = 'Circular Advertisement Allocation');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `ecommerce_channel_allocation` SET TAGS ('dbx_business_glossary_term' = 'E-Commerce Channel Allocation');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|M(0[1-9]|1[0-2])|H[1-2]|FY)$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `mobile_channel_allocation` SET TAGS ('dbx_business_glossary_term' = 'Mobile Channel Allocation');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `mobile_channel_allocation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `mobile_channel_allocation` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `otb_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Open to Buy (OTB) Integration Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `pos_channel_allocation` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Channel Allocation');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^PC-[0-9]{6}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `remaining_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `variance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percent');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ALTER COLUMN `vendor_funded_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Calendar ID');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `applicable_banner_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Banner Codes');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `applicable_market_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Market Codes');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `banner_applicability` SET TAGS ('dbx_business_glossary_term' = 'Banner Applicability Scope');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `banner_applicability` SET TAGS ('dbx_value_regex' = 'enterprise_wide|banner_specific');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_business_glossary_term' = 'Blackout Period Reason');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Budget Amount');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability Scope');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_value_regex' = 'omnichannel|store_only|ecommerce_only|mobile_app_only');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `circular_production_deadline` SET TAGS ('dbx_business_glossary_term' = 'Circular Production Deadline');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `competitive_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Response Flag');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `competitive_trigger_description` SET TAGS ('dbx_business_glossary_term' = 'Competitive Trigger Description');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional Period End Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `expected_sales_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Expected Sales Lift Percentage');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `expected_traffic_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Expected Traffic Lift Percentage');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `fiscal_week` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `inventory_build_start_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Build Start Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `is_blackout_period` SET TAGS ('dbx_business_glossary_term' = 'Blackout Period Indicator');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `market_applicability` SET TAGS ('dbx_business_glossary_term' = 'Market Applicability Scope');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `market_applicability` SET TAGS ('dbx_value_regex' = 'national|regional|local');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Planning Notes');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Promotional Period Name');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `period_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Promotional Period Type');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'weekly_ad_cycle|seasonal_event|holiday|clearance_window|competitive_response|vendor_funded');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Lock Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Planning Owner Email Address');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Planning Owner Name');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_owner_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_status` SET TAGS ('dbx_business_glossary_term' = 'Planning Status');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `planning_status` SET TAGS ('dbx_value_regex' = 'draft|locked|active|archived');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Promotional Priority Tier');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1_strategic|tier_2_major|tier_3_standard|tier_4_tactical');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional Period Start Date');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `theme_description` SET TAGS ('dbx_business_glossary_term' = 'Promotional Theme Description');
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_calendar` ALTER COLUMN `vendor_negotiation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Vendor Negotiation Deadline');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` SET TAGS ('dbx_subdomain' = 'offer_execution');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` SET TAGS ('dbx_association_edges' = 'promotion.circular_ad,promotion.promo_offer');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` ALTER COLUMN `circular_ad_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Ad Placement - Circular Ad Placement Id');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` ALTER COLUMN `circular_ad_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Ad Placement - Circular Ad Id');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Ad Placement - Promo Offer Id');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` ALTER COLUMN `ad_copy_override` SET TAGS ('dbx_business_glossary_term' = 'Ad Copy Override');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` ALTER COLUMN `ad_placement_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement Position');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` ALTER COLUMN `display_priority` SET TAGS ('dbx_business_glossary_term' = 'Display Priority');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` ALTER COLUMN `feature_size` SET TAGS ('dbx_business_glossary_term' = 'Feature Size');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` ALTER COLUMN `page_number` SET TAGS ('dbx_business_glossary_term' = 'Circular Page Number');
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad_placement` ALTER COLUMN `vendor_funded_placement_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Placement Flag');
