-- Schema for Domain: marketplace | Business: Ecommerce | Version: v1_mvm
-- Generated on: 2026-05-05 00:58:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`marketplace` COMMENT 'Owns the multi-sided marketplace platform connecting buyers and sellers. Manages marketplace catalog listings, C2C and B2C transaction facilitation, GMV reporting, buy-box eligibility rules, seller-buyer dispute resolution, sponsored listing management, and FTC-compliant advertising disclosure for the marketplace ecosystem.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` (
    `marketplace_listing_id` BIGINT COMMENT 'Unique system-generated identifier for the marketplace listing.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Brand registry enforcement and brand-gating programs require knowing which brand owns a marketplace listing. E-commerce platforms (Amazon Brand Registry, etc.) enforce authorized-seller rules at the l',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Bundle listings require distinct display logic, component-level fulfillment, and bundle-specific pricing on the marketplace. marketplace_listing.sku_id alone cannot identify bundle structure. A direct',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Sellers often designate a default carrier for their listings; needed for contract compliance and rate negotiations.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: marketplace_listing already has carrier_id but lacks a carrier_service_id, leaving the specific shipping service (standard, express, same-day) unresolved. Listings must advertise a specific shipping s',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Required for listing‑catalog synchronization report that maps each marketplace listing to the internal catalog item for inventory and pricing alignment.',
    `commission_schedule_id` BIGINT COMMENT 'Foreign key linking to marketplace.commission_schedule. Business justification: marketplace_listing has commission_rate_percent: DECIMAL(5,2) which is a denormalized commission rate. The commission_schedule table is the authoritative reference for commission rate structures appli',
    `delivery_zone_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_zone. Business justification: Shipping SLA and cost calculations are based on the delivery zone assigned to each listing.',
    `listing_category_id` BIGINT COMMENT 'Foreign key linking to marketplace.listing_category. Business justification: marketplace_listing has category_path: STRING which is a denormalized string representation of the category hierarchy. The listing_category table is the authoritative marketplace-specific category tax',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: Every marketplace listing belongs to a specific marketplace instance (e.g., US marketplace, EU marketplace). The marketplace table is the master reference for all marketplace instances. Adding marketp',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Required for Listing Price Determination Report linking each listing to the price list used for pricing calculations, essential for audit and dynamic pricing.',
    `seller_profile_id` BIGINT COMMENT 'Unique identifier of the seller who owns this marketplace listing.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Needed for inventory and fulfillment tracking per SKU, enabling real‑time stock reconciliation between marketplace listings and internal SKU records.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Listing availability sync process: a marketplace listing must reference its authoritative stock_position to display accurate ATP quantity and stock status. inventory_quantity and stock_status on marke',
    `warehouse_node_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_node. Business justification: Assign fulfillment warehouse for merchant‑fulfilled (FBM) listings; used in fulfillment planning and inventory allocation reports.',
    `advertised` BOOLEAN COMMENT 'True when the listing includes FTC‑compliant advertising disclosures.',
    `buy_box_eligible` BOOLEAN COMMENT 'Indicates whether the listing qualifies for the marketplace buy‑box algorithm.',
    `condition` STRING COMMENT 'Physical state of the item being sold.. Valid values are `new|used|refurbished`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the listing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the listing price currency.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the listing expires or is deactivated.',
    `featured` BOOLEAN COMMENT 'True if the seller has paid for promotional placement of the listing.',
    `ftc_ad_disclosure` BOOLEAN COMMENT 'True when the listing includes required FTC advertising disclosure statements.',
    `fulfillment_type` STRING COMMENT 'Method by which the product is delivered to the buyer.. Valid values are `fba|seller_fulfilled|dropship`',
    `height_cm` DECIMAL(18,2) COMMENT 'Physical height of the product for dimensional shipping.',
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
    `title` STRING COMMENT 'The headline or title of the product offering displayed to buyers.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the listing record.',
    `width_cm` DECIMAL(18,2) COMMENT 'Physical width of the product for dimensional shipping.',
    CONSTRAINT pk_marketplace_listing PRIMARY KEY(`marketplace_listing_id`)
) COMMENT 'Core master entity representing a sellers product offering on the marketplace platform. Captures the full lifecycle of a marketplace listing including listing status (active, inactive, suspended, pending review), listing type (B2C, C2C, auction, fixed-price), buy-box eligibility status, featured listing flag, listing creation and expiry dates, listing title, description, condition (new, used, refurbished), category path, brand, ASIN/UPC/EAN identifiers, seller SKU, marketplace-assigned listing ID, fulfillment type (FBA-style, seller-fulfilled, dropship), listing visibility flags, and FTC-compliant advertising disclosure indicators. SSOT for marketplace catalog listings distinct from the product domains master catalog.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` (
    `listing_offer_id` BIGINT COMMENT 'Unique identifier for the sellers offer on a marketplace listing.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: listing_offer carries shipping_cost and shipping_estimate_days as plain denormalized values. Linking to carrier_service formalizes the shipping promise backing each offer, enabling accurate SLA-based ',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the product (SKU) that the offer is for.',
    `commission_schedule_id` BIGINT COMMENT 'Foreign key linking to marketplace.commission_schedule. Business justification: listing_offer has commission_rate_percent: DECIMAL(5,2) which is a denormalized commission rate. The commission_schedule table is the authoritative reference for commission rate structures. Adding com',
    `dynamic_price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.dynamic_price_rule. Business justification: A listing offers price is often computed by a dynamic price rule. Price audit, compliance reporting, and buy-box strategy analysis require knowing which rule produced the current offer price. No exis',
    `listing_category_id` BIGINT COMMENT 'FK to marketplace.listing_category',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Offers often belong to marketing campaigns (discounts, bundles); linking enables Offer‑Campaign performance dashboards.',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: A listing offer is made on a specific marketplace. listing_offer currently has marketplace_region: STRING which is a denormalized string representation of the marketplaces region. Adding marketplace_',
    `marketplace_listing_id` BIGINT COMMENT 'Identifier of the marketplace listing to which this offer belongs.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: Needed for Offer Price Audit to trace each offer back to the specific price list item that generated its price, supporting compliance and price change traceability.',
    `seller_profile_id` BIGINT COMMENT 'Unique identifier of the seller who submitted the offer.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Enables offer pricing and stock allocation per SKU, essential for dynamic pricing engine.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_sla. Business justification: SLA promise enforcement: marketplace listing_offer advertises handling-time SLA to buyers; this must be grounded in a fulfillment_sla record to enforce compliance, trigger SLA-breach alerts, and valid',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Offer availability must reflect allocated stock; linking offer to stock position enables quantity validation and replenishment triggers.',
    `buy_box_winner_flag` BOOLEAN COMMENT 'True if the offer is the current buy‑box winner for the listing.',
    `buyer_feedback_score` DECIMAL(18,2) COMMENT 'Aggregated rating given by buyers who purchased this specific offer.',
    `compliance_flag` BOOLEAN COMMENT 'True if the offer meets required FTC advertising disclosures.',
    `compliance_notes` STRING COMMENT 'Additional information regarding compliance status or special handling.',
    `condition` STRING COMMENT 'State of the product as described by the seller.. Valid values are `new|used|refurbished|open_box`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the offer record was first created in the system.',
    `currency_code` STRING COMMENT 'Currency in which the offer_price and related monetary fields are expressed.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `fulfillment_method` STRING COMMENT 'Logistics approach used to deliver the item to the buyer.. Valid values are `seller_fulfilled|platform_fulfilled|dropship`',
    `gift_wrap_price` DECIMAL(18,2) COMMENT 'Additional charge for gift‑wrap when selected by the buyer.',
    `is_gift_wrap_available` BOOLEAN COMMENT 'True if the seller offers gift‑wrap service for this offer.',
    `is_prime_eligible` BOOLEAN COMMENT 'True if the offer qualifies for accelerated shipping benefits.',
    `is_returnable` BOOLEAN COMMENT 'True if the seller accepts returns for this offer.',
    `listing_offer_status` STRING COMMENT 'Operational state of the offer within its lifecycle.. Valid values are `active|inactive|expired|suppressed`',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` (
    `marketplace_transaction_id` BIGINT COMMENT 'Unique identifier for the marketplace transaction. Primary key for the marketplace transaction entity.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Marketplace transactions generate AR entries for commission and platform fee receivables owed by sellers. Finance tracks fee collection aging and dunning against AR. E-commerce finance teams require t',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Carrier performance & cost allocation report requires linking each transaction to the carrier that shipped it.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Exact carrier service used per transaction is needed for service‑level compliance and buyer ETA guarantees.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Supports sales analytics that aggregate revenue by catalog item independent of SKU variations.',
    `commission_id` BIGINT COMMENT 'Foreign key linking to seller.commission. Business justification: Commission audit trails require knowing which seller-negotiated commission record governed each transaction. marketplace_transaction already stores commission_rate_percent (denormalized) but the autho',
    `commission_schedule_id` BIGINT COMMENT 'Foreign key linking to marketplace.commission_schedule. Business justification: Marketplace transactions need to reference the commission schedule that defines their commission rates; adds commission_schedule_id FK to marketplace_transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed for internal cost allocation reports that assign transaction processing costs to specific cost centers.',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Required for order fulfillment shipping address, used in delivery performance reports and compliance with shipping regulations.',
    `center_id` BIGINT COMMENT 'Identifier of the fulfillment center responsible for shipping the item, if applicable for marketplace-fulfilled transactions.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.header. Business justification: Marketplace GMV reconciliation and finance settlement require matching each marketplace_transaction to its corresponding order header. Enables commission auditing, dispute resolution, and revenue reco',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Seller commission calculation, payout verification, and line-level dispute resolution require linking each marketplace_transaction to the specific order line it represents. Enables per-line GMV report',
    `listing_offer_id` BIGINT COMMENT 'Reference to the specific seller offer accepted by the buyer for this transaction.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Marketplace transaction-to-shipment traceability is a core e-commerce operation: SLA compliance reporting, dispute resolution, and post-purchase delivery tracking all require linking the marketplace t',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: marketplace_transaction is the core transactional record for the marketplace platform. Each transaction occurs on a specific marketplace. This FK is critical for GMV reporting by marketplace, marketpl',
    `marketplace_listing_id` BIGINT COMMENT 'Reference to the marketplace catalog listing that was purchased in this transaction.',
    `marketplace_promotion_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_promotion. Business justification: marketplace_transaction records completed transactions. When a transaction is influenced by a marketplace promotion (deal event, discount campaign), the transaction should reference which promotion wa',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.payment_method. Business justification: REQUIRED: Capturing the stored payment method used for each transaction supports PCI compliance, analytics, and dispute handling.',
    `payment_transaction_id` BIGINT COMMENT 'External transaction identifier from the payment gateway or payment processor for reconciliation and dispute resolution.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Required for Transaction Pricing Source Report to identify which price list was applied to calculate transaction totals, used in finance reconciliation.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: Enables Detailed Pricing Attribution linking each transaction to the exact price list item (SKU, tier) used, needed for margin analysis.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Supports profit‑center profitability reporting by linking each transaction to the responsible profit center.',
    `revenue_recognition_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition. Business justification: Each marketplace transaction triggers ASC 606 revenue recognition events (commission earned, take-rate revenue). Finance must trace recognized revenue back to the originating marketplace transaction f',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Commission auditing, fraud review, and seller payout reconciliation all require direct seller attribution on each transaction. Finance and compliance teams run seller-level transaction reports daily; ',
    `seller_settlement_id` BIGINT COMMENT 'Foreign key linking to marketplace.seller_settlement. Business justification: Each transaction is settled in a seller settlement period; adding seller_settlement_id to marketplace_transaction records which settlement the transaction belongs to.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Allows transaction‑level reconciliation to internal SKU for accurate inventory deduction and financial reporting.',
    `campaign_id` BIGINT COMMENT 'Identifier of the sponsored advertising campaign if this transaction resulted from a sponsored listing.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Link sales transaction to stock position for real‑time inventory deduction and on‑hand stock reporting.',
    `tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.tax_record. Business justification: Each marketplace transaction is the direct taxable event for sales tax/VAT under marketplace facilitator laws. Finance needs marketplace_transaction→tax_record linkage for tax audit trails, ASC 606 co',
    `warehouse_node_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_node. Business justification: Inventory deduction and multi-node fulfillment reporting: a marketplace transaction must record which warehouse_node fulfilled the order for stock deduction, seller settlement reconciliation, and node',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Brand-specific commission schedules are standard in e-commerce (exclusive brand deals, premium brand lower rates, vendor-funded commission tiers). commission_schedule already has category_id; brand_id',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Commission schedules are applied per product category; a FK ensures accurate fee calculation and compliance reporting.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Commission schedules define revenue rates that map to specific GL accounts for revenue posting. Finance uses commission_schedule→GL mapping to automate revenue recognition journal entries and ensure c',
    `listing_category_id` BIGINT COMMENT 'Foreign key linking to marketplace.listing_category. Business justification: Commission schedules in marketplace platforms are typically defined at the marketplace listing category level (e.g., Electronics: 8%, Clothing: 15%). commission_schedule already references product.cat',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Commission schedules are scoped to marketplace verticals/segments tracked as profit centers. Finance uses this for segment P&L reporting — different commission structures per profit center enable take',
    `tier_id` BIGINT COMMENT 'Foreign key linking to seller.tier. Business justification: Commission schedules are tier-gated in e-commerce — the correct rate card is selected based on seller tier. seller_tier_code is a denormalized plain-text copy of seller.tier.tier_code; replacing it wi',
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
    `updated_by` STRING COMMENT 'Identifier of the internal user or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `variable_fee_structure` STRING COMMENT 'Textual definition of any variable fee components (e.g., tier‑based bonuses, volume discounts).',
    `version_number` STRING COMMENT 'Incremental version number for change management and audit.',
    `created_by` STRING COMMENT 'Identifier of the internal user or system that created the schedule.',
    CONSTRAINT pk_commission_schedule PRIMARY KEY(`commission_schedule_id`)
) COMMENT 'Reference master defining the commission rate structures applied to marketplace transactions by seller tier, product category, fulfillment type, and promotional period. Captures commission schedule name, applicable seller tier, product category path, base commission rate percentage, variable fee structure, minimum and maximum fee caps, effective date range, currency, and schedule status. Drives automated commission calculation on marketplace transactions and seller settlement processing.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` (
    `seller_settlement_id` BIGINT COMMENT 'Unique system-generated identifier for the seller settlement record.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Seller settlement disbursements are AP obligations — the marketplace owes sellers net payouts. Finance reconciles seller_settlement records against AP entries to confirm disbursements cleared and trac',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost‑center allocation is required for internal reporting of settlement processing expenses.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Settlement payouts are recorded in the general ledger via a journal entry for each seller settlement.',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: Seller settlements are marketplace-specific — a seller operating on multiple marketplaces (e.g., US and EU) receives separate settlement disbursements per marketplace. Adding marketplace_id FK enables',
    `promotional_campaign_id` BIGINT COMMENT 'Foreign key linking to pricing.promotional_campaign. Business justification: Seller settlements include promotional_credits_amount funded by pricing promotional campaigns. Finance reconciliation and promotional budget reporting require tracing which promotional campaign funded',
    `seller_profile_id` BIGINT COMMENT 'Identifier of the marketplace seller receiving the settlement.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to payment.settlement. Business justification: Seller settlement disbursements are funded by and reconciled against payment settlement batches. Finance and treasury teams must trace which payment.settlement batch funded each seller_settlement for ',
    `tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.tax_record. Business justification: Seller settlements include tax_withheld_amount. The corresponding tax_record captures the withholding tax filing obligation. Finance reconciles withheld taxes from settlements against tax_record for r',
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
    `settlement_start_date` DATE COMMENT 'First calendar date of the settlement period.',
    `settlement_type` STRING COMMENT 'Indicates whether the settlement is periodic (e.g., weekly) or ad‑hoc.',
    `tax_withheld_amount` DECIMAL(18,2) COMMENT 'Amount of tax withheld from the sellers payout as required by jurisdictional regulations.',
    `total_commission_amount` DECIMAL(18,2) COMMENT 'Sum of marketplace commissions deducted from the sellers gross sales.',
    CONSTRAINT pk_seller_settlement PRIMARY KEY(`seller_settlement_id`)
) COMMENT 'Transactional record capturing the periodic financial settlement disbursed to marketplace sellers. Tracks settlement period start and end dates, seller identifier, gross sales amount, total commissions deducted, refund deductions, promotional funding credits, net disbursement amount, settlement currency, disbursement status (pending, processing, disbursed, on-hold), bank transfer reference, and settlement generation timestamp. Supports seller financial reconciliation and SOX-compliant revenue reporting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`dispute` (
    `dispute_id` BIGINT COMMENT 'System-generated unique identifier for the dispute record.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Dispute resolutions involving refunds or chargebacks create AR adjustments, credit memos, or write-offs. Finance teams link dispute outcomes to AR records for credit memo processing, bad debt provisio',
    `agent_id` BIGINT COMMENT 'Identifier of the marketplace agent responsible for handling the dispute.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Dispute investigation requires fulfillment details: marketplace dispute agents pull fulfillment_order records (pick/pack timestamps, carrier, SLA status) to adjudicate wrong-item, not-delivered, and d',
    `header_id` BIGINT COMMENT 'Identifier of the order that is the subject of the dispute.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Dispute resolutions (refunds, chargebacks, fee reversals) generate journal entries for accounting. Finance auditors trace dispute outcomes to journal entries for SOX compliance and period-close accura',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: Disputes occur on a specific marketplace platform. Linking dispute to marketplace enables marketplace-level dispute analytics, SLA compliance reporting by marketplace, and FTC disclosure tracking per ',
    `marketplace_transaction_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_transaction. Business justification: A dispute is always about a specific marketplace transaction; linking dispute to marketplace_transaction provides the necessary reference.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Dispute management requires direct seller attribution — seller operations teams query open disputes by seller for SLA tracking, enforcement action, and seller scorecarding. Reaching seller via marketp',
    `support_case_id` BIGINT COMMENT 'Foreign key linking to service.service_support_case. Business justification: Dispute resolution creates a support case; the link ties dispute records to the corresponding case for end‑to‑end tracking.',
    `tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.tax_record. Business justification: Dispute refund resolutions require tax adjustments — VAT/sales tax credit notes must be filed when refunds are issued. Tax compliance teams link dispute outcomes to tax_record for amended tax filings ',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`listing_category` (
    `listing_category_id` BIGINT COMMENT 'Unique identifier for the marketplace listing category.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Marketplace listing taxonomy must map to product catalog taxonomy for cross-channel category reporting, commission inheritance, and compliance rule propagation. Role-prefix catalog_ distinguishes th',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: listing_category defines the marketplace-specific product category taxonomy. The domain description explicitly states it is marketplace-specific product category taxonomy used for listing classificat',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` (
    `marketplace_promotion_id` BIGINT COMMENT 'Unique system-generated identifier for the promotion.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Marketplace promotions are targeted to defined audience segments (loyalty tiers, Prime members). Linking to audience_segment enforces referential integrity and enables segment-level promotion performa',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Brand-funded promotions (vendor-sponsored deals, brand days, co-op advertising events) are a standard e-commerce revenue stream. marketplace_promotion needs brand_id to track which brand is funding or',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Marketplace promotions are frequently funded by or co-ordinated with marketing campaigns (co-op advertising, campaign-funded flash sales). Promotional ROI attribution and campaign spend reconciliation',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Shipping promotions (e.g., free 2-day delivery, discounted express shipping) are tied to specific carrier services in e-commerce operations. Linking marketplace_promotion to carrier_service enables pr',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Category-scoped promotions (Electronics sale, Apparel clearance) are a core e-commerce merchandising operation. marketplace_promotion.eligibility_criteria is a text field; a proper FK to product.categ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Marketplace promotions are funded by specific cost centers (marketing budget, seller-funded promotions). Finance allocates promotional spend to cost centers for P&L reporting and budget variance analy',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Promotional discounts and funding are posted to specific GL accounts (promotional expense, contra-revenue). Finance maps promotions to GL accounts for expense recognition and financial statement class',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: marketplace_promotion represents marketplace-level promotional campaigns. The entity name itself implies marketplace ownership. A promotion runs on a specific marketplace (e.g., Prime Day on US market',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: Promotions are defined at the listing level; adding marketplace_listing_id FK ties each promotion to its target listing.',
    `promotional_campaign_id` BIGINT COMMENT 'Foreign key linking to pricing.promotional_campaign. Business justification: A marketplace_promotion is the execution of an upstream pricing promotional_campaign. Finance and pricing teams reconcile promotional spend by tracing marketplace promotions back to their originating ',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Seller-funded promotions (deals, coupons) require tracking which seller is funding and accepting the promotion. seller_acceptance_required flag on marketplace_promotion confirms seller involvement; wi',
    `budget_cap_amount` DECIMAL(18,2) COMMENT 'Maximum total monetary value the promotion can consume across all enrollments.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 currency code for the promotion budget.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount subtracted when the discount mechanism is fixed amount based.',
    `discount_mechanism` STRING COMMENT 'Method used to calculate the promotional discount.. Valid values are `percentage|fixed_amount|buy_one_get_one|tiered|bundle_price`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage value applied when the discount mechanism is percentage based.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which listings or sellers may enroll in the promotion.',
    `end_date` DATE COMMENT 'Date when the promotion expires or is no longer applicable.',
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
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the promotion record.',
    CONSTRAINT pk_marketplace_promotion PRIMARY KEY(`marketplace_promotion_id`)
) COMMENT 'Master entity representing marketplace-level promotional campaigns, deal events, and their enrolled listing associations. Captures promotion lifecycle (name, type, status, date range, discount mechanics, funding source, budget cap, FTC disclosure requirements) and listing enrollment details as child records (enrolled listing references, promotional pricing, quantity limits, seller acceptance status, enrollment source, enrollment date, eligibility score at enrollment, enrollment status). Supports lightning deals, deal-of-the-day, coupons, bundle deals, and seasonal events. Manages the many-to-many relationship between promotions and marketplace listings including enrollment workflows and seller opt-in tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`marketplace` (
    `marketplace_id` BIGINT COMMENT 'Primary key for marketplace',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each marketplace entity (regional or vertical marketplace) maps to a cost center for operational expense tracking and budget allocation. Finance allocates marketplace operating costs by cost center fo',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier of the owning organization.',
    `parent_marketplace_id` BIGINT COMMENT 'Self-referencing FK on marketplace (parent_marketplace_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Each marketplace maps to a profit center for segment P&L reporting. Finance requires marketplace→profit_center for GMV-to-revenue attribution, take-rate reporting, and management segment reporting — f',
    `average_order_value` DECIMAL(18,2) COMMENT 'Mean monetary value of orders processed on the marketplace.',
    `buyer_count` BIGINT COMMENT 'Count of distinct buyer accounts that have placed at least one order.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance state of the marketplace.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the marketplace record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Default transaction currency for the marketplace, using ISO 4217 codes.',
    `data_classification` STRING COMMENT 'Classification level applied to data originating from this marketplace.',
    `gmv_annual` DECIMAL(18,2) COMMENT 'Total value of goods and services transacted on the marketplace in the most recent fiscal year.',
    `is_ftc_compliant` BOOLEAN COMMENT 'True if the marketplace meets FTC advertising disclosure requirements.',
    `is_spam_protected` BOOLEAN COMMENT 'True if the marketplace employs anti‑spam measures for listings and communications.',
    `launch_date` DATE COMMENT 'Date the marketplace was first made available to sellers and buyers.',
    `marketplace_code` STRING COMMENT 'External business code used to reference the marketplace in contracts and reporting.',
    `marketplace_description` STRING COMMENT 'Free‑form text describing the marketplaces purpose, target audience, and unique features.',
    `marketplace_name` STRING COMMENT 'Human‑readable name of the marketplace (e.g., US Marketplace, EU Marketplace).',
    `marketplace_status` STRING COMMENT 'Current operational status of the marketplace.',
    `marketplace_type` STRING COMMENT 'Category of marketplace based on scope and product focus.',
    `owner` STRING COMMENT 'Name of the internal business unit or legal entity that owns the marketplace.',
    `privacy_policy_url` STRING COMMENT 'Web address of the marketplaces privacy policy document.',
    `region` STRING COMMENT 'Primary geographic region the marketplace serves, expressed as a 3‑letter ISO country code.',
    `seller_count` BIGINT COMMENT 'Count of distinct seller accounts actively listing on the marketplace.',
    `termination_date` DATE COMMENT 'Date the marketplace was permanently closed or retired (null if still active).',
    `terms_of_service_url` STRING COMMENT 'Web address of the marketplaces terms of service document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the marketplace record.',
    CONSTRAINT pk_marketplace PRIMARY KEY(`marketplace_id`)
) COMMENT 'Master reference table for marketplace. Referenced by marketplace_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` (
    `promotion_category_enrollment_id` BIGINT COMMENT 'Primary key for the promotion_category_enrollment association',
    `listing_category_id` BIGINT COMMENT 'Foreign key linking to the marketplace listing category participating in the promotion.',
    `marketplace_promotion_id` BIGINT COMMENT 'Foreign key linking to the promotional campaign this category is enrolled in.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The specific discount percentage applied to listings in this category within this promotion. May differ per category enrolled in the same promotion. Sourced from discount_percentage identified in detection phase.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which listings within this category qualify for the promotion enrollment. Sourced from eligibility_criteria identified in detection phase.',
    `end_date` DATE COMMENT 'Date when this categorys enrollment window closes for the promotion. Sourced from enrollment_end_date identified in detection phase.',
    `enrollment_end_date` DATE COMMENT 'Date when the enrollment window closes for the promotion. [Moved from marketplace_promotion: Same reasoning as enrollment_start_date — the enrollment window close date is specific to each category-promotion pairing, not a single value on the promotion master record.]',
    `enrollment_source` STRING COMMENT 'Origin of the enrollment request for a listing. [Moved from marketplace_promotion: The origin of the enrollment request (e.g., seller-initiated, platform-initiated, bulk upload) is specific to each category-promotion enrollment event, not a property of the promotion itself.]. Valid values are `auto|seller_opt_in|admin`',
    `enrollment_start_date` DATE COMMENT 'Date when the enrollment window opens for the promotion. [Moved from marketplace_promotion: This date governs the enrollment window for a specific category within a promotion, not the promotion as a whole. When a promotion covers multiple categories, each category may have a different enrollment window. It belongs to the association, not to marketplace_promotion.]',
    `enrollment_status` STRING COMMENT 'Current processing state of a listings enrollment request. [Moved from marketplace_promotion: The enrollment status tracks the lifecycle of a specific categorys participation in a promotion. A promotion can have some categories in ACTIVE status and others in PENDING or REJECTED — this state belongs to the association record, not the promotion.]. Valid values are `pending|accepted|rejected|withdrawn`',
    `promotion_category_enrollment_status` STRING COMMENT 'Current lifecycle state of this categorys enrollment in the promotion. Sourced from enrollment_status identified in detection phase.',
    `start_date` DATE COMMENT 'Date when this categorys enrollment window opens for the promotion. Sourced from enrollment_start_date identified in detection phase.',
    CONSTRAINT pk_promotion_category_enrollment PRIMARY KEY(`promotion_category_enrollment_id`)
) COMMENT 'This association product represents the Enrollment event between marketplace_promotion and listing_category. It captures the operational record of a specific product category being enrolled in a specific promotional campaign, including the enrollment lifecycle, applicable discount terms for that category within the promotion, and the date window during which the enrollment is active. Each record links one marketplace_promotion to one listing_category with attributes that exist only in the context of this category-level promotional participation.. Existence Justification: In marketplace operations, promotional campaigns are explicitly scoped to specific product categories — a Deal of the Day or Lightning Deal targets Electronics, Apparel, or other category nodes with distinct discount rules and enrollment windows. One promotion covers many categories simultaneously, and one category participates in many promotions over time (seasonal events, flash sales, coupon campaigns). The business actively manages this as promotion_category_enrollment — a named operational concept with its own lifecycle, dates, status, and discount terms that belong neither to the promotion nor the category alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_commission_schedule_id` FOREIGN KEY (`commission_schedule_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`commission_schedule`(`commission_schedule_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_listing_category_id` FOREIGN KEY (`listing_category_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_category`(`listing_category_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_commission_schedule_id` FOREIGN KEY (`commission_schedule_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`commission_schedule`(`commission_schedule_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_listing_category_id` FOREIGN KEY (`listing_category_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_category`(`listing_category_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_commission_schedule_id` FOREIGN KEY (`commission_schedule_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`commission_schedule`(`commission_schedule_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_listing_offer_id` FOREIGN KEY (`listing_offer_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_offer`(`listing_offer_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_marketplace_promotion_id` FOREIGN KEY (`marketplace_promotion_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_promotion`(`marketplace_promotion_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_seller_settlement_id` FOREIGN KEY (`seller_settlement_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`seller_settlement`(`seller_settlement_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ADD CONSTRAINT `fk_marketplace_commission_schedule_listing_category_id` FOREIGN KEY (`listing_category_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_category`(`listing_category_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ADD CONSTRAINT `fk_marketplace_seller_settlement_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ADD CONSTRAINT `fk_marketplace_listing_category_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ADD CONSTRAINT `fk_marketplace_listing_category_parent_category_listing_category_id` FOREIGN KEY (`parent_category_listing_category_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_category`(`listing_category_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ADD CONSTRAINT `fk_marketplace_marketplace_parent_marketplace_id` FOREIGN KEY (`parent_marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ADD CONSTRAINT `fk_marketplace_promotion_category_enrollment_listing_category_id` FOREIGN KEY (`listing_category_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_category`(`listing_category_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ADD CONSTRAINT `fk_marketplace_promotion_category_enrollment_marketplace_promotion_id` FOREIGN KEY (`marketplace_promotion_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_promotion`(`marketplace_promotion_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`marketplace` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `ecommerce_ecm`.`marketplace` SET TAGS ('dbx_domain' = 'marketplace');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` SET TAGS ('dbx_subdomain' = 'listing_catalog');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `commission_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `listing_category_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `advertised` SET TAGS ('dbx_business_glossary_term' = 'Advertising Disclosure Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `buy_box_eligible` SET TAGS ('dbx_business_glossary_term' = 'Buy Box Eligibility');
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
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Listing Title');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Listing Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Product Width (cm)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` SET TAGS ('dbx_subdomain' = 'listing_catalog');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `listing_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Offer ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `commission_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `dynamic_price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `listing_category_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Sla Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `buy_box_winner_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy Box Winner Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `buyer_feedback_score` SET TAGS ('dbx_business_glossary_term' = 'Buyer Feedback Score (0‑5)');
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
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `is_gift_wrap_available` SET TAGS ('dbx_business_glossary_term' = 'Gift‑Wrap Availability Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `is_prime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Prime Eligibility Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `is_returnable` SET TAGS ('dbx_business_glossary_term' = 'Returnable Flag');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `listing_offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ALTER COLUMN `listing_offer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suppressed');
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
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` SET TAGS ('dbx_subdomain' = 'seller_settlement');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `commission_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `commission_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Header Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `listing_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `marketplace_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Promotion Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Transaction ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `seller_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Settlement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Campaign ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` SET TAGS ('dbx_subdomain' = 'seller_settlement');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `commission_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `listing_category_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `variable_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Variable Fee Structure');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` SET TAGS ('dbx_subdomain' = 'seller_settlement');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `seller_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Settlement ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `settlement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Start Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withheld Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ALTER COLUMN `total_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Commission Amount');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` SET TAGS ('dbx_subdomain' = 'seller_settlement');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Order ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Support Case Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` SET TAGS ('dbx_subdomain' = 'listing_catalog');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `listing_category_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Category ID');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` SET TAGS ('dbx_subdomain' = 'listing_catalog');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `marketplace_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promotion Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` SET TAGS ('dbx_subdomain' = 'listing_catalog');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Identifier');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ALTER COLUMN `parent_marketplace_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` SET TAGS ('dbx_subdomain' = 'listing_catalog');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` SET TAGS ('dbx_association_edges' = 'marketplace.marketplace_promotion,marketplace.listing_category');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `promotion_category_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Category Enrollment - Promotion Category Enrollment Id');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `listing_category_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Category Enrollment - Listing Category Id');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `marketplace_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Category Enrollment - Marketplace Promotion Id');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Category Discount Percentage');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Category Eligibility Criteria');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date (ENROLL_END)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source (ENROLL_SRC)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'auto|seller_opt_in|admin');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date (ENROLL_START)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ENROLL_STATUS)');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|withdrawn');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `promotion_category_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `ecommerce_ecm`.`marketplace`.`promotion_category_enrollment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
