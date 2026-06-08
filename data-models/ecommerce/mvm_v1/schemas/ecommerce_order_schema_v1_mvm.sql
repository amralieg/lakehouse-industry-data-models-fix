-- Schema for Domain: order | Business: Ecommerce | Version: v1_mvm
-- Generated on: 2026-05-05 00:58:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`order` COMMENT 'Core transactional domain managing the full order lifecycle from cart submission through confirmed delivery. Owns order capture, OMS orchestration, order status tracking, cancellations, delivery confirmation, and order-level SLA management across B2C, B2B, and marketplace channels. Tracks AOV, CVR, and GMV at the order level.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`cart` (
    `cart_id` BIGINT COMMENT 'Unique identifier for the cart (primary key).',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Abandoned cart recovery and cart-creation attribution require linking each cart to the originating campaign (email, paid ad). Enables campaign-level cart conversion rate reporting and marketing ROI an',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Cart channel attribution (email, social, paid search, organic) drives channel-level conversion funnel analysis. The existing plain-text channel column is a denormalized string; replacing it with cha',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: In B2B e-commerce, a specific contact (buyer) initiates and owns a cart. This FK enables contact-level purchase attribution, approval workflow routing, and B2B procurement reporting — standard B2B mar',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who owns the cart.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.header. Business justification: When a cart is converted to a confirmed order, the resulting header record should be traceable from the originating cart. This FK enables cart-to-order conversion rate (CVR) analysis, abandoned cart r',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: CART PRICING CONTEXT: The cart calculates totals using a selected price list; persisting the list ID enables seamless order conversion.',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.customer_address. Business justification: Cart currently stores shipping address as denormalized plain columns violating 3NF. Linking to customer_address enables address pre-fill from saved addresses, address validation during checkout, and c',
    `wishlist_id` BIGINT COMMENT 'Foreign key linking to customer.wishlist. Business justification: Wishlist-to-cart conversion is a primary e-commerce funnel metric. Linking cart to the originating wishlist enables conversion rate reporting, abandoned cart recovery campaigns tied to wishlist intent',
    `abandonment_email_sent_flag` BOOLEAN COMMENT 'Indicates whether a cart abandonment email has been sent.',
    `abandonment_reason` STRING COMMENT 'Free‑text reason captured (if any) for why the cart was abandoned.',
    `cart_number` STRING COMMENT 'Business-facing cart identifier shown to customers and used in support.',
    `cart_source` STRING COMMENT 'System or integration source that created the cart.. Valid values are `web|app|api|partner|offline`',
    `cart_status` STRING COMMENT 'Current lifecycle status of the cart.. Valid values are `active|abandoned|converted|expired|cancelled`',
    `coupon_code` STRING COMMENT 'Promotional coupon applied to the cart, if any.',
    `coupon_discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the coupon discount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart was initially created (business event time).',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `device_type` STRING COMMENT 'Type of device used to create the cart.. Valid values are `desktop|mobile|tablet|other`',
    `discount_total_amount` DECIMAL(18,2) COMMENT 'Aggregate discount amount from coupons, promotions, and cart-level discounts.',
    `estimated_delivery_date` DATE COMMENT 'Projected delivery date based on shipping method and inventory.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart is scheduled to expire if not converted.',
    `gift_message` STRING COMMENT 'Optional message entered by the shopper for the gift recipient.',
    `ip_address` STRING COMMENT 'IP address of the client at cart creation.',
    `is_gift` BOOLEAN COMMENT 'Indicates whether the cart is marked as a gift purchase.',
    `item_count` STRING COMMENT 'Count of unique product SKUs in the cart.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent interaction with the cart.',
    `loyalty_points_applied` STRING COMMENT 'Number of loyalty points redeemed against the cart.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart record was first persisted in the data lake (audit).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cart record (audit).',
    `saved_for_later_flag` BOOLEAN COMMENT 'Indicates if the cart is marked as saved for later purchase.',
    `shipping_fee_estimated_amount` DECIMAL(18,2) COMMENT 'Estimated shipping cost for the cart.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of line-item prices before discounts, taxes, and shipping.',
    `tax_estimated_amount` DECIMAL(18,2) COMMENT 'Estimated tax calculated for the cart based on jurisdiction.',
    `total_estimated_amount` DECIMAL(18,2) COMMENT 'Final estimated amount payable after discounts, tax, and shipping.',
    `total_quantity` STRING COMMENT 'Sum of quantities across all cart items.',
    `total_volume_cm3` DECIMAL(18,2) COMMENT 'Aggregate volume of all items, used for logistics planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of all items in the cart, used for shipping calculations.',
    `user_agent` STRING COMMENT 'Browser or app user-agent string for the session.',
    `version` STRING COMMENT 'Optimistic concurrency version number for the cart record.',
    CONSTRAINT pk_cart PRIMARY KEY(`cart_id`)
) COMMENT 'Represents a customers active shopping cart prior to order submission. Captures session context, channel origin (B2C, B2B, marketplace, mobile app), cart creation and expiry timestamps, applied coupon codes, estimated totals, saved-for-later flag, and cart abandonment signals (last activity timestamp, abandonment email trigger status). Serves as the SSOT for pre-purchase intent and cart-to-order conversion tracking. This is the entry point of the order lifecycle — cart submission triggers order_header creation. Line-item details are held in the related cart_item product.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`cart_item` (
    `cart_item_id` BIGINT COMMENT 'Unique identifier for the cart line item.',
    `bundle_id` BIGINT COMMENT 'Identifier of the bundle to which this line belongs.',
    `cart_id` BIGINT COMMENT 'Identifier of the shopping cart that contains this item.',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: When a buyer adds a marketplace listing to cart, the specific listing (seller, price, condition, buy-box winner) must be captured for price-lock integrity, listing-level conversion analytics, and aban',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: Price audit and abandoned cart analysis require knowing which specific price_list_item was presented to the customer. Enables detection of price changes between cart creation and checkout, and support',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for real‑time inventory, pricing and fulfillment; cart item must map to the definitive SKU record used in downstream order processing.',
    `seller_profile_id` BIGINT COMMENT 'Identifier of the marketplace seller offering the product.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Real-time cart availability check: when a customer adds an item, the system queries stock_position for ATP qty, backorder status, and lot availability. E-commerce experts expect cart_item to reference',
    `added_timestamp` TIMESTAMP COMMENT 'Date and time when the item was added to the cart.',
    `backorder_estimate_date` DATE COMMENT 'Estimated date when the back‑ordered item will be available.',
    `coupon_applied` BOOLEAN COMMENT 'True if a coupon was applied to this line.',
    `coupon_code` STRING COMMENT 'Code of the coupon applied, if any.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `device_type` STRING COMMENT 'Type of device used during the add‑to‑cart action.. Valid values are `desktop|mobile|tablet`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to this line item.',
    `fulfillment_method` STRING COMMENT 'Chosen shipping or pickup method for the item.. Valid values are `standard|express|same_day|pickup|drone`',
    `gift_message` STRING COMMENT 'Optional message entered for the gift recipient.',
    `ip_address` STRING COMMENT 'IP address of the client at the time of add‑to‑cart.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `is_backorder` BOOLEAN COMMENT 'True if the item is currently back‑ordered.',
    `is_bundle` BOOLEAN COMMENT 'True if the item is part of a product bundle.',
    `is_gift` BOOLEAN COMMENT 'True if the item is marked as a gift.',
    `is_preorder` BOOLEAN COMMENT 'True if the item is a preorder.',
    `is_promotional` BOOLEAN COMMENT 'True if the item is part of a promotion.',
    `is_tax_exempt` BOOLEAN COMMENT 'True if the line is exempt from tax.',
    `item_status` STRING COMMENT 'Current lifecycle status of the cart line.. Valid values are `active|removed|saved|purchased|expired`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to this cart line.',
    `line_sequence` STRING COMMENT 'Ordinal position of the item within the cart.',
    `line_total` DECIMAL(18,2) COMMENT 'Final net amount for the line after discounts and tax.',
    `preorder_release_date` DATE COMMENT 'Release date when the preorder item becomes available.',
    `price_after_discount` DECIMAL(18,2) COMMENT 'Price after discount but before tax.',
    `price_before_discount` DECIMAL(18,2) COMMENT 'Original list price of the line before any promotional discounts.',
    `promotion_code` STRING COMMENT 'Code of the promotion applied to this line, if any.',
    `quantity` STRING COMMENT 'Number of units of the product requested in the cart.',
    `referral_source` STRING COMMENT 'Marketing source that drove the user to add the item.. Valid values are `email|ads|organic|social|affiliate`',
    `shipping_estimate_date` DATE COMMENT 'Projected date the item will be shipped to the customer.',
    `source_channel` STRING COMMENT 'Channel through which the item was added to the cart.. Valid values are `web|mobile|app|api`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax charged on this line item.',
    `tax_exemption_code` STRING COMMENT 'Code representing the reason for tax exemption.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per single unit at the moment the item was added to the cart.',
    CONSTRAINT pk_cart_item PRIMARY KEY(`cart_item_id`)
) COMMENT 'Individual line-level SKU entries within a shopping cart. Tracks SKU identifier, quantity requested, unit price at time of add-to-cart, seller ID for marketplace items, product variant details, and item-level promotional flags. Supports cart-to-order conversion analysis and CVR optimization.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`header` (
    `header_id` BIGINT COMMENT 'Primary key for header',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Required for B2B order processing: links each order to the corporate account used for billing and credit checks, enabling account‑level revenue and risk reporting.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Required for Audience Segment ROI analysis: associates each order with the targeted audience segment, supporting segment‑level conversion and spend efficiency reports.',
    `order_address_id` BIGINT COMMENT 'Reference to the address used for billing purposes.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for Campaign‑Order Performance tracking: directly ties an order to the originating marketing campaign (e.g., email or ad) for conversion and revenue attribution.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Required for Order‑Channel Attribution Report: links each order to the marketing channel that drove it, enabling ROI calculations and channel performance dashboards.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Captures the B2B contact person responsible for the order, essential for order support, invoicing, and compliance audit trails.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: REQUIRED: Allocate order fulfillment costs to a cost center for expense tracking and budgeting.',
    `customer_profile_id` BIGINT COMMENT 'Foreign key linking to customer.customer_profile. Business justification: Guest checkout orders have no account_id but must still reference a customer profile for order history, GDPR data subject requests, and post-purchase communications. A direct header→customer_profile F',
    `center_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center assigned to the order.',
    `header_order_address_id` BIGINT COMMENT 'Reference to the address where the order will be shipped.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: In multi-entity e-commerce operations, each order must be attributed to a legal entity for revenue recognition, intercompany accounting, VAT filing, and regulatory reporting. A finance domain expert w',
    `loyalty_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.loyalty_enrollment. Business justification: Loyalty points accrual requires knowing the exact enrollment active at order placement — not just the program. This FK drives points-earn calculations, tier qualification spend tracking, and loyalty a',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: Orders must be attributed to a specific marketplace for GMV reporting, marketplace-level SLA compliance, regulatory jurisdiction enforcement, and seller fee structures. order_source is a plain-text de',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to payment.merchant_account. Business justification: REQUIRED: Reconciliation reports need the merchant account that processed each order; linking order_header to merchant_account enables accurate financial statements and audit trails.',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.gateway. Business justification: REQUIRED: Operational dashboards track which payment gateway handled each order for SLA monitoring and compliance; a FK from order_header to gateway provides this linkage.',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.payment_method. Business justification: REQUIRED: Storing the tokenized payment method used for an order enables refunds, recurring billing, and fraud analysis; the FK links order_header to payment_method.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: ORDER PRICING AUDIT: Each order is priced using a specific price list; storing price_list_id enables price source traceability for compliance reports.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: REGIONAL PRICING: Orders are assigned to a price zone to apply region‑specific pricing rules; FK required for zone‑based revenue analysis.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: REQUIRED: Assign each order to a profit center for profit‑center performance reporting.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Needed for segment‑based order analytics and targeted marketing, allowing each order to be attributed to the customer segment at time of purchase.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the order header record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency identifier for the order.. Valid values are `^[A-Z]{3}$`',
    `delivery_actual_date` DATE COMMENT 'Date the order was actually delivered to the customer.',
    `delivery_estimated_date` DATE COMMENT 'Projected date for order delivery based on SLA.',
    `device_code` STRING COMMENT 'Identifier of the device used to place the order.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total promotional discounts applied to the order.',
    `fraud_score` STRING COMMENT 'Risk score assigned by fraud detection engine.',
    `internal_notes` STRING COMMENT 'Internal operational notes about the order, visible to staff only.',
    `ip_address` STRING COMMENT 'IP address of the client at order submission.',
    `is_backorder` BOOLEAN COMMENT 'True if any line items are on backorder at order creation.',
    `is_expedited` BOOLEAN COMMENT 'Indicates whether the order requires expedited handling.',
    `is_gift` BOOLEAN COMMENT 'Indicates whether the order is a gift purchase.',
    `is_split_shipment` BOOLEAN COMMENT 'True if the order will be fulfilled in multiple shipments.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes and discounts.',
    `order_comments` STRING COMMENT 'Free‑form comments entered by the customer or support staff.',
    `order_number` STRING COMMENT 'Human‑readable order identifier used in customer communications and external systems.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Exact moment the order was submitted by the customer.',
    `order_priority` STRING COMMENT 'Priority level used for fulfillment sequencing.. Valid values are `low|medium|high|critical`',
    `order_status` STRING COMMENT 'Current lifecycle state of the order.. Valid values are `pending|confirmed|shipped|delivered|cancelled|returned`',
    `order_type` STRING COMMENT 'Logical classification of the order (e.g., standard purchase, gift, subscription).. Valid values are `standard|gift|subscription`',
    `payment_reference` STRING COMMENT 'External identifier returned by the payment gateway.',
    `payment_status` STRING COMMENT 'Current processing state of the payment.. Valid values are `authorized|captured|settled|failed|refunded`',
    `promo_code` STRING COMMENT 'Code of any promotion applied to the order.',
    `sla_actual_minutes` STRING COMMENT 'Actual fulfillment time in minutes measured for the order.',
    `sla_target_minutes` STRING COMMENT 'Maximum allowed fulfillment time in minutes for the SLA tier.',
    `sla_tier` STRING COMMENT 'Service‑level agreement tier promised for the order.. Valid values are `standard|express|priority`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the order.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the order is exempt from tax.',
    `tax_exempt_reason` STRING COMMENT 'Reason code for tax exemption, if applicable.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross monetary value of the order before taxes, discounts, or fees.',
    `total_volume_cm3` DECIMAL(18,2) COMMENT 'Aggregate volume of all items in the order, expressed in cubic centimeters.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of all items in the order, expressed in kilograms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the order header.',
    CONSTRAINT pk_header PRIMARY KEY(`header_id`)
) COMMENT 'The authoritative master record for a confirmed customer order within the OMS. Captures the full order header including order number, channel (B2C, B2B, marketplace, BOPIS, DTC), order placement timestamp, customer reference, billing address, total GMV, AOV contribution, tax amount, discount amount, currency, order status, SLA tier, and payment reference. This is the SSOT for order-level identity and lifecycle management across all channels.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`line` (
    `line_id` BIGINT COMMENT 'Unique identifier for the order_order_line data product (auto-inserted pre-linking).',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: When a bundle is purchased, the order_line must reference the bundle for bundle-level return policy enforcement, fulfillment splitting, revenue attribution, and discount validation. cart_item already ',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Sponsored product and marketplace ad attribution requires campaign-level tracking at the line item — different SKUs in one order may be promoted by different campaigns. Enables product-level ROAS and ',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Carrier assignment per order line is required for carrier performance reporting and SLA compliance; e‑commerce ops track carrier_id for each line.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Each order line is fulfilled via a specific carrier service governing transit time, cost, and SLA. The existing shipping_method is a denormalized text field; a proper FK enables line-level shipping co',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Link enables compliance, merchandising and sales reporting by tying each order line to its master catalog item record.',
    `commission_id` BIGINT COMMENT 'Foreign key linking to seller.commission. Business justification: Each order line must reference the exact commission record applied at transaction time for commission auditing, seller dispute resolution, and accurate payout calculation. Commission rates change over',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: REQUIRED: Track line‑level cost allocation to cost centers for detailed expense reporting.',
    `dynamic_price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.dynamic_price_rule. Business justification: DYNAMIC PRICING LOG: When a dynamic pricing rule adjusts a line, storing the rule ID supports performance reporting and rule‑impact analysis.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: REQUIRED: Directly map each order line to a GL account for precise accounting postings.',
    `header_id` BIGINT COMMENT 'Identifier of the parent order header.',
    `markdown_schedule_id` BIGINT COMMENT 'Foreign key linking to pricing.markdown_schedule. Business justification: DISCOUNT AUDIT: A markdown schedule may be applied to a line; linking enables tracking of schedule source for discount compliance.',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line_item. Business justification: Drop-ship and vendor-fulfilled order reconciliation requires matching each order line to its specific PO line item for three-way match (ordered qty vs PO line qty vs received qty), price variance anal',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: LINE PRICE SOURCE: Order line price is calculated from a concrete price‑list item; FK allows audit of which item supplied the unit price.',
    `product_listing_id` BIGINT COMMENT 'Foreign key linking to product.product_listing. Business justification: Order lines are fulfilled against a specific channel listing capturing price, condition, seller, and channel at purchase time. This link enables channel-level sales reporting, seller commission calcul',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: REQUIRED: Attribute each order line to a profit center for granular margin analysis.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Drop‑ship fulfillment creates a PO per marketplace order line; linking enables PO tracking, cost allocation, and delivery ETA reporting.',
    `seller_profile_id` BIGINT COMMENT 'Identifier of the marketplace seller offering the product.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Order line needs a stable reference to the SKU entity for shipping, tax calculation and returns; replaces the denormalized sku string.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: PICK PLAN: Mapping each order line to a specific stock position is required for the warehouse picking system to generate accurate pick lists and optimize routing.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Drop-ship fulfillment routing, supplier performance attribution per order line, and returns routing to the correct supplier all require direct supplier identification on the order line. E-commerce pla',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment node assigned to this line.',
    `actual_delivery_date` DATE COMMENT 'Date the line was actually delivered to the customer.',
    `asin` STRING COMMENT 'Marketplace‑specific product identifier.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `dimensions_cm` STRING COMMENT 'Package dimensions formatted as LxWxH in centimeters.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute discount applied to this line.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to this line.',
    `fulfillment_status` STRING COMMENT 'Current status of the fulfillment process for this line.. Valid values are `allocated|picked|packed|shipped|delivered|failed`',
    `fulfillment_type` STRING COMMENT 'Method by which the line is fulfilled.. Valid values are `warehouse|drop_ship|store_pickup|third_party`',
    `hazardous_material_flag` BOOLEAN COMMENT 'True if the product is classified as hazardous.',
    `is_backordered` BOOLEAN COMMENT 'True if the line is currently on backorder.',
    `is_gift` BOOLEAN COMMENT 'True if the line is marked as a gift for the recipient.',
    `is_returnable` BOOLEAN COMMENT 'Indicates whether the product can be returned under policy.',
    `line_status` STRING COMMENT 'Current lifecycle status of the order line.. Valid values are `pending|confirmed|shipped|delivered|canceled|returned`',
    `product_name` STRING COMMENT 'Human‑readable name of the product.',
    `promised_delivery_date` DATE COMMENT 'Date promised to the customer for delivery of this line.',
    `quantity_fulfilled` STRING COMMENT 'Number of units actually shipped to the customer.',
    `quantity_ordered` STRING COMMENT 'Number of units requested by the customer.',
    `restricted_item_flag` BOOLEAN COMMENT 'True if the product is subject to sales restrictions.',
    `return_window_days` STRING COMMENT 'Number of days after delivery during which a return is allowed.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax charged for this line.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the line is exempt from tax.',
    `tax_jurisdiction` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code indicating the tax authority for this line.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `total_gross` DECIMAL(18,2) COMMENT 'Total amount before tax and after discounts (quantity × unit_price – discount).',
    `total_net` DECIMAL(18,2) COMMENT 'Final amount after tax (gross total + tax_amount).',
    `tracking_number` STRING COMMENT 'Carrier‑provided tracking identifier for the shipment.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit before discounts and taxes.',
    `upc` STRING COMMENT 'Global barcode identifier for the product.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of the line item in kilograms.',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Individual SKU-level line items within a confirmed order. Captures SKU/ASIN/UPC, product name, quantity ordered/fulfilled, unit selling price, line-level discount, line total, seller ID for marketplace orders, fulfillment node assignment, line status, promised delivery date, and line-level tax details (jurisdiction, rate, amount, exemption status). Supports GMV decomposition, line-level fulfillment tracking, returns attribution, and tax compliance reporting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Unique surrogate identifier for each status transition record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the actor (user, system, seller, etc.) that performed the transition.',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this status transition belongs.',
    `support_case_id` BIGINT COMMENT 'Foreign key linking to service.service_support_case. Business justification: Order status changes triggered by service actions (RMA approvals, fraud holds, case-driven cancellations) require case linkage for audit trails, regulatory compliance reporting, and customer dispute r',
    `actor_type` STRING COMMENT 'Category of the entity that triggered the status change.. Valid values are `system|user|seller|partner`',
    `comment` STRING COMMENT 'Free‑form text providing additional context for the status change.',
    `is_system_generated` BOOLEAN COMMENT 'Indicates whether the transition was automatically generated by the system (true) or manually entered (false).',
    `reason_code` STRING COMMENT 'Standardized code explaining why the status changed (e.g., payment_failed, inventory_allocated).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this status history record was first inserted into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record (e.g., correction of comment).',
    `sla_actual_seconds` STRING COMMENT 'Actual elapsed time between the previous status and this transition, in seconds.',
    `sla_breach_flag` BOOLEAN COMMENT 'True if the actual duration exceeded the SLA target, otherwise false.',
    `sla_target_seconds` STRING COMMENT 'Configured service‑level‑agreement target time for this status transition, expressed in seconds.',
    `status_from` STRING COMMENT 'The order status before the transition occurred.',
    `status_to` STRING COMMENT 'The order status after the transition occurred.',
    `transition_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the status change was recorded.',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'Immutable audit log of all order lifecycle state transitions for a sales order. Records each status change event (e.g., PLACED → CONFIRMED → ALLOCATED → SHIPPED → DELIVERED → CANCELLED), the timestamp of transition, the actor or system that triggered the change, and any associated reason codes. Enables SLA breach detection, order lifecycle analytics, and OMS orchestration tracing.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`order_address` (
    `order_address_id` BIGINT COMMENT 'Unique surrogate key for the order address record.',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Provides audit link from the order shipping address to the customers saved address record, required for address change compliance and delivery performance analysis.',
    `address_type` STRING COMMENT 'Classification of the address purpose for the order (shipping, billing, or pickup).. Valid values are `shipping|billing|pickup`',
    `carrier_preference` STRING COMMENT 'Preferred shipping speed or carrier service level.. Valid values are `standard|express|overnight`',
    `city` STRING COMMENT 'City component of the address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was first created.',
    `delivery_instructions` STRING COMMENT 'Special instructions provided by the recipient for delivery.',
    `email_address` STRING COMMENT 'Primary email address for the recipient.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `external_address_reference` STRING COMMENT 'Identifier assigned by an external address verification or logistics provider.',
    `geocode_accuracy` STRING COMMENT 'Indicates the confidence level of the geocoding result.. Valid values are `high|medium|low`',
    `is_residential` BOOLEAN COMMENT 'True if the address is a residential location; false otherwise.',
    `label` STRING COMMENT 'Human‑readable label for the address (e.g., Home, Office).',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the address in decimal degrees.',
    `line1` STRING COMMENT 'First line of the street address.',
    `line2` STRING COMMENT 'Second line of the street address (optional).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the address in decimal degrees.',
    `order_address_status` STRING COMMENT 'Current lifecycle status of the address record.. Valid values are `active|inactive|archived`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the recipient.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address.',
    `recipient_name` STRING COMMENT 'Full legal name of the person receiving the shipment.',
    `state_province` STRING COMMENT 'State or province component of the address.',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the tax jurisdiction applicable to the address.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate for the address expressed as a percentage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the address record.',
    `validation_status` STRING COMMENT 'Result of address validation (valid, invalid, or partially valid).. Valid values are `valid|invalid|partial`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the address was last validated.',
    CONSTRAINT pk_order_address PRIMARY KEY(`order_address_id`)
) COMMENT 'Shipping and billing address records associated with a sales order. Stores address type (shipping/billing/pickup), recipient name, address lines, city, state/province, postal code, country, geolocation coordinates, address validation status, and residential vs. commercial flag. Supports last-mile delivery routing, tax jurisdiction determination, and fraud screening.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`order_payment` (
    `order_payment_id` BIGINT COMMENT 'Surrogate primary key for the order payment allocation record.',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to payment.authorization. Business justification: Treasury and dispute-resolution processes require tracing each captured order payment back to the specific authorization record (auth code, AVS/CVV result, hold expiry). Finance and fraud teams use th',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.gateway. Business justification: Split-payment scenarios route individual payment lines through different gateways with distinct fee structures and settlement cycles. Finance teams require per-payment-line gateway attribution for acc',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Every payment transaction must post to a GL account for period-end close, audit trail, and financial reporting. An e-commerce finance team expects each order_payment to be directly traceable to its GL',
    `gmv_settlement_id` BIGINT COMMENT 'Foreign key linking to seller.gmv_settlement. Business justification: Finance reconciliation requires knowing which GMV settlement period each order payment was included in. This FK enables payment-to-settlement traceability for audit, dispute resolution, and regulatory',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this payment allocation belongs.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: REQUIRED: Reconcile each payment to its accounting journal entry for audit and financial reporting.',
    `merchant_account_id` BIGINT COMMENT 'Identifier of the merchant (seller) receiving the payment.',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.method. Business justification: Split-payment processing requires per-line payment method tracking for fraud scoring, daily/monthly limit enforcement, and method-level revenue reporting. payment_method on order_payment is a denormal',
    `payment_transaction_id` BIGINT COMMENT 'Identifier of the payment transaction from the payment gateway.',
    `reconciliation_id` BIGINT COMMENT 'Foreign key linking to payment.reconciliation. Business justification: Period-close financial reporting requires tracing each order payment line to its reconciliation run to identify matched vs. unmatched lines and variance amounts. reconciliation_status on order_payment',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Required for marketplace split‑payment reconciliation; each payment line must be tied to the seller receiving funds, a standard financial report in e‑commerce.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to payment.settlement. Business justification: Settlement reconciliation reporting requires linking each order payment line to the settlement batch it was included in. Finance teams track which orders settled in which batch and on which date for p',
    `token_id` BIGINT COMMENT 'Foreign key linking to payment.token. Business justification: PCI-DSS compliance audit trails require recording which payment token was used for each order payment line. Security and compliance teams use this link to verify token scope, expiry, and usage counts ',
    `amount` DECIMAL(18,2) COMMENT 'Gross amount authorized for this payment allocation.',
    `audit_trail` STRING COMMENT 'JSON string capturing audit events for this payment allocation.',
    `authorization_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment was authorized.',
    `capture_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment was captured.',
    `channel` STRING COMMENT 'Channel through which the payment was initiated.. Valid values are `web|mobile|in_store|api`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was created in the data lake.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code of the payment.. Valid values are `[A-Z]{3}`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if settlement currency differs from transaction currency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Processing fee charged by the payment processor.',
    `fraud_check_status` STRING COMMENT 'Result of fraud detection checks for this payment.. Valid values are `passed|failed|pending`',
    `fraud_score` STRING COMMENT 'Numeric fraud risk score assigned by the payment gateway.',
    `is_gift_card` BOOLEAN COMMENT 'True if part of the payment was made using a gift card.',
    `is_refund` BOOLEAN COMMENT 'Indicates if this record represents a refund transaction.',
    `is_split_payment` BOOLEAN COMMENT 'Indicates if the order payment is part of a split payment across multiple methods.',
    `is_store_credit` BOOLEAN COMMENT 'True if part of the payment was made using store credit.',
    `line_quantity` STRING COMMENT 'Number of payment units allocated (typically 1).',
    `line_sequence` STRING COMMENT 'Sequence number of this payment allocation line within the payment transaction.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after taxes and fees.',
    `note` STRING COMMENT 'Additional notes or remarks about the payment.',
    `payment_description` STRING COMMENT 'Optional free-text description of the payment allocation.',
    `payment_status` STRING COMMENT 'Current status of the payment allocation.. Valid values are `authorized|captured|failed|refunded|partial|voided`',
    `reference` STRING COMMENT 'External reference or token from the payment gateway for this payment transaction.',
    `refunded_amount` DECIMAL(18,2) COMMENT 'Amount refunded for this payment allocation, if any.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the payment amount, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    CONSTRAINT pk_order_payment PRIMARY KEY(`order_payment_id`)
) COMMENT 'Order-level payment allocation records linking a sales order to one or more payment transactions. Captures payment method type, payment reference from the payment gateway, amount allocated to this order, currency, payment status (authorized, captured, failed, refunded), split-payment flags, and gift card or store credit redemption amounts. This is the order domains local reference to payment events — it does NOT own gateway integration, PCI-scoped card data, or settlement processing (those belong to the payment domain). Enables order-level payment reconciliation, refund eligibility checks, and revenue recognition without crossing domain boundaries.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`order_promotion` (
    `order_promotion_id` BIGINT COMMENT 'Unique identifier for the order promotion record.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Promotions are targeted to specific audience segments (VIP customers, lapsed buyers). Linking order_promotion to audience_segment enables segment-level promotion redemption analysis and validates targ',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that generated the promotion, if applicable.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Promotions are distributed through specific channels (email, push notification, social). Channel-level promotion redemption reporting — which channel drives the most coupon usage and discount spend — ',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Promotional discounts must post to specific GL accounts (discount expense, promotional accrual). E-commerce finance teams require promotional spend to be GL-coded for P&L reporting and marketing ROI a',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this promotion is applied.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: The order_promotion product description explicitly states promotions are applied at the order or line level. The existing header_id FK covers order-level promotions, but line-level promotions (e.g.,',
    `loyalty_program_id` BIGINT COMMENT 'Identifier of the loyalty program associated with the promotion, if applicable.',
    `marketplace_promotion_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_promotion. Business justification: When a marketplace promotion (deal, coupon, sponsored discount) is applied to an order, the order_promotion record must reference the originating marketplace_promotion for ROI reporting, FTC disclosur',
    `promotion_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.promotion_rule. Business justification: Compliance and audit processes require verifying the correct promotion_rule was applied to each order (correct discount value, stacking rules, max redemption limits). Without this FK, auditors cannot ',
    `promotional_campaign_id` BIGINT COMMENT 'Foreign key linking to pricing.promotional_campaign. Business justification: Promotion redemption reconciliation and promotional spend financial reporting require order_promotion to reference the specific pricing.promotional_campaign that authorized the discount. Pricing analy',
    `seller_profile_id` BIGINT COMMENT 'Identifier of the marketplace seller that funded or owns the promotion.',
    `applied_by` STRING COMMENT 'Mechanism that applied the promotion: system, customer service agent, or automated rule.. Valid values are `system|customer_service|automated`',
    `applied_timestamp` TIMESTAMP COMMENT 'Exact time when the promotion was applied to the order.',
    `audit_trail` STRING COMMENT 'JSON string capturing audit events related to the promotion record.',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance verification.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the promotion (e.g., GDPR, PCI).. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied (currency defined by discount_currency).',
    `discount_currency` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which discount_amount is expressed.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage value of the discount when promotion_type is percentage.',
    `eligibility_message` STRING COMMENT 'Human‑readable explanation when eligibility_status is ineligible or pending.',
    `eligibility_status` STRING COMMENT 'Result of promotion eligibility validation for this order.. Valid values are `eligible|ineligible|pending`',
    `end_date` DATE COMMENT 'Date when the promotion expires and can no longer be applied.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the promotion is currently active in the system.',
    `is_combination_allowed` BOOLEAN COMMENT 'Indicates if this promotion may be combined with other promotions beyond stacking_rule logic.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates if the promotion excludes all other promotions when applied.',
    `is_refunded` BOOLEAN COMMENT 'Indicates whether the promotion discount was later reversed or refunded.',
    `line_sequence` STRING COMMENT 'Ordinal position of the promotion within the orders promotion list.',
    `max_uses_per_customer` STRING COMMENT 'Maximum total number of times a single customer may use this promotion.',
    `max_uses_per_order` STRING COMMENT 'Maximum number of times this promotion can be applied within a single order.',
    `net_discount_amount` DECIMAL(18,2) COMMENT 'Discount amount after tax adjustments, if applicable.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or internal comments.',
    `order_promotion_description` STRING COMMENT 'Human‑readable description of the promotions purpose and mechanics.',
    `promotion_category` STRING COMMENT 'High‑level classification of the promotion for reporting.. Valid values are `discount|rebate|credit|gift`',
    `promotion_code` STRING COMMENT 'Business code that uniquely identifies the promotion rule.',
    `promotion_source` STRING COMMENT 'Origin of the promotion – marketing campaign, loyalty program, seller‑funded, or system generated.. Valid values are `marketing_campaign|loyalty_program|seller_funded|system_generated`',
    `promotion_type` STRING COMMENT 'Category of promotion: percentage discount, fixed amount, buy‑one‑get‑one, or free shipping.. Valid values are `percentage|fixed_amount|bogo|free_shipping`',
    `quantity_applied` STRING COMMENT 'Number of discount units applied (e.g., number of items covered by a BOGO).',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount refunded for the promotion, if any.',
    `refund_timestamp` TIMESTAMP COMMENT 'Time when the promotion refund was processed.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation or policy governing the promotion (e.g., GDPR, PCI DSS).',
    `stacking_rule` STRING COMMENT 'Rule that defines whether this promotion can be combined with other promotions.. Valid values are `stackable|non_stackable|conditional`',
    `start_date` DATE COMMENT 'Date when the promotion becomes valid for use.',
    `tax_exempt` BOOLEAN COMMENT 'Indicates whether the discount amount is exempt from sales tax.',
    `updated_by` STRING COMMENT 'System user or process that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the promotion record.',
    `created_by` STRING COMMENT 'System user or process that created the promotion record.',
    CONSTRAINT pk_order_promotion PRIMARY KEY(`order_promotion_id`)
) COMMENT 'Records of promotions, discount codes, and coupons applied at the order or line level. Captures promotion code, promotion type (percentage discount, fixed amount, BOGO, free shipping), discount amount applied, promotion source (marketing campaign, loyalty program, seller-funded), eligibility validation status, and stacking rules applied. Supports GMV-net-of-discount reporting and ROAS attribution.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`tax` (
    `tax_id` BIGINT COMMENT 'Unique surrogate key for each tax line applied to an order.',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this tax line belongs.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Tax can be applied at the line level; adding order_line_id FK enables precise tax calculations per line and removes ambiguity of using only header_id.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Tax compliance requires attributing tax amounts to the responsible seller for jurisdictional reporting and settlement.',
    `tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.tax_record. Business justification: The order.tax table captures operational tax calculations; finance.tax_record captures the official tax filing record. Linking them enables tax reconciliation between calculated and filed amounts — a ',
    `amount` DECIMAL(18,2) COMMENT 'Calculated monetary tax amount (taxable_amount * tax_rate).',
    `calculation_timestamp` TIMESTAMP COMMENT 'Exact time when the tax engine performed the calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction (e.g., USD, EUR).',
    `engine_reference` STRING COMMENT 'Opaque identifier returned by the tax calculation engine for audit and traceability.',
    `exempt_flag` BOOLEAN COMMENT 'Indicates whether the tax was exempted for this order line (true = exempt, false = taxable).',
    `exemption_reason` STRING COMMENT 'Reason code or description for tax exemption, if applicable.',
    `jurisdiction_code` STRING COMMENT 'Code representing the tax jurisdiction (state, province, country) that governs the tax calculation.',
    `line_sequence` STRING COMMENT 'Sequential number of the tax line within the order for ordering purposes.',
    `nexus_country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code where tax nexus exists.',
    `nexus_state` STRING COMMENT 'State or province code within the nexus country that creates tax liability.',
    `rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a decimal (e.g., 0.0750 for 7.5%).',
    `tax_status` STRING COMMENT 'Current processing status of the tax line.. Valid values are `applied|reversed|pending|error`',
    `tax_type` STRING COMMENT 'Category of tax applied: sales tax, VAT, GST, customs duty, or other.. Valid values are `sales_tax|vat|gst|customs_duty|other`',
    `taxable_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the order line(s) that is subject to this tax.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tax record.',
    CONSTRAINT pk_tax PRIMARY KEY(`tax_id`)
) COMMENT 'Tax calculation and jurisdiction records applied to a sales order. Captures tax jurisdiction code, tax type (sales tax, VAT, GST, customs duty), taxable amount, tax rate applied, tax amount, tax exemption status, nexus state/country, and the tax engine calculation reference. Supports SOX-compliant tax reporting, GDPR-aligned data residency, and cross-border e-commerce compliance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`cancellation` (
    `cancellation_id` BIGINT COMMENT 'System-generated unique identifier for the cancellation event.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Cancellations must clear or reduce the corresponding AR balance — a core AR cash application and credit memo process. E-commerce AR teams need to trace which AR record is reversed by each cancellation',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Stop-ship/stop-pick workflow: when an order is cancelled, the corresponding fulfillment_order must be halted immediately. Operations need this direct link to trigger cancellation in the WMS/fulfillmen',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Cancellations trigger GL reversal postings (revenue reversal, refund accruals). Finance teams require cancellation records to reference the GL account for period-end accuracy and audit compliance. No ',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this cancellation applies.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Cancellations generate journal entries (revenue reversal, refund liability postings). Linking cancellation to its journal entry provides the audit trail required for SOX compliance and period-end clos',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: The cancellation product description explicitly states it records order or order-line cancellation events. The existing header_id FK covers order-level cancellations, but partial/line-level cancella',
    `payment_refund_id` BIGINT COMMENT 'Foreign key linking to payment.payment_refund. Business justification: The cancellation-to-refund lifecycle is a core e-commerce operational process: customer service and finance must trace each cancellation to the resulting refund record for SLA tracking, refund status ',
    `rma_id` BIGINT COMMENT 'Foreign key linking to service.rma. Business justification: Post-shipment cancellations convert to RMAs; linking cancellation to the resulting RMA enables end-to-end refund processing, inventory restocking coordination, and customer service case resolution. E-',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Seller cancellation rate (scorecard KPI) and commission reversal in gmv_settlement require linking each cancellation directly to the responsible seller. Seller ops teams use this for performance monit',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Order cancellation triggers inventory release back to available stock. The cancellation record must reference the specific stock_position to restore on_hand_qty and release reserved_qty. E-commerce in',
    `actor` STRING COMMENT 'Entity that initiated the cancellation request.. Valid values are `customer|seller|system|fraud|payment_gateway`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the cancellation request was approved.',
    `cancellation_number` STRING COMMENT 'Human‑readable cancellation reference number used in communications and reporting.',
    `cancellation_status` STRING COMMENT 'Current lifecycle status of the cancellation request.. Valid values are `requested|approved|rejected|completed|cancelled`',
    `cancellation_type` STRING COMMENT 'Specifies the domain of the cancellation (e.g., order‑level, line‑item, shipment, payment).. Valid values are `order|order_line|shipment|payment`',
    `cancelled_amount` DECIMAL(18,2) COMMENT 'Monetary value of the cancelled items before any refunds.',
    `cancelled_quantity` STRING COMMENT 'Total quantity of items cancelled (relevant for partial cancellations).',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the cancellation process reached its final state (refunded or closed).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cancellation record was first created in the system.',
    `is_partial` BOOLEAN COMMENT 'True if the cancellation is partial; false if it is a full order cancellation.',
    `notes` STRING COMMENT 'Additional free‑form comments or internal notes about the cancellation.',
    `reason_code` STRING COMMENT 'Standardized code representing why the cancellation occurred.. Valid values are `customer_initiated|out_of_stock|fraud_hold|seller_cancellation|payment_failure|other`',
    `reason_description` STRING COMMENT 'Free‑text description providing additional context for the cancellation reason.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount to be refunded to the customer as a result of the cancellation.',
    `refund_currency` STRING COMMENT 'Three‑letter ISO currency code of the refund amount.. Valid values are `^[A-Z]{3}$`',
    `refund_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the cancellation qualifies for a refund according to policy.',
    `refund_processed_timestamp` TIMESTAMP COMMENT 'Timestamp when the refund was actually processed and posted.',
    `rejected_timestamp` TIMESTAMP COMMENT 'Timestamp when the cancellation request was rejected.',
    `rejection_reason` STRING COMMENT 'Explanation why a cancellation request was denied.',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp when the cancellation was initially requested.',
    `scope` STRING COMMENT 'Indicates whether the cancellation applies to the entire order or only specific line items.. Valid values are `full|partial`',
    `source_channel` STRING COMMENT 'Channel through which the cancellation request was received.. Valid values are `web|mobile_app|call_center|api|store`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cancellation record.',
    CONSTRAINT pk_cancellation PRIMARY KEY(`cancellation_id`)
) COMMENT 'Records of order or order-line cancellation events initiated by customers, sellers, or the OMS. Captures cancellation request timestamp, reason code (customer-initiated, out-of-stock, fraud hold, seller cancellation, payment failure), status workflow (requested → approved/rejected → completed), refund eligibility, cancellation actor, and partial vs. full cancellation scope. Supports cancellation rate KPI tracking, GMV leakage analysis, and refund workflow triggering.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` (
    `delivery_confirmation_id` BIGINT COMMENT 'Primary key for delivery_confirmation',
    `fulfillment_shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_shipment. Business justification: Delivery SLA reporting and carrier performance: delivery_confirmation records the final delivery event and must reference the specific fulfillment_shipment for SLA compliance measurement, carrier disp',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this delivery confirmation belongs.',
    `actual_delivery_time_seconds` STRING COMMENT 'Measured time from order dispatch to successful delivery, in seconds.',
    `carrier_scan_reference` STRING COMMENT 'Reference code from the carriers scan event confirming hand‑off.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery confirmation record was first created in the lakehouse.',
    `delivery_attempt_number` STRING COMMENT 'Sequential count of delivery attempts made for this order.',
    `delivery_exception_code` STRING COMMENT 'Code indicating why a delivery attempt failed or was exceptional (e.g., address_not_found, recipient_unavailable).',
    `delivery_location_type` STRING COMMENT 'Physical type of the delivery location where the package was left.. Valid values are `door|locker|neighbor|pickup_point|other`',
    `delivery_status` STRING COMMENT 'Current status of the delivery after this confirmation event.. Valid values are `delivered|failed|returned|pending`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Exact date and time when the delivery was completed and confirmed.',
    `device_code` STRING COMMENT 'Identifier of the handheld device or scanner used to record the confirmation.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the delivery point.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the delivery point.',
    `notes` STRING COMMENT 'Free‑form text notes entered by the driver or carrier about the delivery.',
    `otp_verified` BOOLEAN COMMENT 'Indicates whether the OTP provided by the recipient was successfully verified.',
    `proof_of_delivery_method` STRING COMMENT 'Method used to capture proof of delivery (e.g., signature, photo, one‑time‑password).. Valid values are `signature|photo|otp|none`',
    `recipient_name` STRING COMMENT 'Name of the person who received the package, captured for signature or verification.',
    `recipient_signature_image_url` STRING COMMENT 'Link to the stored image of the recipients signature, if captured.',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'Planned date and time for delivery as per the order SLA.',
    `sla_delivery_time_seconds` STRING COMMENT 'Service‑level‑agreement target delivery time expressed in seconds.',
    `source_system` STRING COMMENT 'Originating system that generated the delivery confirmation (e.g., WMS, TMS, OMS).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this delivery confirmation record.',
    CONSTRAINT pk_delivery_confirmation PRIMARY KEY(`delivery_confirmation_id`)
) COMMENT 'Final delivery confirmation records for fulfilled orders. Captures actual delivery timestamp, delivery location type (door, locker, neighbor, pickup point), proof-of-delivery reference (signature, photo, OTP), carrier scan event reference, delivery attempt number, and delivery exception codes (failed attempt, returned to sender). This is the SSOT for confirmed delivery events within the order domain, distinct from logistics shipment tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` (
    `fulfillment_allocation_id` BIGINT COMMENT 'Primary key for fulfillment_allocation',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Fulfillment allocation selects a specific carrier service (e.g., FedEx Ground, UPS 2-Day) based on zone, SLA, and cost. This FK enables SLA enforcement, shipping cost estimation, and carrier performan',
    `center_id` BIGINT COMMENT 'FK to fulfillment.center.center_id — Order allocation to warehouse tracing. Without this FK, the OMS cannot determine which fulfillment center was assigned to process an order line — breaking allocation-to-dispatch traceability.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fulfillment costs (shipping, handling, warehouse) must be allocated to cost centers for operational P&L and management accounting. The fulfillment_allocation has cost_estimate fields but no cost cente',
    `delivery_zone_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_zone. Business justification: Allocation decisions are zone-driven — delivery zone determines SLA, carrier eligibility, and surcharges. The existing shipping_zone is a denormalized text field; replacing it with a proper FK to deli',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Allocation-to-fulfillment traceability: when inventory is allocated for an order line, it results in a fulfillment_order. Operations teams need this link for allocation reconciliation, split-shipment ',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: Allocation of inventory to an order line must reference the goods receipt that supplied the stock for accurate inventory and financial reconciliation.',
    `header_id` BIGINT COMMENT 'Identifier of the order to which this allocation belongs.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: The fulfillment_allocation product description explicitly states it Records the assignment of order lines to specific fulfillment nodes. The existing header_id FK provides order-level context, but t',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Drop-ship fulfillment allocations (is_drop_ship=true) must reference the fulfilling seller directly for routing, SLA tracking, and seller performance measurement. Without this FK, drop-ship allocation',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Fulfillment allocation commits specific inventory (SKU+lot+location) to an order. Direct reference to stock_position enables reserved_qty management, lot traceability, and expiry-date-first picking. w',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse, 3PL center, or seller location assigned to fulfill the line.',
    `allocated_quantity` STRING COMMENT 'Number of units allocated to the fulfillment node.',
    `allocation_method` STRING COMMENT 'Algorithm or rule used to select the fulfillment node.. Valid values are `nearest_node|lowest_cost|seller_fulfilled|zone_skipping|manual|algorithmic`',
    `allocation_rule_version` STRING COMMENT 'Version identifier of the allocation algorithm or rule set applied.',
    `allocation_source` STRING COMMENT 'Origin of the allocation decision (automated system, manual entry, API call, batch process).. Valid values are `system|manual|api|batch`',
    `allocation_status` STRING COMMENT 'Current state of the allocation decision.. Valid values are `pending|confirmed|picked|cancelled|failed|partial`',
    `allocation_timestamp` TIMESTAMP COMMENT 'Date and time when the allocation decision was made.',
    `carrier_preference` STRING COMMENT 'Preferred carrier or service level for the shipment.. Valid values are `standard|express|same_day|overnight|pickup|third_party`',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost of fulfilling the allocated quantity before taxes and shipping.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `dimensions_cm` STRING COMMENT 'Length x Width x Height expressed in centimeters.',
    `estimated_ship_date` DATE COMMENT 'Projected date the allocated items will be shipped.',
    `fulfillment_type` STRING COMMENT 'Category of fulfillment node handling the allocation.. Valid values are `warehouse|3pl|seller|dark_store|store_pickup`',
    `handling_instructions` STRING COMMENT 'Specific instructions for packing or handling the item.',
    `is_backorder` BOOLEAN COMMENT 'True if the allocated quantity is on backorder.',
    `is_drop_ship` BOOLEAN COMMENT 'True if the fulfillment is performed directly by the supplier.',
    `is_eligible_for_fast_ship` BOOLEAN COMMENT 'True if the line qualifies for accelerated shipping options.',
    `is_eligible_for_free_shipping` BOOLEAN COMMENT 'True if the line meets criteria for free shipping.',
    `is_expedited` BOOLEAN COMMENT 'True if the allocation is marked for expedited processing.',
    `is_fragile` BOOLEAN COMMENT 'True if the item requires special handling due to fragility.',
    `is_gift_wrap` BOOLEAN COMMENT 'True if the allocation includes gift‑wrap service.',
    `is_oversized` BOOLEAN COMMENT 'True if the item dimensions exceed standard handling limits.',
    `last_status_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status change for the allocation.',
    `line_sequence` STRING COMMENT 'Sequential position of the line within the order.',
    `notes` STRING COMMENT 'Free‑form comments from the allocation engine or operator.',
    `priority_flag` BOOLEAN COMMENT 'Marks the allocation as high priority for expedited handling.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the allocation record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation record.',
    `shipping_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated shipping charge for the allocated quantity.',
    `sla_actual_seconds` STRING COMMENT 'Actual elapsed time from allocation to shipment.',
    `sla_breach_flag` BOOLEAN COMMENT 'True if actual SLA exceeds the target.',
    `sla_target_seconds` STRING COMMENT 'Service‑level‑agreement target time for allocation fulfillment.',
    `split_shipment_flag` BOOLEAN COMMENT 'Indicates whether the order line is split across multiple nodes.',
    `tax_estimate` DECIMAL(18,2) COMMENT 'Estimated tax amount applicable to the allocation.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Sum of cost, shipping, and tax estimates for the allocation.',
    `volume_cubic_m` DECIMAL(18,2) COMMENT 'Physical volume of the allocated quantity.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of the allocated quantity.',
    CONSTRAINT pk_fulfillment_allocation PRIMARY KEY(`fulfillment_allocation_id`)
) COMMENT 'Records the assignment of order lines to specific fulfillment nodes (warehouses, 3PL centers, FBA-style nodes, seller locations, dark stores). Captures the fulfillment node ID, allocation timestamp, allocation method (nearest node, lowest cost, seller-fulfilled, zone-skipping), allocated quantity, allocation status (pending, confirmed, picked, cancelled), split-shipment flag, and estimated ship date. This is the order domains handoff point to the fulfillment domain — it owns the allocation decision, not the pick-pack-ship execution.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ADD CONSTRAINT `fk_order_cart_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `ecommerce_ecm`.`order`.`cart`(`cart_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_order_address_id` FOREIGN KEY (`order_address_id`) REFERENCES `ecommerce_ecm`.`order`.`order_address`(`order_address_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_header_order_address_id` FOREIGN KEY (`header_order_address_id`) REFERENCES `ecommerce_ecm`.`order`.`order_address`(`order_address_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ADD CONSTRAINT `fk_order_delivery_confirmation_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`order` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `ecommerce_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` SET TAGS ('dbx_subdomain' = 'cart_management');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Cart ID');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Header Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Customer Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `wishlist_id` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `abandonment_email_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Email Sent Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `abandonment_email_sent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `abandonment_email_sent_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `abandonment_reason` SET TAGS ('dbx_business_glossary_term' = 'Cart Abandonment Reason');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_number` SET TAGS ('dbx_business_glossary_term' = 'Cart Number (CART_NO)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_source` SET TAGS ('dbx_business_glossary_term' = 'Cart Source System');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_source` SET TAGS ('dbx_value_regex' = 'web|app|api|partner|offline');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_status` SET TAGS ('dbx_business_glossary_term' = 'Cart Status');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `cart_status` SET TAGS ('dbx_value_regex' = 'active|abandoned|converted|expired|cancelled');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `coupon_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Coupon Discount Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cart Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|other');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `discount_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cart Expiry Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `is_gift` SET TAGS ('dbx_business_glossary_term' = 'Gift Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Distinct Items in Cart');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `loyalty_points_applied` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Applied');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `saved_for_later_flag` SET TAGS ('dbx_business_glossary_term' = 'Saved For Later Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `shipping_fee_estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Shipping Fee Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Cart Subtotal Amount (Gross Base Amount)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `tax_estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tax Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `total_estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cart Amount (Net Total)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity of Items in Cart');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `total_volume_cm3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume of Cart Items (cm³)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight of Cart Items (kg)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Cart Record Version');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` SET TAGS ('dbx_subdomain' = 'cart_management');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `cart_item_id` SET TAGS ('dbx_business_glossary_term' = 'Cart Item Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Cart Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `added_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cart Item Added Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `backorder_estimate_date` SET TAGS ('dbx_business_glossary_term' = 'Backorder Estimated Delivery Date');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `coupon_applied` SET TAGS ('dbx_business_glossary_term' = 'Coupon Applied Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|pickup|drone');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `is_backorder` SET TAGS ('dbx_business_glossary_term' = 'Backorder Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `is_bundle` SET TAGS ('dbx_business_glossary_term' = 'Bundle Item Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `is_gift` SET TAGS ('dbx_business_glossary_term' = 'Gift Item Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `is_preorder` SET TAGS ('dbx_business_glossary_term' = 'Preorder Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `is_promotional` SET TAGS ('dbx_business_glossary_term' = 'Promotional Item Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Cart Item Status');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'active|removed|saved|purchased|expired');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cart Item Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `line_total` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `preorder_release_date` SET TAGS ('dbx_business_glossary_term' = 'Preorder Release Date');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `price_after_discount` SET TAGS ('dbx_business_glossary_term' = 'Net Price After Discount');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `price_before_discount` SET TAGS ('dbx_business_glossary_term' = 'List Price Before Discount');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'email|ads|organic|social|affiliate');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `shipping_estimate_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Shipping Date');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|app|api');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `tax_exemption_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Code');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (Percent)');
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`order`.`header` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Header Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address ID (BAID)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center ID (FCID)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `header_order_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address ID (SAID)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `header_order_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `header_order_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `loyalty_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `delivery_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ADD)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `delivery_estimated_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date (EDD)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (DID)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DA)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score (FS)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes (IN)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Customer IP Address (CIP)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `is_backorder` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag (BF)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `is_expedited` SET TAGS ('dbx_business_glossary_term' = 'Expedited Flag (EF)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `is_gift` SET TAGS ('dbx_business_glossary_term' = 'Gift Flag (GF)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `is_split_shipment` SET TAGS ('dbx_business_glossary_term' = 'Split Shipment Flag (SSF)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Order Amount (NOA)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_comments` SET TAGS ('dbx_business_glossary_term' = 'Order Comments (OC)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number (ON)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp (OPT)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority (OP)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status (OS)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|shipped|delivered|cancelled|returned');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type (OT)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|gift|subscription');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference (PR)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PS)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'authorized|captured|settled|failed|refunded');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `promo_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code (PC)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Minutes (SLAMA)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Minutes (SLATM)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'SLA Tier (SLAT)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|express|priority');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TA)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TEF)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason (TER)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount (TGA)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `total_volume_cm3` SET TAGS ('dbx_business_glossary_term' = 'Total Order Volume (CM3)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Order Weight (KG)');
ALTER TABLE `ecommerce_ecm`.`order`.`header` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`line` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for order_order_line');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `commission_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `dynamic_price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Price Rule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `markdown_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Schedule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `product_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Product Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `asin` SET TAGS ('dbx_business_glossary_term' = 'Amazon Standard Identification Number (ASIN)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `dimensions_cm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions (cm)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Percent');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'allocated|picked|packed|shipped|delivered|failed');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'warehouse|drop_ship|store_pickup|third_party');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `is_backordered` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `is_gift` SET TAGS ('dbx_business_glossary_term' = 'Gift Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `is_returnable` SET TAGS ('dbx_business_glossary_term' = 'Returnable Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|shipped|delivered|canceled|returned');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `quantity_fulfilled` SET TAGS ('dbx_business_glossary_term' = 'Quantity Fulfilled');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `restricted_item_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Item Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window (Days)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `total_gross` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Total');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `total_net` SET TAGS ('dbx_business_glossary_term' = 'Line Net Total');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Selling Price (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`line` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status History ID');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Actor Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Support Case Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Actor Type');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `actor_type` SET TAGS ('dbx_value_regex' = 'system|user|seller|partner');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Transition Comment');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `is_system_generated` SET TAGS ('dbx_business_glossary_term' = 'System‑Generated Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reason Code');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `sla_actual_seconds` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Duration (Seconds)');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `sla_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Duration (Seconds)');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `status_from` SET TAGS ('dbx_business_glossary_term' = 'Previous Order Status');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `status_to` SET TAGS ('dbx_business_glossary_term' = 'New Order Status');
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `order_address_id` SET TAGS ('dbx_business_glossary_term' = 'Order Address ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `order_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `order_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Original Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'shipping|billing|pickup');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `carrier_preference` SET TAGS ('dbx_business_glossary_term' = 'Carrier Preference');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `carrier_preference` SET TAGS ('dbx_value_regex' = 'standard|express|overnight');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `external_address_reference` SET TAGS ('dbx_business_glossary_term' = 'External Address Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `external_address_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `external_address_reference` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `is_residential` SET TAGS ('dbx_business_glossary_term' = 'Residential Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Address Label');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `label` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `label` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Degrees)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Degrees)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `order_address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Record Status');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `order_address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `order_address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `order_address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Full Name');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (%)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|partial');
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` SET TAGS ('dbx_subdomain' = 'payment_billing');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `order_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Payment ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `gmv_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Gmv Settlement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `token_id` SET TAGS ('dbx_business_glossary_term' = 'Token Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Gross Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (JSON)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Capture Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|in_store|api');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Processing Fee Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Check Status');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `is_gift_card` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Payment Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `is_refund` SET TAGS ('dbx_business_glossary_term' = 'Refund Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `is_split_payment` SET TAGS ('dbx_business_glossary_term' = 'Split Payment Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `is_store_credit` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Payment Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `line_quantity` SET TAGS ('dbx_business_glossary_term' = 'Payment Line Quantity');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Net Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Payment Note');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'authorized|captured|failed|refunded|partial|voided');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference (Token)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `refunded_amount` SET TAGS ('dbx_business_glossary_term' = 'Refunded Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Tax Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` SET TAGS ('dbx_subdomain' = 'payment_billing');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `order_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Order Promotion ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `marketplace_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Promotion Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `promotion_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `applied_by` SET TAGS ('dbx_business_glossary_term' = 'Applied By');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `applied_by` SET TAGS ('dbx_value_regex' = 'system|customer_service|automated');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promotion Applied Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `discount_currency` SET TAGS ('dbx_business_glossary_term' = 'Discount Currency (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `eligibility_message` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Message');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `is_combination_allowed` SET TAGS ('dbx_business_glossary_term' = 'Is Combination Allowed');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Exclusive Promotion');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `is_refunded` SET TAGS ('dbx_business_glossary_term' = 'Is Refunded');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Promotion Line Sequence');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `max_uses_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Max Uses Per Customer');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `max_uses_per_order` SET TAGS ('dbx_business_glossary_term' = 'Max Uses Per Order');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `net_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Discount Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `order_promotion_description` SET TAGS ('dbx_business_glossary_term' = 'Promotion Description');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `promotion_category` SET TAGS ('dbx_business_glossary_term' = 'Promotion Category');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `promotion_category` SET TAGS ('dbx_value_regex' = 'discount|rebate|credit|gift');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `promotion_source` SET TAGS ('dbx_business_glossary_term' = 'Promotion Source');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `promotion_source` SET TAGS ('dbx_value_regex' = 'marketing_campaign|loyalty_program|seller_funded|system_generated');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|bogo|free_shipping');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `quantity_applied` SET TAGS ('dbx_business_glossary_term' = 'Quantity Applied');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `stacking_rule` SET TAGS ('dbx_business_glossary_term' = 'Stacking Rule');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `stacking_rule` SET TAGS ('dbx_value_regex' = 'stackable|non_stackable|conditional');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Promotion');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` SET TAGS ('dbx_subdomain' = 'payment_billing');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_business_glossary_term' = 'Order Tax Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Calculation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `engine_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Engine Reference');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Reason');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code (JURIS_CODE)');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Tax Line Sequence');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `nexus_country` SET TAGS ('dbx_business_glossary_term' = 'Nexus Country Code');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `nexus_state` SET TAGS ('dbx_business_glossary_term' = 'Nexus State/Province Code');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Line Status');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `tax_status` SET TAGS ('dbx_value_regex' = 'applied|reversed|pending|error');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'sales_tax|vat|gst|customs_duty|other');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `taxable_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` SET TAGS ('dbx_subdomain' = 'fulfillment_delivery');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation ID');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `payment_refund_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Refund Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `actor` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Actor');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `actor` SET TAGS ('dbx_value_regex' = 'customer|seller|system|fraud|payment_gateway');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Approved Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_number` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Number (CN)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_status` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Status');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_status` SET TAGS ('dbx_value_regex' = 'requested|approved|rejected|completed|cancelled');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_type` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Type');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `cancellation_type` SET TAGS ('dbx_value_regex' = 'order|order_line|shipment|payment');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `cancelled_amount` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Amount');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `cancelled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Quantity');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Completed Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `is_partial` SET TAGS ('dbx_business_glossary_term' = 'Partial Cancellation Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notes');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'customer_initiated|out_of_stock|fraud_hold|seller_cancellation|payment_failure|other');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Description');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount (Monetary Value)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `refund_currency` SET TAGS ('dbx_business_glossary_term' = 'Refund Currency (ISO 4217 Code)');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `refund_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `refund_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligibility Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `refund_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Rejected Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Rejection Reason');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Request Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Scope');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'full|partial');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Source Channel');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|api|store');
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` SET TAGS ('dbx_subdomain' = 'fulfillment_delivery');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Shipment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `actual_delivery_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Time (Seconds)');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `carrier_scan_reference` SET TAGS ('dbx_business_glossary_term' = 'Carrier Scan Reference');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Number');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Exception Code');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_location_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Type');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_location_type` SET TAGS ('dbx_value_regex' = 'door|locker|neighbor|pickup_point|other');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'delivered|failed|returned|pending');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Latitude');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Longitude');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `otp_verified` SET TAGS ('dbx_business_glossary_term' = 'One‑Time‑Password Verified');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `proof_of_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Method');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `proof_of_delivery_method` SET TAGS ('dbx_value_regex' = 'signature|photo|otp|none');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Full Name');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `recipient_signature_image_url` SET TAGS ('dbx_business_glossary_term' = 'Recipient Signature Image URL');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `sla_delivery_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'SLA Delivery Time (Seconds)');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` SET TAGS ('dbx_subdomain' = 'fulfillment_delivery');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `fulfillment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Allocation Identifier');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'nearest_node|lowest_cost|seller_fulfilled|zone_skipping|manual|algorithmic');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `allocation_rule_version` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Version');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_business_glossary_term' = 'Allocation Source');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_value_regex' = 'system|manual|api|batch');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|picked|cancelled|failed|partial');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `carrier_preference` SET TAGS ('dbx_business_glossary_term' = 'Carrier Preference');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `carrier_preference` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|overnight|pickup|third_party');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `dimensions_cm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions (Centimeters)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `estimated_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ship Date');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'warehouse|3pl|seller|dark_store|store_pickup');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Handling Instructions');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `is_backorder` SET TAGS ('dbx_business_glossary_term' = 'Backorder Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `is_drop_ship` SET TAGS ('dbx_business_glossary_term' = 'Drop Ship Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `is_eligible_for_fast_ship` SET TAGS ('dbx_business_glossary_term' = 'Fast Ship Eligibility Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `is_eligible_for_free_shipping` SET TAGS ('dbx_business_glossary_term' = 'Free Shipping Eligibility Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `is_expedited` SET TAGS ('dbx_business_glossary_term' = 'Expedited Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `is_fragile` SET TAGS ('dbx_business_glossary_term' = 'Fragile Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `is_gift_wrap` SET TAGS ('dbx_business_glossary_term' = 'Gift Wrap Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `is_oversized` SET TAGS ('dbx_business_glossary_term' = 'Oversized Indicator');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `last_status_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `shipping_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Estimate (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `sla_actual_seconds` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual (Seconds)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `sla_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'SLA Target (Seconds)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `split_shipment_flag` SET TAGS ('dbx_business_glossary_term' = 'Split Shipment Flag');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `tax_estimate` SET TAGS ('dbx_business_glossary_term' = 'Tax Estimate (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost (USD)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `volume_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
