-- Schema for Domain: marketplace | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`marketplace` COMMENT 'Owns the multi-sided marketplace platform connecting buyers and sellers. Manages marketplace catalog listings, C2C and B2C transaction facilitation, GMV reporting, buy-box eligibility rules, seller-buyer dispute resolution, sponsored listing management, and FTC-compliant advertising disclosure for the marketplace ecosystem.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` (
    `marketplace_listing_id` BIGINT COMMENT 'Unique system-generated identifier for the marketplace listing.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for Promotion ROI Report linking each listing to the marketing campaign that promoted it; marketers expect this direct association.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Sellers often designate a default carrier for their listings; needed for contract compliance and rate negotiations.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Required for listing‑catalog synchronization report that maps each marketplace listing to the internal catalog item for inventory and pricing alignment.',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: REQUIRED: Listing page needs primary product image; the primary_asset_id FK links to digital_asset for image rendering on marketplace listings.',
    `delivery_zone_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_zone. Business justification: Shipping SLA and cost calculations are based on the delivery zone assigned to each listing.',
    `item_id` BIGINT COMMENT 'Foreign key linking to content.content_item. Business justification: REQUIRED: Marketplace listing displays rich product description and SEO fields stored in content_item; FK enables content management system to supply listing copy.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Required for Listing Price Determination Report linking each listing to the price list used for pricing calculations, essential for audit and dynamic pricing.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Regulatory Compliance Report requires each listing to reference the regulation it must satisfy (e.g., safety, labeling). This is standard in e‑commerce product compliance.',
    `seller_profile_id` BIGINT COMMENT 'Unique identifier of the seller who owns this marketplace listing.',
    `seo_metadata_id` BIGINT COMMENT 'Foreign key linking to content.seo_metadata. Business justification: REQUIRED: Per‑listing SEO overrides (title, meta tags) are managed in seo_metadata; FK allows marketplace to apply SEO settings specific to each listing.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Needed for inventory and fulfillment tracking per SKU, enabling real‑time stock reconciliation between marketplace listings and internal SKU records.',
    `warehouse_node_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_node. Business justification: Assign fulfillment warehouse for merchant‑fulfilled (FBM) listings; used in fulfillment planning and inventory allocation reports.',
    `advertised` BOOLEAN COMMENT 'True when the listing includes FTC‑compliant advertising disclosures.',
    `buy_box_eligible` BOOLEAN COMMENT 'Indicates whether the listing qualifies for the marketplace buy‑box algorithm.',
    `category_path` STRING COMMENT 'Hierarchical category taxonomy path for the product (e.g., Electronics > Mobile Phones > Smartphones).',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of the sale price retained by the marketplace as commission.',
    `condition` STRING COMMENT 'Physical state of the item being sold.. Valid values are `new|used|refurbished`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the listing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the listing price currency.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the listing expires or is deactivated.',
    `featured` BOOLEAN COMMENT 'True if the seller has paid for promotional placement of the listing.',
    `ftc_ad_disclosure` BOOLEAN COMMENT 'True when the listing includes required FTC advertising disclosure statements.',
    `fulfillment_type` STRING COMMENT 'Method by which the product is delivered to the buyer.. Valid values are `fba|seller_fulfilled|dropship`',
    `height_cm` DECIMAL(18,2) COMMENT 'Physical height of the product for dimensional shipping.',
    `inventory_quantity` BIGINT COMMENT 'Number of units the seller has allocated to this marketplace listing.',
    `is_searchable` BOOLEAN COMMENT 'True if the listing is included in search and recommendation results.',
    `is_visible` BOOLEAN COMMENT 'Indicates whether the listing is visible to shoppers on the marketplace.',
    `length_cm` DECIMAL(18,2) COMMENT 'Physical length of the product for dimensional shipping.',
    `listing_source` STRING COMMENT 'Origin of the listing record (e.g., seller uploaded, system generated, bulk import).. Valid values are `seller_uploaded|system_generated|imported`',
    `listing_type` STRING COMMENT 'Business model of the listing (B2C, C2C, auction, or fixed‑price).. Valid values are `b2c|c2c|auction|fixed_price`',
    `marketplace_listing_description` STRING COMMENT 'Full textual description of the product, including features and specifications.',
    `marketplace_listing_status` STRING COMMENT 'Current operational state of the listing.. Valid values are `active|inactive|suspended|pending_review`',
    `price` DECIMAL(18,2) COMMENT 'Base monetary amount the buyer pays before taxes, fees, or discounts.',
    `rating_average` DECIMAL(18,2) COMMENT 'Mean rating score from buyer reviews (scale 1‑5).',
    `review_count` BIGINT COMMENT 'Total number of customer reviews submitted for the listing.',
    `shipping_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the product used for shipping calculations.',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the listing becomes active for purchase.',
    `stock_status` STRING COMMENT 'Current availability state of the inventory for this listing.. Valid values are `in_stock|out_of_stock|preorder|backorder`',
    `title` STRING COMMENT 'The headline or title of the product offering displayed to buyers.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the listing record.',
    `width_cm` DECIMAL(18,2) COMMENT 'Physical width of the product for dimensional shipping.',
    CONSTRAINT pk_marketplace_listing PRIMARY KEY(`marketplace_listing_id`)
) COMMENT 'Core master entity representing a sellers product offering on the marketplace platform. Captures the full lifecycle of a marketplace listing including listing status (active, inactive, suspended, pending review), listing type (B2C, C2C, auction, fixed-price), buy-box eligibility status, featured listing flag, listing creation and expiry dates, listing title, description, condition (new, used, refurbished), category path, brand, ASIN/UPC/EAN identifiers, seller SKU, marketplace-assigned listing ID, fulfillment type (FBA-style, seller-fulfilled, dropship), listing visibility flags, and FTC-compliant advertising disclosure indicators. SSOT for marketplace catalog listings distinct from the product domains master catalog.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` (
    `listing_offer_id` BIGINT COMMENT 'Unique identifier for the sellers offer on a marketplace listing.',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the product (SKU) that the offer is for.',
    `listing_category_id` BIGINT COMMENT 'FK to marketplace.listing_category',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Offers often belong to marketing campaigns (discounts, bundles); linking enables Offer‑Campaign performance dashboards.',
    `marketplace_listing_id` BIGINT COMMENT 'Identifier of the marketplace listing to which this offer belongs.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: Needed for Offer Price Audit to trace each offer back to the specific price list item that generated its price, supporting compliance and price change traceability.',
    `seller_profile_id` BIGINT COMMENT 'Unique identifier of the seller who submitted the offer.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Enables offer pricing and stock allocation per SKU, essential for dynamic pricing engine.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Offer availability must reflect allocated stock; linking offer to stock position enables quantity validation and replenishment triggers.',
    `buy_box_winner_flag` BOOLEAN COMMENT 'True if the offer is the current buy‑box winner for the listing.',
    `buyer_feedback_score` DECIMAL(18,2) COMMENT 'Aggregated rating given by buyers who purchased this specific offer.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of the offer price retained by the marketplace as commission.',
    `compliance_flag` BOOLEAN COMMENT 'True if the offer meets required FTC advertising disclosures.',
    `compliance_notes` STRING COMMENT 'Additional information regarding compliance status or special handling.',
    `condition` STRING COMMENT 'State of the product as described by the seller.. Valid values are `new|used|refurbished|open_box`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the offer record was first created in the system.',
    `currency_code` STRING COMMENT 'Currency in which the offer_price and related monetary fields are expressed.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `fulfillment_method` STRING COMMENT 'Logistics approach used to deliver the item to the buyer.. Valid values are `seller_fulfilled|platform_fulfilled|dropship`',
    `gift_wrap_price` DECIMAL(18,2) COMMENT 'Additional charge for gift‑wrap when selected by the buyer.',
    `handling_time_sla_days` STRING COMMENT 'Maximum number of days the seller commits to process the order before shipment.',
    `is_gift_wrap_available` BOOLEAN COMMENT 'True if the seller offers gift‑wrap service for this offer.',
    `is_prime_eligible` BOOLEAN COMMENT 'True if the offer qualifies for accelerated shipping benefits.',
    `is_returnable` BOOLEAN COMMENT 'True if the seller accepts returns for this offer.',
    `listing_offer_status` STRING COMMENT 'Operational state of the offer within its lifecycle.. Valid values are `active|inactive|expired|suppressed`',
    `marketplace_region` STRING COMMENT 'Regional market segment where the offer is displayed.. Valid values are `NA|EU|APAC|LATAM|MEA`',
    `net_price` DECIMAL(18,2) COMMENT 'Final amount the seller receives after deductions.',
    `offer_end_timestamp` TIMESTAMP COMMENT 'Date and time when the offer is no longer eligible for purchase.',
    `offer_price` DECIMAL(18,2) COMMENT 'Base price of the item as offered by the seller, expressed in the transaction currency.',
    `offer_rank` STRING COMMENT 'Ordinal position of the offer in the ranking algorithm (1 = highest).',
    `offer_source` STRING COMMENT 'Mechanism by which the offer was entered into the marketplace.. Valid values are `api|manual|bulk_upload`',
    `offer_start_timestamp` TIMESTAMP COMMENT 'Date and time when the offer starts being visible to buyers.',
    `price_effective_date` DATE COMMENT 'Calendar date from which the offer_price is valid.',
    `price_expiration_date` DATE COMMENT 'Calendar date after which the offer_price is no longer valid.',
    `price_type` STRING COMMENT 'Indicates whether the price is a regular list price, sale price, or discounted price.. Valid values are `list|sale|discounted`',
    `promotional_flag` BOOLEAN COMMENT 'True if the offer is tied to a marketplace promotion or discount campaign.',
    `quantity_available` STRING COMMENT 'Number of units the seller can fulfill under this offer.',
    `return_window_days` STRING COMMENT 'Timeframe within which a buyer may request a return.',
    `seller_fulfillment_sla_met` BOOLEAN COMMENT 'True if the seller consistently meets the handling time SLA for this offer.',
    `seller_rating` DECIMAL(18,2) COMMENT 'Aggregated rating score for the seller, on a 0‑5 scale.',
    `shipping_cost` DECIMAL(18,2) COMMENT 'Shipping fee associated with the offer, expressed in the transaction currency.',
    `shipping_estimate_days` STRING COMMENT 'Projected transit time from shipment to delivery.',
    `suppression_reason` STRING COMMENT 'Business or policy reason that caused the offer to be hidden from buyers.. Valid values are `out_of_stock|policy_violation|price_too_low|seller_suspended`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Applicable tax calculated on the offer price.',
    `total_price` DECIMAL(18,2) COMMENT 'Combined price of the item and shipping, representing the amount the buyer would pay.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the offer record.',
    CONSTRAINT pk_listing_offer PRIMARY KEY(`listing_offer_id`)
) COMMENT 'Represents a specific sellers price offer on a marketplace listing at a point in time. A single listing may have multiple competing offers from different sellers. Captures offer price, shipping cost, condition, seller fulfillment method, offer rank, buy-box winner flag, offer start and end dates, quantity available, handling time SLA, and offer suppression reason. Drives buy-box eligibility determination and competitive pricing intelligence on the marketplace.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` (
    `buy_box_rule_id` BIGINT COMMENT 'Unique identifier for the buy box rule definition.',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: Buy box rule determines eligibility for a specific marketplace listing; linking buy_box_rule to marketplace_listing captures this parent‑child relationship.',
    `seller_profile_id` BIGINT COMMENT 'Identifier of the seller currently holding the buy box under this rule.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Buy‑box eligibility rules are evaluated per SKU to determine winning offer based on price and seller metrics.',
    `buy_box_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|pending|retired`',
    `category_applicability` STRING COMMENT 'Comma‑separated list of product categories to which the rule applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the rule becomes effective.',
    `effective_until` DATE COMMENT 'Date when the rule expires or is superseded (null if open‑ended).',
    `eligibility_criteria` STRING COMMENT 'Logical expression or JSON defining seller and offer eligibility for the buy box.',
    `eligibility_score` DECIMAL(18,2) COMMENT 'Calculated score indicating how well the offer meets the rules eligibility criteria.',
    `max_wins_per_day` STRING COMMENT 'Upper limit on how many times a single seller can win the buy box for a given listing each day.',
    `price_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum price difference allowed for an offer to be considered for the buy box.',
    `price_threshold_currency` STRING COMMENT 'Currency code for the price threshold amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `rotation_fairness_enabled` BOOLEAN COMMENT 'Flag indicating whether rotation fairness logic is active for this rule.',
    `rotation_interval_minutes` STRING COMMENT 'Minimum time in minutes before the buy box can rotate to another eligible seller.',
    `rule_description` STRING COMMENT 'Detailed description of the rule purpose and logic.',
    `rule_name` STRING COMMENT 'Human‑readable name of the buy box rule.',
    `rule_type` STRING COMMENT 'Category of the rule defining its primary function.. Valid values are `eligibility|scoring|pricing|rotation|suppression`',
    `scoring_weights` STRING COMMENT 'JSON or delimited string representing weightings for each scoring factor (e.g., price, rating, fulfillment speed).',
    `seller_rating_at_win` DECIMAL(18,2) COMMENT 'Seller rating (0‑5) captured at the moment the buy box was awarded.',
    `suppression_reason` STRING COMMENT 'Free‑text explanation why the rule suppressed a buy box assignment.',
    `suppression_trigger` STRING COMMENT 'Condition that suppresses the rule from assigning a buy box.. Valid values are `out_of_stock|low_rating|policy_violation|seller_suspended|price_mismatch`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule.',
    `winning_fulfillment_method` STRING COMMENT 'Fulfillment method associated with the winning offer.. Valid values are `ship_from_warehouse|drop_ship|store_pickup|digital`',
    `winning_offer_price` DECIMAL(18,2) COMMENT 'Price of the offer that currently holds the buy box.',
    CONSTRAINT pk_buy_box_rule PRIMARY KEY(`buy_box_rule_id`)
) COMMENT 'Master and transactional entity managing the complete buy-box lifecycle on the marketplace. Owns business rule definitions (eligibility criteria, scoring weights, pricing thresholds, category applicability, suppression triggers, rotation fairness parameters) and the full transactional event history of buy-box ownership changes (winner/loser tracking per listing per timestamp, ownership duration, rotation timestamps, winning offer price and fulfillment method, seller rating at time of win, eligibility score, suppression reason). Provides the authoritative single source of truth for buy-box assignment logic, ownership event audit trail, rotation fairness auditing, seller competitive intelligence, and GMV optimization reporting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` (
    `marketplace_transaction_id` BIGINT COMMENT 'Unique identifier for the marketplace transaction. Primary key for the marketplace transaction entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Carrier performance & cost allocation report requires linking each transaction to the carrier that shipped it.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Exact carrier service used per transaction is needed for service‑level compliance and buyer ETA guarantees.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Supports sales analytics that aggregate revenue by catalog item independent of SKU variations.',
    `commission_schedule_id` BIGINT COMMENT 'Foreign key linking to marketplace.commission_schedule. Business justification: Marketplace transactions need to reference the commission schedule that defines their commission rates; adds commission_schedule_id FK to marketplace_transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed for internal cost allocation reports that assign transaction processing costs to specific cost centers.',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Required for order fulfillment shipping address, used in delivery performance reports and compliance with shipping regulations.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who purchased the item through the marketplace platform.',
    `center_id` BIGINT COMMENT 'Identifier of the fulfillment center responsible for shipping the item, if applicable for marketplace-fulfilled transactions.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Required for the daily accounting posting process that creates a journal entry for each marketplace transaction.',
    `listing_offer_id` BIGINT COMMENT 'Reference to the specific seller offer accepted by the buyer for this transaction.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Regulated/lot‑tracked products require linking transaction to lot for traceability, recall, and compliance reporting.',
    `marketplace_listing_id` BIGINT COMMENT 'Reference to the marketplace catalog listing that was purchased in this transaction.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Transaction audit requires linking each transaction to the compliance obligation it satisfies (anti‑fraud, consumer rights), supporting the Transaction Compliance Dashboard.',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.payment_method. Business justification: REQUIRED: Capturing the stored payment method used for each transaction supports PCI compliance, analytics, and dispute handling.',
    `payment_transaction_id` BIGINT COMMENT 'External transaction identifier from the payment gateway or payment processor for reconciliation and dispute resolution.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Required for Transaction Pricing Source Report to identify which price list was applied to calculate transaction totals, used in finance reconciliation.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: Enables Detailed Pricing Attribution linking each transaction to the exact price list item (SKU, tier) used, needed for margin analysis.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Supports profit‑center profitability reporting by linking each transaction to the responsible profit center.',
    `route_id` BIGINT COMMENT 'Foreign key linking to logistics.route. Business justification: Route optimization and cost analysis reports tie each transaction to the logistical route it traversed.',
    `seller_settlement_id` BIGINT COMMENT 'Foreign key linking to marketplace.seller_settlement. Business justification: Each transaction is settled in a seller settlement period; adding seller_settlement_id to marketplace_transaction records which settlement the transaction belongs to.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Allows transaction‑level reconciliation to internal SKU for accurate inventory deduction and financial reporting.',
    `campaign_id` BIGINT COMMENT 'Identifier of the sponsored advertising campaign if this transaction resulted from a sponsored listing.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Link sales transaction to stock position for real‑time inventory deduction and on‑hand stock reporting.',
    `buy_box_winner_flag` BOOLEAN COMMENT 'Indicates whether this seller won the buy box for this listing at the time of transaction, affecting marketplace visibility and conversion.',
    `buyer_ip_address` STRING COMMENT 'IP address of the buyer at the time of transaction, used for fraud detection and geographic analysis.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate the marketplace commission. Expressed as a percentage (e.g., 15.00 for 15%).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this marketplace transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_opened_timestamp` TIMESTAMP COMMENT 'Date and time when a dispute was opened for this transaction, if applicable.',
    `dispute_resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the dispute was resolved, if applicable.',
    `dispute_status` STRING COMMENT 'Current status of any buyer-seller dispute associated with this transaction.. Valid values are `none|open|under_review|resolved_buyer_favor|resolved_seller_favor|escalated`',
    `fraud_review_status` STRING COMMENT 'Status of fraud review process for this transaction.. Valid values are `not_reviewed|passed|flagged|under_review|approved|rejected`',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score assigned by fraud detection system indicating the likelihood of fraudulent activity (0-100 scale).',
    `fulfillment_type` STRING COMMENT 'Method by which the purchased item will be fulfilled and delivered to the buyer.. Valid values are `seller_fulfilled|marketplace_fulfilled|dropship|digital_delivery|local_pickup`',
    `gmv_amount` DECIMAL(18,2) COMMENT 'Total transaction amount representing the gross merchandise value before any marketplace fees or commissions. This is the total amount the buyer paid for the item(s).',
    `is_sponsored_listing` BOOLEAN COMMENT 'Flag indicating whether this transaction resulted from a sponsored (paid advertising) listing, requiring FTC-compliant advertising disclosure.',
    `item_subtotal_amount` DECIMAL(18,2) COMMENT 'Subtotal amount for the item(s) purchased, excluding shipping, taxes, and other fees.',
    `marketplace_commission_amount` DECIMAL(18,2) COMMENT 'Commission amount earned by the marketplace platform on this transaction. This is the marketplace revenue from facilitating the transaction.',
    `payment_channel` STRING COMMENT 'Digital channel or interface through which the buyer completed the payment.. Valid values are `web|mobile_app|mobile_web|api|marketplace_app`',
    `product_category` STRING COMMENT 'Primary product category classification for the item sold in this transaction, used for GMV reporting by category.',
    `quantity` STRING COMMENT 'Number of units of the item purchased in this transaction.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded to the buyer if the transaction was fully or partially refunded.',
    `refund_reason_code` STRING COMMENT 'Standardized code indicating the reason for the refund, used for return analytics and seller performance monitoring.. Valid values are `buyer_remorse|item_not_received|item_not_as_described|defective|damaged_in_transit|seller_cancelled`',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was processed, if applicable.',
    `rma_number` STRING COMMENT 'Return Merchandise Authorization number issued for product returns associated with this transaction.',
    `seller_payout_amount` DECIMAL(18,2) COMMENT 'Net amount to be paid to the seller after deducting marketplace commission and any other fees from the transaction amount.',
    `shipping_amount` DECIMAL(18,2) COMMENT 'Shipping and handling charges paid by the buyer for this transaction.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount collected on this transaction, including sales tax, VAT, or other applicable taxes.',
    `transaction_number` STRING COMMENT 'Externally visible unique transaction number for customer and seller reference. Format: MKT-XXXXXXXXXX.. Valid values are `^MKT-[0-9]{10}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the marketplace transaction indicating its processing state and outcome.. Valid values are `pending|completed|cancelled|disputed|refunded|partially_refunded`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the marketplace transaction was completed and recorded. Primary business event timestamp for GMV (Gross Merchandise Value) reporting.',
    `transaction_type` STRING COMMENT 'Classification of the marketplace transaction model: B2C (Business to Consumer), C2C (Consumer to Consumer), or B2B (Business to Business).. Valid values are `B2C|C2C|B2B`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this marketplace transaction record was last modified.',
    CONSTRAINT pk_marketplace_transaction PRIMARY KEY(`marketplace_transaction_id`)
) COMMENT 'Core transactional record capturing each completed C2C or B2C transaction facilitated through the marketplace platform. Records transaction date and time, buyer and seller identifiers, listing and offer references, transaction amount (GMV contribution), marketplace commission amount, commission rate, payment method, transaction currency, transaction status (pending, completed, cancelled, disputed, refunded), fulfillment type, and applicable tax amounts. SSOT for GMV reporting and marketplace revenue recognition distinct from the order domains OMS records.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` (
    `commission_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the commission schedule record.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Commission schedules are applied per product category; a FK ensures accurate fee calculation and compliance reporting.',
    `base_commission_rate_pct` DECIMAL(18,2) COMMENT 'Standard commission percentage applied before any variable adjustments.',
    `cap_type` STRING COMMENT 'Method used to cap commission (none, fixed amount, or percentage).. Valid values are `none|amount|percentage`',
    `cap_value` DECIMAL(18,2) COMMENT 'Numeric value of the commission cap, interpreted according to cap_type.',
    `commission_schedule_description` STRING COMMENT 'Free‑form description providing additional context about the schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code in which commission amounts are expressed.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the commission schedule expires; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the commission schedule becomes effective.',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine which transactions qualify for this schedule.',
    `fulfillment_type` STRING COMMENT 'Method by which the order is fulfilled, influencing commission calculations.. Valid values are `fulfillment_by_seller|fulfillment_by_platform|dropship`',
    `is_exclusive` BOOLEAN COMMENT 'True if the schedule is exclusive to the specified seller tier/category combination.',
    `max_commission_amount` DECIMAL(18,2) COMMENT 'Ceiling amount for commission; calculated commission will not exceed this value.',
    `min_commission_amount` DECIMAL(18,2) COMMENT 'Floor amount for commission; if calculated commission falls below this, the minimum is applied.',
    `promotional_period_flag` BOOLEAN COMMENT 'Indicates whether the schedule is tied to a promotional period.',
    `region_code` STRING COMMENT 'Two‑letter country code indicating the geographic region the schedule applies to.. Valid values are `^[A-Z]{2}$`',
    `schedule_name` STRING COMMENT 'Human‑readable name of the commission schedule used for reporting and UI display.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.. Valid values are `active|inactive|deprecated|pending`',
    `seller_tier_code` STRING COMMENT 'Code representing the seller tier (e.g., bronze, silver, gold) to which the schedule applies.',
    `updated_by` STRING COMMENT 'Identifier of the internal user or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `variable_fee_structure` STRING COMMENT 'Textual definition of any variable fee components (e.g., tier‑based bonuses, volume discounts).',
    `version_number` STRING COMMENT 'Incremental version number for change management and audit.',
    `created_by` STRING COMMENT 'Identifier of the internal user or system that created the schedule.',
    CONSTRAINT pk_commission_schedule PRIMARY KEY(`commission_schedule_id`)
) COMMENT 'Reference master defining the commission rate structures applied to marketplace transactions by seller tier, product category, fulfillment type, and promotional period. Captures commission schedule name, applicable seller tier, product category path, base commission rate percentage, variable fee structure, minimum and maximum fee caps, effective date range, currency, and schedule status. Drives automated commission calculation on marketplace transactions and seller settlement processing.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` (
    `seller_settlement_id` BIGINT COMMENT 'Unique system-generated identifier for the seller settlement record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost‑center allocation is required for internal reporting of settlement processing expenses.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Settlement payouts are recorded in the general ledger via a journal entry for each seller settlement.',
    `seller_profile_id` BIGINT COMMENT 'Identifier of the marketplace seller receiving the settlement.',
    `bank_transfer_reference` STRING COMMENT 'Reference identifier provided by the banking institution for the settlement transfer.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the settlement amounts.',
    `disbursement_status` STRING COMMENT 'Current processing state of the settlement payment.. Valid values are `pending|processing|disbursed|on_hold`',
    `fee_adjustments_amount` DECIMAL(18,2) COMMENT 'Additional fee adjustments (e.g., chargebacks, penalties) applied to the settlement.',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'Total sales revenue generated by the seller during the settlement period before any deductions.',
    `net_disbursement_amount` DECIMAL(18,2) COMMENT 'Final amount transferred to the seller after all deductions and credits.',
    `payment_channel` STRING COMMENT 'Interface through which the settlement payment was initiated.. Valid values are `SellerPortal|API|Batch`',
    `payment_method` STRING COMMENT 'Method used to transfer the settlement funds to the seller.. Valid values are `ACH|Wire|PayPal|Other`',
    `promotional_credits_amount` DECIMAL(18,2) COMMENT 'Credits applied to the seller for promotional funding or marketing incentives.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the settlement record was first captured in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement record.',
    `refund_deductions_amount` DECIMAL(18,2) COMMENT 'Total amount subtracted for buyer refunds processed during the period.',
    `settlement_cycle` STRING COMMENT 'Frequency of the settlement period such as weekly, monthly, or quarterly.',
    `settlement_end_date` DATE COMMENT 'Last calendar date of the settlement period.',
    `settlement_generated_timestamp` TIMESTAMP COMMENT 'Exact time when the settlement record was created by the system.',
    `settlement_notes` STRING COMMENT 'Free‑form text for any additional information or remarks about the settlement.',
    `settlement_number` STRING COMMENT 'Business identifier for the settlement, often used in finance and reporting.',
    `settlement_start_date` DATE COMMENT 'First calendar date of the settlement period.',
    `settlement_type` STRING COMMENT 'Indicates whether the settlement is periodic (e.g., weekly) or ad‑hoc.',
    `tax_withheld_amount` DECIMAL(18,2) COMMENT 'Amount of tax withheld from the sellers payout as required by jurisdictional regulations.',
    `total_commission_amount` DECIMAL(18,2) COMMENT 'Sum of marketplace commissions deducted from the sellers gross sales.',
    CONSTRAINT pk_seller_settlement PRIMARY KEY(`seller_settlement_id`)
) COMMENT 'Transactional record capturing the periodic financial settlement disbursed to marketplace sellers. Tracks settlement period start and end dates, seller identifier, gross sales amount, total commissions deducted, refund deductions, promotional funding credits, net disbursement amount, settlement currency, disbursement status (pending, processing, disbursed, on-hold), bank transfer reference, and settlement generation timestamp. Supports seller financial reconciliation and SOX-compliant revenue reporting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`dispute` (
    `dispute_id` BIGINT COMMENT 'System-generated unique identifier for the dispute record.',
    `agent_id` BIGINT COMMENT 'Identifier of the marketplace agent responsible for handling the dispute.',
    `customer_profile_id` BIGINT COMMENT 'Unique identifier of the buyer who initiated or is involved in the dispute.',
    `header_id` BIGINT COMMENT 'Identifier of the order that is the subject of the dispute.',
    `marketplace_transaction_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_transaction. Business justification: A dispute is always about a specific marketplace transaction; linking dispute to marketplace_transaction provides the necessary reference.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Dispute handling follows defined compliance obligations (e.g., GDPR, consumer rights); linking enables the Dispute Compliance Traceability report.',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the product involved in the dispute.',
    `service_support_case_id` BIGINT COMMENT 'Foreign key linking to service.service_support_case. Business justification: Dispute resolution creates a support case; the link ties dispute records to the corresponding case for end‑to‑end tracking.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was closed in the system.',
    `communication_channel` STRING COMMENT 'Preferred channel used for communications related to the dispute.. Valid values are `email|phone|in_app|chat`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.. Valid values are `USD|EUR|GBP|JPY|CNY|AUD`',
    `dispute_source` STRING COMMENT 'Origin of the dispute creation.. Valid values are `buyer_initiated|seller_initiated|system_generated`',
    `dispute_status` STRING COMMENT 'Current processing state of the dispute.. Valid values are `open|in_review|escalated|resolved|closed|rejected`',
    `dispute_type` STRING COMMENT 'Category of the dispute indicating the underlying issue.. Valid values are `item_not_received|item_not_as_described|unauthorized_transaction|return_dispute|listing_policy_violation`',
    `enforcement_action` STRING COMMENT 'Any punitive action taken against the offending party.. Valid values are `warning|account_suspension|ban|none`',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the dispute was escalated to a senior team or external authority.',
    `evidence_count` STRING COMMENT 'Number of evidence items (photos, documents, messages) attached to the dispute.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any fees, penalties, or processing charges applied to the dispute.',
    `filed_timestamp` TIMESTAMP COMMENT 'Exact date and time when the dispute was initially filed by the initiating party.',
    `ftc_disclosure_required` BOOLEAN COMMENT 'Indicates whether FTC consumer‑protection disclosure is required for this dispute.',
    `gdpr_data_subject_consent` BOOLEAN COMMENT 'Flag indicating that the data subject (buyer/seller) has consented to processing of personal data for this dispute.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total monetary value claimed in the dispute before any adjustments.',
    `is_duplicate_dispute` BOOLEAN COMMENT 'True if this dispute is identified as a duplicate of an existing case.',
    `is_fraud_flag` BOOLEAN COMMENT 'Indicates whether the dispute is suspected to involve fraudulent activity.',
    `last_event_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status change or activity on the dispute.',
    `marketplace_fee_amount` DECIMAL(18,2) COMMENT 'Fee retained by the marketplace platform for handling the transaction.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final monetary amount after fees, representing the amount to be refunded or credited.',
    `notes` STRING COMMENT 'Free‑form text capturing additional details, comments, or observations about the dispute.',
    `priority` STRING COMMENT 'Priority level assigned to the dispute for handling urgency.. Valid values are `low|medium|high|critical`',
    `reason_code` STRING COMMENT 'Internal code representing the specific reason for the dispute.',
    `reference_number` STRING COMMENT 'External reference number assigned to the dispute for tracking and communication with parties.',
    `resolution_outcome` STRING COMMENT 'Result of the dispute after investigation.. Valid values are `refund|replacement|store_credit|partial_refund|none`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the dispute was formally resolved.',
    `sla_achieved_hours` STRING COMMENT 'Actual time taken (in hours) to resolve the dispute.',
    `sla_compliance` BOOLEAN COMMENT 'True if the dispute was resolved within the SLA target.',
    `sla_target_hours` STRING COMMENT 'Service level agreement target duration (in hours) for dispute resolution.',
    `total_refund_amount` DECIMAL(18,2) COMMENT 'Aggregate amount refunded to the buyer as a result of the dispute.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the dispute record.',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Master entity managing the full lifecycle of seller-buyer dispute cases on the marketplace platform, including granular event audit trail. Captures dispute details (reference number, type, initiating party, status, resolution outcome, enforcement actions) and all lifecycle events (status changes with timestamps, evidence submissions, escalations, agent assignments, decisions, appeals, communications). Supports dispute types including item-not-received, item-not-as-described, unauthorized transactions, return disputes, and listing policy violations. Each event records actor type (buyer, seller, marketplace agent, automated system), event notes, attached evidence references, and resulting status. Provides complete audit trail for FTC consumer protection compliance, RMA workflows, SLA tracking, and regulatory reporting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` (
    `sponsored_listing_id` BIGINT COMMENT 'Unique surrogate key for the sponsored listing record.',
    `ad_group_id` BIGINT COMMENT 'Identifier of the ad group within the campaign that contains this sponsored listing.',
    `campaign_id` BIGINT COMMENT 'External identifier of the advertising campaign that owns this sponsored listing.',
    `marketplace_listing_id` BIGINT COMMENT 'Identifier of the underlying product listing that is being sponsored.',
    `seller_profile_id` BIGINT COMMENT 'Unique identifier of the seller who purchased the sponsored placement.',
    `ad_performance_clicks` BIGINT COMMENT 'Cumulative number of clicks received by the sponsored ad.',
    `ad_performance_impressions` BIGINT COMMENT 'Cumulative number of times the sponsored ad was shown.',
    `ad_performance_spend` DECIMAL(18,2) COMMENT 'Total amount spent on the sponsored listing to date.',
    `ad_placement_type` STRING COMMENT 'Type of sponsored ad placement (product, brand, or display).. Valid values are `sponsored_product|sponsored_brand|sponsored_display`',
    `bid_amount` DECIMAL(18,2) COMMENT 'Maximum amount the seller is willing to pay per click or impression, expressed in the campaign currency.',
    `bid_strategy` STRING COMMENT 'Strategy used to set bids: manual (seller‑defined) or automatic (platform‑optimized).. Valid values are `manual|auto`',
    `campaign_end_date` DATE COMMENT 'Date when the sponsored listing stops serving (inclusive).',
    `campaign_start_date` DATE COMMENT 'Date when the sponsored listing becomes eligible to serve.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sponsored listing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for bid and budget amounts.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `daily_budget_cap` DECIMAL(18,2) COMMENT 'Maximum total spend allowed for the sponsored listing each day.',
    `disclosure_label_text` STRING COMMENT 'Text displayed to satisfy FTC advertising disclosure requirements.',
    `ftc_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the required FTC advertising disclosure is attached to the listing.',
    `impression_share` DECIMAL(18,2) COMMENT 'Percentage of eligible impressions captured by this sponsored listing.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the status field last transitioned.',
    `sponsored_listing_status` STRING COMMENT 'Current lifecycle status of the sponsored listing.. Valid values are `active|paused|ended|rejected`',
    `target_value` DECIMAL(18,2) COMMENT 'The specific keyword, category identifier, or ASIN value used for targeting.',
    `targeting_type` STRING COMMENT 'Mechanism used to target the ad (keyword, product category, or specific ASIN).. Valid values are `keyword|category|asin`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sponsored listing record.',
    CONSTRAINT pk_sponsored_listing PRIMARY KEY(`sponsored_listing_id`)
) COMMENT 'Master entity representing a paid sponsored listing placement on the marketplace. Captures sponsorship campaign reference, listing identifier, seller identifier, ad placement type (sponsored product, sponsored brand, sponsored display), bid amount, daily budget cap, campaign start and end dates, targeting type (keyword, category, ASIN), ad status (active, paused, ended, rejected), FTC advertising disclosure flag, disclosure label text, and impression share. Supports SEM/PPC campaign management and FTC-compliant advertising disclosure enforcement.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`ad_event` (
    `ad_event_id` BIGINT COMMENT 'Primary key for ad_event',
    `campaign_id` BIGINT COMMENT 'Identifier of the advertising campaign to which the event belongs.',
    `ad_placement_id` BIGINT COMMENT 'Unique identifier for the specific ad placement instance.',
    `header_id` BIGINT COMMENT 'Reference to the order that resulted from the ad conversion, if any.',
    `sponsored_listing_id` BIGINT COMMENT 'Reference to the sponsored product listing that generated the ad event.',
    `ad_bid_amount` DECIMAL(18,2) COMMENT 'The bid price submitted for the ad placement.',
    `ad_bid_currency` STRING COMMENT 'ISO 4217 currency code for the bid amount. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CAD|AUD|... — promote to reference product]',
    `ad_click_timestamp` TIMESTAMP COMMENT 'Timestamp of the click event (populated when event_type = click).',
    `ad_conversion_timestamp` TIMESTAMP COMMENT 'Timestamp of the conversion event (populated when event_type = conversion).',
    `ad_cost_model` STRING COMMENT 'Billing model for the ad: cost per mille (CPM) or cost per click (CPC).. Valid values are `cpm|cpc`',
    `ad_impression_code` BIGINT COMMENT 'Unique identifier for the impression event (if event_type is impression).',
    `ad_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue credited to the seller for the ad interaction (e.g., commission).',
    `ad_revenue_currency` STRING COMMENT 'ISO 4217 currency code for the ad revenue amount. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CAD|AUD|... — promote to reference product]',
    `ad_status` STRING COMMENT 'Current lifecycle status of the ad event record.. Valid values are `active|inactive|paused|completed`',
    `attribution_window_seconds` STRING COMMENT 'Configured time window used to attribute conversions to clicks.',
    `buyer_session_code` BIGINT COMMENT 'Identifier of the buyers browsing session associated with the ad event.',
    `click_to_conversion_seconds` STRING COMMENT 'Elapsed seconds between the click event and the resulting conversion, if applicable.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost incurred for the ad event based on the billing model (CPC or CPM).',
    `cost_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the ad cost amount. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CAD|AUD|... — promote to reference product]',
    `device_type` STRING COMMENT 'Device category used by the buyer during the ad interaction.. Valid values are `desktop|mobile|tablet`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date and time when the ad event occurred.',
    `event_type` STRING COMMENT 'Type of ad interaction: impression, click, or conversion.. Valid values are `impression|click|conversion`',
    `ftc_disclosure_rendered` BOOLEAN COMMENT 'Indicates whether the required FTC advertising disclosure was displayed to the buyer.',
    `page_type` STRING COMMENT 'Page context of the ad event: product detail page, product listing page, search results, or homepage.. Valid values are `pdp|plp|search_results|homepage`',
    `placement_position` STRING COMMENT 'Logical placement identifier (e.g., top, sidebar, below_fold) where the ad was shown.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the ad event record was first inserted into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ad event record.',
    `viewability_flag` BOOLEAN COMMENT 'True if the ad met viewability standards (e.g., 50% of pixels in view for 1 second).',
    `viewability_percentage` DECIMAL(18,2) COMMENT 'Measured percentage of the ad that was in view during the impression.',
    CONSTRAINT pk_ad_event PRIMARY KEY(`ad_event_id`)
) COMMENT 'Transactional record capturing all advertising interaction events for sponsored listings on the marketplace, serving as the single source of truth for the complete ad interaction funnel. Records event type (impression, click, conversion), timestamp, sponsored listing reference, placement position, page type (PDP, PLP, search results, homepage), device type, buyer session reference, cost amount (CPM/CPC basis), FTC disclosure rendering status, viewability metrics, click-to-conversion attribution, and conversion order reference. Enables comprehensive ROAS calculation, CTR/CVR analysis, CPC/CPM billing to sellers, impression-level cost tracking, and advertising performance measurement across the full interaction funnel.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`listing_category` (
    `listing_category_id` BIGINT COMMENT 'Unique identifier for the marketplace listing category.',
    `parent_category_listing_category_id` BIGINT COMMENT 'Reference to the immediate parent category in the hierarchy.',
    `buy_box_eligible` BOOLEAN COMMENT 'True if listings in this category are eligible for buy‑box placement.',
    `category_image_url` STRING COMMENT 'Link to the representative image for the category.',
    `category_path` STRING COMMENT 'Full hierarchical path (e.g., "Electronics > Computers > Laptops").',
    `commission_rate` DECIMAL(18,2) COMMENT 'Default commission percentage applied to sales in this category (e.g., 0.1500 = 15%).',
    `cpsc_compliance_required` BOOLEAN COMMENT 'Indicates if the category must meet Consumer Product Safety Commission requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the category record was first created in the system.',
    `depth_level` STRING COMMENT 'Integer indicating the level of the category in the hierarchy (root = 0).',
    `display_order` STRING COMMENT 'Integer used to order categories in UI displays.',
    `effective_from` DATE COMMENT 'Date when the category becomes active for listings.',
    `effective_until` DATE COMMENT 'Date when the category is retired or no longer usable (nullable).',
    `external_reference_code` STRING COMMENT 'Identifier used by external catalog or ERP systems.',
    `is_age_restricted` BOOLEAN COMMENT 'True if the category contains age‑sensitive products (e.g., alcohol, tobacco).',
    `is_hazmat` BOOLEAN COMMENT 'True if the category includes hazardous or regulated items.',
    `is_restricted` BOOLEAN COMMENT 'Indicates whether the category is restricted by policy or regulation.',
    `is_searchable` BOOLEAN COMMENT 'True if the category is included in search index.',
    `is_sponsored_allowed` BOOLEAN COMMENT 'True if sellers may purchase sponsored placements within this category.',
    `is_visible` BOOLEAN COMMENT 'True if the category is visible to buyers in the marketplace.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the category was last reviewed for compliance or relevance.',
    `listing_category_code` STRING COMMENT 'Business identifier code for the category (e.g., internal SKU‑style code).',
    `listing_category_description` STRING COMMENT 'Full textual description of the category purpose and scope.',
    `listing_category_name` STRING COMMENT 'Human‑readable name of the category used in UI and reports.',
    `listing_category_status` STRING COMMENT 'Current lifecycle status of the category.. Valid values are `active|inactive|archived|pending|deprecated|draft`',
    `promotional_eligible` BOOLEAN COMMENT 'Indicates whether the category can participate in platform promotions or discounts.',
    `review_status` STRING COMMENT 'Current status of the most recent compliance or content review.. Valid values are `pending|approved|rejected|under_review|escalated|closed`',
    `seo_friendly_name` STRING COMMENT 'Optimized name for search‑engine visibility.',
    `tax_exempt_category` BOOLEAN COMMENT 'True if sales in this category are exempt from sales tax.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the category record.',
    CONSTRAINT pk_listing_category PRIMARY KEY(`listing_category_id`)
) COMMENT 'Reference hierarchy defining the marketplace-specific product category taxonomy used for listing classification, commission schedule mapping, buy-box rule application, and search relevance. Captures category node identifier, category name, parent category reference (supporting multi-level hierarchy), category path string, category depth level, applicable commission rate reference, restricted category flag, age-restricted flag, hazmat flag, category status, and CPSC compliance requirement indicator. Distinct from the product domains catalog taxonomy as it governs marketplace-specific rules.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`listing_review` (
    `listing_review_id` BIGINT COMMENT 'Unique identifier for the review record.',
    `customer_profile_id` BIGINT COMMENT 'Anonymized identifier of the customer who submitted the review.',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: Listing reviews should be directly linked to the listing they review for easier joins; adds listing_id FK to listing_review.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Links customer reviews to the specific SKU, allowing quality monitoring and product‑specific sentiment analysis.',
    `compliance_ccpa_opt_out` BOOLEAN COMMENT 'True if the buyer exercised a CCPA opt‑out for data processing.',
    `compliance_gdpr_consent` BOOLEAN COMMENT 'Indicates whether GDPR consent was recorded for this review.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the buyers country at review time.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'Type of device used to submit the review.. Valid values are `mobile|desktop|tablet|other`',
    `edit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent edit to the review content.',
    `helpful_vote_count` STRING COMMENT 'Number of times other buyers marked the review as helpful.',
    `ip_address` STRING COMMENT 'IP address of the client at review submission (used for fraud detection).',
    `is_spam_flag` BOOLEAN COMMENT 'True if the review was automatically flagged as potential spam.',
    `language_code` STRING COMMENT 'ISO 639‑1 two‑letter code of the language used in the review.. Valid values are `^[a-z]{2}$`',
    `listing_review_status` STRING COMMENT 'Overall lifecycle status of the review record.. Valid values are `active|removed|archived`',
    `media_attachment_flag` BOOLEAN COMMENT 'True if the review includes photos, videos, or other media.',
    `moderation_status` STRING COMMENT 'Current moderation state of the review.. Valid values are `pending|approved|rejected|under_review`',
    `moderation_timestamp` TIMESTAMP COMMENT 'Date and time when the moderation decision was recorded.',
    `rating` STRING COMMENT 'Numeric rating provided by the buyer (e.g., 1‑5 stars).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the review record.',
    `removal_reason` STRING COMMENT 'Reason why a review was removed or hidden.. Valid values are `spam|offensive|policy_violation|buyer_request|other`',
    `review_text` STRING COMMENT 'Full textual feedback submitted by the buyer.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the buyer submitted the review.',
    `review_title` STRING COMMENT 'Optional short title summarizing the review.',
    `review_version` STRING COMMENT 'Incremental version number for edited reviews.',
    `seller_response_text` STRING COMMENT 'Optional textual response from the seller to the review.',
    `seller_response_timestamp` TIMESTAMP COMMENT 'Date and time when the seller posted a response.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Numeric sentiment value (e.g., -1.00 to 1.00) derived from review text.',
    `solicitation_source` STRING COMMENT 'Channel that prompted the buyer to leave a review.. Valid values are `post_purchase_email|in_app_prompt|order_confirmation|other`',
    `source_channel` STRING COMMENT 'Technical channel through which the review was submitted.. Valid values are `web|mobile_app|api`',
    `target_reference` BIGINT COMMENT 'Identifier of the reviewed entity (listing ID or seller ID).',
    `target_type` STRING COMMENT 'Indicates whether the review is for a product listing or a seller.. Valid values are `listing|seller`',
    `user_agent` STRING COMMENT 'Browser or app user‑agent string captured at submission.',
    `verified_purchase` BOOLEAN COMMENT 'True if the review is linked to a verified purchase.',
    CONSTRAINT pk_listing_review PRIMARY KEY(`listing_review_id`)
) COMMENT 'Transactional record capturing all buyer-submitted reviews, ratings, and feedback on the marketplace platform. Supports product-level reviews (star rating, review text, verified purchase flag, media attachments) and seller-level feedback (delivery speed, item accuracy, communication ratings) via a target_type discriminator. Records submission timestamp, target type (listing or seller), target identifier, buyer identifier (anonymized per GDPR/CCPA), rating scores, review/feedback text, moderation status, helpful vote count, seller response, solicitation source, and removal reason if applicable. Drives BSR calculation, listing quality scoring, seller performance scorecards, buy-box eligibility inputs, and buyer trust signals on the marketplace.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` (
    `gmv_snapshot_id` BIGINT COMMENT 'Primary key uniquely identifying each GMV snapshot record.',
    `marketplace_id` BIGINT COMMENT 'Identifier of the marketplace platform instance to which the snapshot belongs.',
    `marketplace_transaction_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_transaction. Business justification: GMV snapshots aggregate transaction data; linking each snapshot to a transaction provides traceability.',
    `average_order_value` DECIMAL(18,2) COMMENT 'Average monetary value per transaction (gross_gmv_amount / transaction_count).',
    `category_path` STRING COMMENT 'Hierarchical category string (e.g., Electronics > Mobile Phones > Smartphones) used for GMV breakdown.',
    `commission_revenue_amount` DECIMAL(18,2) COMMENT 'Total commission earned by the marketplace from the GMV.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which monetary amounts are expressed.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `fulfillment_type` STRING COMMENT 'Type of fulfillment associated with the GMV (standard shipping, express, store pickup, digital delivery).. Valid values are `standard|express|pickup|digital`',
    `gross_gmv_amount` DECIMAL(18,2) COMMENT 'Total gross merchandise value before any deductions, expressed in the snapshot currency.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue after commissions, refunds, and promotional adjustments.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the snapshot record was first created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the snapshot record (e.g., status change).',
    `record_version` STRING COMMENT 'Version number for optimistic concurrency control of the snapshot record.',
    `segment` STRING COMMENT 'Business segment of the GMV (Business‑to‑Consumer, Business‑to‑Business, Consumer‑to‑Consumer).. Valid values are `B2C|B2B|C2C`',
    `snapshot_number` STRING COMMENT 'Human‑readable sequential identifier for the snapshot (e.g., SN‑20231130‑001).',
    `snapshot_status` STRING COMMENT 'Current lifecycle status of the snapshot record.. Valid values are `finalized|pending|error`',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Date‑time when the GMV snapshot was generated (point‑in‑time for reporting).',
    `snapshot_type` STRING COMMENT 'Frequency classification of the snapshot (daily, weekly, or monthly).. Valid values are `daily|weekly|monthly`',
    `source_system` STRING COMMENT 'Name of the operational system that supplied the underlying data (e.g., OMS, WMS).',
    `take_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of GMV retained by the marketplace as commission (commission_revenue_amount / gross_gmv_amount * 100).',
    `transaction_count` BIGINT COMMENT 'Number of individual marketplace transactions included in the snapshot.',
    CONSTRAINT pk_gmv_snapshot PRIMARY KEY(`gmv_snapshot_id`)
) COMMENT 'SOX-required operational point-in-time record capturing GMV (Gross Merchandise Value) positions for financial close and regulatory compliance. Stores snapshot date, marketplace segment (B2C, C2C, B2B), category breakdown, fulfillment type split, total GMV amount, transaction count, average order value, take rate percentage, net revenue amount, commission revenue, and currency. Immutable once generated — serves as the authoritative basis for period-end financial close processes, revenue recognition journal entries, SEC/regulatory disclosures, and audit trail integrity. Generated on a defined schedule (daily/weekly/monthly) aligned with accounting periods.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` (
    `marketplace_promotion_id` BIGINT COMMENT 'Unique system-generated identifier for the promotion.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Promotions are funded from specific budgets; linking to the finance budget enables budget‑vs‑actual tracking.',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: Promotions are defined at the listing level; adding marketplace_listing_id FK ties each promotion to its target listing.',
    `budget_cap_amount` DECIMAL(18,2) COMMENT 'Maximum total monetary value the promotion can consume across all enrollments.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 currency code for the promotion budget.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount subtracted when the discount mechanism is fixed amount based.',
    `discount_mechanism` STRING COMMENT 'Method used to calculate the promotional discount.. Valid values are `percentage|fixed_amount|buy_one_get_one|tiered|bundle_price`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage value applied when the discount mechanism is percentage based.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which listings or sellers may enroll in the promotion.',
    `end_date` DATE COMMENT 'Date when the promotion expires or is no longer applicable.',
    `enrollment_end_date` DATE COMMENT 'Date when the enrollment window closes for the promotion.',
    `enrollment_source` STRING COMMENT 'Origin of the enrollment request for a listing.. Valid values are `auto|seller_opt_in|admin`',
    `enrollment_start_date` DATE COMMENT 'Date when the enrollment window opens for the promotion.',
    `enrollment_status` STRING COMMENT 'Current processing state of a listings enrollment request.. Valid values are `pending|accepted|rejected|withdrawn`',
    `ftc_disclosure_required` BOOLEAN COMMENT 'Indicates whether the promotion must include FTC-mandated advertising disclosures.',
    `ftc_disclosure_text` STRING COMMENT 'Standard disclosure language to be shown with the promotion.',
    `funding_source` STRING COMMENT 'Entity responsible for financing the promotion.. Valid values are `seller|platform|advertiser|partner`',
    `geographic_scope_type` STRING COMMENT 'Level of geographic granularity for the promotions applicability.. Valid values are `global|regional|country|state`',
    `geographic_scope_value` DECIMAL(18,2) COMMENT 'Specific geographic identifiers (e.g., country codes, region names) matching the scope type.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether this promotion can be combined with other promotions on the same listing.',
    `marketplace_promotion_status` STRING COMMENT 'Current lifecycle state of the promotion.. Valid values are `draft|active|paused|completed|cancelled|expired`',
    `max_enrollment_quantity` STRING COMMENT 'Upper limit on the number of listings that can be enrolled in the promotion.',
    `priority_level` STRING COMMENT 'Business priority used for scheduling and conflict resolution among concurrent promotions.. Valid values are `low|medium|high|critical`',
    `promotion_code` STRING COMMENT 'External code used to reference the promotion in business processes and reporting.',
    `promotion_name` STRING COMMENT 'Descriptive name of the promotion shown to sellers and buyers.',
    `promotion_type` STRING COMMENT 'Category of the promotion defining its business rules and display format.. Valid values are `lightning_deal|deal_of_day|coupon|bundle|seasonal|flash_sale`',
    `promotional_price` DECIMAL(18,2) COMMENT 'Fixed price applied to the listing when promotional_price_override is true.',
    `promotional_price_currency` STRING COMMENT 'ISO 4217 currency code for the promotional price.. Valid values are `^[A-Z]{3}$`',
    `promotional_price_override` BOOLEAN COMMENT 'If true, the promotion sets a specific price for the listing regardless of original price.',
    `seller_acceptance_required` BOOLEAN COMMENT 'Indicates whether a seller must explicitly accept the promotion terms before enrollment.',
    `stackable_with` STRING COMMENT 'Comma‑separated list of other promotion codes that may be stacked with this promotion.',
    `start_date` DATE COMMENT 'Date when the promotion becomes active for eligible listings.',
    `target_audience` STRING COMMENT 'Segment of buyers or sellers the promotion is intended for.. Valid values are `all_buyers|new_buyers|loyal_buyers|seller_specific`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the promotion record.',
    CONSTRAINT pk_marketplace_promotion PRIMARY KEY(`marketplace_promotion_id`)
) COMMENT 'Master entity representing marketplace-level promotional campaigns, deal events, and their enrolled listing associations. Captures promotion lifecycle (name, type, status, date range, discount mechanics, funding source, budget cap, FTC disclosure requirements) and listing enrollment details as child records (enrolled listing references, promotional pricing, quantity limits, seller acceptance status, enrollment source, enrollment date, eligibility score at enrollment, enrollment status). Supports lightning deals, deal-of-the-day, coupons, bundle deals, and seasonal events. Manages the many-to-many relationship between promotions and marketplace listings including enrollment workflows and seller opt-in tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`policy` (
    `policy_id` BIGINT COMMENT 'Unique identifier for the policy.',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: Policies apply to specific listings; adding marketplace_listing_id FK connects policies to listings.',
    `applicable_marketplace_segment` STRING COMMENT 'Marketplace segment(s) to which the policy applies.. Valid values are `b2c|b2b|c2c`',
    `compliance_requirements` STRING COMMENT 'Specific compliance obligations outlined in the policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was created.',
    `document_url` STRING COMMENT 'URL to the full policy document.',
    `effective_date` DATE COMMENT 'Date when the policy becomes effective.',
    `enforcement_severity` STRING COMMENT 'Severity level for enforcement actions when the policy is violated.. Valid values are `low|medium|high|critical`',
    `expiry_date` DATE COMMENT 'Date when the policy expires or is no longer in effect.',
    `last_review_date` DATE COMMENT 'Date of the most recent policy review.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the policy.. Valid values are `draft|active|suspended|retired|expired`',
    `next_review_date` DATE COMMENT 'Planned date for the next policy review.',
    `policy_category` STRING COMMENT 'High-level classification of the policy purpose. [ENUM-REF-CANDIDATE: listing_standards|seller_conduct|buyer_protection|advertising_standards|prohibited_items|ftc_compliance|gdpr_data_handling — 7 candidates stripped; promote to reference product]',
    `policy_code` STRING COMMENT 'External business identifier for the policy, used in reporting and compliance.',
    `policy_description` STRING COMMENT 'Detailed textual description of the policy.',
    `policy_name` STRING COMMENT 'Human readable name of the policy.',
    `regulatory_authority_reference` STRING COMMENT 'Regulatory body governing the policy.. Valid values are `FTC|CPSC|GDPR|CCPA|ISO|NIST`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the policy record.',
    `version` STRING COMMENT 'Version string of the policy, e.g., v1.2.',
    `version_number` STRING COMMENT 'Numeric version of the policy for ordering and comparison.',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Reference master defining the operational policies governing marketplace participant behavior, listing standards, and platform rules. Captures policy identifier, policy name, policy category (listing standards, seller conduct, buyer protection, advertising standards, prohibited items, FTC compliance, GDPR data handling), policy version, effective date, expiry date, policy document URL, applicable marketplace segment (B2C, C2C, B2B), enforcement severity, and regulatory authority reference (FTC, CPSC, GDPR, CCPA). Provides the authoritative policy registry for marketplace compliance enforcement.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` (
    `buyer_protection_claim_id` BIGINT COMMENT 'Unique system-generated identifier for the buyer protection claim record.',
    `marketplace_transaction_id` BIGINT COMMENT 'Identifier of the marketplace transaction that triggered the claim.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Buyer protection claims are evaluated against specific consumer‑protection regulations; the claim record must reference the governing regulation.',
    `seller_profile_id` BIGINT COMMENT 'Identifier of the seller associated with the disputed transaction.',
    `service_support_case_id` BIGINT COMMENT 'Foreign key linking to service.service_support_case. Business justification: Buyer protection claims are handled as support cases; linking enables unified case management and reporting.',
    `appeal_deadline` TIMESTAMP COMMENT 'Cut‑off date‑time by which an appeal must be submitted.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Amount approved for reimbursement after investigation.',
    `claim_amount` DECIMAL(18,2) COMMENT 'Total monetary amount the buyer is seeking to recover.',
    `claim_category` STRING COMMENT 'High‑level grouping of the claim reason.. Valid values are `shipping|product|payment|other`',
    `claim_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the claim amount.. Valid values are `[A-Z]{3}`',
    `claim_description` STRING COMMENT 'Narrative provided by the buyer describing the issue.',
    `claim_filed_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the buyer submitted the protection claim.',
    `claim_number` STRING COMMENT 'Human‑readable claim reference number assigned at filing.',
    `claim_priority` STRING COMMENT 'Priority level assigned for processing the claim.. Valid values are `low|medium|high|critical`',
    `claim_source` STRING COMMENT 'Origin of the claim initiation.. Valid values are `buyer|seller|system`',
    `claim_status` STRING COMMENT 'Current processing state of the claim.. Valid values are `filed|under_investigation|approved|denied|appealed|closed`',
    `claim_subcategory` STRING COMMENT 'More detailed classification within the claim category.',
    `claim_type` STRING COMMENT 'Category describing the nature of the buyers grievance.. Valid values are `item_not_received|significantly_not_as_described|unauthorized_purchase|other`',
    `fraud_review_status` STRING COMMENT 'Current status of any fraud investigation linked to the claim.. Valid values are `pending|reviewed|cleared`',
    `fraud_score` STRING COMMENT 'Numeric risk score generated by the fraud detection engine.',
    `is_appealed` BOOLEAN COMMENT 'Indicates whether the buyer has filed an appeal against the decision.',
    `net_refund_amount` DECIMAL(18,2) COMMENT 'Final amount paid to the buyer (after any deductions).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the claim record.',
    `reimbursement_source` STRING COMMENT 'Entity responsible for funding the claim payout.. Valid values are `seller_funded|marketplace_funded|insurance|other`',
    `requested_amount` DECIMAL(18,2) COMMENT 'Amount initially requested by the buyer before any adjustments.',
    `resolution_date` TIMESTAMP COMMENT 'Date‑time when the claim was resolved.',
    `resolution_notes` STRING COMMENT 'Free‑form notes from the investigator or support agent about the resolution.',
    `resolution_type` STRING COMMENT 'Outcome selected by the marketplace after claim investigation.. Valid values are `full_refund|partial_refund|replacement|no_action|other`',
    `supporting_evidence_refs` STRING COMMENT 'Comma‑separated list of file or document identifiers that substantiate the claim.',
    `updated_by` STRING COMMENT 'System user or service that performed the most recent update.',
    `created_by` STRING COMMENT 'System user or service that created the claim record.',
    CONSTRAINT pk_buyer_protection_claim PRIMARY KEY(`buyer_protection_claim_id`)
) COMMENT 'Master entity tracking buyer protection guarantee claims filed on the marketplace platform. Captures claim reference number, transaction reference, buyer identifier, claim type (item not received, significantly not as described, unauthorized purchase), claim filed date, claim amount, claim currency, supporting evidence references, claim status (filed, under investigation, approved, denied, appealed, closed), resolution type (full refund, partial refund, replacement, no action), resolution date, and reimbursement source (seller-funded, marketplace-funded). Supports FTC consumer protection compliance and buyer trust programs.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`listing_compliance` (
    `listing_compliance_id` BIGINT COMMENT 'Primary key for the listing_compliance association',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace_listing',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance_obligation',
    `compliance_status` STRING COMMENT 'Current compliance status of the listing for this obligation (e.g., active, waived, pending)',
    `evidence_url` STRING COMMENT 'URL to the evidence document supporting compliance for this listing‑obligation pair',
    CONSTRAINT pk_listing_compliance PRIMARY KEY(`listing_compliance_id`)
) COMMENT 'This association product represents the contract between a marketplace listing and a compliance obligation. It captures the compliance status and supporting evidence for each listing‑obligation pair.. Existence Justification: A marketplace listing must satisfy multiple compliance obligations, and each compliance obligation applies to many listings. The compliance team actively creates, updates, and deletes these links, tracking status and evidence per listing‑obligation pair.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`ad_placement` (
    `ad_placement_id` BIGINT COMMENT 'Primary key for ad_placement',
    `fallback_ad_placement_id` BIGINT COMMENT 'Self-referencing FK on ad_placement (fallback_ad_placement_id)',
    `ad_placement_code` STRING COMMENT 'Short alphanumeric code used internally to reference the placement (e.g., "HP_BNR").',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the placement record was first created in the system.',
    `ad_placement_description` STRING COMMENT 'Free‑form description providing additional context about the placement.',
    `dimensions` STRING COMMENT 'Standard size of the placement expressed as width x height in pixels (e.g., "300x250").',
    `effective_from` DATE COMMENT 'Date when the placement definition becomes active.',
    `effective_until` DATE COMMENT 'Date when the placement definition expires or is retired; null if indefinite.',
    `format` STRING COMMENT 'Technical format supported by the placement.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this placement is the default option for new campaigns.',
    `ad_placement_name` STRING COMMENT 'Human‑readable name of the ad placement (e.g., "Homepage Banner").',
    `placement_type` STRING COMMENT 'Category of the placement describing its visual/functional format.',
    `priority` STRING COMMENT 'Numeric priority used when multiple placements are eligible; lower numbers indicate higher priority.',
    `ad_placement_status` STRING COMMENT 'Current lifecycle status of the placement definition.',
    `targeting_criteria` STRING COMMENT 'JSON‑encoded rules that define audience or contextual targeting for the placement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the placement record.',
    CONSTRAINT pk_ad_placement PRIMARY KEY(`ad_placement_id`)
) COMMENT 'Master reference table for ad_placement. Referenced by ad_placement_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`marketplace` (
    `marketplace_id` BIGINT COMMENT 'Primary key for marketplace',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier of the owning organization.',
    `parent_marketplace_id` BIGINT COMMENT 'Self-referencing FK on marketplace (parent_marketplace_id)',
    `average_order_value` DECIMAL(18,2) COMMENT 'Mean monetary value of orders processed on the marketplace.',
    `buyer_count` BIGINT COMMENT 'Count of distinct buyer accounts that have placed at least one order.',
    `marketplace_code` STRING COMMENT 'External business code used to reference the marketplace in contracts and reporting.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance state of the marketplace.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the marketplace record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Default transaction currency for the marketplace, using ISO 4217 codes.',
    `data_classification` STRING COMMENT 'Classification level applied to data originating from this marketplace.',
    `marketplace_description` STRING COMMENT 'Free‑form text describing the marketplaces purpose, target audience, and unique features.',
    `gmv_annual` DECIMAL(18,2) COMMENT 'Total value of goods and services transacted on the marketplace in the most recent fiscal year.',
    `is_ftc_compliant` BOOLEAN COMMENT 'True if the marketplace meets FTC advertising disclosure requirements.',
    `is_spam_protected` BOOLEAN COMMENT 'True if the marketplace employs anti‑spam measures for listings and communications.',
    `launch_date` DATE COMMENT 'Date the marketplace was first made available to sellers and buyers.',
    `marketplace_owner` STRING COMMENT 'Name of the internal business unit or legal entity that owns the marketplace.',
    `marketplace_name` STRING COMMENT 'Human‑readable name of the marketplace (e.g., US Marketplace, EU Marketplace).',
    `privacy_policy_url` STRING COMMENT 'Web address of the marketplaces privacy policy document.',
    `region` STRING COMMENT 'Primary geographic region the marketplace serves, expressed as a 3‑letter ISO country code.',
    `seller_count` BIGINT COMMENT 'Count of distinct seller accounts actively listing on the marketplace.',
    `marketplace_status` STRING COMMENT 'Current operational status of the marketplace.',
    `termination_date` DATE COMMENT 'Date the marketplace was permanently closed or retired (null if still active).',
    `terms_of_service_url` STRING COMMENT 'Web address of the marketplaces terms of service document.',
    `marketplace_type` STRING COMMENT 'Category of marketplace based on scope and product focus.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the marketplace record.',
    CONSTRAINT pk_marketplace PRIMARY KEY(`marketplace_id`)
) COMMENT 'Master reference table for marketplace. Referenced by marketplace_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`ad_group` (
    `ad_group_id` BIGINT COMMENT 'Primary key for ad_group',
    `campaign_id` BIGINT COMMENT 'Identifier of the parent advertising campaign.',
    `ad_group_version` STRING COMMENT 'Version number for change tracking of the ad group definition.',
    `ad_rotation_type` STRING COMMENT 'Method used to rotate ads within the group.',
    `bid_strategy` STRING COMMENT 'Algorithmic approach used to bid for ad impressions.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Maximum monetary budget allocated to the ad group for the defined period.',
    `click_through_rate_target` DECIMAL(18,2) COMMENT 'Target CTR the ad group strives to achieve.',
    `ad_group_code` STRING COMMENT 'Business identifier code used to reference the ad group in external systems.',
    `compliance_disclosure_required` BOOLEAN COMMENT 'True if the ad group must include FTC‑compliant advertising disclosures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ad group record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `daily_cap_amount` DECIMAL(18,2) COMMENT 'Maximum amount that can be spent in a single day.',
    `daily_cap_currency` STRING COMMENT 'Currency for the daily spend cap.',
    `device_target` STRING COMMENT 'Device types targeted by the ad group.',
    `end_date` DATE COMMENT 'Date when the ad group stops serving ads; null if open‑ended.',
    `experiment_name` STRING COMMENT 'Name of the experiment the ad group belongs to, if applicable.',
    `frequency_cap` STRING COMMENT 'Maximum number of impressions per user within the defined window.',
    `frequency_cap_window` STRING COMMENT 'Time window for the frequency cap.',
    `impression_share_target` DECIMAL(18,2) COMMENT 'Desired percentage of eligible impressions the ad group aims to capture.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the ad group uses automated bidding.',
    `is_experiment` BOOLEAN COMMENT 'Indicates whether the ad group is part of an A/B test or experiment.',
    `is_smart` BOOLEAN COMMENT 'True if the ad group leverages machine‑learning optimization.',
    `language_target` STRING COMMENT 'Language codes for audience targeting.',
    `last_served_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent ad impression served by this group.',
    `ad_group_name` STRING COMMENT 'Human‑readable name of the advertising group.',
    `priority` STRING COMMENT 'Integer priority used to resolve conflicts when multiple groups compete for the same inventory.',
    `spend_amount` DECIMAL(18,2) COMMENT 'Total monetary spend recorded for the ad group to date.',
    `spend_currency` STRING COMMENT 'Currency of the recorded spend amount.',
    `start_date` DATE COMMENT 'Date when the ad group becomes active for serving ads.',
    `ad_group_status` STRING COMMENT 'Current lifecycle status of the ad group.',
    `target_audience` STRING COMMENT 'Free‑form description of the audience segment targeted by the ad group.',
    `targeting_criteria` STRING COMMENT 'Serialized criteria (e.g., JSON) defining demographic, interest, and behavior filters.',
    `targeting_location` STRING COMMENT 'Country codes representing geographic targeting for the ad group.',
    `ad_group_type` STRING COMMENT 'Category of advertising placement for the ad group.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ad group record.',
    CONSTRAINT pk_ad_group PRIMARY KEY(`ad_group_id`)
) COMMENT 'Master reference table for ad_group. Referenced by ad_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_listing_category_id` FOREIGN KEY (`listing_category_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_category`(`listing_category_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ADD CONSTRAINT `fk_marketplace_buy_box_rule_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_commission_schedule_id` FOREIGN KEY (`commission_schedule_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`commission_schedule`(`commission_schedule_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_listing_offer_id` FOREIGN KEY (`listing_offer_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_offer`(`listing_offer_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_seller_settlement_id` FOREIGN KEY (`seller_settlement_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`seller_settlement`(`seller_settlement_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ADD CONSTRAINT `fk_marketplace_sponsored_listing_ad_group_id` FOREIGN KEY (`ad_group_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`ad_group`(`ad_group_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ADD CONSTRAINT `fk_marketplace_sponsored_listing_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ADD CONSTRAINT `fk_marketplace_ad_event_ad_placement_id` FOREIGN KEY (`ad_placement_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`ad_placement`(`ad_placement_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ADD CONSTRAINT `fk_marketplace_ad_event_sponsored_listing_id` FOREIGN KEY (`sponsored_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`sponsored_listing`(`sponsored_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ADD CONSTRAINT `fk_marketplace_listing_category_parent_category_listing_category_id` FOREIGN KEY (`parent_category_listing_category_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_category`(`listing_category_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ADD CONSTRAINT `fk_marketplace_listing_review_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ADD CONSTRAINT `fk_marketplace_gmv_snapshot_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ADD CONSTRAINT `fk_marketplace_gmv_snapshot_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ADD CONSTRAINT `fk_marketplace_policy_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ADD CONSTRAINT `fk_marketplace_buyer_protection_claim_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_compliance` ADD CONSTRAINT `fk_marketplace_listing_compliance_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_placement` ADD CONSTRAINT `fk_marketplace_ad_placement_fallback_ad_placement_id` FOREIGN KEY (`fallback_ad_placement_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`ad_placement`(`ad_placement_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ADD CONSTRAINT `fk_marketplace_marketplace_parent_marketplace_id` FOREIGN KEY (`parent_marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`marketplace` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `ecommerce_ecm`.`marketplace` SET TAGS ('dbx_domain' = 'marketplace');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` SET TAGS ('dbx_subdomain' = 'listing_management');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `seo_metadata_id` SET TAGS ('dbx_business_glossary_term' = 'Seo Metadata Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `advertised` SET TAGS ('dbx_business_glossary_term' = 'Advertising Disclosure Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `buy_box_eligible` SET TAGS ('dbx_business_glossary_term' = 'Buy Box Eligibility');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `category_path` SET TAGS ('dbx_business_glossary_term' = 'Category Path');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Seller Commission Rate (%)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Product Condition');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'new|used|refurbished');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Listing Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Listing End Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `featured` SET TAGS ('dbx_business_glossary_term' = 'Featured Listing Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `ftc_ad_disclosure` SET TAGS ('dbx_business_glossary_term' = 'FTC Advertising Disclosure');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'fba|seller_fulfilled|dropship');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Product Height (cm)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `inventory_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Inventory Quantity');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `is_searchable` SET TAGS ('dbx_business_glossary_term' = 'Searchability Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `is_visible` SET TAGS ('dbx_business_glossary_term' = 'Visibility Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Product Length (cm)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `listing_source` SET TAGS ('dbx_business_glossary_term' = 'Listing Source');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `listing_source` SET TAGS ('dbx_value_regex' = 'seller_uploaded|system_generated|imported');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `listing_type` SET TAGS ('dbx_business_glossary_term' = 'Listing Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `listing_type` SET TAGS ('dbx_value_regex' = 'b2c|c2c|auction|fixed_price');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `marketplace_listing_description` SET TAGS ('dbx_business_glossary_term' = 'Listing Description');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `marketplace_listing_status` SET TAGS ('dbx_business_glossary_term' = 'Listing Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `marketplace_listing_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_review');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Listing Price');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `rating_average` SET TAGS ('dbx_business_glossary_term' = 'Average Customer Rating');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `review_count` SET TAGS ('dbx_business_glossary_term' = 'Review Count');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `shipping_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipping Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Listing Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'in_stock|out_of_stock|preorder|backorder');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Listing Title');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Listing Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Product Width (cm)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` SET TAGS ('dbx_subdomain' = 'listing_management');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `listing_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Offer ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `listing_category_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `buy_box_winner_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy Box Winner Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `buyer_feedback_score` SET TAGS ('dbx_business_glossary_term' = 'Buyer Feedback Score (0‑5)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate (%)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Item Condition');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'new|used|refurbished|open_box');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'seller_fulfilled|platform_fulfilled|dropship');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `gift_wrap_price` SET TAGS ('dbx_business_glossary_term' = 'Gift‑Wrap Price (USD)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `handling_time_sla_days` SET TAGS ('dbx_business_glossary_term' = 'Handling Time SLA (Days)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `is_gift_wrap_available` SET TAGS ('dbx_business_glossary_term' = 'Gift‑Wrap Availability Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `is_prime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Prime Eligibility Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `is_returnable` SET TAGS ('dbx_business_glossary_term' = 'Returnable Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `listing_offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `listing_offer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suppressed');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `marketplace_region` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Region');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `marketplace_region` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC|LATAM|MEA');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Offer Price (USD)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `offer_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Offer End Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `offer_price` SET TAGS ('dbx_business_glossary_term' = 'Offer Price (USD)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `offer_rank` SET TAGS ('dbx_business_glossary_term' = 'Offer Rank');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `offer_source` SET TAGS ('dbx_business_glossary_term' = 'Offer Source');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `offer_source` SET TAGS ('dbx_value_regex' = 'api|manual|bulk_upload');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `offer_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Offer Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `price_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Price Effective Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `price_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Price Expiration Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|sale|discounted');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window (Days)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `seller_fulfillment_sla_met` SET TAGS ('dbx_business_glossary_term' = 'Seller Fulfillment SLA Met Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `seller_rating` SET TAGS ('dbx_business_glossary_term' = 'Seller Rating (0‑5)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost (USD)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `shipping_estimate_days` SET TAGS ('dbx_business_glossary_term' = 'Shipping Estimate (Days)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_value_regex' = 'out_of_stock|policy_violation|price_too_low|seller_suspended');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Total Offer Price (USD)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` SET TAGS ('dbx_subdomain' = 'listing_management');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `buy_box_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Buy Box Rule ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Winner Seller ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `buy_box_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Buy Box Rule Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `buy_box_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `category_applicability` SET TAGS ('dbx_business_glossary_term' = 'Category Applicability');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `eligibility_score` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Score');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `max_wins_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Wins Per Day');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `price_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Threshold Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `price_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Threshold Currency');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `price_threshold_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `rotation_fairness_enabled` SET TAGS ('dbx_business_glossary_term' = 'Rotation Fairness Enabled');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `rotation_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Rotation Interval (Minutes)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Buy Box Rule Description');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Buy Box Rule Name');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Buy Box Rule Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'eligibility|scoring|pricing|rotation|suppression');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `scoring_weights` SET TAGS ('dbx_business_glossary_term' = 'Scoring Weights');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `seller_rating_at_win` SET TAGS ('dbx_business_glossary_term' = 'Seller Rating at Win');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `suppression_trigger` SET TAGS ('dbx_business_glossary_term' = 'Suppression Trigger');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `suppression_trigger` SET TAGS ('dbx_value_regex' = 'out_of_stock|low_rating|policy_violation|seller_suspended|price_mismatch');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `winning_fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Winning Fulfillment Method');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `winning_fulfillment_method` SET TAGS ('dbx_value_regex' = 'ship_from_warehouse|drop_ship|store_pickup|digital');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buy_box_rule` ALTER COLUMN `winning_offer_price` SET TAGS ('dbx_business_glossary_term' = 'Winning Offer Price');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` SET TAGS ('dbx_subdomain' = 'transaction_finance');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `commission_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `listing_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Transaction ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `seller_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Settlement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Campaign ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `buy_box_winner_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy Box Winner Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `buyer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Buyer IP Address');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `buyer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `buyer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `dispute_opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Opened Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `dispute_resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolved Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'none|open|under_review|resolved_buyer_favor|resolved_seller_favor|escalated');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|passed|flagged|under_review|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `fraud_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'seller_fulfilled|marketplace_fulfilled|dropship|digital_delivery|local_pickup');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `gmv_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV) Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `is_sponsored_listing` SET TAGS ('dbx_business_glossary_term' = 'Is Sponsored Listing');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `item_subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Item Subtotal Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `marketplace_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Commission Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `marketplace_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|mobile_web|api|marketplace_app');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `refund_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `refund_reason_code` SET TAGS ('dbx_value_regex' = 'buyer_remorse|item_not_received|item_not_as_described|defective|damaged_in_transit|seller_cancelled');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `seller_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Seller Payout Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `seller_payout_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `shipping_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^MKT-[0-9]{10}$');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled|disputed|refunded|partially_refunded');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'B2C|C2C|B2B');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` SET TAGS ('dbx_subdomain' = 'transaction_finance');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `commission_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `base_commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Base Commission Rate (Percent)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `cap_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Cap Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `cap_type` SET TAGS ('dbx_value_regex' = 'none|amount|percentage');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `cap_value` SET TAGS ('dbx_business_glossary_term' = 'Commission Cap Value');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `commission_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Description');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'fulfillment_by_seller|fulfillment_by_platform|dropship');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `max_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Commission Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `min_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commission Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `promotional_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Period Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑2)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Name');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `seller_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Seller Tier Code');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `variable_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Variable Fee Structure');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` SET TAGS ('dbx_subdomain' = 'transaction_finance');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `seller_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Settlement ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `bank_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Transfer Reference');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_value_regex' = 'pending|processing|disbursed|on_hold');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `fee_adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustments Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Disbursement Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'SellerPortal|API|Batch');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|Wire|PayPal|Other');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `promotional_credits_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Credits Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `refund_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Deductions Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `settlement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement End Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `settlement_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Generation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `settlement_notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Number');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `settlement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Start Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withheld Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `total_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Commission Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` SET TAGS ('dbx_subdomain' = 'transaction_finance');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Order ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Related Product ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `service_support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Support Case Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Closed Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|in_app|chat');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|AUD');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `dispute_source` SET TAGS ('dbx_business_glossary_term' = 'Dispute Source');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `dispute_source` SET TAGS ('dbx_value_regex' = 'buyer_initiated|seller_initiated|system_generated');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|in_review|escalated|resolved|closed|rejected');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'item_not_received|item_not_as_described|unauthorized_transaction|return_dispute|listing_policy_violation');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_value_regex' = 'warning|account_suspension|ban|none');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `evidence_count` SET TAGS ('dbx_business_glossary_term' = 'Evidence Count');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispute Fee Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `filed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Filed Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `ftc_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'FTC Disclosure Required');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `gdpr_data_subject_consent` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Subject Consent');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Dispute Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `is_duplicate_dispute` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Dispute Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `is_fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `last_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `marketplace_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Fee Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Dispute Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Notes');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference Number');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'refund|replacement|store_credit|partial_refund|none');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `sla_achieved_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Achieved Hours');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `sla_compliance` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Hours');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `total_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Refund Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` SET TAGS ('dbx_subdomain' = 'advertising_promotion');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `sponsored_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Listing ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `ad_group_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Group Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `ad_performance_clicks` SET TAGS ('dbx_business_glossary_term' = 'Ad Performance Clicks');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `ad_performance_impressions` SET TAGS ('dbx_business_glossary_term' = 'Ad Performance Impressions');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `ad_performance_spend` SET TAGS ('dbx_business_glossary_term' = 'Ad Performance Spend');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `ad_placement_type` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `ad_placement_type` SET TAGS ('dbx_value_regex' = 'sponsored_product|sponsored_brand|sponsored_display');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `bid_strategy` SET TAGS ('dbx_business_glossary_term' = 'Bid Strategy');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `bid_strategy` SET TAGS ('dbx_value_regex' = 'manual|auto');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `campaign_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `campaign_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `daily_budget_cap` SET TAGS ('dbx_business_glossary_term' = 'Daily Budget Cap');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `disclosure_label_text` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Label Text');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `ftc_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'FTC Disclosure Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `impression_share` SET TAGS ('dbx_business_glossary_term' = 'Impression Share (%)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `sponsored_listing_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Listing Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `sponsored_listing_status` SET TAGS ('dbx_value_regex' = 'active|paused|ended|rejected');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `targeting_type` SET TAGS ('dbx_business_glossary_term' = 'Targeting Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `targeting_type` SET TAGS ('dbx_value_regex' = 'keyword|category|asin');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`sponsored_listing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` SET TAGS ('dbx_subdomain' = 'advertising_promotion');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_event_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Event Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Campaign Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Order Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `sponsored_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Listing Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Ad Bid Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_bid_currency` SET TAGS ('dbx_business_glossary_term' = 'Ad Bid Currency');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ad Click Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ad Conversion Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_cost_model` SET TAGS ('dbx_business_glossary_term' = 'Ad Cost Model');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_cost_model` SET TAGS ('dbx_value_regex' = 'cpm|cpc');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_impression_code` SET TAGS ('dbx_business_glossary_term' = 'Ad Impression Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Ad Revenue Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_revenue_currency` SET TAGS ('dbx_business_glossary_term' = 'Ad Revenue Currency');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_status` SET TAGS ('dbx_business_glossary_term' = 'Ad Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ad_status` SET TAGS ('dbx_value_regex' = 'active|inactive|paused|completed');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `attribution_window_seconds` SET TAGS ('dbx_business_glossary_term' = 'Attribution Window (Seconds)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `buyer_session_code` SET TAGS ('dbx_business_glossary_term' = 'Buyer Session Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `click_to_conversion_seconds` SET TAGS ('dbx_business_glossary_term' = 'Click‑to‑Conversion Time (Seconds)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Ad Cost Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Ad Cost Currency');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Ad Event Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'impression|click|conversion');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `ftc_disclosure_rendered` SET TAGS ('dbx_business_glossary_term' = 'FTC Disclosure Rendered Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `page_type` SET TAGS ('dbx_business_glossary_term' = 'Page Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `page_type` SET TAGS ('dbx_value_regex' = 'pdp|plp|search_results|homepage');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `placement_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement Position');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `viewability_flag` SET TAGS ('dbx_business_glossary_term' = 'Viewability Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_event` ALTER COLUMN `viewability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Viewability Percentage');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` SET TAGS ('dbx_subdomain' = 'listing_management');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `listing_category_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Category ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `parent_category_listing_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `buy_box_eligible` SET TAGS ('dbx_business_glossary_term' = 'Buy‑Box Eligibility Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `category_image_url` SET TAGS ('dbx_business_glossary_term' = 'Category Image URL');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `category_path` SET TAGS ('dbx_business_glossary_term' = 'Category Path');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `cpsc_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'CPSC Compliance Required Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `depth_level` SET TAGS ('dbx_business_glossary_term' = 'Category Depth Level');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `is_age_restricted` SET TAGS ('dbx_business_glossary_term' = 'Age‑Restricted Category Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `is_restricted` SET TAGS ('dbx_business_glossary_term' = 'Restricted Category Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `is_searchable` SET TAGS ('dbx_business_glossary_term' = 'Searchable Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `is_sponsored_allowed` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Listing Allowed Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `is_visible` SET TAGS ('dbx_business_glossary_term' = 'Visibility Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `listing_category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `listing_category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `listing_category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `listing_category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `listing_category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending|deprecated|draft');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `promotional_eligible` SET TAGS ('dbx_business_glossary_term' = 'Promotional Eligible Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review|escalated|closed');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `seo_friendly_name` SET TAGS ('dbx_business_glossary_term' = 'SEO Friendly Name');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `tax_exempt_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Category Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` SET TAGS ('dbx_subdomain' = 'listing_management');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `listing_review_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Review ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `compliance_ccpa_opt_out` SET TAGS ('dbx_business_glossary_term' = 'CCPA Opt‑Out Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `compliance_gdpr_consent` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Captured');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|desktop|tablet|other');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `edit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Edit Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `helpful_vote_count` SET TAGS ('dbx_business_glossary_term' = 'Helpful Vote Count');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `is_spam_flag` SET TAGS ('dbx_business_glossary_term' = 'Spam Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `listing_review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `listing_review_status` SET TAGS ('dbx_value_regex' = 'active|removed|archived');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `media_attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Media Attachment Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `moderation_status` SET TAGS ('dbx_business_glossary_term' = 'Moderation Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `moderation_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `moderation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Moderation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Rating Score');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `removal_reason` SET TAGS ('dbx_value_regex' = 'spam|offensive|policy_violation|buyer_request|other');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `review_text` SET TAGS ('dbx_business_glossary_term' = 'Review Text');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Submission Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `review_title` SET TAGS ('dbx_business_glossary_term' = 'Review Title');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `review_version` SET TAGS ('dbx_business_glossary_term' = 'Review Version');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `seller_response_text` SET TAGS ('dbx_business_glossary_term' = 'Seller Response Text');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `seller_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Seller Response Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `solicitation_source` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Source');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `solicitation_source` SET TAGS ('dbx_value_regex' = 'post_purchase_email|in_app_prompt|order_confirmation|other');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|api');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `target_reference` SET TAGS ('dbx_business_glossary_term' = 'Review Target ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'Review Target Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'listing|seller');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_review` ALTER COLUMN `verified_purchase` SET TAGS ('dbx_business_glossary_term' = 'Verified Purchase Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` SET TAGS ('dbx_subdomain' = 'transaction_finance');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `gmv_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'GMV Snapshot Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `average_order_value` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `category_path` SET TAGS ('dbx_business_glossary_term' = 'Product Category Path');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `commission_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Revenue Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'standard|express|pickup|digital');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `gross_gmv_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross GMV Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Segment');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'B2C|B2B|C2C');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `snapshot_number` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Number');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_value_regex' = 'finalized|pending|error');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Generation Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `take_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Take Rate Percentage');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`gmv_snapshot` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` SET TAGS ('dbx_subdomain' = 'advertising_promotion');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `marketplace_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `budget_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotion Budget Cap Amount (BUDGET_CAP)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code (CUR)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promotion Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (AMT)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `discount_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Discount Mechanism (MECH)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `discount_mechanism` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|buy_one_get_one|tiered|bundle_price');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage (PCT)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (ELIG_CRIT)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date (END_DATE)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date (ENROLL_END)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source (ENROLL_SRC)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'auto|seller_opt_in|admin');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date (ENROLL_START)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ENROLL_STATUS)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|withdrawn');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `ftc_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'FTC Disclosure Required (FTC_DISC)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `ftc_disclosure_text` SET TAGS ('dbx_business_glossary_term' = 'FTC Disclosure Text (FTC_TEXT)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source (SOURCE)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'seller|platform|advertiser|partner');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `geographic_scope_type` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope Type (GEO_TYPE)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `geographic_scope_type` SET TAGS ('dbx_value_regex' = 'global|regional|country|state');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `geographic_scope_value` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope Value (GEO_VALUE)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Is Stackable (STACKABLE)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `marketplace_promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Status (STATUS)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `marketplace_promotion_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|cancelled|expired');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `max_enrollment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment Quantity (MAX_QTY)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Promotion Priority Level (PRIORITY)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code (CODE)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Name (NAME)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type (TYPE)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'lightning_deal|deal_of_day|coupon|bundle|seasonal|flash_sale');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `promotional_price` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price (PROMO_PRICE)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `promotional_price_currency` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Currency (PROMO_CUR)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `promotional_price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `promotional_price_override` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Override (PRICE_OVR)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `seller_acceptance_required` SET TAGS ('dbx_business_glossary_term' = 'Seller Acceptance Required (SELLER_ACCEPT)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `stackable_with` SET TAGS ('dbx_business_glossary_term' = 'Stackable With Promotion Codes (STACK_WITH)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date (START_DATE)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience (AUDIENCE)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `target_audience` SET TAGS ('dbx_value_regex' = 'all_buyers|new_buyers|loyal_buyers|seller_specific');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promotion Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` SET TAGS ('dbx_subdomain' = 'listing_management');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `applicable_marketplace_segment` SET TAGS ('dbx_business_glossary_term' = 'Applicable Marketplace Segment');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `applicable_marketplace_segment` SET TAGS ('dbx_value_regex' = 'b2c|b2b|c2c');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Policy Document URL');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `enforcement_severity` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Severity');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `enforcement_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|expired');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code (Identifier)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `regulatory_authority_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Reference');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `regulatory_authority_reference` SET TAGS ('dbx_value_regex' = 'FTC|CPSC|GDPR|CCPA|ISO|NIST');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` SET TAGS ('dbx_subdomain' = 'transaction_finance');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `buyer_protection_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Protection Claim ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `service_support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Support Case Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount (Requested)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_category` SET TAGS ('dbx_business_glossary_term' = 'Claim Category');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_category` SET TAGS ('dbx_value_regex' = 'shipping|product|payment|other');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_currency` SET TAGS ('dbx_business_glossary_term' = 'Claim Currency');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_description` SET TAGS ('dbx_business_glossary_term' = 'Claim Description');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_filed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Filed Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_priority` SET TAGS ('dbx_business_glossary_term' = 'Claim Priority');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_source` SET TAGS ('dbx_business_glossary_term' = 'Claim Source');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_source` SET TAGS ('dbx_value_regex' = 'buyer|seller|system');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'filed|under_investigation|approved|denied|appealed|closed');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Claim Subcategory');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'item_not_received|significantly_not_as_described|unauthorized_purchase|other');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|cleared');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `is_appealed` SET TAGS ('dbx_business_glossary_term' = 'Is Appealed');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `net_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Refund Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `reimbursement_source` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Source');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `reimbursement_source` SET TAGS ('dbx_value_regex' = 'seller_funded|marketplace_funded|insurance|other');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'full_refund|partial_refund|replacement|no_action|other');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `supporting_evidence_refs` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence References');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`buyer_protection_claim` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_compliance` SET TAGS ('dbx_subdomain' = 'listing_management');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_compliance` SET TAGS ('dbx_association_edges' = 'marketplace.marketplace_listing,compliance.compliance_obligation');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_compliance` ALTER COLUMN `listing_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Compliance - Listing Compliance Id');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_compliance` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Compliance - Marketplace Listing Id');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_compliance` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Compliance - Compliance Obligation Id');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_compliance` ALTER COLUMN `evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence URL');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_placement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_placement` SET TAGS ('dbx_subdomain' = 'advertising_promotion');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_placement` ALTER COLUMN `ad_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_placement` ALTER COLUMN `fallback_ad_placement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` SET TAGS ('dbx_subdomain' = 'listing_management');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ALTER COLUMN `parent_marketplace_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_group` SET TAGS ('dbx_subdomain' = 'advertising_promotion');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`ad_group` ALTER COLUMN `ad_group_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Group Identifier');
